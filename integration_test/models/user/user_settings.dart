// ==========================================
// SETTINGS CLASSES
// ==========================================

class UserSettings {
  CallSettings? call;
  ChatSettings? chat;
  FriendSettings? friend;
  NotificationSettings? notification;
  ProfileSettings? profile;
  SecuritySettings? security;
  AnalyticSettings? analytic;

  UserSettings({
    this.call,
    this.chat,
    this.friend,
    this.notification,
    this.profile,
    this.security,
    this.analytic,
  });

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      call: json['call'] != null ? CallSettings.fromJson(json['call']) : null,
      chat: json['chat'] != null ? ChatSettings.fromJson(json['chat']) : null,
      friend: json['friend'] != null ? FriendSettings.fromJson(json['friend']) : null,
      notification: json['notification'] != null ? NotificationSettings.fromJson(json['notification']) : null,
      profile: json['profile'] != null ? ProfileSettings.fromJson(json['profile']) : null,
      security: json['security'] != null ? SecuritySettings.fromJson(json['security']) : null,
      analytic: json['analytic'] != null ? AnalyticSettings.fromJson(json['analytic']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'call': call?.toJson(),
      'chat': chat?.toJson(),
      'friend': friend?.toJson(),
      'notification': notification?.toJson(),
      'profile': profile?.toJson(),
      'security': security?.toJson(),
      'analytic': analytic?.toJson(),
    };
  }
}

class CallSettings {
  bool? enabled;
  bool? allowIncomingCall;
  bool? allowCallKit;

  CallSettings({this.enabled, this.allowIncomingCall, this.allowCallKit});

  factory CallSettings.fromJson(Map<String, dynamic> json) => CallSettings(
        enabled: json['enabled'],
        allowIncomingCall: json['allowIncomingCall'],
        allowCallKit: json['allowCallKit'],
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'allowIncomingCall': allowIncomingCall,
        'allowCallKit': allowCallKit,
      };
}

class ChatSettings {
  bool? enabled;
  bool? chatFolder;
  bool? showCategory;
  String? sort;

  ChatSettings({this.enabled, this.chatFolder, this.showCategory, this.sort});

  factory ChatSettings.fromJson(Map<String, dynamic> json) => ChatSettings(
        enabled: json['enabled'],
        chatFolder: json['chatFolder'],
        showCategory: json['showCategory'],
        sort: json['sort'],
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'chatFolder': chatFolder,
        'showCategory': showCategory,
        'sort': sort,
      };
}

class FriendSettings {
  bool? enabled;
  bool? canFriendSeeMyLastSeen;
  AllowFriendAddSettings? allowFriendAdd;

  FriendSettings({this.enabled, this.canFriendSeeMyLastSeen, this.allowFriendAdd});

  factory FriendSettings.fromJson(Map<String, dynamic> json) => FriendSettings(
        enabled: json['enabled'],
        canFriendSeeMyLastSeen: json['canFriendSeeMyLastSeen'],
        allowFriendAdd: json['allowFriendAdd'] != null ? AllowFriendAddSettings.fromJson(json['allowFriendAdd']) : null,
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'canFriendSeeMyLastSeen': canFriendSeeMyLastSeen,
        'allowFriendAdd': allowFriendAdd?.toJson(),
      };
}

class AllowFriendAddSettings {
  bool? enabled;
  bool? canAddByPhoneNumber;
  bool? canAddByUsername;
  bool? canAddFromGroup;

  AllowFriendAddSettings({this.enabled, this.canAddByPhoneNumber, this.canAddByUsername, this.canAddFromGroup});

  factory AllowFriendAddSettings.fromJson(Map<String, dynamic> json) => AllowFriendAddSettings(
        enabled: json['enabled'],
        canAddByPhoneNumber: json['canAddByPhoneNumber'],
        canAddByUsername: json['canAddByUsername'],
        canAddFromGroup: json['canAddFromGroup'],
      );

  Map<String, dynamic> toJson() => {
        'enabled': enabled,
        'canAddByPhoneNumber': canAddByPhoneNumber,
        'canAddByUsername': canAddByUsername,
        'canAddFromGroup': canAddFromGroup,
      };
}

class NotificationSettings {
  bool? enabled;
  bool? hiddenMessage;

  NotificationSettings({this.enabled, this.hiddenMessage});

  factory NotificationSettings.fromJson(Map<String, dynamic> json) => NotificationSettings(
        enabled: json['enabled'],
        hiddenMessage: json['hiddenMessage'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'hiddenMessage': hiddenMessage};
}

class ProfileSettings {
  bool? enabled;
  bool? hiddenPhoneNumber;

  ProfileSettings({this.enabled, this.hiddenPhoneNumber});

  factory ProfileSettings.fromJson(Map<String, dynamic> json) => ProfileSettings(
        enabled: json['enabled'],
        hiddenPhoneNumber: json['hiddenPhoneNumber'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'hiddenPhoneNumber': hiddenPhoneNumber};
}

class SecuritySettings {
  bool? enabled;
  bool? allowMultiFactor;

  SecuritySettings({this.enabled, this.allowMultiFactor});

  factory SecuritySettings.fromJson(Map<String, dynamic> json) => SecuritySettings(
        enabled: json['enabled'],
        allowMultiFactor: json['allowMultiFactor'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled, 'allowMultiFactor': allowMultiFactor};
}

class AnalyticSettings {
  bool? enabled;

  AnalyticSettings({this.enabled});

  factory AnalyticSettings.fromJson(Map<String, dynamic> json) => AnalyticSettings(
        enabled: json['enabled'],
      );

  Map<String, dynamic> toJson() => {'enabled': enabled};
}
