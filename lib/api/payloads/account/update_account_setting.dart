import 'package:uchat/entities/models.dart';

class UpdateAccountSettingRequest {
  AccountSettingsModel accountSettingsModel;

  UpdateAccountSettingRequest({required this.accountSettingsModel});

  static UpdateAccountSettingRequest create({
    CallSettingsModel? call,
    ChatSettingsModel? chat,
    FriendSettingsModel? friend,
    NotificationSettingsModel? notification,
    ProfileSettingsModel? profile,
    SecuritySettingsModel? security,
  }) {
    final requestData = AccountSettingsModel(
      call: call,
      chat: chat,
      friend: friend,
      notification: notification,
      profile: profile,
      security: security,
    );
    return UpdateAccountSettingRequest(accountSettingsModel: requestData);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (accountSettingsModel.call != null) {
      data['call'] = accountSettingsModel.call?.toMap();
    }

    if (accountSettingsModel.chat != null) {
      data['chat'] = accountSettingsModel.chat?.toMap();
    }

    if (accountSettingsModel.friend != null) {
      data['friend'] = accountSettingsModel.friend?.toMap();
    }

    if (accountSettingsModel.notification != null) {
      data['notification'] = accountSettingsModel.notification?.toMap();
    }

    if (accountSettingsModel.profile != null) {
      data['profile'] = accountSettingsModel.profile?.toMap();
    }

    if (accountSettingsModel.security != null) {
      data['security'] = accountSettingsModel.security?.toMap();
    }

    if (data.isEmpty) throw Exception('UpdateAccountSettingRequest data can not be empty!');

    return data;
  }
}
