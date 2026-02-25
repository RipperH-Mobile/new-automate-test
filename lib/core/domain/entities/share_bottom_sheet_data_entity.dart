import 'dart:io';

import 'package:uchat/core/domain/entities/share_message_selection_entity.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/album/domain/album_domain.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

/// This Entity represent all data to be share such as All selected messages or All selection album image.
class ShareBottomSheetDataEntity {
  /// If sharing message from chat room or share media from room detail, Put that message data in here.
  List<ShareMessageSelectionEntity>? messageList;

  /// If sharing image from album, put image data in here.
  ShareAlbumImageEntity? albumImageList;

  /// If sending new message (But it is share from user POV) such as share contact from room detail, Put that message
  /// data in here.
  MessageCollection? newMessage;

  /// If sending new file (But it is share from user POV) such as share my qr code, Put that file in here.
  FileInfoModel? newFile;

  List<File>? fileList;

  ShareBottomSheetDataEntity({
    this.messageList,
    this.albumImageList,
    this.newMessage,
    this.newFile,
    this.fileList,
  }) : assert(
          messageList != null || albumImageList != null || newMessage != null || newFile != null || fileList != null,
          'At least one property must not be null',
        );
}
