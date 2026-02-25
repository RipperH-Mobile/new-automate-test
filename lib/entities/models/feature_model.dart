import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models/chat_folder_feature_flag_model.dart';
import 'package:uchat/entities/models/feature_ability_live_location_model.dart';
import 'package:uchat/entities/models/feature_ability_pin_model.dart';
import 'package:uchat/entities/models/feature_ability_secret_room_model.dart';
import 'package:uchat/entities/models/feature_flag_base.dart';
import 'package:uchat/entities/models/hold_chat_feature_flag_model.dart';
import 'package:uchat/entities/models/multiple_account_feature_flag_model.dart';

part 'feature_model.g.dart';

@embedded
class FeatureModel {
  FeatureAbilitySecretRoomModel? secretRoomFeature;
  MultipleAccountFeatureFlagModel? multipleAccountFeature;
  FeatureAbilityPinModel? pinFeature;
  HoldChatFeatureFlagModel? holdChatFeature;
  FeatureFlagBase? emojiFeature;
  ChatFolderFeatureFlagModel? chatFolderFeature;
  FeatureFlagBase? emojiBookmarkFeature;
  FeatureFlagBase? lockMessageFeature;
  FeatureAbilityLiveLocationModel? liveLocationFeature;
  FeatureFlagBase? coCalendarFeature;
  FeatureFlagBase? pinToAccessFeature;
  FeatureFlagBase? changeFriendProfileFeature;
  FeatureFlagBase? animatedProfileFeature;
  FeatureFlagBase? changeAppIconFeature;
  FeatureFlagBase? lastSeenTimeFeature;
  FeatureFlagBase? hideAccountFeature;
  FeatureFlagBase? privacyAccountFeature;

  List<FeatureFlagBase>? contents;

  FeatureModel({
    this.secretRoomFeature,
    this.multipleAccountFeature,
    this.pinFeature,
    this.holdChatFeature,
    this.emojiFeature,
    this.chatFolderFeature,
    this.emojiBookmarkFeature,
    this.lockMessageFeature,
    this.liveLocationFeature,
    this.coCalendarFeature,
    this.pinToAccessFeature,
    this.changeFriendProfileFeature,
    this.animatedProfileFeature,
    this.changeAppIconFeature,
    this.lastSeenTimeFeature,
    this.hideAccountFeature,
    this.privacyAccountFeature,
    this.contents,
  });

  factory FeatureModel.fromMap(Map<String, dynamic> json) {
    final contents = json.entries.map((e) => FeatureFlagBase.fromMap(e.value)).toList();

    if (contents.isNotEmpty && !contents.any((value) => value.compareThemeContent?.order == null)) {
      contents.sort((a, b) => a.compareThemeContent!.order!.compareTo(b.compareThemeContent!.order!));
    }

    return FeatureModel(
      secretRoomFeature: json['secretRoom'] != null ? FeatureAbilitySecretRoomModel.fromMap(json['secretRoom']) : null,
      multipleAccountFeature:
          json['multipleAccount'] != null ? MultipleAccountFeatureFlagModel.fromMap(json['multipleAccount']) : null,
      pinFeature: json['pin'] != null ? FeatureAbilityPinModel.fromMap(json['pin']) : null,
      holdChatFeature: json['holdChat'] != null ? HoldChatFeatureFlagModel.fromMap(json['holdChat']) : null,
      emojiFeature: json['emoji'] != null ? FeatureFlagBase.fromMap(json['emoji']) : null,
      chatFolderFeature: json['chatFolder'] != null ? ChatFolderFeatureFlagModel.fromMap(json['chatFolder']) : null,
      emojiBookmarkFeature: json['emojiBookmark'] != null ? FeatureFlagBase.fromMap(json['emojiBookmark']) : null,
      lockMessageFeature: json['lockMessage'] != null ? FeatureFlagBase.fromMap(json['lockMessage']) : null,
      liveLocationFeature:
          json['liveLocation'] != null ? FeatureAbilityLiveLocationModel.fromMap(json['liveLocation']) : null,
      coCalendarFeature: json['coCalendar'] != null ? FeatureFlagBase.fromMap(json['coCalendar']) : null,
      pinToAccessFeature: json['pinToAccess'] != null ? FeatureFlagBase.fromMap(json['pinToAccess']) : null,
      changeFriendProfileFeature:
          json['changeFriendProfile'] != null ? FeatureFlagBase.fromMap(json['changeFriendProfile']) : null,
      animatedProfileFeature: json['animatedProfile'] != null ? FeatureFlagBase.fromMap(json['animatedProfile']) : null,
      changeAppIconFeature: json['changeAppIcon'] != null ? FeatureFlagBase.fromMap(json['changeAppIcon']) : null,
      lastSeenTimeFeature: json['lastSeenTime'] != null ? FeatureFlagBase.fromMap(json['lastSeenTime']) : null,
      hideAccountFeature: json['hideAccount'] != null ? FeatureFlagBase.fromMap(json['hideAccount']) : null,
      privacyAccountFeature: json['privacyAccount'] != null ? FeatureFlagBase.fromMap(json['privacyAccount']) : null,
      contents: contents,
    );
  }

  @override
  String toString() =>
      'FeatureModel(secretRoomFeature: $secretRoomFeature, multipleAccountFeature: $multipleAccountFeature, pinFeature: $pinFeature,   holdChatFeature: $holdChatFeature, emojiFeature: $emojiFeature, chatFolderFeature: $chatFolderFeature, emojiBookmark: $emojiBookmarkFeature, lockMessage: $lockMessageFeature, liveLocation: $liveLocationFeature, coCalendar: $coCalendarFeature, pinToAccess: $pinToAccessFeature, changeFriendProfile: $changeFriendProfileFeature, animatedProfile: $animatedProfileFeature, changeAppIcon: $changeAppIconFeature, lastSeenTime: $lastSeenTimeFeature, hideAccount: $hideAccountFeature, privacyAccount: $privacyAccountFeature)';
}
