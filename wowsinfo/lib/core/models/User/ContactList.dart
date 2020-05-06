import 'package:wowsinfo/core/data/Preference.dart';
import 'package:wowsinfo/core/models/User/Player.dart';
import 'package:wowsinfo/core/models/User/Clan.dart';

/// This stores and manages player contact including players and clans
class ContactList {
  final pref = Preference.shared;

  List<Player> players = [];
  updatePlayer(Player player, {bool add = true}) {
    if (add) players.add(player);
    else players.removeWhere((element) => element.playerId == player.playerId);
    _save();
  }
  bool containsPlayer(Player player) => this.players.any((element) => element.playerId == player.playerId);

  List<Clan> clans = [];
  updateClan(Clan clan, {bool add = true}) {
    if (add) clans.add(clan);
    else clans.removeWhere((element) => element.clanId == clan.clanId);
    _save();
  }
  bool containsClan(Clan clan) => this.clans.any((element) => element.clanId == clan.clanId);

  ContactList();
  ContactList.fromJson(Map<String, dynamic> json) {
    this.players = (json['players'] as List).map((e) => Player.fromJson(e)).toList();
    this.clans = (json['clans'] as List).map((e) => Clan.fromJson(e)).toList();
  }

  void _save() => pref.setContactList(this);

  Map<String, dynamic> toJson() {
    /// Although `Set` is used, it might be great to 
    return {
      'players': players,
      'clans': clans,
    };
  }
}
