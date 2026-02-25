import 'package:uchat/features/chat_room/data/models/requests/pin_message_request.dart';
import 'package:uchat/features/chat_room/domain/entities/pin_message_entity.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/data/models/requests/pin_message_local_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class PinMessageParams {
  final String messageId;
  final String roomId;

  PinMessageParams({
    required this.messageId,
    required this.roomId,
  });
}

class PinMessageUseCase extends SimpleUseCase<void, PinMessageParams> {
  PinMessageUseCase({
    required this.pinMessageLocalRepository,
    required this.pinMessageServerRepository,
    required this.messageLocalRepository,
  });

  final PinMessageLocalRepository pinMessageLocalRepository;
  final PinMessageServerRepository pinMessageServerRepository;
  final MessageLocalRepository messageLocalRepository;

  @override
  Future<void> call(PinMessageParams params) async {
    // Get pinned message from server
    final PinMessageEntity serverResponse = await pinMessageServerRepository.pinMessage(
      PinMessageRequest(
        roomId: params.roomId,
        messageId: params.messageId,
      ),
    );

    // Save to local storage (encryption handling will be done automatically)
    await pinMessageLocalRepository.pinMessage(
      PinMessageLocalRequest(pinMessage: serverResponse),
    );
  }
}
