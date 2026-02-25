import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';

/// `RoomCapabilityEntity` with two constant presets *and*
/// a factory that decides which one to return.
///
/// Usage:
///   final cap = RoomCapabilityEntity.from(isOfficialAccount);
///
class RoomCapabilityEntity {
  // ─────────────────────────────────── disable flags
  final bool disableCall;
  final bool disableCamera;
  final bool disableSendMessage;
  final bool disableSendImage;
  final bool disableSendVideo;
  final bool disableSendFile;
  final bool disableSendLocation;
  final bool disableSendContact;
  final bool disableSendVoice;
  final bool disableSendGif;
  final bool disableSendSticker;
  final bool disableEditMessage;
  final bool disableUnsendMessage;
  final bool disableDeleteMessage;
  final bool disableReportMessage;
  final bool disableReplyMessage;
  final bool disableSwipeToReplyMessage;
  final bool disableEditNameMenu;
  final bool disableMediaMenu;
  final bool disableFilesMenu;
  final bool disableAlbumMenu;
  final bool disableEmojiReaction;
  final bool disableMentionAll;

  const RoomCapabilityEntity._({
    this.disableCall = false,
    this.disableCamera = false,
    this.disableSendMessage = false,
    this.disableSendImage = false,
    this.disableSendVideo = false,
    this.disableSendFile = false,
    this.disableSendLocation = false,
    this.disableSendContact = false,
    this.disableSendVoice = false,
    this.disableSendGif = false,
    this.disableSendSticker = false,
    this.disableEditMessage = false,
    this.disableUnsendMessage = false,
    this.disableDeleteMessage = false,
    this.disableReportMessage = false,
    this.disableReplyMessage = false,
    this.disableSwipeToReplyMessage = false,
    this.disableEditNameMenu = false,
    this.disableMediaMenu = false,
    this.disableFilesMenu = false,
    this.disableAlbumMenu = false,
    this.disableEmojiReaction = false,
    this.disableMentionAll = false,
  });

  /// Everything **enabled**
  static const direct = RoomCapabilityEntity._();

  /// Everything **disabled**
  static const official = RoomCapabilityEntity._(
    disableCall: true,
    disableCamera: false,
    disableSendMessage: false,
    disableSendImage: false,
    disableSendVideo: true,
    disableSendFile: false,
    disableSendLocation: true,
    disableSendContact: true,
    disableSendVoice: true,
    disableSendGif: true,
    disableSendSticker: true,
    disableEditMessage: true,
    disableUnsendMessage: true,
    disableDeleteMessage: true,
    disableReportMessage: true,
    disableReplyMessage: false,
    disableSwipeToReplyMessage: false,
    disableEditNameMenu: true,
    disableMediaMenu: false,
    disableFilesMenu: false,
    disableAlbumMenu: true,
  );

  static const groupOwner = RoomCapabilityEntity._();

  /// Factory method to create a `RoomCapabilityEntity` based on the type
  factory RoomCapabilityEntity.fromGroupPermission(GroupPermissionEntity? groupPermission) {
    if (groupPermission?.enable == false) {
      return const RoomCapabilityEntity._();
    }
    return RoomCapabilityEntity._(
      disableCall: false,
      disableSendMessage: !(groupPermission?.canSendMessages ?? true),
      disableCamera: !(groupPermission?.canSendMedia ?? true),
      disableSendImage: !(groupPermission?.canSendMedia ?? true),
      disableSendVideo: !(groupPermission?.canSendMedia ?? true),
      disableSendFile: !(groupPermission?.canSendMedia ?? true),
      disableSendLocation: !(groupPermission?.canSendMedia ?? true),
      disableSendContact: !(groupPermission?.canSendMedia ?? true),
      disableSendVoice: !(groupPermission?.canSendMedia ?? true),
      disableSendGif: !(groupPermission?.canSendMedia ?? true),
      disableSendSticker: !(groupPermission?.canSendMedia ?? true),
      disableEditMessage: !(groupPermission?.canEditOwnMessage ?? true),
      disableUnsendMessage: !(groupPermission?.canUnsendOwnMessage ?? true),
      disableDeleteMessage: false,
      disableReportMessage: false,
      disableReplyMessage: !(groupPermission?.canSendMessages ?? true),
      disableSwipeToReplyMessage: !(groupPermission?.canSendMessages ?? true),
      disableEditNameMenu: false,
      disableMediaMenu: !(groupPermission?.canSendMedia ?? true),
      disableFilesMenu: !(groupPermission?.canSendMedia ?? true),
      disableAlbumMenu: !(groupPermission?.canAddDeleteAlbum ?? true),
      disableEmojiReaction: !(groupPermission?.canReactions ?? true),
      disableMentionAll: !(groupPermission?.canMentionAll ?? true),
    );
  }

  @override
  String toString() {
    return 'RoomCapabilityEntity(disableCall: $disableCall, disableCamera: $disableCamera, disableSendMessage: $disableSendMessage, disableSendImage: $disableSendImage, disableSendVideo: $disableSendVideo, disableSendFile: $disableSendFile, disableSendLocation: $disableSendLocation, disableSendContact: $disableSendContact, disableSendVoice: $disableSendVoice, disableSendGif: $disableSendGif, disableSendSticker: $disableSendSticker, disableEditMessage: $disableEditMessage, disableUnsendMessage: $disableUnsendMessage, disableDeleteMessage: $disableDeleteMessage, disableReportMessage: $disableReportMessage, disableReplyMessage: $disableReplyMessage, disableSwipeToReplyMessage: $disableSwipeToReplyMessage, disableEditNameMenu: $disableEditNameMenu, disableMediaMenu: $disableMediaMenu, disableFilesMenu: $disableFilesMenu, disableAlbumMenu: $disableAlbumMenu, disableEmojiReaction: $disableEmojiReaction, disableMentionAll: $disableMentionAll)';
  }

  RoomCapabilityEntity copyWith({
    bool? disableCall,
    bool? disableCamera,
    bool? disableSendMessage,
    bool? disableSendImage,
    bool? disableSendVideo,
    bool? disableSendFile,
    bool? disableSendLocation,
    bool? disableSendContact,
    bool? disableSendVoice,
    bool? disableSendGif,
    bool? disableSendSticker,
    bool? disableEditMessage,
    bool? disableUnsendMessage,
    bool? disableDeleteMessage,
    bool? disableReportMessage,
    bool? disableReplyMessage,
    bool? disableSwipeToReplyMessage,
    bool? disableEditNameMenu,
    bool? disableMediaMenu,
    bool? disableFilesMenu,
    bool? disableAlbumMenu,
    bool? disableEmojiReaction,
    bool? disableMentionAll,
  }) {
    return RoomCapabilityEntity._(
      disableCall: disableCall ?? this.disableCall,
      disableCamera: disableCamera ?? this.disableCamera,
      disableSendMessage: disableSendMessage ?? this.disableSendMessage,
      disableSendImage: disableSendImage ?? this.disableSendImage,
      disableSendVideo: disableSendVideo ?? this.disableSendVideo,
      disableSendFile: disableSendFile ?? this.disableSendFile,
      disableSendLocation: disableSendLocation ?? this.disableSendLocation,
      disableSendContact: disableSendContact ?? this.disableSendContact,
      disableSendVoice: disableSendVoice ?? this.disableSendVoice,
      disableSendGif: disableSendGif ?? this.disableSendGif,
      disableSendSticker: disableSendSticker ?? this.disableSendSticker,
      disableEditMessage: disableEditMessage ?? this.disableEditMessage,
      disableUnsendMessage: disableUnsendMessage ?? this.disableUnsendMessage,
      disableDeleteMessage: disableDeleteMessage ?? this.disableDeleteMessage,
      disableReportMessage: disableReportMessage ?? this.disableReportMessage,
      disableReplyMessage: disableReplyMessage ?? this.disableReplyMessage,
      disableSwipeToReplyMessage: disableSwipeToReplyMessage ?? this.disableSwipeToReplyMessage,
      disableEditNameMenu: disableEditNameMenu ?? this.disableEditNameMenu,
      disableMediaMenu: disableMediaMenu ?? this.disableMediaMenu,
      disableFilesMenu: disableFilesMenu ?? this.disableFilesMenu,
      disableAlbumMenu: disableAlbumMenu ?? this.disableAlbumMenu,
      disableEmojiReaction: disableEmojiReaction ?? this.disableEmojiReaction,
      disableMentionAll: disableMentionAll ?? this.disableMentionAll,
    );
  }
}
