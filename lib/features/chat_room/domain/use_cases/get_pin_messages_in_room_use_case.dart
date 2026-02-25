import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/chat_room/data/models/requests/get_pin_messages_request.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_messages_local_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetPinMessagesInRoomUseCase extends SimpleUseCase<PaginationPayload<PinMessageEntity>, GetPinMessagesRequest> {
  GetPinMessagesInRoomUseCase({
    required this.pinMessageLocalRepository,
    required this.pinMessageServerRepository,
  });

  final PinMessageLocalRepository pinMessageLocalRepository;
  final PinMessageServerRepository pinMessageServerRepository;

  @override
  Future<PaginationPayload<PinMessageEntity>> call(GetPinMessagesRequest params) async {
    final serverResponse = await pinMessageServerRepository.getPinMessages(params);

    final pinedList = serverResponse.data?.toList();
    if (pinedList != null && pinedList.isNotEmpty) {
      await pinMessageLocalRepository.pinMessages(
        PinMessagesLocalRequest(
          pinMessages: pinedList,
        ),
      );
    }

    final localResponse = await pinMessageLocalRepository.getPinMessagesInRoom(
      GetPinMessagesRequest(
        roomId: params.roomId,
      ),
    );

    return localResponse;
  }
}
