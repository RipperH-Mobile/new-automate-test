import 'dart:math';

import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/utilities/mongo_id_generator.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/entities/manager.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_member_in_room_use_case.dart';
import 'package:uchat/features/sync/domain/typedefs.dart';
import 'package:uchat/features/sync/domain/use_cases/sync_handle_update_message_use_case.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/collections/message_collection.dart';
import '../params/chat_room_params.dart';

class DebugSendMockMessageParams {
  final String roomId;
  final int delay;
  final int amount;

  DebugSendMockMessageParams({
    required this.roomId,
    required this.delay,
    required this.amount,
  });
}

///
/// Use case to send mock messages in a chat room.
/// Can random member for testing purpose.
///
class DebugSendMockMessageUseCase extends SimpleUseCase<void, DebugSendMockMessageParams> {
  SyncHandleUpdateMessageUseCase get syncHandleUpdateMessageUseCase {
    return GetIt.I<SyncHandleUpdateMessageUseCase>();
  }

  @override
  Future<void> call(DebugSendMockMessageParams params) async {
    // Random member
    final random = Random();
    final members = await GetIt.I<GetAllMemberInRoomUseCase>().call(ChatRoomParams(roomId: params.roomId));

    final mongoGenerator = MongoIdGenerator();

    // print('ZZZ => Setting mock message for roomId: ${params.roomId}, amount: ${params.amount}, delay: ${params.delay}');

    for (int i = 0; i < params.amount; i++) {
      final member = members[random.nextInt(members.length)];

      final messageGenerated = 'Mock message $i';
      final ref = '${UserController.instance.currentUser()!.id}-${const Uuid().v4()}';

      // Send message event only local.
      final message = MessageCollection(
        id: mongoGenerator.generate(),
        roomId: params.roomId,
        ref: ref,
        accountId: member.account.id,
        message: messageGenerated,
        searchMessage: messageGenerated,
        type: MessageType.text,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        account: ContactModel.fromRoomMember(RoomMemberCollection.fromEntity(member)),
        sequence: DateTime.now().millisecondsSinceEpoch,
        isEncrypted: false,
        historyForAccountId: UserController.instance.currentUser.value?.id,
      );

      final EventListCallback eventCbList = [];
      await DbManager().authenticatedInstance?.writeTxn(() async {
        final eventCbs = await syncHandleUpdateMessageUseCase.call(SyncHandleUpdateMessageParams(
          receiveMessage: message,
        ));
        // print('ZZZ => eventCB length: ${eventCbs.length}');
        eventCbList.addAll(eventCbs);
      });

      // print('ZZZ => eventCbList length: ${eventCbList.length}');
      for (final eventCb in eventCbList) {
        // print('ZZZ => call eventCb');
        eventCb();
      }

      // print(
      //   'ZZZ => Mock message [$messageGenerated], roomId: ${message.roomId}, accountId: ${message.accountId}, ref: ${message.ref}',
      // );

      await Future.delayed(Duration(milliseconds: params.delay));
    }
  }
}
