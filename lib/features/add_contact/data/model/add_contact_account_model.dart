import 'package:uchat/utils/datetime.dart';

class AddContactAccountModel {
  String? type;

  String? userName;

  String? phoneNumber;

  String? appleId;

  String? googleAccount;

  String? email;

  bool? hiddenPhoneNumber;

  String? displayName;

  String? avatarId;

  String? avatarBlurhash;

  String? backgroundId;

  String? backgroundBlurhash;

  DateTime? createdAt;

  String? statusMessage;

  bool? allowGroupMembersToAddFriends;

  bool? friendCanSeeMyLastSeen;

  bool? hiddenMessageNotification;

  bool? allowNotification;

  bool? allowIncomingCall;

  bool? allowCallKit;

  bool? allowAddFriendsByPhoneNumber;

  bool? allowAddFriendByUsername;

  DateTime? lastSeenNotificationAt;

  DateTime? lastSeenAt;

  String? onlineStatus;

  bool? deleted;

  bool? enableChatFolder;

  int? maxChatFolder;

  int? maxRoomInChatFolder;

  DateTime? birthDate;

  String? purchaseRefId;

  String? nickName;

  String? senderNickName;

  AddContactAccountModel({
    this.type,
    this.userName,
    this.phoneNumber,
    this.appleId,
    this.googleAccount,
    this.email,
    this.hiddenPhoneNumber,
    this.displayName,
    this.avatarId,
    this.avatarBlurhash,
    this.backgroundId,
    this.backgroundBlurhash,
    this.createdAt,
    this.statusMessage,
    this.allowGroupMembersToAddFriends,
    this.friendCanSeeMyLastSeen,
    this.hiddenMessageNotification,
    this.allowNotification,
    this.allowIncomingCall,
    this.allowCallKit,
    this.allowAddFriendsByPhoneNumber,
    this.allowAddFriendByUsername,
    this.lastSeenNotificationAt,
    this.lastSeenAt,
    this.onlineStatus,
    this.deleted,
    this.enableChatFolder,
    this.maxChatFolder,
    this.maxRoomInChatFolder,
    this.birthDate,
    this.purchaseRefId,
    this.nickName,
    this.senderNickName,
  });

  factory AddContactAccountModel.fromMap(Map<String, dynamic> data) {
    return AddContactAccountModel(
      type: data['type'],
      userName: data['userName'],
      phoneNumber: data['phoneNumber'],
      appleId: data['appleId'],
      googleAccount: data['googleAccount'],
      email: data['email'],
      hiddenPhoneNumber: data['hiddenPhoneNumber'],
      displayName: data['displayName'],
      avatarId: data['avatarId'],
      avatarBlurhash: data['avatarBlurhash'],
      backgroundId: data['backgroundId'],
      backgroundBlurhash: data['backgroundBlurhash'],
      createdAt: strToDateTime(data['createdAt']),
      statusMessage: data['statusMessage'],
      allowGroupMembersToAddFriends: data['allowGroupMembersToAddFriends'],
      friendCanSeeMyLastSeen: data['friendCanSeeMyLastSeen'],
      hiddenMessageNotification: data['hiddenMessageNotification'],
      allowNotification: data['allowNotification'],
      allowIncomingCall: data['allowIncomingCall'],
      allowCallKit: data['allowCallKit'],
      allowAddFriendsByPhoneNumber: data['allowAddFriendsByPhoneNumber'],
      allowAddFriendByUsername: data['allowAddFriendByUsername'],
      lastSeenNotificationAt: strToDateTime(data['lastSeenNotificationAt']),
      lastSeenAt: strToDateTime(data['lastSeenAt']),
      onlineStatus: data['onlineStatus'],
      deleted: data['deleted'],
      enableChatFolder: data['enableChatFolder'],
      maxChatFolder: data['maxChatFolder'],
      maxRoomInChatFolder: data['maxRoomInChatFolder'],
      birthDate: strToDateTime(data['birthDate']),
      purchaseRefId: data['purchaseRefId'],
      nickName: data['nickName'],
      senderNickName: data['senderNickName'],
    );
  }
}
