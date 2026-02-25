// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/data/models/collections/album_image_collection.dart';
import 'package:uchat/features/album/data/models/models/album_image_model.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/date.dart';

// ignore: depend_on_referenced_packages
import 'package:uuid/uuid.dart';

class MediaFileModel {
  /// The url of the file
  String url;

  /// The path of the file for local file
  String? path;

  /// Decrypted file for lock message.
  File? decryptedFile;

  /// The type of the file [IMAGE, VIDEO, GIF]
  MessageFileType fileType;

  /// The id of the sender account of the file
  /// This is used to determine the name of the sender
  String sentById;

  /// The name of the sender account of the file
  /// This is used to determine the name of the sender
  String sentByName;
  DateTime sentAt;
  String? messageId;
  String? roomId;
  String fileName;
  double? width;
  double? height;

  /// The duration of the video file in milliseconds
  double? duration;

  /// The path of the thumbnail file for local file (only for video)
  String? thumbnailPath;
  double? thumbnailWidth;
  double? thumbnailHeight;
  String? thumbnailFileName;

  /// The hero tag of the file for hero animation
  String? heroTag;

  String? giphyId;

  int? messageSeq;

  String? mimeType;
  String? fileExtension;
  String? fileId;
  int? size;

  /// The id of the album if this media is open from album. Will be null otherwise.
  String? albumId;
  String? albumName;

  MediaFileModel({
    required this.url,
    this.path,
    this.decryptedFile,
    required this.fileType,
    required this.sentById,
    required this.sentByName,
    required this.sentAt,
    this.messageId,
    this.roomId,
    required this.fileName,
    this.width,
    this.height,
    this.duration,
    this.thumbnailPath,
    this.thumbnailWidth,
    this.thumbnailHeight,
    this.thumbnailFileName,
    this.heroTag,
    this.giphyId,
    this.messageSeq,
    this.mimeType,
    this.fileExtension,
    this.fileId,
    this.size,
    this.albumId,
    this.albumName,
  });

  MediaFileModel copyWith({
    String? url,
    String? path,
    File? decryptedFile,
    MessageFileType? fileType,
    String? sentById,
    String? sentByName,
    DateTime? sentAt,
    String? messageId,
    String? roomId,
    String? fileName,
    double? width,
    double? height,
    double? duration,
    String? thumbnailPath,
    double? thumbnailWidth,
    double? thumbnailHeight,
    String? thumbnailFileName,
    String? heroTag,
    String? giphyId,
    int? messageSeq,
    String? mimeType,
    String? fileExtension,
    String? fileId,
    int? size,
    String? albumId,
    String? albumName,
  }) {
    return MediaFileModel(
      url: url ?? this.url,
      path: path ?? this.path,
      decryptedFile: decryptedFile ?? this.decryptedFile,
      fileType: fileType ?? this.fileType,
      sentById: sentById ?? this.sentById,
      sentByName: sentByName ?? this.sentByName,
      sentAt: sentAt ?? this.sentAt,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      fileName: fileName ?? this.fileName,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      thumbnailWidth: thumbnailWidth ?? this.thumbnailWidth,
      thumbnailHeight: thumbnailHeight ?? this.thumbnailHeight,
      thumbnailFileName: thumbnailFileName ?? this.thumbnailFileName,
      heroTag: heroTag ?? this.heroTag,
      giphyId: giphyId ?? this.giphyId,
      messageSeq: messageSeq ?? this.messageSeq,
      mimeType: mimeType ?? this.mimeType,
      fileExtension: fileExtension ?? this.fileExtension,
      fileId: fileId ?? this.fileId,
      size: size ?? this.size,
      albumId: albumId ?? this.albumId,
      albumName: albumName ?? this.albumName,
    );
  }

  static String _findSenderName({
    String? accountId,
    String? roomId,
  }) {
    if (accountId == null || accountId.isEmpty) {
      return 'UNKNOWN'.tr;
    }

    final currentUser = UserController.instance.currentUser();
    // Current user
    if (accountId == currentUser?.id) {
      return currentUser?.displayName ?? 'UNKNOWN'.tr;
    }

    // Contact with nickname
    final contactData = GetIt.I<GetContactSyncUseCase>().call(accountId);
    if (contactData?.nickname?.isNotEmpty == true) {
      return contactData!.nickname!;
    }

    // Contact display name
    if (contactData?.showName != null) {
      return contactData!.showName;
    }

    // Room member
    if (roomId != null) {
      final member = GetIt.I<RoomMemberDb>().getOneMemberInRoomSync(roomId, accountId);
      if (member?.account?.showName != null) {
        return member!.account!.showName;
      }
    }

    return 'UNKNOWN'.tr;
  }

  factory MediaFileModel.fromRoomContactModel(RoomContactModel roomContact) {
    String heroTag = '';
    if (roomContact.type == RoomContactType.contact) {
      /// Hero tag for hero animation
      heroTag = 'CONTACT-${roomContact.contact?.id ?? const Uuid().v4()}';
    } else {
      heroTag = 'CONTACT-${roomContact.room?.ownerId ?? const Uuid().v4()}';
    }

    return MediaFileModel(
      url: roomContact.avatarUrl ?? '',
      fileType: MessageFileType.image,
      sentById: roomContact.id ?? '',
      sentByName: roomContact.name ?? 'UNKNOWN'.tr,
      sentAt: DateTime.now(),
      messageId: null,
      roomId: null,
      fileName: roomContact.avatarUrl ?? '',
      heroTag: heroTag,
    );
  }

  factory MediaFileModel.fromGiphyMessage(MessageCollection messageCollection) {
    // Get sender name
    String sentByName = _findSenderName(
      accountId: messageCollection.accountId,
      roomId: messageCollection.roomId,
    );

    /// Hero tag for hero animation
    String heroTag = 'GIPHY-${messageCollection.id}-${messageCollection.meta!.giphyId}';

    return MediaFileModel(
      url: messageCollection.meta!.gifUrl!,
      fileType: MessageFileType.gif,
      sentById: messageCollection.accountId!,
      sentByName: sentByName,
      sentAt: messageCollection.createdAt!,
      messageId: messageCollection.id,
      roomId: messageCollection.roomId,
      fileName: messageCollection.meta!.gifUrl!,
      heroTag: heroTag,
      giphyId: messageCollection.meta!.giphyId,
      messageSeq: messageCollection.sequence,
      fileId: messageCollection.file!.id,
      mimeType: messageCollection.file!.mime,
      fileExtension: messageCollection.file!.fileExt,
    );
  }

  factory MediaFileModel.fromAlbumImageModel(
    AlbumImageModel albumImageModel, {
    required String albumId,
    required String albumName,
    required String roomId,
  }) {
    String sentByName = _findSenderName(
      accountId: albumImageModel.ownerId,
    );
    return MediaFileModel(
      url: albumImageModel.apiAlbumImageUrl(albumId) ?? '',
      fileType: albumImageModel.imageType != null
          ? MessageFileType.fromString(albumImageModel.imageType)
          : MessageFileType.unknown,
      sentById: albumImageModel.ownerId ?? '',
      sentByName: sentByName,
      sentAt: albumImageModel.createAt ?? DateTime.now(),
      messageId: null,
      roomId: roomId,
      fileName: albumImageModel.imageName ?? '',
      width: albumImageModel.width?.toDouble(),
      height: albumImageModel.height?.toDouble(),
      heroTag: albumImageModel.hero,
      fileId: albumImageModel.imageId,
      mimeType: albumImageModel.mimeType,
      size: albumImageModel.size,
      albumId: albumId,
      albumName: albumName,
    );
  }

  factory MediaFileModel.fromAlbumImageCollection(
    AlbumImageCollection albumImageCollection, {
    required String albumId,
    required String albumName,
    required String roomId,
  }) {
    String sentByName = _findSenderName(
      accountId: albumImageCollection.ownerId,
    );
    return MediaFileModel(
      url: albumImageCollection.imageUrl ?? '',
      fileType: albumImageCollection.imageType != null
          ? MessageFileType.fromString(albumImageCollection.imageType)
          : MessageFileType.unknown,
      sentById: albumImageCollection.ownerId ?? '',
      sentByName: sentByName,
      sentAt: albumImageCollection.createAt ?? DateTime.now(),
      messageId: null,
      roomId: roomId,
      fileName: albumImageCollection.imageName ?? '',
      width: albumImageCollection.width?.toDouble(),
      height: albumImageCollection.height?.toDouble(),
      heroTag: albumImageCollection.hero,
      fileId: albumImageCollection.imageId,
      mimeType: albumImageCollection.mimeType,
      albumId: albumId,
      albumName: albumName,
    );
  }

  factory MediaFileModel.fromAlbumImageEntity(
    AlbumImageEntity albumImageEntity, {
    required String albumId,
    required String albumName,
    required String roomId,
  }) {
    String sentByName = _findSenderName(
      accountId: albumImageEntity.ownerId,
    );
    return MediaFileModel(
      url: albumImageEntity.imageUrl ?? '',
      fileType: albumImageEntity.imageType != null
          ? MessageFileType.fromString(albumImageEntity.imageType)
          : MessageFileType.unknown,
      sentById: albumImageEntity.ownerId ?? '',
      sentByName: sentByName,
      sentAt: albumImageEntity.createAt ?? DateTime.now(),
      messageId: null,
      roomId: roomId,
      fileName: albumImageEntity.imageName ?? '',
      width: albumImageEntity.width?.toDouble(),
      height: albumImageEntity.height?.toDouble(),
      heroTag: albumImageEntity.hero,
      fileId: albumImageEntity.imageId,
      mimeType: albumImageEntity.mimeType,
      albumId: albumId,
      albumName: albumName,
    );
  }

  factory MediaFileModel.fromRoomFileCollection(
    RoomFileCollection roomFileCollection,
  ) {
    final messageFile = roomFileCollection.file;

    if (messageFile == null) {
      throw Exception('Invalid message file');
    }

    // Get sender name
    String sentByName = _findSenderName(
      accountId: messageFile.accountId,
      roomId: roomFileCollection.roomId,
    );

    /// Hero tag for hero animation
    String heroTag = '';
    if (messageFile.type == MessageFileType.image) {
      heroTag = 'IMAGE-${messageFile.id ?? messageFile.refFile}-${messageFile.apiFileUrl}';
    } else if (messageFile.type == MessageFileType.video) {
      heroTag = 'VIDEO-${messageFile.id ?? messageFile.refFile}-${messageFile.apiFileUrl}';
    }

    return MediaFileModel(
      url: messageFile.apiFileUrl ?? '',
      decryptedFile: messageFile.decryptedFile,
      fileType: messageFile.type != null ? messageFile.type! : MessageFileType.unknown,
      sentById: messageFile.accountId ?? '',
      sentByName: sentByName,
      sentAt: messageFile.createdAt ?? DateTime.now(),
      messageId: roomFileCollection.messageId,
      roomId: roomFileCollection.roomId,
      fileName: messageFile.name ?? '',
      width: messageFile.width,
      height: messageFile.height,
      duration: messageFile.duration,
      thumbnailPath: messageFile.thumbnailFileId != null
          ? FileService().getFileUrl(messageFile.thumbnailFileId!)
          : messageFile.url,
      thumbnailWidth: messageFile.thumbnailWidth,
      thumbnailHeight: messageFile.thumbnailHeight,
      thumbnailFileName: messageFile.thumbnailFileName,
      heroTag: heroTag,
      messageSeq: roomFileCollection.messageSeq,
      fileId: messageFile.id,
      mimeType: messageFile.mime,
      fileExtension: messageFile.fileExt,
      size: messageFile.size,
    );
  }

  factory MediaFileModel.fromRoomFileEntity(RoomFileEntity roomFileEntity) {
    final messageFile = roomFileEntity.file;

    // Get sender name
    String sentByName = _findSenderName(
      accountId: messageFile.accountId,
      roomId: roomFileEntity.roomId,
    );

    /// Hero tag for hero animation
    String heroTag = '';
    if (messageFile.type == MessageFileType.image) {
      heroTag = 'IMAGE-${messageFile.id ?? messageFile.refFile}-${messageFile.apiFileUrl}';
    } else if (messageFile.type == MessageFileType.video) {
      heroTag = 'VIDEO-${messageFile.id ?? messageFile.refFile}-${messageFile.apiFileUrl}';
    }

    return MediaFileModel(
      url: messageFile.apiFileUrl ?? '',
      decryptedFile: messageFile.decryptedFile,
      fileType: messageFile.type != null ? messageFile.type! : MessageFileType.unknown,
      sentById: messageFile.accountId ?? '',
      sentByName: sentByName,
      sentAt: messageFile.createdAt ?? DateTime.now(),
      messageId: roomFileEntity.messageId,
      roomId: roomFileEntity.roomId,
      fileName: messageFile.name ?? '',
      width: messageFile.width,
      height: messageFile.height,
      duration: messageFile.duration,
      thumbnailPath: messageFile.thumbnailFileId != null
          ? FileService().getFileUrl(messageFile.thumbnailFileId!)
          : messageFile.url,
      thumbnailWidth: messageFile.thumbnailWidth,
      thumbnailHeight: messageFile.thumbnailHeight,
      heroTag: heroTag,
      messageSeq: roomFileEntity.messageSeq,
      fileId: messageFile.id,
      mimeType: messageFile.mime,
      fileExtension: messageFile.fileExt,
      size: messageFile.size,
    );
  }

  factory MediaFileModel.fromMessageFileModel(
    MessageFileModel messageFile, {
    required int messageSeq,
  }) {
    // Get sender name
    String sentByName = _findSenderName(
      accountId: messageFile.accountId,
      roomId: messageFile.roomId,
    );

    /// Hero tag for hero animation
    String heroTag = '';
    if (messageFile.type == MessageFileType.image) {
      heroTag = 'IMAGE-${messageFile.id ?? messageFile.refFile}-${messageFile.apiFileUrl}';
    } else if (messageFile.type == MessageFileType.video) {
      heroTag = 'VIDEO-${messageFile.id ?? messageFile.refFile}-${messageFile.apiFileUrl}';
    }

    return MediaFileModel(
      url: messageFile.apiFileUrl ?? messageFile.url!,
      decryptedFile: messageFile.decryptedFile,
      fileType: messageFile.type != null ? messageFile.type! : MessageFileType.unknown,
      sentById: messageFile.accountId ?? '',
      sentByName: sentByName,
      sentAt: messageFile.createdAt ?? DateTime.now(),
      messageId: messageFile.messageId,
      roomId: messageFile.roomId,
      fileName: messageFile.name ?? 'UNKNOWN'.tr,
      width: messageFile.width,
      height: messageFile.height,
      duration: messageFile.duration,
      thumbnailPath: messageFile.thumbnailFileId != null
          ? FileService().getFileUrl(messageFile.thumbnailFileId!)
          : messageFile.url,
      thumbnailWidth: messageFile.thumbnailWidth,
      thumbnailHeight: messageFile.thumbnailHeight,
      thumbnailFileName: messageFile.thumbnailFileName,
      heroTag: heroTag,
      messageSeq: messageSeq,
      fileId: messageFile.id,
      mimeType: messageFile.mime,
      fileExtension: messageFile.fileExt,
      size: messageFile.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'path': path,
      'fileType': fileType,
      'sentById': sentById,
      'sentByName': sentByName,
      'sentAt': sentAt.millisecondsSinceEpoch,
      'messageId': messageId,
      'roomId': roomId,
      'fileName': fileName,
      'width': width,
      'height': height,
      'duration': duration,
      'thumbnailPath': thumbnailPath,
      'thumbnailWidth': thumbnailWidth,
      'thumbnailHeight': thumbnailHeight,
      'thumbnailFileName': thumbnailFileName,
      'heroTag': heroTag,
      'giphyId': giphyId,
      'messageSeq': messageSeq,
      'mimeType': mimeType,
      'fileExtension': fileExtension,
      'fileId': fileId,
      'size': size,
    };
  }

  factory MediaFileModel.fromMap(Map<String, dynamic> map) {
    return MediaFileModel(
      url: map['url'] as String,
      path: map['path'] != null ? map['path'] as String : null,
      fileType: MessageFileType.fromString(map['fileType'] as String),
      sentById: map['sentById'] as String,
      sentByName: map['sentByName'] as String,
      sentAt: DateTime.fromMillisecondsSinceEpoch(map['sentAt'] as int),
      messageId: map['messageId'] != null ? map['messageId'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as String : null,
      fileName: map['fileName'] as String,
      width: map['width'] != null ? map['width'] as double : null,
      height: map['height'] != null ? map['height'] as double : null,
      duration: map['duration'] != null ? map['duration'] as double : null,
      thumbnailPath: map['thumbnailPath'] != null ? map['thumbnailPath'] as String : null,
      thumbnailWidth: map['thumbnailWidth'] != null ? map['thumbnailWidth'] as double : null,
      thumbnailHeight: map['thumbnailHeight'] != null ? map['thumbnailHeight'] as double : null,
      thumbnailFileName: map['thumbnailFileName'] != null ? map['thumbnailFileName'] as String : null,
      heroTag: map['heroTag'] != null ? map['heroTag'] as String : null,
      giphyId: map['giphyId'] != null ? map['giphyId'] as String : null,
      messageSeq: map['messageSeq'] != null ? map['messageSeq'] as int : null,
      mimeType: map['mimeType'] != null ? map['mimeType'] as String : null,
      fileExtension: map['fileExtension'] != null ? map['fileExtension'] as String : null,
      fileId: map['fileId'] != null ? map['fileId'] as String : null,
      size: map['size'] != null ? map['size'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaFileModel.fromJson(String source) => MediaFileModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MediaFileModel(url: $url, path: $path, fileType: $fileType, sentById: $sentById, sentByName: $sentByName, sentAt: $sentAt, messageId: $messageId, roomId: $roomId, fileName: $fileName, width: $width, height: $height, duration: $duration, thumbnailPath: $thumbnailPath, thumbnailWidth: $thumbnailWidth, thumbnailHeight: $thumbnailHeight, heroTag: $heroTag, giphyId: $giphyId, messageSeq: $messageSeq, mimeType: $mimeType, fileExtension: $fileExtension, fileId: $fileId)';
  }

  @override
  bool operator ==(covariant MediaFileModel other) {
    if (identical(this, other)) return true;

    // Check only unique key, some case when get new message open incorrect index.
    return other.url == url &&
        other.messageId == messageId &&
        other.fileName == fileName &&
        other.messageSeq == messageSeq;
  }

  @override
  int get hashCode {
    return url.hashCode ^ messageId.hashCode ^ fileName.hashCode ^ messageSeq.hashCode;
  }

  bool get isImage => fileType == MessageFileType.image;

  bool get isGif => fileType == MessageFileType.gif;

  bool get isVideo => fileType == MessageFileType.video;

  bool get isMe {
    final currentUserId = UserController.instance.currentUser()?.id;
    return currentUserId == sentById;
  }

  String get sentAtFormat {
    return sentAt.format('MMM, d yyyy HH:mm');
  }

  String get sentAtStringDesktop {
    return sentAt.format('d LLL y | HH:mm aa');
  }

  String get controllerTag {
    if (heroTag != null) {
      return heroTag!.split('/').last.split('.').join('');
    } else {
      return 'file_previewer_$messageId';
    }
  }
}
