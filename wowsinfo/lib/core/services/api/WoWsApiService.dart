import 'package:wowsinfo/core/models/UI/GameServer.dart';
import 'package:wowsinfo/core/services/api/BaseApiService.dart';
import 'package:wowsinfo/core/services/api/key.dart';
import 'package:wowsinfo/core/utils/Utils.dart';
import 'package:http/http.dart' as http;

/// Wargmaing API is a bit complicated. Often, it needs an api key, data language and some fields
/// - Paging is necessary sometimes
/// - It returns a list of string
abstract class WoWsApiService extends BaseApiService<List<String>> {
  int _pageNumber = 1;
  final GameServer server;

  /// Server is necessary for almost all getters
  WoWsApiService(this.server);

  /// This requests to Wargaming API server and will check if it is valid and will request more if it has more data
  @override
  Future<List<String>> requestData() async {
    final jsonList = [];
    try {
      while (true) {
        final response = await http
            .get(
              getRequestLink() + '&page_no=$_pageNumber',
            )
            .timeout(Duration(seconds: 8));

        // Only 200 is valid
        if (response.statusCode != 200) break;
        final body = response.body;
        // This means that API has an error
        if (body.isEmpty || body.contains('"status": "error"')) break;
        jsonList.add(body);
        // Valid response but it only has one page, if it has multiple pages, page_total exists
        if (!body.contains('"page_total"')) break;

        _pageNumber += 1;
      }

      return jsonList;
    } catch (e) {
      Utils.debugPrint(e);
      return jsonList;
    }
  }

  /// It is a bit different for almost all data
  String getDomainFields();
  String getServerDomain() => 'https://api.worldofwarships.';
  String getAPIKeyField() => '?application_id=$API_KEY';

  /// This link usually includes 4 parts
  /// - root domain (wows or wowt)
  /// - server
  /// - other domain
  /// - api key
  /// Make sure `key.dart` contains the key
  @override
  String getBaseLink() =>
      '${getServerDomain()}${server.domain}/${getDomainFields()}${getAPIKeyField()}';
}
