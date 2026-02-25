import 'package:isar_community/isar.dart';

part 'last_emoji_account_info_model.g.dart';

@embedded
class LastEmojiAccountInfoModel {
  final String? accountId;
  final String? accountName;
  final String? avatarId;

  LastEmojiAccountInfoModel({
    this.accountId,
    this.accountName,
    this.avatarId,
  });

  Map<String, dynamic> toMap() {
    return {
      'accountId': accountId,
      'displayName': accountName,
      'avatarId': avatarId,
    };
  }

  static LastEmojiAccountInfoModel fromMap(Map<String, dynamic> data) {
    return LastEmojiAccountInfoModel(
      accountId: data['accountId'],
      accountName: data['displayName'],
      avatarId: data['avatarId'],
    );
  }

  @override
  bool operator ==(Object other) {
    return other is LastEmojiAccountInfoModel && accountId == other.accountId;
  }

  @override
  int get hashCode => accountId.hashCode;
}
