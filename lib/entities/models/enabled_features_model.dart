import 'package:isar_community/isar.dart';
import 'package:uchat/entities/models.dart';

part 'enabled_features_model.g.dart';

@embedded
class EnabledFeaturesModel {
  BookmarkFeatureFlagModel? bookmark;
  CallFeatureFlagModel? call;
  @Deprecated('Use chatFolderV2 instead')
  ChatFolderFeatureFlagModel? chatFolder;
  ChatFolderFeatureFlagModel? chatFolderV2;
  FeatureFlagBase? coin;
  FeatureFlagBase? helpCenter;
  HoldChatFeatureFlagModel? holdChat;
  FeatureFlagBase? lockMessage;
  MultipleAccountFeatureFlagModel? multipleAccount;
  NewMessageEffectFeatureFlagModel? newMessage;
  FeatureAbilityPinModel? pin;
  FeatureFlagBase? premiumStore;
  FeatureFlagBase? previewFont;
  FeatureFlagBase? reactMessage;
  FeatureAbilitySecretRoomModel? secretRoom;
  FeatureFlagBase? talker;
  FeatureFlagBase? troubleshoot;
  FeatureFlagBase? uploadPro;
  FeatureFlagBase? webhook;
  FeatureFlagBase? debugAccount;
  FeatureFlagBase? analytic;
  FeatureFlagBase? groupPermission;
  FeatureFlagBase? useFirebaseState;
  FeatureFlagBase? whoRead;

  EnabledFeaturesModel({
    this.bookmark,
    this.call,
    this.chatFolder,
    this.chatFolderV2,
    this.coin,
    this.helpCenter,
    this.holdChat,
    this.lockMessage,
    this.multipleAccount,
    this.newMessage,
    this.pin,
    this.premiumStore,
    this.previewFont,
    this.reactMessage,
    this.secretRoom,
    this.talker,
    this.troubleshoot,
    this.uploadPro,
    this.webhook,
    this.debugAccount,
    this.analytic,
    this.groupPermission,
    this.useFirebaseState,
    this.whoRead,
  });

  factory EnabledFeaturesModel.fromMap(Map<String, dynamic> json) {
    return EnabledFeaturesModel(
      bookmark: json['bookmark'] != null ? BookmarkFeatureFlagModel.fromMap(json['bookmark']) : null,
      call: json['call'] != null ? CallFeatureFlagModel.fromMap(json['call']) : null,
      chatFolder: json['chatFolder'] != null ? ChatFolderFeatureFlagModel.fromMap(json['chatFolder']) : null,
      chatFolderV2: json['chatFolderV2'] != null ? ChatFolderFeatureFlagModel.fromMap(json['chatFolderV2']) : null,
      coin: json['coin'] != null ? FeatureFlagBase.fromMap(json['coin']) : null,
      helpCenter: json['helpCenter'] != null ? FeatureFlagBase.fromMap(json['helpCenter']) : null,
      holdChat: json['holdChat'] != null ? HoldChatFeatureFlagModel.fromMap(json['holdChat']) : null,
      lockMessage: json['lockMessage'] != null ? FeatureFlagBase.fromMap(json['lockMessage']) : null,
      multipleAccount:
          json['multipleAccount'] != null ? MultipleAccountFeatureFlagModel.fromMap(json['multipleAccount']) : null,
      newMessage:
          json['newMessageEffect'] != null ? NewMessageEffectFeatureFlagModel.fromMap(json['newMessageEffect']) : null,
      pin: json['pin'] != null ? FeatureAbilityPinModel.fromMap(json['pin']) : null,
      premiumStore: json['premiumStore'] != null ? FeatureFlagBase.fromMap(json['premiumStore']) : null,
      previewFont: json['previewFont'] != null ? FeatureFlagBase.fromMap(json['previewFont']) : null,
      reactMessage: json['reactMessage'] != null ? FeatureFlagBase.fromMap(json['reactMessage']) : null,
      secretRoom: json['secretRoom'] != null ? FeatureAbilitySecretRoomModel.fromMap(json['secretRoom']) : null,
      talker: json['talker'] != null ? FeatureFlagBase.fromMap(json['talker']) : null,
      troubleshoot: json['troubleshoot'] != null ? FeatureFlagBase.fromMap(json['troubleshoot']) : null,
      uploadPro: json['uploadPro'] != null ? FeatureFlagBase.fromMap(json['uploadPro']) : null,
      webhook: json['webhook'] != null ? FeatureFlagBase.fromMap(json['webhook']) : null,
      debugAccount: json['debugAccount'] != null ? FeatureFlagBase.fromMap(json['debugAccount']) : null,
      analytic: json['analytic'] != null ? FeatureFlagBase.fromMap(json['analytic']) : null,
      groupPermission: json['groupPermission'] != null ? FeatureFlagBase.fromMap(json['groupPermission']) : null,
      useFirebaseState: json['useFirebaseState'] != null ? FeatureFlagBase.fromMap(json['useFirebaseState']) : null,
      whoRead: json['whoRead'] != null ? FeatureFlagBase.fromMap(json['whoRead']) : null,
    );
  }

  @override
  String toString() {
    return '[EnabledFeatures]\n'
        'bookmark: $bookmark\n'
        'call: $call\n'
        'chatFolder: $chatFolder\n'
        'chatFolderV2: $chatFolderV2\n'
        'coin: $coin\n'
        'helpCenter:$helpCenter\n'
        'holdChat: $holdChat\n'
        'lockMessage: $lockMessage\n'
        'multipleAccount: $multipleAccount\n'
        'newMessage: $newMessage\n'
        'pin: $pin\n'
        'premiumStore: $premiumStore\n'
        'previewFont: $previewFont\n'
        'reactMessage: $reactMessage\n'
        'secretRoom: $secretRoom\n'
        'talker: $talker\n'
        'troubleshoot: $troubleshoot\n'
        'uploadPro: $uploadPro\n'
        'webhook: $webhook\n'
        'debugAccount: $debugAccount\n'
        'analytic: $analytic\n'
        'groupPermission: $groupPermission\n'
        'useFirebaseState: $useFirebaseState\n'
        'whoRead: $whoRead';
  }
}
