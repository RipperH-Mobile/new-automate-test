import 'package:recase/recase.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/entities/models/user_typing_model.dart';
import 'package:uchat/features/album/data/models/collections/album_collection.dart';
import 'package:uchat/features/call_log/data/models/collections/call_log_collection.dart';
import 'package:uchat/features/central_notification/domain/entities/notification_center_account_deleted_entity.dart';
import 'package:uchat/features/chat_folder/domain/entities/room_subscription_with_chat_folder_meta_entity.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/pin_message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/bookmark_tag_model.dart';
import 'package:uchat/features/chat_room/data/models/responses/update_message_reaction_response.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/sticker/data/models/models/reorder_sticker_model.dart';
import 'package:uchat/features/sync/data/models/entities/assign_admin_state_data_model.dart';
import 'package:uchat/features/sync/data/models/entities/ownership_transferred_state_data_model.dart';
import 'package:uchat/features/sync/data/models/entities/remove_member_state_data_model.dart';
import 'package:uchat/utils/datetime.dart';

import '../enum/state_group.dart';
import '../enum/update_state_type.dart';
import 'member_state_data_model.dart';

class UpdateStateModel {
  final String id;
  final String accountId;
  final StateGroup group;
  final UpdateStateType type;
  final int seq;
  final DateTime? createdAt;
  final dynamic data;

  UpdateStateModel({
    required this.id,
    required this.accountId,
    required this.group,
    required this.type,
    required this.seq,
    this.createdAt,
    required this.data,
  });

  factory UpdateStateModel.fromMap(Map<String, dynamic> json) {
    final String type = json['type'];
    final stateType = UpdateStateType.from(type.camelCase);
    final group = StateGroup.from(json['group']);

    return UpdateStateModel(
      id: json['_id'],
      accountId: json['accountId'],
      type: stateType,
      seq: json['seq'],
      data: json['data'],
      createdAt: strToDateTime(json['createdAt']),
      group: group,
    );
  }

  RoomCollection? get room {
    return RoomCollection.fromMap(data);
  }

  RoomSubscriptionCollection? get roomSubscription {
    return RoomSubscriptionCollection.fromMap(data);
  }

  RoomSubscriptionCollection? get roomSubInRoom {
    if (data['mySubscription'] == null) return null;
    return RoomSubscriptionCollection.fromMap(data['mySubscription']);
  }

  RemoveMemberStateDataModel? get removeMembersData {
    return RemoveMemberStateDataModel.fromMap(data);
  }

  MemberStateDataModel? get membersData {
    return MemberStateDataModel.fromMap(data);
  }

  UserTypingModel? get userTyping {
    return UserTypingModel.fromMap(data);
  }

  MessageCollection? get message {
    return MessageCollection.fromMap(data);
  }

  ContactCollection? get contact {
    return ContactCollection.fromMap(data);
  }

  UserCollection? get user {
    return UserCollection.fromMap(data);
  }

  AlbumCollection? get album {
    return AlbumCollection.fromJson(data);
  }

  CoinUpdateResponse? get coinUpdate {
    return CoinUpdateResponse.fromMap(data);
  }

  BookmarkTagModel? get bookmarkTag {
    return BookmarkTagModel.fromMap(data);
  }

  CallLogCollection? get callLog {
    return CallLogCollection.fromJson(data);
  }

  ReorderStickerModel get reorderSticker {
    return ReorderStickerModel.fromJson(data);
  }

  AssignAdminStateDataModel get assignAdmin {
    return AssignAdminStateDataModel.fromJson(data);
  }

  OwnershipTransferredStateDataModel get ownershipTransferred {
    return OwnershipTransferredStateDataModel.fromJson(data);
  }

  UpdateMessageReactionResponse get updateMessageReaction {
    return UpdateMessageReactionResponse.fromMap(data);
  }

  PinMessageCollection get pinMessage {
    return PinMessageCollection.fromJson(data);
  }

  List<RoomSubscriptionWithChatFolderMetaEntity> get chatFolderUpdateRoomSubscription {
    if (data['subscriptions'] == null) return [];

    final List<RoomSubscriptionWithChatFolderMetaEntity> roomSubs = [];
    for (final roomSub in data['subscriptions'] as List) {
      roomSubs.add(RoomSubscriptionWithChatFolderMetaEntity.fromMap(roomSub as Map<String, dynamic>));
    }

    return roomSubs;
  }

  List<BookmarkTagModel> get deletedBookmarkEmojiTags {
    if (type != UpdateStateType.deleteBookmarkEmojiTag) return [];

    if (data is List) {
      return (data as List<dynamic>)
          .map((item) {
            if (item is Map<String, dynamic>) {
              return BookmarkTagModel.fromMap(item);
            } else {
              return null;
            }
          })
          .whereType<BookmarkTagModel>()
          .toList();
    } else {
      return [];
    }
  }

  GroupPermissionEntity get updateRoomPermissions {
    return GroupPermissionEntity.fromJson(data);
  }

  NotificationCenterAccountDeletedEntity get notificationCenterAccountDeleted {
    return NotificationCenterAccountDeletedEntity.fromJson(data);
  }

  @override
  String toString() {
    return 'SEQ: $group-$seq, Type: $type, ID: $id';
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateStateModel && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
