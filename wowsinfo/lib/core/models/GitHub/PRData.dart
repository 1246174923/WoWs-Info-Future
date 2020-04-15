import 'package:wowsinfo/core/models/Cacheable.dart';

/// This is the `PRData` class, `Personal Rating Data`
class PRData extends Cacheable {
  Map<String, AverageStats> ships;

  PRData.fromJson(Map<String, dynamic> json) {
    ships = json.map((key, value) {
      // If it is a list it means that it is an empty entry
      if (value == null || value is List) return MapEntry(key, null);
      return MapEntry(key, AverageStats.fromJson(value));
    });
  }

  Map<String, dynamic> toJson() => ships.cast<String, dynamic>();

  @override
  void save() => cached.savePRData(this);
}

/// This is the `AverageStats` class
class AverageStats {
  double averageDamageDealt;
  String get averageDamageString => averageDamageDealt.toStringAsFixed(0);
  double averageFrag;
  String get averageFragString => averageFrag.toStringAsFixed(2);
  double winRate;
  String get winRateString => winRate.toStringAsFixed(1) + '%';

  AverageStats.fromJson(Map<String, dynamic> json) {
    this.averageDamageDealt = json['average_damage_dealt'].toDouble();
    this.averageFrag = json['average_frags'];
    this.winRate = json['win_rate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'average_damage_dealt': this.averageDamageDealt,
      'average_frags': this.averageFrag,
      'win_rate': this.winRate,
    };
  }
}
