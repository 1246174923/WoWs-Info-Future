import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';
import 'package:wowsinfo/ui/pages/setup/IntroPage.dart';

void main() async {
  // Run a loading screen here
  // runApp(Theme(
  //   data: ThemeData(
  //     brightness: Brightness.dark,
  //   ),
  //   child: Container(
  //     color: Colors.blue,
  //   )
  // ));

  /// Setup local data
  await Hive.initFlutter();
  // Init preference box 
  final pref = Preference()..init();
  // Create and setup AppSetting
  final settings = AppSettings()..init();
  // Init cached data
  final cache = CachedData()..init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppSettings>.value(value: settings),
      ChangeNotifierProvider<Preference>.value(value: pref),
      Provider<CachedData>.value(value: cache),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppSettings>(
      builder: (context, wowsinfo, child) => MaterialApp(
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: wowsinfo.locale,
        supportedLocales: AppLocalization.supportedLocales,
        localeResolutionCallback: (locale, supported) {
          if (locale == null) return supported.first;
          switch (locale.languageCode) {
            case 'en':
            case 'ja':
            case 'zh':
              return locale;
            default:
              // This should be english
              return supported.first;
          }
        },
        title: 'WoWs Info Re',
        theme: wowsinfo.theme,
        darkTheme: wowsinfo.darkTheme,
        themeMode: wowsinfo.themeMode,
        // This should depend on whether first_launch is true or not
        home: buildHome()
      ),
    );
  }

  /// Setup should be the home
  Widget buildHome() {
    return Consumer<Preference>(
      builder: (context, pref, child) {
        if (pref.firstLaunch) return IntroPage();
        return InitialPage();
      }
    );
  }
}
