import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';

// TODO (improve) maybe this class is not necessary. Maybe remove this class ???
class RoomDataModel {
  Rx<RoomCollection?> room = Rx<RoomCollection?>(null);
  Rx<RoomSubscriptionCollection?> roomSub = Rx<RoomSubscriptionCollection?>(null);
  RxList<RoomMemberCollection> members = <RoomMemberCollection>[].obs;

  static Future<RoomDataModel> fromRoomSubscription(
    RoomSubscriptionCollection roomSub, {
    bool getRoomFromLocalDb = false,
    bool getMemberFromLocalDb = false,
  }) async {
    final model = RoomDataModel();
    model.roomSub.value = roomSub;
    if (getRoomFromLocalDb) {
      model.room.value = await GetIt.I<RoomDb>().getRoom(model.id ?? '');
    }
    if (getMemberFromLocalDb) {
      model.members(GetIt.I<RoomMemberDb>().getAllMemberInRoomSync(roomSub.roomId ?? ''));
    }

    return model;
  }

  static Future<RoomDataModel> fromRoom(
    RoomCollection room, {
    bool getRoomSubFromLocalDb = false,
    bool getMemberFromLocalDb = false,
  }) async {
    final model = RoomDataModel();
    if (getRoomSubFromLocalDb) {
      model.roomSub.value = await GetIt.I<RoomSubscriptionDb>().getRoomSubscriptionWithRoomId(room.id ?? '');
    }
    model.room.value = room;
    if (getMemberFromLocalDb) {
      model.members(GetIt.I<RoomMemberDb>().getAllMemberInRoomSync(room.id ?? ''));
    }
    return model;
  }

  void refresh() {
    room.refresh();
    roomSub.refresh();
    members.refresh();
  }

  String? get id {
    return room()?.id ?? roomSub()?.roomId;
  }
}
