import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wowsinfo/core/data/AppSettings.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/pages/BottomNavigationPage.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/PlatformWidget.dart';

/// InitialPage class
/// - It shows a full screen overlay
/// - Maybe display some messages as well
class InitialPage extends StatefulWidget {
  InitialPage({Key key}) : super(key: key);

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  final settings = AppSettings.shared;
  bool showLogo = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000)).then((_) {
      setState(() => showLogo = true);
    });

    Future.delayed(Duration(milliseconds: 4000)).then((_) {
      setState(() => showLogo = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Utils.delay(2000).then((_) {
    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => BottomNavigationPage()));
    // });

    return Theme(
      // Only here, the overlay is blue and white text should be used
      data: ThemeData(
        accentColor: Colors.white,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white)
        ),
      ),
      child: Builder(builder: (c) {
        return Stack(
          children: <Widget>[
            // This app bar will update the status bar color
            AppBar(brightness: Brightness.dark),
            Container(
              color: settings.isDarkMode() ? Colors.grey[900] : Colors.blue,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 1000),
                      switchInCurve: Curves.linearToEaseOut,
                      switchOutCurve: Curves.linearToEaseOut,
                      transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
                      child: buildLogo(c),
                    ),
                    PlatformLoadingIndiactor(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildLogo(BuildContext c) {
    if (showLogo) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/logo_white.png')),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalization.of(c).localised('app_name'), 
                style: Theme.of(c).textTheme.subtitle1
              ),
            )
          ],
        ),
      );
    }

    return SizedBox.shrink();
  }
}
