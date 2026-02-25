import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/room_file_local_repository.dart';
import 'package:uchat/features/chat_room_detail/data/data_source/local/room_invite_link_db.dart';
import 'package:uchat/features/chat_room_detail/data/data_source/remote/chat_room_detail_api_service.dart';
import 'package:uchat/features/chat_room_detail/data/data_source/remote/chat_room_detail_socket_service.dart';
import 'package:uchat/features/chat_room_detail/data/repositories/chat_room_detail_local_repository_impl.dart';
import 'package:uchat/features/chat_room_detail/data/repositories/chat_room_detail_server_repository_impl.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_local_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/repositories/chat_room_detail_server_repository.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/edit_group_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_all_admin_and_owner_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_all_member_and_admin_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_next_owner_suggestion_list_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_in_any_room_sync_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_one_member_sync_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_promotable_members_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/get_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/put_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/revoke_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/search_member_in_room_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/update_room_invite_link_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/use_cases.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';

Future<void> registerChatRoomDetailSingletonDependencies() async {
  final getIt = GetIt.instance;

  // Register data sources.
  getIt.registerSingleton<ChatRoomDetailApiService>(
    ChatRoomDetailApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );
  getIt.registerSingleton<ChatRoomDetailSocketService>(
    ChatRoomDetailSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );
  getIt.registerSingleton<RoomInviteLinkDb>(RoomInviteLinkDb());

  getIt.registerSingleton<ChatRoomDetailLocalRepository>(
    ChatRoomDetailLocalRepositoryImpl(
      roomMemberDb: getIt<RoomMemberDb>(),
      roomSubDb: getIt<RoomSubscriptionDb>(),
      roomFileDb: getIt<RoomFileDb>(),
      roomDb: getIt<RoomDb>(),
      messageDb: getIt<MessageDb>(),
      configAuthenticated: getIt<ConfigDb>(),
      roomInviteLinkDb: getIt<RoomInviteLinkDb>(),
    ),
  );
  getIt.registerSingleton<ChatRoomDetailServerRepository>(
    ChatRoomDetailRepositoryImpl(
      chatRoomDetailApiService: getIt<ChatRoomDetailApiService>(),
      chatRoomDetailSocketService: getIt<ChatRoomDetailSocketService>(),
      socketCaller: getIt<SocketCaller>(),
    ),
  );
}

Future<void> registerChatRoomDetailFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register use cases.
  getIt
    ..registerFactory(
      () => AcceptGroupMemberRequestUseCase(),
    )
    ..registerFactory(
      () => AddGroupAdminUseCase(
        chatRoomDetailServerRepository: getIt<ChatRoomDetailServerRepository>(),
        chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => EditGroupAdminUseCase(
        chatRoomDetailServerRepository: getIt<ChatRoomDetailServerRepository>(),
        chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => AddMemberToChatUseCase(),
    )
    ..registerFactory(
      () => ChangeGroupAccessTypeUseCase(),
    )
    ..registerFactory(
      () => ChangeGroupOwnerUseCase(),
    )
    ..registerFactory(
      () => ChangeRoomNameUseCase(),
    )
    ..registerFactory(
      () => ChangeRoomPhotoUseCase(),
    )
    ..registerFactory(
      () => CreateGroupChatUseCase(),
    )
    ..registerFactory(
      () => EndSecretChatUseCase(),
    )
    ..registerFactory(
      () => FetchRoomDetailMediaCountUseCase(),
    )
    ..registerFactory(
      () => FetchRoomFileUseCase(),
    )
    ..registerFactory(
      () => FetchRoomLinksUseCase(),
    )
    ..registerFactory(
      () => FetchRoomPhotoAndVideoUseCase(),
    )
    ..registerFactory(
      () => FindGroupUseCase(),
    )
    ..registerFactory(
      () => GetAllAdminAndOwnerUseCase(
        chatRoomDetailLocalRepository: GetIt.I<ChatRoomDetailLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => GetAllMemberAndAdminUseCase(
        chatRoomDetailLocalRepository: GetIt.I<ChatRoomDetailLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => GetNextOwnerSuggestionListUseCase(
        chatRoomDetailLocalRepository: GetIt.I<ChatRoomDetailLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => GetOneMemberUseCase(),
    )
    ..registerFactory(
      () => GetOneMemberSyncUseCase(),
    )
    ..registerFactory(
      () => GetOneMemberInAnyRoomSyncUseCase(),
    )
    ..registerFactory(
      () => GetDraftMenuUseCase(),
    )
    ..registerFactory(
      () => GetFileSeqUseCase(),
    )
    ..registerFactory(
      () => GetGroupMemberRequestListUseCase(),
    )
    ..registerFactory(
      () => GetMemberListUseCase(),
    )
    ..registerFactory(
      () => GetRoomMemberFromLocalUseCase(),
    )
    ..registerFactory(
      () => GetPhotosAndVideosInRoomUseCase(),
    )
    ..registerFactory(
      () => GetPromotableMemberUseCase(
        chatRoomDetailLocalRepository: GetIt.I<ChatRoomDetailLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => GetRoomInviteListUseCase(),
    )
    ..registerFactory(
      () => GetRoomMemberAndPendingListUseCase(
        chatRoomDetailServerRepository: getIt<ChatRoomDetailServerRepository>(),
      ),
    )
    ..registerFactory(
      () => LeaveGroupUseCase(
        chatRoomListServerRepository: getIt<ChatRoomListServerRepository>(),
        chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
        messageLocalRepository: getIt<MessageLocalRepository>(),
        roomFileLocalRepository: getIt<RoomFileLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => PublishMenuUseCase(),
    )
    ..registerFactory(
      () => PutAllRoomFileUseCase(),
    )
    ..registerFactory(
      () => RejectGroupMemberRequestUseCase(),
    )
    ..registerFactory(
      () => RemoveGroupAdminUseCase(
        chatRoomDetailServerRepository: getIt<ChatRoomDetailServerRepository>(),
        chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => RemoveMemberFromChatUseCase(),
    )
    ..registerFactory(
      () => RemovePendingMembersUseCase(),
    )
    ..registerFactory(
      () => SetDefaultGroupAvatarUseCase(),
    )
    ..registerFactory(
      () => SetRoomThemeUseCase(),
    )
    ..registerFactory(
      () => ToggleHideMessageNotificationUseCase(),
    )
    ..registerFactory(
      () => ToggleMuteCallNotificationUseCase(),
    )
    ..registerFactory(
      () => ToggleShowExpiredDateUseCase(),
    )
    ..registerFactory(
      () => UnpublishMenuUseCase(),
    )
    ..registerFactory(
      () => UpdateAdminsUseCase(),
    )
    ..registerFactory(
      () => UpdateMenuUseCase(),
    )
    ..registerFactory(
      () => UpdateSecretRoomExpiredAtUseCase(),
    )
    ..registerFactory(
      () => SearchMemberInRoomUseCase(
        chatRoomDetailLocalRepository: GetIt.I<ChatRoomDetailLocalRepository>(),
      ),
    )
    ..registerFactory(
      () => GetRoomInviteLinkUseCase(
        localRepository: getIt<ChatRoomDetailLocalRepository>(),
        serverRepository: getIt<ChatRoomDetailServerRepository>(),
      ),
    )
    ..registerFactory(
      () => UpdateRoomInviteLinkUseCase(
        localRepository: getIt<ChatRoomDetailLocalRepository>(),
        serverRepository: getIt<ChatRoomDetailServerRepository>(),
      ),
    )
    ..registerFactory(
      () => RevokeRoomInviteLinkUseCase(
        localRepository: getIt<ChatRoomDetailLocalRepository>(),
        serverRepository: getIt<ChatRoomDetailServerRepository>(),
      ),
    )
    ..registerFactory(() => PutRoomInviteLinkUseCase(localRepository: getIt<ChatRoomDetailLocalRepository>()));
}
