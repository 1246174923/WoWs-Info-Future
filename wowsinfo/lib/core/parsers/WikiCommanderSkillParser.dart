import 'package:wowsinfo/core/data/GameServer.dart';
import 'package:wowsinfo/core/models/Wiki/WikiCommanderSkill.dart';

import 'APIParser.dart';

class WikiCommanderSkillParser extends APIParser {
  WikiCommanderSkillParser(GameServer server) : super(server) {
    this.link += '/wows/encyclopedia/crewskills/';
    addAPIKey();
  }

  @override
  WikiCommanderSkill parse(List<Map<String, dynamic>> json) {
    final first = WikiCommanderSkill.fromJson(json.removeAt(0)['data']);
    // Merge everything
    json.forEach((element) {
      first.skill.addAll(WikiCommanderSkill.fromJson(element['data']).skill);
    });
    return first;
  }
}
