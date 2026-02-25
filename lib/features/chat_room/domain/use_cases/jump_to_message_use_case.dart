import 'package:get/get.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/data/models/mapper/message_mapper_extensions.dart';
import 'package:uchat/features/chat_room/data/models/mapper/room_mapper_extensions.dart';
import 'package:uchat/features/chat_room/domain/params/chat_room_arguments.dart';
import 'package:uchat/features/chat_room/domain/params/jump_to_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/use_cases/use_case.dart';

class JumpToMessageUseCase extends SimpleUseCase<void, JumpToMessageParams> {
  final _log = useLogger();

  JumpToMessageUseCase({
    required this.chatRoomLocalRepository,
  });

  final ChatRoomLocalCompatRepository chatRoomLocalRepository;

  @override
  Future<void> call(JumpToMessageParams params) async {
    final roomId = params.roomId;
    final message = params.message;

    final room = await chatRoomLocalRepository.getRoom(roomId);
    if (room != null) {
      Get.toNamed(
        Routes.chatRoomDirect.replaceAll(':id', roomId),
        arguments: ChatRoomArguments(
          room: room.toCollection(),
          targetMessage: message.toCollection(),
        ),
      );
    } else {
      _log.w('handleJumpToMessage failed room id $roomId is null');
    }
  }
}
