import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/BasicPlayerInfo.dart';
import 'APIParser.dart';

class BasicPlayerInfoParser extends APIParser {
  BasicPlayerInfoParser(GameServer server, int accountId) : super(server) {
    this.link += '/wows/account/info/';
    addAPIKey();
    this.link += '&account_id=$accountId';
  }

  @override
  BasicPlayerInfo parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = BasicPlayerInfo(json[0]['data']);
    return data;
  }
}