import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';

part 'account_settings_model.g.dart';

@embedded
class AccountSettingsModel {
  final CallSettingsModel? call;
  final ChatSettingsModel? chat;
  final FriendSettingsModel? friend;
  final NotificationSettingsModel? notification;
  final ProfileSettingsModel? profile;
  final SecuritySettingsModel? security;

  AccountSettingsModel({
    this.call,
    this.chat,
    this.friend,
    this.notification,
    this.profile,
    this.security,
  });

  factory AccountSettingsModel.fromMap(Map<String, dynamic> data) {
    return AccountSettingsModel(
      call: CallSettingsModel.fromMap(data['call']),
      chat: ChatSettingsModel.fromMap(data['chat']),
      friend: FriendSettingsModel.fromMap(data['friend']),
      notification: NotificationSettingsModel.fromMap(data['notification']),
      profile: ProfileSettingsModel.fromMap(data['profile']),
      security: SecuritySettingsModel.fromMap(data['security']),
    );
  }

  @override
  String toString() {
    return '[AccountSettings]\n'
        'call: $call\n'
        'chat: $chat\n'
        'friend: $friend\n'
        'notification:$notification\n'
        'profile: $profile\n'
        'security: $security';
  }
}
