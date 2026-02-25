import 'package:isar_community/isar.dart';

part 'allow_friend_add_model.g.dart';

@embedded
class AllowFriendAddModel {
  bool? enabled;
  bool? canAddByPhoneNumber;
  bool? canAddByUsername;
  bool? canAddFromGroup;

  AllowFriendAddModel({
    this.enabled,
    this.canAddByPhoneNumber,
    this.canAddByUsername,
    this.canAddFromGroup,
  });

  factory AllowFriendAddModel.fromMap(Map<String, dynamic> data) {
    return AllowFriendAddModel(
      enabled: data['enabled'],
      canAddByPhoneNumber: data['canAddByPhoneNumber'],
      canAddByUsername: data['canAddByUsername'],
      canAddFromGroup: data['canAddFromGroup'],
    );
  }

  AllowFriendAddModel copyWith({
    bool? enabled,
    bool? canAddByPhoneNumber,
    bool? canAddByUsername,
    bool? canAddFromGroup,
  }) {
    return AllowFriendAddModel(
      enabled: enabled,
      canAddByPhoneNumber: canAddByPhoneNumber,
      canAddByUsername: canAddByUsername,
      canAddFromGroup: canAddFromGroup,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (canAddByPhoneNumber != null) {
      data['canAddByPhoneNumber'] = canAddByPhoneNumber;
    }

    if (canAddByUsername != null) {
      data['canAddByUsername'] = canAddByUsername;
    }

    if (canAddFromGroup != null) {
      data['canAddFromGroup'] = canAddFromGroup;
    }

    return data;
  }
}
