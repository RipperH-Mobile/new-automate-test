import 'package:uchat/use_cases/use_case.dart';

import '../entities/chat_folder_entity.dart';
import '../repositories/chat_folder_local_repository.dart';

class SaveAllChatFoldersToLocalParams {
  final List<ChatFolderEntity> chatFolders;
  final bool useTxn;

  SaveAllChatFoldersToLocalParams({
    required this.chatFolders,
    this.useTxn = true,
  });
}

class SaveAllChatFoldersToLocalUseCase implements SimpleUseCase<void, SaveAllChatFoldersToLocalParams> {
  final ChatFolderLocalRepository chatFolderLocalRepository;

  SaveAllChatFoldersToLocalUseCase({
    required this.chatFolderLocalRepository,
  });

  @override
  Future<void> call(SaveAllChatFoldersToLocalParams params) async {
    await chatFolderLocalRepository.putAll(chatFolders: params.chatFolders, useTxn: params.useTxn);
  }
}
