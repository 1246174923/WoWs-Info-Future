import 'package:flutter/material.dart';
import 'package:wowsinfo/core/models/WoWs/PlayerShipInfo.dart';
import 'package:wowsinfo/core/others/Utils.dart';
import 'package:wowsinfo/ui/pages/player/PlayerShipDetailPage.dart';
import 'package:wowsinfo/ui/widgets/player/BasicShipInfoTile.dart';
import 'package:wowsinfo/ui/widgets/player/RatingBar.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// PlayerShipInfoPage class
class PlayerShipInfoPage extends StatefulWidget {
  final PlayerShipInfo info;
  PlayerShipInfoPage({Key key, this.info}) : super(key: key);

  @override
  _PlayerShipInfoPageState createState() => _PlayerShipInfoPageState();
}

class _PlayerShipInfoPageState extends State<PlayerShipInfoPage> {
  @override
  Widget build(BuildContext context) {
    final ships = widget.info.ships.where((e) => e.battle > 0)
      .toList(growable: false)
      ..sort((b, a) => a.lastBattleTime.compareTo(b.lastBattleTime));
    // 120 can place 3 on iPhone 11
    final itemCount = Utils.of(context).getItemCount(6, 1, 200);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('PlayerShipInfoPage')
      ),
      body: SafeArea(
        child: Scrollbar(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemCount,
              childAspectRatio: 0.9
            ),
            itemCount: ships.length,
            itemBuilder: (context, index) {
              final curr = ships[index];
              return WikiWarshipCell(
                ship: curr.ship,
                hero: true,
                bottom: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BasicShipInfoTile(stats: curr.pvp, compact: true),
                    ),
                    RatingBar(rating: curr.rating, compact: true)
                  ],
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (c) => PlayerShipDetailPage(ship: curr))),
              );
            },
          ),
        ),
      ),
    );
  }
}
