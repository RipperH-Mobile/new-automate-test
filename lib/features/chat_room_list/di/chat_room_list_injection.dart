import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/performance_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_compat_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/services/chat_list_performance_tracker.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/create_secret_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_chat_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/fetch_default_group_avatar_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/get_all_room_last_seen_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/read_all_room_in_local_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/read_all_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list/sort_rooms_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/delete_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_chat_category_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_hide_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_pin_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/delete_room_with_countdown_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/accept_room_handle_accept_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/accept_room_handle_join_group_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/join_group_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/reject_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/chat_list_search_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/find_search_message_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/search/save_recent_search_result_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/verify_room_invite_link_use_case.dart';

Future<void> registerChatRoomListFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register services.
  getIt.registerFactory<ChatListPerformanceTracker>(
    () => ChatListPerformanceTracker(
      GetIt.I<PerformanceService>(),
    ),
  );

  // Register use cases.
  getIt
    ..registerFactory<AcceptRoomHandleAcceptUseCase>(() => AcceptRoomHandleAcceptUseCase())
    ..registerFactory<AcceptRoomHandleJoinGroupUseCase>(
      () => AcceptRoomHandleJoinGroupUseCase(
        chatRoomLocalRepository: GetIt.I<ChatRoomLocalCompatRepository>(),
        chatRoomListServerRepository: GetIt.I<ChatRoomListServerRepository>(),
      ),
    )
    ..registerFactory<ChatListSearchUseCase>(
      () => ChatListSearchUseCase(
        roomDb: GetIt.I<RoomDb>(),
        messageDb: GetIt.I<MessageDb>(),
        roomSubDb: GetIt.I<RoomSubscriptionDb>(),
        roomMemberDb: GetIt.I<RoomMemberDb>(),
      ),
    )
    ..registerFactory<CreateSecretRoomUseCase>(() => CreateSecretRoomUseCase())
    ..registerFactory<DeleteRoomUseCase>(() => DeleteRoomUseCase())
    ..registerFactory<DeleteRoomWithCountdownUseCase>(() => DeleteRoomWithCountdownUseCase())
    ..registerFactory<FetchChatRoomUseCase>(() => FetchChatRoomUseCase())
    ..registerFactory<FetchDefaultGroupAvatarUseCase>(() => FetchDefaultGroupAvatarUseCase())
    ..registerFactory<GetAllRoomLastSeenUseCase>(
      () => GetAllRoomLastSeenUseCase(
        configDb: GetIt.I<ConfigDb>(),
        chatRoomLocalRepository: GetIt.I<ChatRoomLocalCompatRepository>(),
        chatRoomListServerRepository: GetIt.I<ChatRoomListServerRepository>(),
      ),
    )
    ..registerFactory<JoinGroupUseCase>(() => JoinGroupUseCase())
    ..registerFactory<ReadAllRoomUseCase>(() => ReadAllRoomUseCase())
    ..registerFactory<ReadAllRoomInLocalUseCase>(
      () => ReadAllRoomInLocalUseCase(
        chatRoomLocalRepository: GetIt.I<ChatRoomLocalRepository>(),
      ),
    )
    ..registerFactory<RejectRoomUseCase>(() => RejectRoomUseCase())
    ..registerFactory<ToggleChatCategoryUseCase>(() => ToggleChatCategoryUseCase())
    ..registerFactory<ToggleHideRoomUseCase>(() => ToggleHideRoomUseCase())
    ..registerFactory<ToggleMuteRoomUseCase>(() => ToggleMuteRoomUseCase())
    ..registerFactory<TogglePinRoomUseCase>(() => TogglePinRoomUseCase())
    ..registerFactory<FindSearchMessageUseCase>(
      () => FindSearchMessageUseCase(
        messageLocalRepository: GetIt.I<MessageLocalRepository>(),
      ),
    )
    ..registerFactory<SaveRecentSearchResultUseCase>(
      () => SaveRecentSearchResultUseCase(
        roomMemberDb: GetIt.I<RoomMemberDb>(),
        roomDb: GetIt.I<RoomDb>(),
        chatListSearchLocalRepository: GetIt.I<ChatListSearchLocalRepository>(),
      ),
    )
    ..registerFactory<SortRoomsUseCase>(() => SortRoomsUseCase())
    ..registerFactory<VerifyRoomInviteLinkUseCase>(
      () => VerifyRoomInviteLinkUseCase(
        repository: GetIt.I<ChatRoomListServerRepository>(),
      ),
    );
}
