import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/pages/InitialPage.dart';

/// WelcomeWidget class
class WelcomeWidget extends StatelessWidget {
  WelcomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WelcomeWidget')
      ),
      body: Center(
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (c) => InitialPage()));
          }, 
          child: Text('Initial')
        ),
      )
    );
  }
}
