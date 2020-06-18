import '../Cacheable.dart';

/// This is the `ClanGlossary` class
class ClanGlossary extends Cacheable {
  Map<String, String> roles;

  ClanGlossary.fromJson(Map<String, dynamic> json) {
    this.roles = (json['clans_roles'] as Map).cast<String, String>();
  }

  Map<String, dynamic> toJson() {
    return {
      'clans_roles': this.roles,
    };
  }

  @override
  void save() => cached.saveClanGlossary(this);
}
