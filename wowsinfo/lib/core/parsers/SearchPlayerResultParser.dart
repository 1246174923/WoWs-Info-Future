import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/WoWs/SearchPlayerResult.dart';
import 'package:wowsinfo/core/parsers/APIParser.dart';

class SearchPlayerResultParser extends APIParser {
  SearchPlayerResultParser(GameServer server, String name) : super(server) {
    this.link += '/wows/account/list/';
    addAPIKey();
    this.link += '&search=$name';
  }

  @override
  SearchPlayerResult parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final data = SearchPlayerResult(json[0]['data']);
    return data;
  }
}