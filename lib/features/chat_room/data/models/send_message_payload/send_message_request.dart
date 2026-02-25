import 'package:flutter/foundation.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models/mobile_contact_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_meta_model.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request_interface.dart';

class SendMessageRequest implements SendMessageRequestInterface {
  @override
  final Future<void> Function()? onSendFail;

  @override
  final Future<void> Function()? onPermissionDenied;

  @override
  final String ref;

  @override
  final String roomId;

  @override
  final bool? isLocked;

  @override
  final String? replyId;

  final MessageCollection initMessage;
  final MessageCollection message;
  final String? contactId;
  final MobileContactModel? mobileContact;
  final bool? isEncrypted;
  final String? bookmarkTagId;
  final int loopCount;

  SendMessageRequest({
    required this.roomId,
    required this.ref,
    required this.message,
    required this.initMessage,
    this.onSendFail,
    this.onPermissionDenied,
    this.isLocked,
    this.replyId,
    this.contactId,
    this.mobileContact,
    this.isEncrypted,
    this.bookmarkTagId,
    this.loopCount = 1,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> json = {
      'roomId': roomId,
      'message': message.message,
      'type': message.type?.value,
      'contactId': contactId,
      'ref': ref,
      'mobileContact': mobileContact?.toJson(),
      'isEncrypted': isEncrypted,
      'isLocked': isLocked,
      'emojiTagId': bookmarkTagId,
    };

    if (message.links != null) {
      try {
        json['links'] = message.links?.map((link) => link.toMap()).toList() ?? [];
      } catch (e) {
        debugPrint('Error converting links to map: $e');
        json['links'] = [];
      }
    }

    if (message.meta != null) {
      MessageMetaModel meta = message.meta!;
      if (message.type == MessageType.sticker) {
        json['meta'] = {'stickerPack': meta.stickerPack, 'stickerValue': meta.stickerValue};
      }

      if (message.type == MessageType.gif) {
        json['meta'] = {
          'gifUrl': meta.gifUrl,
          'gifMp4Url': meta.gifMp4Url,
          'gifWebpUrl': meta.gifWebpUrl,
          'giphyId': meta.giphyId,
          'gifWidth': meta.gifWidth,
          'gifHeight': meta.gifHeight,
        };
      }

      if (message.type == MessageType.location) {
        json['meta'] = {
          'locationLat': meta.locationLat,
          'locationLng': meta.locationLng,
          'locationName': meta.locationName,
          'locationFormattedAddress': meta.locationFormattedAddress,
          'locationPlacesId': meta.locationPlacesId,
          'locationVicinity': meta.locationVicinity,
        };
      }

      if (message.type == MessageType.stickerSharing) {
        json['meta'] = {
          'stickerPack': meta.stickerPack,
        };
      }

      if (message.type == MessageType.stickerGift) {
        json['meta'] = {
          'stickerPublisher': meta.stickerPublisher,
          'stickerPack': meta.stickerPack,
        };
      }

      if (message.type == MessageType.text) {
        if (message.meta?.isRegEx == true) {
          json['meta'] = {
            'isEmoji': message.meta?.isEmoji,
            'isRegEx': message.meta?.isRegEx,
          };
        }
      }

      if (message.isLocked == true) {
        json['meta'] ??= {};
        json['meta'].addAll({
          'lockMessageSalt': meta.lockMessageSalt,
          'lockMessageIv': meta.lockMessageIv,
          'lockMessageData': meta.lockMessageData,
        });
      }
    }

    if (replyId != null) {
      json['replyId'] = replyId;
    }

    return json;
  }

  @override
  String toString() {
    return '[SendMessageRequest] roomId: $roomId, ref: $ref';
  }
}

class SendMessageResponse {
  final MessageCollection? message;

  SendMessageResponse({this.message});

  factory SendMessageResponse.fromMap(Map<String, dynamic> json) {
    return SendMessageResponse(message: MessageCollection.fromMap(json));
  }
}
