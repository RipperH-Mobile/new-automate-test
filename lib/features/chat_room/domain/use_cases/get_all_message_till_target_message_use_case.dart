import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/params/get_all_message_till_target_message_param.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_sent_message_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetAllMessageTillTargetMessageUseCase extends SimpleUseCase<void, GetAllMessageTillTargetMessageParam> {
  final roomSubLocalRepo = GetIt.I<RoomSubLocalRepository>();

  @override
  Future<void> call(GetAllMessageTillTargetMessageParam params) async {
    final roomId = params.roomId;
    final roomSub = await roomSubLocalRepo.getRoomSubscriptionWithRoomId(roomId);

    if (roomSub != null) {
      final sequenceOfVeryFirstMessageInRoom = roomSub.firstSequence ?? 0;
      final targetMessageSeq = params.message.sequence ?? 0;

      bool foundTargetMessage = false;
      int sequenceOfTopMessage = DateTime.now().millisecondsSinceEpoch;

      while (!foundTargetMessage) {
        final moreMessages = await GetIt.I<GetAllSentMessageUseCase>().call(GetAllSentMessageParams(
          roomId: roomId,
          sequenceLessThan: sequenceOfTopMessage,
          sequenceOfVeryFirstMessageInRoom: sequenceOfVeryFirstMessageInRoom,
        ));

        final messageIndex = findMessage(targetMessageSeq, moreMessages.toCollections());
        sequenceOfTopMessage = moreMessages.lastOrNull?.sequence ?? 0;

        if (messageIndex != -1) {
          foundTargetMessage = true;
        }
      }
    }
  }

  int findMessage(int targetMessageSeq, List<MessageCollection> messages) {
    return messages.indexWhere((msgElement) => msgElement.sequence == targetMessageSeq);
  }
}
