// -- Sub Feature Classes --

class BaseFeature {
  bool? enabled;
  bool? isTest;

  BaseFeature({this.enabled, this.isTest});

  factory BaseFeature.fromJson(Map<String, dynamic> json) {
    return BaseFeature(
      enabled: json['enabled'],
      isTest: json['isTest'],
    );
  }

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        if (isTest != null) 'isTest': isTest,
      };
}

class SecretRoomFeature {
  bool? enabled;
  int? maxSecond;

  SecretRoomFeature({this.enabled, this.maxSecond});

  factory SecretRoomFeature.fromJson(Map<String, dynamic> json) => SecretRoomFeature(
        enabled: json['enabled'],
        maxSecond: json['maxSecond'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'maxSecond': maxSecond};
}

class MultipleAccountFeature {
  bool? enabled;
  bool? canUseShortCutPasscode;
  bool? canHideFromList;
  int? maxMultipleAccount;

  MultipleAccountFeature({this.enabled, this.canUseShortCutPasscode, this.canHideFromList, this.maxMultipleAccount});

  factory MultipleAccountFeature.fromJson(Map<String, dynamic> json) => MultipleAccountFeature(
        enabled: json['enabled'],
        canUseShortCutPasscode: json['canUseShortCutPasscode'],
        canHideFromList: json['canHideFromList'],
        maxMultipleAccount: json['maxMultipleAccount'],
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'canUseShortCutPasscode': canUseShortCutPasscode,
        'canHideFromList': canHideFromList,
        'maxMultipleAccount': maxMultipleAccount,
      };
}

class HoldChatFeature {
  bool? enabled;
  bool? withScroll;

  HoldChatFeature({this.enabled, this.withScroll});

  factory HoldChatFeature.fromJson(Map<String, dynamic> json) => HoldChatFeature(
        enabled: json['enabled'],
        withScroll: json['withScroll'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'withScroll': withScroll};
}

class NewMessageEffectFeature {
  bool? enabled;
  bool? animation;
  bool? sound;

  NewMessageEffectFeature({this.enabled, this.animation, this.sound});

  factory NewMessageEffectFeature.fromJson(Map<String, dynamic> json) => NewMessageEffectFeature(
        enabled: json['enabled'],
        animation: json['animation'],
        sound: json['sound'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'animation': animation, 'sound': sound};
}

class ChatFolderFeature {
  bool? enabled;
  int? maxChatFolder;
  int? maxRoomInChatFolder;

  ChatFolderFeature({this.enabled, this.maxChatFolder, this.maxRoomInChatFolder});

  factory ChatFolderFeature.fromJson(Map<String, dynamic> json) => ChatFolderFeature(
        enabled: json['enabled'],
        maxChatFolder: json['maxChatFolder'],
        maxRoomInChatFolder: json['maxRoomInChatFolder'],
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'maxChatFolder': maxChatFolder,
        'maxRoomInChatFolder': maxRoomInChatFolder,
      };
}

class PinFeature {
  bool? enabled;
  int? maxPin;

  PinFeature({this.enabled, this.maxPin});

  factory PinFeature.fromJson(Map<String, dynamic> json) => PinFeature(
        enabled: json['enabled'],
        maxPin: json['maxPin'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'maxPin': maxPin};
}

class BookmarkFeature {
  bool? enabled;
  bool? emojiTag;

  BookmarkFeature({this.enabled, this.emojiTag});

  factory BookmarkFeature.fromJson(Map<String, dynamic> json) => BookmarkFeature(
        enabled: json['enabled'],
        emojiTag: json['emojiTag'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'emojiTag': emojiTag};
}

class ExperienceFeature {
  bool? enabled;
  bool? shareScreen;
  bool? pip;
  bool? whoRead;
  bool? virtualBackground;
  bool? beautyFilter;
  bool? stickerSendingTransition;

  ExperienceFeature({
    this.enabled,
    this.shareScreen,
    this.pip,
    this.whoRead,
    this.virtualBackground,
    this.beautyFilter,
    this.stickerSendingTransition,
  });

  factory ExperienceFeature.fromJson(Map<String, dynamic> json) => ExperienceFeature(
        enabled: json['enabled'],
        shareScreen: json['shareScreen'],
        pip: json['pip'],
        whoRead: json['whoRead'],
        virtualBackground: json['virtualBackground'],
        beautyFilter: json['beautyFilter'],
        stickerSendingTransition: json['stickerSendingTransition'],
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'shareScreen': shareScreen,
        'pip': pip,
        'whoRead': whoRead,
        'virtualBackground': virtualBackground,
        'beautyFilter': beautyFilter,
        'stickerSendingTransition': stickerSendingTransition,
      };
}