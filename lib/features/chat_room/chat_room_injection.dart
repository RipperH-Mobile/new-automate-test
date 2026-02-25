import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/entities/services/message_reaction_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/pin_message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_socket_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/emoji_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/emoji_socket_service.dart';
import 'package:uchat/features/chat_room/data/repositories/chat_room_server_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/emoji_server_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/pin_message_local_repository_impl.dart';
import 'package:uchat/features/chat_room/domain/repositories/emoji_server_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_file_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_gif_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_image_video_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_sticker_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/delete_other_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_members_in_room_use_case.dart';
import 'package:uchat/features/chat_room/data/repositories/message_local_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/message_server_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/pin_message_server_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/room_file_local_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/room_member_local_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/room_subscription_local_repository_impl.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room/domain/repositories/pin_message_server_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_items_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_emoji_packages_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_groups_with_me_as_an_owner_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_images_from_clipboard_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_local_message_reactions_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_reactions_from_server_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_oa_rich_menu_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_pin_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/pin_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_text_from_clipboard_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reaction_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/remove_reactions_by_room_id_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_system_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/save_draft_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/take_photo_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/trigger_read_message_v2_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_bulk_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_all_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/unpin_message_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_default_emoji_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/update_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_group_permission_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/watch_pin_messages_in_room_use_case.dart';
import 'package:uchat/features/chat_room/utils/chat_room_utils.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_room_list_server_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/room_sub_local_repository.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/utils/encrypt_helper.dart';

import 'domain/use_cases/leave_groups_with_me_as_an_owner_use_case.dart';
import 'domain/use_cases/toggle_message_image_selection_use_case.dart';
import 'domain/use_cases/toggle_message_selection_use_case.dart';

Future<void> registerChatRoomSingletonDependencies() async {
  final getIt = GetIt.instance;

  /// Data Sources
  getIt.registerSingleton<EmojiApiService>(
    EmojiApiService(
      httpCaller: GetIt.I<HttpCaller>(),
    ),
  );
  getIt.registerSingleton<EmojiSocketService>(
    EmojiSocketService(
      socketCaller: GetIt.I<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<ChatRoomServerRepository>(
    ChatRoomServerRepositoryImpl(
      roomSocketService: GetIt.I<ChatRoomSocketService>(),
      roomApiService: GetIt.I<ChatRoomApiService>(),
      socketCaller: GetIt.I<SocketCaller>(),
      offlineTaskDb: GetIt.I<OfflineTaskDb>(),
    ),
  );
  getIt.registerSingleton<MessageLocalRepository>(
    MessageLocalRepositoryImpl(
      messageDb: GetIt.I<MessageDb>(),
      messageReactionDb: GetIt.I<MessageReactionDb>(),
      roomMemberDb: GetIt.I<RoomMemberDb>(),
      configInstance: ConfigDb().authenticated,
    ),
  );
  getIt.registerSingleton<MessageServerRepository>(
    MessageServerRepositoryImpl(
      socketCaller: GetIt.I<SocketCaller>(),
      chatRoomApiService: GetIt.I<ChatRoomApiService>(),
      chatRoomSocketService: GetIt.I<ChatRoomSocketService>(),
    ),
  );
  getIt.registerSingleton<PinMessageLocalRepository>(
    PinMessageLocalRepositoryImpl(
      pinMessageDb: GetIt.I<PinMessageDb>(),
      messageDb: GetIt.I<MessageDb>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      encryptHelper: EncryptHelper.instance,
    ),
  );

  getIt.registerSingleton<PinMessageServerRepository>(
    PinMessageServerRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      chatRoomApiService: getIt<ChatRoomApiService>(),
      chatRoomSocketService: getIt<ChatRoomSocketService>(),
    ),
  );
  getIt.registerSingleton<RoomFileLocalRepository>(
    RoomFileLocalRepositoryImpl(),
  );
  getIt.registerSingleton<RoomMemberLocalRepository>(
    RoomMemberLocalRepositoryImpl(
      roomMemberDb: GetIt.I<RoomMemberDb>(),
    ),
  );
  getIt.registerSingleton<RoomSubscriptionLocalRepository>(
    RoomSubscriptionLocalRepositoryImpl(
      roomSubscriptionDb: GetIt.I<RoomSubscriptionDb>(),
    ),
  );
  getIt.registerSingleton<EmojiServerRepository>(
    EmojiServerRepositoryImpl(
      emojiApiService: GetIt.I<EmojiApiService>(),
      emojiSocketService: GetIt.I<EmojiSocketService>(),
      socketCaller: GetIt.I<SocketCaller>(),
      log: GetIt.I<LoggerService>(),
    ),
  );
  getIt.registerLazySingleton<IChatRoomUtils>(
    () => ChatRoomUtils(
      roomMemberDb: GetIt.I<RoomMemberDb>(),
    ),
  );
}

Future<void> registerChatRoomFactoryDependencies() async {
  final getIt = GetIt.instance;

  getIt.registerFactory<GetAllSentMessageMediaFilesUseCase>(
    () => GetAllSentMessageMediaFilesUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );

  getIt.registerFactory<GetMessageByRefUseCase>(
    () => GetMessageByRefUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );

  getIt.registerFactory<DeleteMessageUseCase>(
    () => DeleteMessageUseCase(
      messageRepoServer: getIt<MessageServerRepository>(),
      messageRepoLocal: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<DeleteOtherMessageUseCase>(
    () => DeleteOtherMessageUseCase(
      messageRepoServer: getIt<MessageServerRepository>(),
      messageRepoLocal: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<DeleteAllMessageInRoomUseCase>(
    () => DeleteAllMessageInRoomUseCase(
      messageRepoLocal: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<EditMessageUseCase>(
    () => EditMessageUseCase(
      messageServerRepository: getIt<MessageServerRepository>(),
    ),
  );
  getIt.registerFactory<ExpireAllSecretChatWithAccountIdUseCase>(
    () => ExpireAllSecretChatWithAccountIdUseCase(
      roomMemberLocalRepository: getIt<RoomMemberLocalRepository>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
    ),
  );
  getIt.registerFactory<FetchMessageUseCase>(
    () => FetchMessageUseCase(
      messageRepository: getIt<MessageServerRepository>(),
    ),
  );
  getIt.registerFactory<FetchRoomMemberUseCase>(
    () => FetchRoomMemberUseCase(
      log: getIt<LoggerService>(),
      roomMemberDb: getIt<RoomMemberDb>(),
      roomSubDb: getIt<RoomSubscriptionDb>(),
      chatRoomApiService: getIt<ChatRoomApiService>(),
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory<GetAllGroupRoomOwnByMeUseCase>(
    () => GetAllGroupRoomOwnByMeUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<GetAllMemberInRoomUseCase>(
    () => GetAllMemberInRoomUseCase(
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
    ),
  );
  getIt.registerFactory<GetAllSentMessageUseCase>(
    () => GetAllSentMessageUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<GetGroupsWithMeAsAnOwnerUseCase>(
    () => GetGroupsWithMeAsAnOwnerUseCase(
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
    ),
  );
  getIt.registerFactory<GetTextFromClipboardUseCase>(
    () => GetTextFromClipboardUseCase(),
  );
  getIt.registerFactory<GetImagesFromClipboardUseCase>(
    () => GetImagesFromClipboardUseCase(),
  );
  getIt.registerFactory<GetStreamImagesUseCase>(
    () => GetStreamImagesUseCase(),
  );
  getIt.registerFactory<GetLocationUseCase>(
    () => GetLocationUseCase(
      log: GetIt.I<LoggerService>(),
    ),
  );
  getIt.registerFactory<GetMessageFromServerUseCase>(
    () => GetMessageFromServerUseCase(
      log: GetIt.I<LoggerService>(),
      encryptHelper: EncryptHelper.instance,
      messageLocalRepository: getIt<MessageLocalRepository>(),
      messageServerRepository: getIt<MessageServerRepository>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
    ),
  );
  getIt.registerFactory<GetRoomByIdUseCase>(
    () => GetRoomByIdUseCase(
      chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
    ),
  );
  getIt.registerFactory<GetRoomEncryptionKeyUseCase>(
    () => GetRoomEncryptionKeyUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<GetRoomSubscriptionUseCase>(
    () => GetRoomSubscriptionUseCase(
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
    ),
  );
  getIt.registerFactory<GetRoomsTypeGroupUseCase>(() => GetRoomsTypeGroupUseCase());
  getIt.registerFactory<LeaveGroupsWithMeAsAnOwnerUseCase>(() => LeaveGroupsWithMeAsAnOwnerUseCase(
        chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
      ));
  getIt.registerFactory<GetSecretRoomEncryptionKeyUseCase>(
    () => GetSecretRoomEncryptionKeyUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<GetSendingMessageUseCase>(
    () => GetSendingMessageUseCase(),
  );
  getIt.registerFactory<JumpToMessageUseCase>(
    () => JumpToMessageUseCase(
      chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
    ),
  );
  getIt.registerFactory<OpenDirectChatAndSaveToDbUseCase>(
    () => OpenDirectChatAndSaveToDbUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      roomSubLocalRepository: getIt<RoomSubLocalRepository>(),
      roomMemberLocalRepository: getIt<RoomMemberLocalRepository>(),
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory<OpenSystemChatAndSaveToDbUseCase>(
    () => OpenSystemChatAndSaveToDbUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      roomSubLocalRepository: getIt<RoomSubLocalRepository>(),
      roomMemberLocalRepository: getIt<RoomMemberLocalRepository>(),
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory<PickFileUseCase>(
    () => PickFileUseCase(),
  );
  getIt.registerFactory<ReactMessageUseCase>(
    () => ReactMessageUseCase(
      messageServerRepository: getIt<MessageServerRepository>(),
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<RemoveFailedMessageUseCase>(
    () => RemoveFailedMessageUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<ReportMessageUseCase>(
    () => ReportMessageUseCase(
      chatRoomApiService: getIt<ChatRoomApiService>(),
    ),
  );
  getIt.registerFactory<ResendMessageUseCase>(
    () => ResendMessageUseCase(
      messageServerRepository: getIt<MessageServerRepository>(),
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<SendFileMessageToServerUseCase>(
    () => SendFileMessageToServerUseCase(
      logger: getIt<LoggerService>(),
      userLocalRepository: getIt<UserDb>(),
      messageLocalRepository: getIt<MessageDb>(),
      roomSubscriptionDb: getIt<RoomSubscriptionDb>(),
    ),
  );
  getIt.registerFactory<SendMessageToServerUseCase>(
    () => SendMessageToServerUseCase(
      roomsServerRepository: getIt<ChatRoomServerRepository>(),
      messageServerRepository: getIt<MessageServerRepository>(),
    ),
  );
  getIt.registerFactory<SendReadMessageUseCase>(
    () => SendReadMessageUseCase(),
  );
  getIt.registerFactory<ShareFileUseCase>(
    () => ShareFileUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<ShareToOtherAppUseCase>(
    () => ShareToOtherAppUseCase(),
  );
  getIt.registerFactory<TakePhotoAndVideoUseCase>(
    () => TakePhotoAndVideoUseCase(),
  );
  getIt.registerFactory<TakePhotoUseCase>(
    () => TakePhotoUseCase(),
  );

  getIt.registerFactory<TogglePinRoomUseCase>(
    () => TogglePinRoomUseCase(
      chatRoomListServerRepository: getIt<ChatRoomListServerRepository>(),
      roomSubLocalRepository: getIt<RoomSubLocalRepository>(),
    ),
  );
  getIt.registerFactory<TriggerOfflineQueueUseCase>(
    () => TriggerOfflineQueueUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<TriggerReadMessageUseCase>(
    () => TriggerReadMessageUseCase(
      chatRoomServerRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<TriggerReadMessageV2UseCase>(
    () => TriggerReadMessageV2UseCase(),
  );
  getIt.registerFactory<UnsentMessageUseCase>(
    () => UnsentMessageUseCase(
      messageRepoServer: getIt<MessageServerRepository>(),
      messageRepoLocal: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<SaveDraftMessageUseCase>(
    () => SaveDraftMessageUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<UpdateDraftMessageUseCase>(
    () => UpdateDraftMessageUseCase(
      log: getIt<LoggerService>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<UpdateLastTypedAtUseCase>(() => UpdateLastTypedAtUseCase());
  getIt.registerFactory<UpdateMemberInRoomUseCase>(
    () => UpdateMemberInRoomUseCase(),
  );
  getIt.registerFactory<UpdateRoomSubUseCase>(
    () => UpdateRoomSubUseCase(),
  );
  getIt.registerFactory<GetAllMessageTillTargetMessageUseCase>(() => GetAllMessageTillTargetMessageUseCase());

  getIt.registerFactory<GetAllMembersInRoomUseCase>(() => GetAllMembersInRoomUseCase(
        chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      ));

  getIt.registerFactory<DecryptMessageTextUseCase>(
    () => DecryptMessageTextUseCase(
      log: getIt<LoggerService>(),
      encryptHelper: EncryptHelper.instance,
      chatRoomLocalRepository: getIt<ChatRoomLocalCompatRepository>(),
    ),
  );

  getIt.registerFactory<DebugSendMockMessageUseCase>(
    () => DebugSendMockMessageUseCase(),
  );

  getIt.registerFactory<MarkSendingMessagesAsFailedUseCase>(
    () => MarkSendingMessagesAsFailedUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );

  getIt.registerFactory<TapToMentionUseCase>(
    () => TapToMentionUseCase(),
  );
  getIt.registerFactory<UpdateMentionInChatInputUseCase>(
    () => UpdateMentionInChatInputUseCase(),
  );
  getIt.registerFactory<FindLastReadMessageIndexUseCase>(
    () => FindLastReadMessageIndexUseCase(),
  );
  getIt.registerFactory<ToggleMessageSelectionUseCase>(
    () => ToggleMessageSelectionUseCase(),
  );
  getIt.registerFactory<ToggleMessageImageSelectionUseCase>(
    () => ToggleMessageImageSelectionUseCase(),
  );
  getIt.registerFactory<IsReadMessageUseCase>(
    () => IsReadMessageUseCase(),
  );

  getIt.registerFactory<GetEmojiPackagesItemsUseCase>(
    () => GetEmojiPackagesItemsUseCase(
      emojiRepository: getIt<EmojiServerRepository>(),
    ),
  );
  getIt.registerFactory<GetEmojiPackagesUseCase>(
    () => GetEmojiPackagesUseCase(
      emojiRepository: getIt<EmojiServerRepository>(),
    ),
  );
  getIt.registerFactory<UpdateDefaultEmojiUseCase>(
    () => UpdateDefaultEmojiUseCase(
      emojiRepository: getIt<EmojiServerRepository>(),
    ),
  );
  getIt.registerFactory<GetLocalMessageReactionsUseCase>(
    () => GetLocalMessageReactionsUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<RemoveReactionUseCase>(
    () => RemoveReactionUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<RemoveReactionsByRoomIdUseCase>(
    () => RemoveReactionsByRoomIdUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );
  getIt.registerFactory<GetMessageReactionsFromServerUseCase>(
    () => GetMessageReactionsFromServerUseCase(
      messageLocalRepository: getIt<MessageLocalRepository>(),
      messageServerRepository: getIt<MessageServerRepository>(),
    ),
  );
  getIt.registerFactory<GetGroupPermissionUseCase>(
    () => GetGroupPermissionUseCase(
      localRepository: getIt<ChatRoomLocalRepository>(),
      serverRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<UpdateGroupPermissionUseCase>(
    () => UpdateGroupPermissionUseCase(
      localRepository: getIt<ChatRoomLocalRepository>(),
      serverRepository: getIt<ChatRoomServerRepository>(),
    ),
  );
  getIt.registerFactory<UpdateBulkGroupPermissionUseCase>(
    () => UpdateBulkGroupPermissionUseCase(
      localRepository: getIt<ChatRoomLocalRepository>(),
      serverRepository: getIt<ChatRoomServerRepository>(),
    ),
  );

  getIt.registerFactory<WatchGroupPermissionUseCase>(
    () => WatchGroupPermissionUseCase(
      localRepository: getIt<ChatRoomLocalRepository>(),
    ),
  );

  getIt.registerFactory(
    () => PinMessageUseCase(
      pinMessageLocalRepository: getIt<PinMessageLocalRepository>(),
      pinMessageServerRepository: getIt<PinMessageServerRepository>(),
      messageLocalRepository: getIt<MessageLocalRepository>(),
    ),
  );

  getIt.registerFactory(
    () => UnpinMessageUseCase(
      pinMessageLocalRepository: getIt<PinMessageLocalRepository>(),
      pinMessageServerRepository: getIt<PinMessageServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => UnpinAllMessagesInRoomUseCase(
      pinMessageLocalRepository: getIt<PinMessageLocalRepository>(),
      pinMessageServerRepository: getIt<PinMessageServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetPinMessagesInRoomUseCase(
      pinMessageLocalRepository: getIt<PinMessageLocalRepository>(),
      pinMessageServerRepository: getIt<PinMessageServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => WatchPinMessagesInRoomUseCase(
      pinMessageRepository: getIt<PinMessageLocalRepository>(),
    ),
  );

  getIt.registerFactory(() => GetOaRichMenuUseCase(
        serverRepository: getIt<ChatRoomServerRepository>(),
        contactLocalRepository: getIt<ContactLocalRepository>(),
      ));

  getIt.registerFactory(() => DebugSendSampleMessageUseCase());

  getIt.registerFactory(() => DebugSendSampleFileMessageUseCase());

  getIt.registerFactory(() => DebugSendSampleStickerUseCase());

  getIt.registerFactory(() => DebugSendSampleGifUseCase());

  getIt.registerFactory(() => DebugSendSampleImageVideoUseCase());
}
