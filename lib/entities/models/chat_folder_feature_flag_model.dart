import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/compare_theme_content_model.dart';
import 'package:uchat/entities/models/detail_theme_content_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';

part 'chat_folder_feature_flag_model.g.dart';

@embedded
class ChatFolderFeatureFlagModel implements FeatureFlagInterface, FeatureFlagContentInterface {
  @override
  bool? enabled;
  int? maxChatFolder;
  int? maxRoomInChatFolder;
  @override
  CompareThemeContentModel? compareThemeContent;
  @override
  DetailThemeContentModel? detailThemeContentModel;

  ChatFolderFeatureFlagModel({
    this.enabled,
    this.maxChatFolder,
    this.maxRoomInChatFolder,
    this.compareThemeContent,
    this.detailThemeContentModel,
  });

  static ChatFolderFeatureFlagModel fromMap(Map<String, dynamic> json) {
    return ChatFolderFeatureFlagModel(
      enabled: json['enabled'],
      maxChatFolder: json['maxChatFolder'],
      maxRoomInChatFolder: json['maxRoomInChatFolder'],
      compareThemeContent: json['compareTheme'] != null ? CompareThemeContentModel.fromMap(json['compareTheme']) : null,
      detailThemeContentModel:
          json['detailTheme'] != null ? DetailThemeContentModel.fromMap(json['detailTheme']) : null,
    );
  }

  @override
  String toString() {
    return '[ChatFolderFeatureFlagModel] enabled: $enabled'
        ' maxChatFolder: $maxChatFolder'
        ' maxRoomInChatFolder: $maxRoomInChatFolder';
  }
}
