import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:wowsinfo/core/models/GitHub/Plugin.dart';

void main() {
  test('Load plugin into memory', () async {
    final file = File('test/json/plugin.json');
    final jsonString = await file.readAsString();
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    final output = jsonEncode(jsonMap);
    
    final a = Plugin.fromJson(jsonMap);
    expect(a.consumable['PCY020_RLSSearchPremium'].data[10]['USSR_8_BB'].distShip == 500, isTrue);
    final myOutput = jsonEncode(a.toJson());

    // I ignored many data
    expect(myOutput == output, isFalse);
  });
}
