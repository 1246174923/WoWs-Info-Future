import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/RankPlayerShipInfo.dart';
import 'APIParser.dart';

class RankPlayerShipInfoGetter extends WoWsApiService {
  RankPlayerShipInfoGetter(GameServer server, int accountId) : super(server) {
    this.link += '/wows/seasons/shipstats/';
    addAPIKey();
    this.link += '&account_id=$accountId';
  }

  @override
  RankPlayerShipInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = RankPlayerShipInfo(json[0]['data']);
    return data;
  }
}