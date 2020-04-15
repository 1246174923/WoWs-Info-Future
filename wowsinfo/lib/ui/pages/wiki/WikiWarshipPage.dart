import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';
import 'package:wowsinfo/ui/widgets/FlatFilterChip.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// WikiWarshipPage class
class WikiWarshipPage extends StatefulWidget {
  WikiWarshipPage({Key key}) : super(key: key);

  @override
  _WikiWarshipPageState createState() => _WikiWarshipPageState();
}


class _WikiWarshipPageState extends State<WikiWarshipPage> {
  final cached = CachedData.shared;
  /// Only one nation can be shown at a time
  String nation;
  /// Only one type can be shown if selected, when nation changed type is cleared, select again to cancel
  String type;
  // One is saved for quick ship type filter
  Iterable<Warship> nationShips = [];
  Iterable<Warship> displayedShips = [];
  List<Warship> sortedList = [];

  @override
  void initState() {
    super.initState();
    // Grab a sorted list
    this.sortedList = cached.sortedWarshipList;
    // Select a random nation here
    this.updateNation((cached.shipNation.keys.toList()..shuffle()).first);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WikiWarshipPage')
      ),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            VerticalDivider(width: 1),
            SizedBox(
              width: 96,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      children: cached.shipNation.entries.map((e) => FlatFilterChip(
                        selected: e.key == this.nation,
                        onSelected: (_) => this.updateNation(e.key), 
                        label: Text(e.value, maxLines: 2),
                      )).toList(growable: false),
                    ),
                  ),
                  Divider(height: 0)
                ],
              ),
            ),
            VerticalDivider(width: 1),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 300),
                    child: WarshipList(ships: displayedShips.toList(growable: false), key: Key('$nation$type')),
                  )),
                  Divider(height: 1),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: cached.shipType.entries.map((e) => FlatFilterChip(
                        onSelected: (_) => this.updateType(e.key), 
                        selected: e.key == this.type,
                        label: Text(e.value),
                      )).toList(growable: false),
                    ),
                  ),
                  Divider(height: 1),
                ],
              )
            ),
            VerticalDivider(width: 1),
          ],
        ),
      ),
    );
  }

  /// Get a list of ships with a certain nation
  void updateNation(String nation) {
    // Same nation, nothing needs to be done
    if (nation == this.nation) return;
    this.nationShips = this.sortedList.where((e) => e.nation == nation);
    setState(() {
      this.nation = nation;
      this.type = '';
      this.displayedShips = this.nationShips;
    });
  }

  /// Update ship type
  void updateType(String type) {
    if (type == this.type) {
      setState(() {
        this.type = '';
        this.displayedShips = this.nationShips;
      });
    } else {
      setState(() {
        this.type = type;
        this.displayedShips = this.nationShips.where((e) => e.type == type);
      });
    }
  }
}

class WarshipList extends StatelessWidget {
  final List<Warship> ships;
  const WarshipList({Key key, @required this.ships}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        final width = MediaQuery.of(context).size.width;
        // 120 can place 3 on iPhone 11
        final itemCount = min(5, max(width / 200, 2)).toInt();
        return Scrollbar(
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            itemCount: ships.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCount,
              childAspectRatio: 1.3,
            ), 
            itemBuilder: (context, index) {
              return WikiWarshipCell(ship: ships[index], showDetail: true);
            }
          ),
        );
      },
    );
  }
}
