import 'package:flutter/material.dart';
import 'package:wowsinfo/ui/widgets/common/GameServerSelection.dart';
import 'package:wowsinfo/ui/widgets/common/ServerLanguageSelection.dart';

/// Settings class
class SettingPage extends StatelessWidget {
  SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GameServerSelection(),
              ServerLanguageSelection(),
            ],
          ),
        ),
      ),
    );
  }
}
