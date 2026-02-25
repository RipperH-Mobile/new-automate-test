import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/controllers/real_time_database_controller.dart';
import 'package:uchat/entities/collections/user_collection.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/entities/models/room_contact_model.dart';
import 'package:uchat/entities/models/room_data_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_members_in_room_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_block_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_vibranium_shield_use_case.dart';

class OnlineStatusUtil {
  static UserController userController = UserController.instance;
  static String? myAccountId = userController.currentUser()?.id;
  static Map<dynamic, dynamic> onlineUsers = RealTimeDatabaseController.instance.onlineUsers;
  static Rx<OnlineStatus> getRxOnlineStatus(dynamic data) {
    if (data is RoomCollection) {
      if (data.isDirect) {
        final otherAccountId = data.firstOtherInRoom?.accountId;
        return getRxOnlineStatusDirectRoom(accountId: otherAccountId);
      } else if (data.isGroup) {
        final groupId = data.id;
        return getRxOnlineStatusGroupRoom(groupId: groupId);
      }
    } else if (data is RoomDataModel) {
      if (data.roomSub()?.isDirect == true) {
        final otherAccountId = data.room()?.firstOtherInRoom?.accountId;
        return getRxOnlineStatusDirectRoom(accountId: otherAccountId);
      } else if (data.roomSub()?.isGroup == true) {
        final groupId = data.id;
        return getRxOnlineStatusGroupRoom(groupId: groupId);
      }
    } else if (data is ContactInterface) {
      if (userController.isCurrentUser(data.id ?? '') &&
          (userController.currentUser()?.accountSettings?.friend?.canFriendSeeMyLastSeen ?? false)) {
        return getRxOnlineStatusDirectRoom(accountId: myAccountId);
      } else {
        final otherAccountId = data.id;
        return getRxOnlineStatusDirectRoom(accountId: otherAccountId);
      }
    } else if (data is RoomMemberCollection) {
      final otherAccountId = data.accountId;
      return getRxOnlineStatusDirectRoom(accountId: otherAccountId);
    } else if (data is RoomContactModel) {
      final otherAccountId = data.id;
      return getRxOnlineStatusDirectRoom(accountId: otherAccountId);
    } else if (data is UserCollection) {
      return getRxOnlineStatusDirectRoom(accountId: myAccountId);
    }
    return OnlineStatus.offline.obs;
  }

  static Rx<OnlineStatus> getRxOnlineStatusDirectRoom({required String? accountId}) {
    if (accountId == null) return OnlineStatus.offline.obs;

    final responseIsBlock = GetIt.I<GetRoomDirectIsBlockUseCase>().call(accountId);
    final responseIsVibraniumShield = GetIt.I<GetRoomDirectIsVibraniumShieldUseCase>().call(accountId);
    if (responseIsBlock || responseIsVibraniumShield) {
      return OnlineStatus.offline.obs;
    }

    if (onlineUsers[accountId] != null) {
      return OnlineStatus.online.obs;
    } else {
      return OnlineStatus.offline.obs;
    }
  }

  static Rx<OnlineStatus> getRxOnlineStatusGroupRoom({required String? groupId}) {
    if (groupId == null) return OnlineStatus.offline.obs;

    final allMembers = GetIt.I<GetAllMembersInRoomUseCase>().call(groupId);

    final isSomeOneInGroupOnline = allMembers.any((member) {
      final accountId = member.account.id;
      if (accountId == null) {
        return false;
      }

      final isOnline = onlineUsers[accountId] != null;
      final isBlocked = GetIt.I<GetRoomDirectIsBlockUseCase>().call(accountId);
      final isShielded = GetIt.I<GetRoomDirectIsVibraniumShieldUseCase>().call(accountId);

      return accountId != myAccountId && isOnline && isBlocked != true && isShielded != true;
    });

    if (isSomeOneInGroupOnline) {
      return OnlineStatus.online.obs;
    } else {
      return OnlineStatus.offline.obs;
    }
  }
}
