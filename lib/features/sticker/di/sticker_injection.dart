import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/services/sticker/sticker_downloader_service.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/sticker/data/data_sources/local/sticker_db.dart';
import 'package:uchat/features/sticker/data/data_sources/local/sticker_recently_search_db.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_http_data_source.dart';
import 'package:uchat/features/sticker/data/data_sources/remote/sticker_socket_data_source.dart';
import 'package:uchat/features/sticker/data/repositories/my_sticker_local_repository_impl.dart';
import 'package:uchat/features/sticker/data/repositories/my_sticker_remote_repository_impl.dart';
import 'package:uchat/features/sticker/data/repositories/sticker_search_local_repository_impl.dart';
import 'package:uchat/features/sticker/data/repositories/store_sticker_local_repository_impl.dart';
import 'package:uchat/features/sticker/data/repositories/store_sticker_remote_repository_impl.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/my_sticker_remote_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/sticker_search_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_local_repository.dart';
import 'package:uchat/features/sticker/domain/repositories/store_sticker_remote_repository.dart';
import 'package:uchat/features/sticker/domain/use_cases/acquire_sticker_pack_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/add_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/buy_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/check_owner_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/clear_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/delete_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/favorite_sticker_pack_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_and_save_all_my_stickers_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_received_sticker_gift_history_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sent_sticker_gift_history_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sticker_detail_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_sticker_history_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_store_sticker_by_type_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/fetch_store_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_all_recently_search_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_recent_chat_sticker_gift_target_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/get_sorted_my_sticker_list_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_all_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_one_sticker_pack_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/reorder_sticker_packs_to_the_top_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/search_store_sticker_use_case.dart';
import 'package:uchat/features/sticker/domain/use_cases/send_gift_sticker_use_case.dart';

Future<void> registerStickerSingletonDependencies({
  required HttpCaller httpCaller,
  required SocketCaller socketCaller,
}) async {
  final getIt = GetIt.instance;

  final stickerDb = getIt.registerSingleton<StickerDb>(StickerDb());

  final stickerRecentlySearchDb = getIt.registerSingleton<StickerRecentlySearchDb>(StickerRecentlySearchDb());

  final httpDataSource = getIt.registerSingleton<StickerHttpDataSource>(
    StickerHttpDataSource(httpCaller: httpCaller),
  );
  final socketDataSource = getIt.registerSingleton<StickerSocketDataSource>(
    StickerSocketDataSource(socketCaller: socketCaller),
  );

  getIt.registerSingleton<StoreStickerLocalRepository>(
    StoreStickerLocalRepositoryImpl(
      stickerDb: stickerDb,
    ),
  );

  getIt.registerSingleton<StoreStickerRemoteRepository>(
    StoreStickerRemoteRepositoryImpl(
      httpDataSource: httpDataSource,
      socketDataSource: socketDataSource,
    ),
  );

  getIt.registerSingleton<MyStickerLocalRepository>(
    MyStickerLocalRepositoryImpl(
      stickerDb: stickerDb,
    ),
  );

  getIt.registerSingleton<MyStickerRemoteRepository>(
    MyStickerRemoteRepositoryImpl(
      httpDataSource: httpDataSource,
      socketDataSource: socketDataSource,
    ),
  );

  getIt.registerSingleton<StickerDownloaderService>(StickerDownloaderService(
    stickerHttpDataSource: httpDataSource,
  ));

  getIt.registerSingleton<StickerSearchLocalRepository>(StickerSearchLocalRepositoryImpl(
    stickerRecentlySearchDb: stickerRecentlySearchDb,
  ));
}

Future<void> registerStickerFactoryDependencies({
  required MyStickerLocalRepository myStickerLocalRepository,
  required MyStickerRemoteRepository myStickerRemoteRepository,
  required StoreStickerLocalRepository storeStickerLocalRepository,
  required StoreStickerRemoteRepository storeStickerRemoteRepository,
  required StickerSearchLocalRepository stickerSearchLocalRepository,
}) async {
  final getIt = GetIt.instance;

  getIt.registerFactory<FetchStoreStickerUseCase>(
    () => FetchStoreStickerUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<FetchStoreStickerByTypeUseCase>(
    () => FetchStoreStickerByTypeUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<FetchStickerDetailUseCase>(
    () => FetchStickerDetailUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<FavoriteStickerPackUseCase>(
    () => FavoriteStickerPackUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<AcquireStickerPackUseCase>(
    () => AcquireStickerPackUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<BuyStickerUseCase>(
    () => BuyStickerUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<CheckOwnerStickerUseCase>(
    () => CheckOwnerStickerUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<SendGiftStickerUseCase>(
    () => SendGiftStickerUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );
  getIt.registerFactory<ReorderStickerPacksToTheTopUseCase>(
    () => ReorderStickerPacksToTheTopUseCase(
      myStickerRemoteRepository: getIt<MyStickerRemoteRepository>(),
    ),
  );
  getIt.registerFactory<ReorderAllStickerUseCase>(
    () => ReorderAllStickerUseCase(
      myStickerRemoteRepository: getIt<MyStickerRemoteRepository>(),
    ),
  );
  getIt.registerFactory<FetchAndSaveAllMyStickersUseCase>(
    () => FetchAndSaveAllMyStickersUseCase(
      myStickerRemoteRepository: getIt<MyStickerRemoteRepository>(),
      myStickerLocalRepository: myStickerLocalRepository,
      stickerDownloaderService: getIt<StickerDownloaderService>(),
    ),
  );

  getIt.registerFactory<SearchStoreStickerUseCase>(
    () => SearchStoreStickerUseCase(storeStickerRemoteRepository: storeStickerRemoteRepository),
  );

  getIt.registerFactory<GetAllRecentlySearchStickerUseCase>(
    () => GetAllRecentlySearchStickerUseCase(stickerSearchLocalRepository: stickerSearchLocalRepository),
  );

  getIt.registerFactory<AddRecentlySearchStickerUseCase>(
    () => AddRecentlySearchStickerUseCase(stickerSearchLocalRepository: stickerSearchLocalRepository),
  );

  getIt.registerFactory<DeleteRecentlySearchStickerUseCase>(
    () => DeleteRecentlySearchStickerUseCase(stickerSearchLocalRepository: stickerSearchLocalRepository),
  );

  getIt.registerFactory<ClearRecentlySearchStickerUseCase>(
    () => ClearRecentlySearchStickerUseCase(stickerSearchLocalRepository: stickerSearchLocalRepository),
  );

  getIt.registerFactory<GetRecentChatStickerGiftTargetUseCase>(
    () => GetRecentChatStickerGiftTargetUseCase(
      chatRoomLocalRepository: GetIt.I<ChatRoomLocalRepository>(),
      contactLocalRepository: GetIt.I<ContactLocalRepository>(),
    ),
  );

  getIt.registerFactory<FetchStickerHistoryUseCase>(
    () => FetchStickerHistoryUseCase(myStickerRemoteRepository: myStickerRemoteRepository),
  );

  getIt.registerFactory<GetSortedMyStickerListUseCase>(
    () => GetSortedMyStickerListUseCase(myStickerLocalRepository: myStickerLocalRepository),
  );

  getIt.registerFactory<FetchReceivedStickerGiftHistoryUseCase>(
    () => FetchReceivedStickerGiftHistoryUseCase(
      storeStickerRemoteRepository: storeStickerRemoteRepository,
      contactLocalRepository: GetIt.I<ContactLocalRepository>(),
    ),
  );

  getIt.registerFactory<FetchSentStickerGiftHistoryUseCase>(
    () => FetchSentStickerGiftHistoryUseCase(
      storeStickerRemoteRepository: storeStickerRemoteRepository,
      contactLocalRepository: GetIt.I<ContactLocalRepository>(),
    ),
  );

  getIt.registerFactory<ReorderOneStickerPackUseCase>(
    () => ReorderOneStickerPackUseCase(
      myStickerLocalRepository: myStickerLocalRepository,
    ),
  );
}
