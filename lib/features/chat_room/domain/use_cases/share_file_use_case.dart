import 'package:uchat/features/chat_room/data/models/requests/share_file_request.dart';
import 'package:uchat/features/chat_room/domain/params/share_file_param.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class ShareFileUseCase extends SimpleUseCase<void, ShareFileParam> {
  ShareFileUseCase({required this.chatRoomServerRepository});

  final ChatRoomServerRepository chatRoomServerRepository;

  @override
  Future<void> call(ShareFileParam params) async {
    ShareFileRequest request = ShareFileRequest(
      roomId: params.originRoomId,
      destRoomId: params.destinationRoomId,
      messageId: params.messageId,
      fileIdList: params.fileIdList,
    );
    await chatRoomServerRepository.shareFile(request);
  }
}
