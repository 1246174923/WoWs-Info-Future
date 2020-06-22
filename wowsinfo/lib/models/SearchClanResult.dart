import 'package:wowsinfo/core/models/User/Clan.dart';

/// This is the `SearchClanResult` class
class SearchClanResult {
  List<Clan> data = [];

  SearchClanResult(List json) {
    json.forEach((item) => data.add(Clan.fromJson(item)));
  }
}
