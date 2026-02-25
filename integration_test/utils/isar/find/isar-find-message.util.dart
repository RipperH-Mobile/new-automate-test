import 'package:isar_community/isar.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_subscription_collection.dart';
import '../base/isar-base.util.dart';

class IsarFindMessageUtil extends IsarBaseUtil {
  Future<MessageCollection?> getDetailByAccountIdInMessages(String accountId) async {
    final message = await authDb.messages.where().accountIdEqualTo(accountId).sortByCreatedAtDesc().findFirst();
    return message;
  }

  Future<List<MessageCollection>> getAllMessagesByAccountId(String accountId, String message) async {
    final output = await authDb.messages
        .where()
        .accountIdEqualTo(accountId)
        .filter()
        .messageEqualTo(message)
        .sortByCreatedAtDesc()
        .findAll();
    return output;
  }

  Future<RoomSubscriptionCollection?> getDetailByAccountIdInRoomSubscription(String accountId) async {
    final message = await authDb.roomSubscription.where().accountIdEqualTo(accountId).sortByCreatedAtDesc().findFirst();
    return message;
  }
}
