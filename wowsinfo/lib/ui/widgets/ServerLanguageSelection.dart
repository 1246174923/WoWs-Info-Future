import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';
import 'package:wowsinfo/ui/widgets/WrapBox.dart';

/// ServerLanguageSelection class
class ServerLanguageSelection extends StatefulWidget {

  ServerLanguageSelection({Key key}) : super(key: key);

  @override
  _ServerLanguageSelectionState createState() => _ServerLanguageSelectionState();
}

class _ServerLanguageSelectionState extends State<ServerLanguageSelection> {
  final cached = CachedData.shared;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalization.of(context);
    
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lang.localised('server_language_selection_title'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          WrapBox(
            spacing: 2,
            children: cached.serverLanguage.entries.map((e) {
              return Consumer<Preference>(
                builder: (context, pref, child) => FlatFilterChip(
                  label: Text(e.value),
                  selected: e.key == pref.appLanguage, 
                  onSelected: (_) {
                    setState(() {});
                    pref.serverLanguage = e.key;
                  }
                ),
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
