import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiWarship.dart';

import 'APIParser.dart';

class WikiWarshipGetter extends WoWsApiService {
  WikiWarshipGetter(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/ships/';
    addAPIKey();
  }

  @override
  WikiWarship parse(List<Map<String, dynamic>> json) {
    if (json.length == 0) return null;
    final first = WikiWarship.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.ships.addAll(WikiWarship.fromJson(element['data']).ships);
    });
    return first;
  }
}
