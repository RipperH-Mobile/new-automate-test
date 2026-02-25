import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';

part 'friend_settings_model.g.dart';

@embedded
class FriendSettingsModel {
  final bool? enabled;
  final bool? canFriendSeeMyLastSeen;
  final AllowFriendAddModel? allowFriendAdd;

  FriendSettingsModel({
    this.enabled,
    this.canFriendSeeMyLastSeen,
    this.allowFriendAdd,
  });

  factory FriendSettingsModel.fromMap(Map<String, dynamic> data) {
    return FriendSettingsModel(
      enabled: data['enabled'],
      canFriendSeeMyLastSeen: data['canFriendSeeMyLastSeen'],
      allowFriendAdd: data['allowFriendAdd'] != null ? AllowFriendAddModel.fromMap(data['allowFriendAdd']) : null,
    );
  }

  FriendSettingsModel copyWith({
    bool? enabled,
    bool? canFriendSeeMyLastSeen,
    AllowFriendAddModel? allowFriendAdd,
  }) {
    return FriendSettingsModel(
      enabled: enabled,
      canFriendSeeMyLastSeen: canFriendSeeMyLastSeen,
      allowFriendAdd: allowFriendAdd,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (canFriendSeeMyLastSeen != null) {
      data['canFriendSeeMyLastSeen'] = canFriendSeeMyLastSeen;
    }

    if (allowFriendAdd != null) {
      data['allowFriendAdd'] = allowFriendAdd?.toMap();
    }

    return data;
  }
}
