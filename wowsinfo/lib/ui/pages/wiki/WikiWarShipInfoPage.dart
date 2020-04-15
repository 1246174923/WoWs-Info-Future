import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:wowsinfo/core/data/CachedData.dart';
import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart' as Wiki;
import 'package:wowsinfo/core/models/WoWs/WikiShipInfo.dart';
import 'package:wowsinfo/core/models/WoWs/WikiShipModule.dart';
import 'package:wowsinfo/core/others/AppLocalization.dart';
import 'package:wowsinfo/core/parsers/API/WikiShipInfoParser.dart';
import 'package:wowsinfo/ui/widgets/PlatformLoadingIndiactor.dart';
import 'package:wowsinfo/ui/widgets/TextWithCaption.dart';
import 'package:wowsinfo/ui/widgets/wiki/ShipAverageStats.dart';
import 'package:wowsinfo/ui/widgets/wiki/ShipParameter.dart';
import 'package:wowsinfo/ui/widgets/wiki/WikiWarshipCell.dart';

/// WikiWarShipInfoPage class
class WikiWarShipInfoPage extends StatefulWidget {
  final Wiki.Warship ship;
  WikiWarShipInfoPage({Key key, @required this.ship}) : super(key: key);

  @override
  _WikiWarShipInfoPageState createState() => _WikiWarShipInfoPageState();
}

class _WikiWarShipInfoPageState extends State<WikiWarShipInfoPage> with SingleTickerProviderStateMixin {
  final pref = Preference.shared;
  AppLocalization lang;
  bool loading = true;
  bool error = false;
  WikiShipInfo info;
  /// Modules can be changed by users
  WikiShipModule modules;

  ScrollController controller;
  bool showBottomBar = true;
  Iterable<Wiki.Warship> similarShips;

  @override
  void initState() {
    super.initState();
    // Setup scroll controller to hide bottom app bar
    this.controller = ScrollController();
    controller.addListener(() {
      final direction = controller.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        if (showBottomBar) {
          setState(() {
            showBottomBar = false;
          });
        }
      } else if (direction == ScrollDirection.forward) {
        if (!showBottomBar) {
          setState(() {
            showBottomBar = true;
          });
        }
      }
    });

    // Find similar ships
    this.similarShips = CachedData.shared.warship.values.where((s) {
      return widget.ship.isSimilar(s);
    });

    // Load data
    final parser = WikiShipInfoParser(pref.gameServer, widget.ship.shipId);
    parser.download().then((value) {
      this.info = parser.parse(value);
      this.modules = info.defaultProfile;
      setState(() {
        loading = false;
        // The value must not be null
        error = this.info == null;
      });
    }).catchError((e) => setState(() => error = true));
  }

  @override
  Widget build(BuildContext context) {
    // Setup localization
    lang = AppLocalization.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ship.shipIdAndIdStr)
      ),
      body: SafeArea(child: buildBody()),
      bottomNavigationBar: AnimatedContainer(
        height: showBottomBar ? 120 : 0,
        duration: Duration(milliseconds: 300), 
        child: BottomAppBar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: similarShips.map((e) => WikiWarshipCell(ship: e, showDetail: true)).toList(growable: false),
            ),
          ),
        ),
      )
    );
  }

  Widget buildBody() {
    if (error) return SizedBox.shrink();
    return buildInfo();
  }

  Widget buildInfo() {
    return SingleChildScrollView(
      controller: controller,
      child: Center(
        child: Column(
          children: [
            Hero(
              tag: widget.ship.shipId,
              child: Image(image: NetworkImage(widget.ship.smallImage)),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              switchInCurve: Curves.linearToEaseOut,
              transitionBuilder: (w, a) => SizeTransition(sizeFactor: a, child: w),
              child: buildContent()
            ),
          ],
        ),
      ),
    );
  }

  /// Build ship info, everything
  Widget buildContent() {
    if (loading) return Center(child: const PlatformLoadingIndiactor());

    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(widget.ship.tierName, style: textTheme.headline6),
        Text(widget.ship.nationShipType),
        buildShipPrice(),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ShipAverageStats(shipId: info.shipId),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(info.description, style: textTheme.bodyText1, textAlign: TextAlign.center),
        ),
        buildParameter(),
      ],
    );
  }

  /// A gold colour is used if it is priced by gold
  Widget buildShipPrice() {
    if (info.priceGold > 0) return Text(info.priceGold.toString(), style: TextStyle(color: Colors.orange));
    return Text(info.priceCredit.toString(), style: TextStyle(color: Colors.blueGrey));
  }

  /// Build ship parameter
  Widget buildParameter() {
    return Column(
      children: modules.getParameter(context).map((e) => 
        ShipParameter(paramater: e)).toList(growable: false),
    );
  }
}
