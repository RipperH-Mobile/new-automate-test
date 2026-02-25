import 'package:isar_community/isar.dart';

part 'chat_settings_model.g.dart';

@embedded
class ChatSettingsModel {
  final bool? enabled;
  final bool? chatFolder;
  final bool? showCategory;

  ChatSettingsModel({
    this.enabled,
    this.chatFolder,
    this.showCategory,
  });

  factory ChatSettingsModel.fromMap(Map<String, dynamic> data) {
    return ChatSettingsModel(
      enabled: data['enabled'],
      chatFolder: data['chatFolder'],
      showCategory: data['showCategory'],
    );
  }

  ChatSettingsModel copyWith({
    bool? enabled,
    bool? chatFolder,
    bool? showCategory,
  }) {
    return ChatSettingsModel(
      enabled: enabled,
      chatFolder: chatFolder,
      showCategory: showCategory,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};

    if (enabled != null) {
      data['enabled'] = enabled;
    }

    if (chatFolder != null) {
      data['chatFolder'] = chatFolder;
    }

    if (showCategory != null) {
      data['showCategory'] = showCategory;
    }

    return data;
  }
}
