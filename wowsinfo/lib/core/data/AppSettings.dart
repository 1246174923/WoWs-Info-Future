import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wowsinfo/core/data/LocalData.dart';
import 'package:wowsinfo/core/others/Utils.dart';

/// All material colour
const THEME_COLOUR_LIST = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  // Orange is removed
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
];

/// light or dark
const THEME_BRIGHTNESS_MODE = [
  ThemeMode.light,
  ThemeMode.dark,
  ThemeMode.system,
];

/// it saves locale, theme colour and app brightness
class AppSettings extends LocalData with ChangeNotifier {
  /// Singleton pattern 
  AppSettings._init();
  static final AppSettings shared = AppSettings._init();

  ///
  /// Variables
  ///

  bool isCrazy = false;
  Timer crazyTimer;
  
  ThemeData _theme;
  ThemeData _darkTheme;
  ThemeData get theme => _theme;
  ThemeData get darkTheme => _darkTheme;
  
  // By default, it is blue
  MaterialColor _color;
  MaterialColor get color => _color;
  setColor(MaterialColor m) {
    _color = m;
    _generateTheme();
    notifyListeners();
    this.box.put('color', THEME_COLOUR_LIST.indexOf(_color));
  }

  ThemeMode _brightness;
  ThemeMode get themeMode => _brightness;
  bool isDarkMode() => _brightness == ThemeMode.dark;
  bool isLightMode() => _brightness == ThemeMode.light;
  setBrightness(ThemeMode m) {
    _brightness = m;
    notifyListeners();
    this.box.put('brightness', THEME_BRIGHTNESS_MODE.indexOf(_brightness));
  }
  
  // If locale is null, system locale will be used
  Locale _locale;
  Locale get locale => _locale;
  setLocale(Locale l) {
    _locale = l;
    notifyListeners();
    this.box.put('locale', _localeToCode());
  }

  ///
  /// Functions
  ///

  /// Update theme if brightness or colour changed
  _generateTheme() {
    _theme = ThemeData(
      primarySwatch: _color,
    );

    _darkTheme = ThemeData(
      brightness: Brightness.dark,
      primarySwatch: _color,
      accentColor: _color.shade500,
      indicatorColor: _color.shade500,
    );
  }
    
  @override
  Future init() async {
    this.box = await Hive.openBox('app_settings');
    Utils.debugPrint('app_settings box has been loaded');

    // 5 is the index of blue
    _color = THEME_COLOUR_LIST[box.get('color') ?? 5];
    // 2 is the index of following system
    _brightness = THEME_BRIGHTNESS_MODE[box.get('brightness') as int ?? 2];
    // Convert locale back to object
    final localeString = box.get('locale') as String;
    if (localeString != null) {
      if (localeString.contains('_')) {
        final codes = localeString.split('_');
        _locale = Locale.fromSubtags(countryCode: codes[0], scriptCode: codes[1]);
      } else {
        _locale = Locale(localeString);
      }
    }

    this._generateTheme();
    debug();
  }

  /// Updates colour, language and theme randomly at a really fast pace
  crazyMode() {
    if (!isCrazy) {
      final luck = Random();
      final colorLength = THEME_COLOUR_LIST.length;
      crazyTimer = Timer.periodic(Duration(milliseconds: 200), (_) {
        setColor(THEME_COLOUR_LIST[luck.nextInt(colorLength)]);
        setBrightness(THEME_BRIGHTNESS_MODE[luck.nextInt(2)]);
      });
      isCrazy = true;
    } else {
      isCrazy = false;
      crazyTimer.cancel();
    }
  }

  /// Convert locale object to a string
  String _localeToCode() {
    final scriptCode = _locale.scriptCode;
    final langCode = _locale.languageCode;
    if (scriptCode != null) return langCode + '_' + scriptCode;
    return langCode;
  }
}
