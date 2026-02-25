import 'package:get_it/get_it.dart';
import 'package:uchat/features/call_log/presentation/controllers/call_log_screen_controller.dart';
import 'package:uchat/features/chat_folder/presentation/chat_folder_presentation.dart';
import 'package:uchat/features/chat_room_list/presentation/chat_room_list_presentation.dart';
import 'package:uchat/features/contact/presentation/contact_presentation.dart';
import 'package:uchat/features/sync/sync_barrel.dart';

import '../../analytics/logger_service.dart';
import '../common/task_result.dart';

Future<TaskResult> onAuthenticated() async {
  await GetIt.I<SyncService>().onUserLoaded();

  try {
    final List<Future> homepageFirstLoadItems = [
      Future.sync(ContactsController.instance.onUserLoaded),
      Future.sync(ChatListController.instance.onUserLoaded),
      Future.sync(CallLogScreenController.instance.onUserLoaded),
      Future.sync(ChatFolderController.instance.initialTabChatFolderData),
    ];
    await Future.wait(homepageFirstLoadItems);
  } catch (e, stackTrace) {
    useLogger().e('Error loading homepage items.', e, stackTrace);
  }

  return TaskResult.next;
}
