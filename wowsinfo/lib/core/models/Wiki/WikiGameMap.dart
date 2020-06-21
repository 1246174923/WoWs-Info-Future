import 'package:wowsinfo/core/models/Cacheable.dart';
import 'package:wowsinfo/core/models/Mergeable.dart';

/// This is the `WikiGameMap` class
class WikiGameMap extends Cacheable implements Mergeable<WikiGameMap>  {
  Map<String, GameMap> gameMap;

  WikiGameMap.fromJson(Map<String, dynamic> json) : super(json) {
    this.gameMap = json.map((a, b) => MapEntry(a, GameMap.fromJson(b)));
  }

  Map<String, dynamic> toJson() => this.gameMap.cast<String, dynamic>();

  @override
  bool isValid() => gameMap.isNotEmpty;

  @override
  merge(WikiGameMap object) {
    if (object != null) gameMap.addAll(object.gameMap);
  }

  @override
  mergeAll(Iterable<WikiGameMap> object) {
    object.forEach((e) => this.merge(e));
  }
}

/// This is the `GameMap` class
class GameMap {
  String description;
  String name;
  String icon;

  GameMap.fromJson(Map<String, dynamic> json) {
    this.description = json['description'];
    this.name = json['name'];
    this.icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    return {
      'description': this.description,
      'name': this.name,
      'icon': this.icon,
    };
  }
}
