import 'package:uchat/features/chat_room/domain/params/edit_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class EditMessageUseCase extends SimpleUseCase<void, EditMessageParams> {
  EditMessageUseCase({
    required this.messageServerRepository,
  });

  final MessageServerRepository messageServerRepository;

  @override
  Future<void> call(EditMessageParams params) async {
    final resp = await messageServerRepository.editMessage(params);
    // TODO: update ui by resp instead of using state.
  }
}
