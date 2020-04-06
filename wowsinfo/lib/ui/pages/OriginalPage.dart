import 'package:flutter/material.dart';

/// This mimics the original home page back in early 2017, this is the start of everything
class OriginalPage extends StatelessWidget {
  OriginalPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WoWs Info'),
        backgroundColor: Color(0XFF5A9CFF),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/search_button.png',
          height: 128,
          width: 128,
        ),
      ),
    );
  }
}