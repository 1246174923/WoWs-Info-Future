import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/OnlinePlayerCount.dart';
import 'APIParser.dart';

class OnlinePlayerCountParser extends APIParser {
  /// It requests to world of tank
  OnlinePlayerCountParser(GameServer server, String name) : super(null) {
    this.link = 'https://api.worldoftanks.${server.domain}/wgn/servers/info/';
    addAPIKey();
    this.link += '&fields=players_online&game=wows';
  }

  @override
  OnlinePlayerCount parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = OnlinePlayerCount(json[0]['data']);
    return data;
  }
}