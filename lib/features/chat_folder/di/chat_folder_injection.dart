import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';

import '../data/data_sources/local/chat_folder_db.dart';
import '../data/data_sources/remote/chat_folder_http_data_source.dart';
import '../data/data_sources/remote/chat_folder_socket_data_source.dart';
import '../data/repositories/chat_folder_local_repository_impl.dart';
import '../data/repositories/chat_folder_remote_repository_impl.dart';
import '../domain/repositories/chat_folder_local_repository.dart';
import '../domain/repositories/chat_folder_remote_repository.dart';
import '../domain/use_cases/get_all_chat_folder_use_case.dart';
import '../domain/use_cases/get_all_room_subscription_by_chat_folder_use_case.dart';
import '../domain/use_cases/get_chat_folder_by_id_use_case.dart';
import '../domain/use_cases/save_all_chat_folders_to_local_use_case.dart';

///
/// Initialize Chat Folder singleton Dependencies
///
Future<void> registerChatFolderSingletonDependencies({
  required HttpCaller httpCaller,
  required SocketCaller socketCaller,
}) async {
  final getIt = GetIt.instance;

  // Register Local Database
  final chatFolderDb = getIt.registerSingleton(ChatFolderDb());

  // Register Data Sources
  final httpDataSource = getIt.registerSingleton<ChatFolderHttpDataSource>(ChatFolderHttpDataSource(
    httpCaller: httpCaller,
  ));
  final socketDataSource = getIt.registerSingleton<ChatFolderSocketDataSource>(ChatFolderSocketDataSource(
    socketCaller: socketCaller,
  ));

  // Register Repositories
  getIt.registerSingleton<ChatFolderLocalRepository>(
    ChatFolderLocalRepositoryImpl(
      chatFolderDb: chatFolderDb,
    ),
  );
  getIt.registerSingleton<ChatFolderRemoteRepository>(
    ChatFolderRemoteRepositoryImpl(
      httpDataSource: httpDataSource,
      socketDataSource: socketDataSource,
    ),
  );
}

///
/// Initialize Chat Folder factory Dependencies
///
Future<void> registerChatFolderFactoryDependencies({
  required ChatRoomLocalRepository chatRoomLocalRepository,
  required ChatFolderLocalRepository chatFolderLocalRepository,
}) async {
  final getIt = GetIt.instance;

  // Register Use Cases
  getIt.registerFactory<GetAllRoomSubscriptionByChatFolderUseCase>(
    () => GetAllRoomSubscriptionByChatFolderUseCase(
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
    ),
  );

  getIt.registerFactory<GetAllChatFolderUseCase>(
    () => GetAllChatFolderUseCase(
      getAllRoomSubscriptionByChatFolderUseCase: getIt<GetAllRoomSubscriptionByChatFolderUseCase>(),
      chatFolderLocalRepository: chatFolderLocalRepository,
    ),
  );

  getIt.registerFactory<GetChatFolderByIdUseCase>(
    () => GetChatFolderByIdUseCase(
      getAllRoomSubscriptionByChatFolderUseCase: getIt<GetAllRoomSubscriptionByChatFolderUseCase>(),
      chatFolderLocalRepository: chatFolderLocalRepository,
    ),
  );

  getIt.registerFactory<SaveAllChatFoldersToLocalUseCase>(
    () => SaveAllChatFoldersToLocalUseCase(
      chatFolderLocalRepository: chatFolderLocalRepository,
    ),
  );
}
