import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import 'package:uchat/features/chat_room/domain/entities/group_permission_entity.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';

class InitStateModel {
  @Deprecated('Change to defaultSeq, messageSeq and [groupName]Seq.')
  int? seq;

  List<RoomCollection>? rooms;
  List<RoomSubscriptionCollection>? roomSubs;
  List<ContactCollection>? contacts;
  List<GroupPermissionEntity>? groupPermissions;

  int defaultSeq = 0;
  int messageSeq = 0;
  int roomSeq = 0;
  int roomSubscriptionSeq = 0;
  int friendSeq = 0;

  InitStateModel({
    this.seq,
    this.defaultSeq = 0,
    this.messageSeq = 0,
    this.roomSeq = 0,
    this.roomSubscriptionSeq = 0,
    this.friendSeq = 0,
    this.rooms,
    this.contacts,
    this.groupPermissions,
  });
}
