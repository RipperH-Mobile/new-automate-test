import 'package:uchat/features/chat_room/data/models/requests/unpin_message_request.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UnpinMessageParams {
  final String roomId;
  final String? pinId;
  final String? ref;

  UnpinMessageParams({
    required this.roomId,
    this.pinId,
    this.ref,
  });
}

class UnpinMessageUseCase extends SimpleUseCase<void, UnpinMessageParams> {
  UnpinMessageUseCase({
    required this.pinMessageLocalRepository,
    required this.pinMessageServerRepository,
  });

  final PinMessageLocalRepository pinMessageLocalRepository;
  final PinMessageServerRepository pinMessageServerRepository;

  @override
  Future<void> call(UnpinMessageParams params) async {
    String? targetPinId = params.pinId;

    if (targetPinId == null && params.ref != null) {
      final pinMessage = await pinMessageLocalRepository.getPinMessageByRef(params.ref!);
      targetPinId = pinMessage?.id;
    }

    if (targetPinId == null) {
      throw Exception('Either pinId or a valid ref must be provided to unpin a message.');
    }

    final request = UnpinMessageRequest(
      roomId: params.roomId,
      pinId: targetPinId,
    );
    await pinMessageServerRepository.unpinMessage(request);
    await pinMessageLocalRepository.unpinMessage(request);
  }
}
