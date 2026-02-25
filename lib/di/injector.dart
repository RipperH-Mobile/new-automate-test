import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/api/services/message_service.dart';
import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/data/data_sources/common_service.dart';
import 'package:uchat/core/data/repositories/core_server_repository_impl.dart';
import 'package:uchat/core/data/repositories/user_local_repository_impl.dart';
import 'package:uchat/core/domain/repositories/core_server_repository.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/domain/use_cases/app_share_bottom_sheet_share_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_enabled_country_list_use_case.dart';
import 'package:uchat/core/domain/use_cases/get_public_config_use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/services/sharing/sharing_service_impl.dart';
import 'package:uchat/core/services/social_auth_provider/apple_auth_service.dart';
import 'package:uchat/core/services/social_auth_provider/google_auth_service.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/entities/services/message_reaction_db.dart';
import 'package:uchat/features/add_contact/add_contact_barrel.dart';
import 'package:uchat/features/add_contact/data/data_source/remote/add_contact_api_service.dart';
import 'package:uchat/features/add_contact/data/data_source/remote/add_contact_socket_service.dart';
import 'package:uchat/features/add_contact/data/repositories/add_contact_server_repository_impl.dart';
import 'package:uchat/features/add_contact/domain/use_cases/approve_group_requested_use_case.dart';
import 'package:uchat/features/add_contact/domain/use_cases/get_group_requested_list_use_case.dart';
import 'package:uchat/features/add_contact/domain/use_cases/reject_group_requested_use_case.dart';
import 'package:uchat/features/album/album_barrel.dart';
import 'package:uchat/features/album/data/data_source/local/album_db.dart';
import 'package:uchat/features/album/data/data_source/local/album_image_db.dart';
import 'package:uchat/features/album/data/data_source/local/album_task_db.dart';
import 'package:uchat/features/album/data/data_source/remote/album_api_service.dart';
import 'package:uchat/features/album/data/data_source/remote/album_socket_service.dart';
import 'package:uchat/features/album/data/repositories/album_local_repository_impl.dart';
import 'package:uchat/features/album/data/repositories/album_server_repository_impl.dart';
import 'package:uchat/features/auth/auth_barrel.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_socket_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/qr_code_login_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/social_auth_api_service.dart';
import 'package:uchat/features/auth/data/repositories/auth_server_repository_impl.dart';
import 'package:uchat/features/auth/data/repositories/social_auth_provider_repository_impl.dart';
import 'package:uchat/features/auth/data/repositories/social_auth_server_repository_impl.dart';
import 'package:uchat/features/auth/domain/use_cases/check_password_required_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_session_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_sessions_list_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_method_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_otp_two_fa_login_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_sessions_list_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/multifactor_update_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/multifactor_validate_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_to_firebase_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/update_account_setting_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/update_email_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/update_new_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_forgot_password_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_email_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/validate_new_password_use_case.dart'; // Import the new use case
import 'package:uchat/features/auth/domain/use_cases/verify_otp_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_password_setting_account_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/verify_token_forgot_password_use_case.dart';
import 'package:uchat/features/auth/presentation/managers/setting_account_forgot_password_flow_manager.dart';
import 'package:uchat/features/call/call_barrel.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/call_kit_incoming.dart';
import 'package:uchat/features/call/data/data_source/remote/calling_api_service.dart';
import 'package:uchat/features/call/data/data_source/remote/calling_socket_service.dart';
import 'package:uchat/features/call/data/repositories/calling_server_repository_impl.dart';
import 'package:uchat/features/call_log/call_log_barrel.dart';
import 'package:uchat/features/call_log/data/data_source/local/call_log_db.dart';
import 'package:uchat/features/call_log/data/data_source/remote/call_log_api_service.dart';
import 'package:uchat/features/call_log/data/data_source/remote/call_log_socket_service.dart';
import 'package:uchat/features/call_log/data/repositories/call_log_local_repository_impl.dart';
import 'package:uchat/features/call_log/data/repositories/call_log_server_repository_impl.dart';
import 'package:uchat/features/chat_room/chat_room_barrel.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/group_permission_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/pin_message_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_file_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_member_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/local/room_subscription_db.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_socket_service.dart';
import 'package:uchat/features/chat_room/data/repositories/chat_room_local_compat_repository_impl.dart';
import 'package:uchat/features/chat_room/data/repositories/chat_room_local_repository_impl.dart';
import 'package:uchat/features/chat_room_list/chat_room_list_barrel.dart';
import 'package:uchat/features/chat_room_list/data/data_source/local/recent_search_db.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/chat_room_list_api_service.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/chat_room_list_socket_service.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/search/chat_list_search_api_service.dart';
import 'package:uchat/features/chat_room_list/data/data_source/remote/search/chat_list_search_socket_service.dart';
import 'package:uchat/features/chat_room_list/data/repositories/chat_list_search_local_repository_impl.dart';
import 'package:uchat/features/chat_room_list/data/repositories/chat_list_search_server_repository_impl.dart';
import 'package:uchat/features/chat_room_list/data/repositories/chat_room_list_server_repository_impl.dart';
import 'package:uchat/features/chat_room_list/data/repositories/room_local_repository_impl.dart';
import 'package:uchat/features/chat_room_list/data/repositories/room_sub_local_repository_impl.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_local_repository.dart';
import 'package:uchat/features/chat_room_list/domain/repositories/chat_list_search_server_repository.dart';
import 'package:uchat/features/contact/contact_barrel.dart';
import 'package:uchat/features/media/media_barrel.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/features/media_gallery/media_gallery.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/features/report/data/data_sources/remote/report_api_service.dart';
import 'package:uchat/features/report/data/data_sources/remote/report_socket_service.dart';
import 'package:uchat/features/report/data/repositories/report_repository_impl.dart';
import 'package:uchat/features/report/report_barrel.dart';
import 'package:uchat/features/setting/setting_barrel.dart';

Future<void> initSingletons() async {
  final getIt = GetIt.instance;

  getIt.registerSingleton<SocketCaller>(
    SocketCaller.instance,
  );

  getIt.registerSingleton<HttpCaller>(
    HttpCaller.instance,
  );

  getIt.registerSingleton<RoomDb>(
    RoomDb(),
  );

  getIt.registerSingleton<ConfigDb>(
    ConfigDb.instance,
  );

  getIt.registerSingleton<MessageDb>(
    MessageDb(),
  );

  getIt.registerSingleton<MessageReactionDb>(
    MessageReactionDb.instance,
  );

  getIt.registerSingleton<PinMessageDb>(
    PinMessageDb.instance,
  );

  getIt.registerSingleton<RoomFileDb>(
    RoomFileDb(),
  );

  getIt.registerSingleton<RoomMemberDb>(
    RoomMemberDb(),
  );

  getIt.registerSingleton<RoomSubscriptionDb>(
    RoomSubscriptionDb(),
  );

  getIt.registerSingleton<OfflineTaskDb>(
    OfflineTaskDb.instance,
  );

  getIt.registerSingleton<UserDb>(
    UserDb.instance,
  );

  getIt.registerSingleton<GoogleAuthService>(
    GoogleAuthService(),
  );

  getIt.registerSingleton<AppleAuthService>(
    AppleAuthService(),
  );

  getIt.registerSingleton<AlbumDb>(
    AlbumDb(),
  );

  getIt.registerSingleton<AlbumImageDb>(
    AlbumImageDb(),
  );

  getIt.registerSingleton<AlbumTaskDb>(
    AlbumTaskDb(),
  );

  getIt.registerSingleton<AnnouncementDb>(
    AnnouncementDb(),
  );

  getIt.registerSingleton<GroupPermissionDb>(
    GroupPermissionDb.instance,
  );

  getIt.registerSingleton<ProfileService>(
    ProfileService(),
  );

  getIt.registerSingleton<RecentSearchDb>(
    RecentSearchDb(),
  );
}

void provideDataSources() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<AlbumSocketService>(
    AlbumSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<AlbumApiService>(
    AlbumApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

// TODO (refactor clean) Remove this and ChatRoomSocketService and uncomment code in chat_room_injection.dart after initialize dependencies refactor is completed.
  getIt.registerSingleton<ChatRoomApiService>(
    ChatRoomApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<ChatRoomSocketService>(
    ChatRoomSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<ChatRoomListApiService>(
    ChatRoomListApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<ChatRoomListSocketService>(
    ChatRoomListSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<SocialAuthApiService>(
    SocialAuthApiService(),
  );

  getIt.registerSingleton<AuthSocketService>(
    AuthSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<AuthApiServiceNew>(
    AuthApiServiceNew(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<CommonService>(
    CommonService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<QrCodeLoginService>(
    QrCodeLoginService(
      httpCaller: getIt<HttpCaller>(),
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<AccountService>(
    AccountService(),
  );

  getIt.registerSingleton<ReportApiService>(
    ReportApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<ReportSocketService>(
    ReportSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<AddContactApiService>(
    AddContactApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<AddContactSocketService>(
    AddContactSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<ThumbnailBytesCacheManager>(
    ThumbnailBytesCacheManager(),
  );

  getIt.registerSingleton<CallLogApiService>(
    CallLogApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<CallLogSocketService>(
    CallLogSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<CallingApiService>(
    CallingApiService(
      httpCaller: getIt<HttpCaller>(),
    ),
  );

  getIt.registerSingleton<CallingSocketService>(
    CallingSocketService(
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<FileService>(
    FileService(),
  );

  getIt.registerSingleton<SharingService>(SharingServiceImpl());

  getIt.registerSingleton<ChatListSearchApiService>(
    ChatListSearchApiService(httpCaller: getIt<HttpCaller>()),
  );

  getIt.registerSingleton<ChatListSearchSocketService>(
    ChatListSearchSocketService(socketCaller: getIt<SocketCaller>()),
  );
}

void provideRepositories() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<AlbumServerRepository>(
    AlbumServerRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      albumApiService: getIt<AlbumApiService>(),
      albumSocketService: getIt<AlbumSocketService>(),
    ),
  );

  getIt.registerSingleton<AlbumLocalRepository>(
    AlbumLocalRepositoryImpl(
      albumDb: getIt<AlbumDb>(),
      albumImageDb: getIt<AlbumImageDb>(),
      albumTaskDb: getIt<AlbumTaskDb>(),
    ),
  );

// TODO (refactor clean) Remove this and ChatRoomLocalRepository and uncomment code in chat_room_injection.dart after initialize dependencies refactor is completed.
  getIt.registerSingleton<SocialAuthProviderRepository>(
    SocialAuthProviderRepositoryImpl(
      googleSignInService: getIt<GoogleAuthService>(),
      appleSignInService: getIt<AppleAuthService>(),
    ),
  );

  getIt.registerSingleton<SocialAuthServerRepository>(
    SocialAuthServerRepositoryImpl(
      socialAuthApiService: getIt<SocialAuthApiService>(),
    ),
  );

  getIt.registerSingleton<UserLocalRepository>(
    UserLocalRepositoryImpl(
      userDb: getIt<UserDb>(),
      configGeneral: getIt<ConfigDb>().general,
    ),
  );

  getIt.registerSingleton<AuthServerRepository>(
    AuthServerRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      authSocketService: getIt<AuthSocketService>(),
      authApiServiceNew: getIt<AuthApiServiceNew>(),
      accountService: getIt<AccountService>(),
      qrCodeLoginService: getIt<QrCodeLoginService>(),
      configGeneral: getIt<ConfigDb>().general,
      socialAuthApiService: getIt<SocialAuthApiService>(),
    ),
  );

  getIt.registerSingleton<CoreServerRepository>(
    CoreServerRepositoryImpl(
      commonService: getIt<CommonService>(),
    ),
  );

  getIt.registerSingleton<AddContactServerRepository>(
    AddContactServerRepositoryImpl(),
  );

  getIt.registerSingleton<ReportRepository>(
    ReportRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      reportApiService: getIt<ReportApiService>(),
      reportSocketService: getIt<ReportSocketService>(),
    ),
  );

  getIt.registerSingleton<RoomLocalRepository>(
    RoomLocalRepositoryImpl(
      roomDb: getIt<RoomDb>(),
    ),
  );

  getIt.registerSingleton<RoomSubLocalRepository>(
    RoomSubLocalRepositoryImpl(
      roomSubDb: getIt<RoomSubscriptionDb>(),
    ),
  );

  getIt.registerSingleton<ChatRoomLocalRepository>(
    ChatRoomLocalRepositoryImpl(
      roomDb: GetIt.I<RoomDb>(),
      roomSubscriptionDb: GetIt.I<RoomSubscriptionDb>(),
      groupPermissionDb: GetIt.I<GroupPermissionDb>(),
    ),
  );

  getIt.registerSingleton<ChatRoomLocalCompatRepository>(
    ChatRoomLocalCompatRepositoryImpl(
      roomDb: GetIt.I<RoomDb>(),
      roomSubscriptionDb: GetIt.I<RoomSubscriptionDb>(),
      roomMemberDb: GetIt.I<RoomMemberDb>(),
    ),
  );

  getIt.registerSingleton<CallLogServerRepository>(
    CallLogServerRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      callLogApiService: getIt<CallLogApiService>(),
      callLogSocketService: getIt<CallLogSocketService>(),
      log: getIt<LoggerService>(),
    ),
  );

  getIt.registerSingleton<CallLogDb>(
    CallLogDb(),
  );

  getIt.registerSingleton<CallLogLocalRepository>(
    CallLogLocalRepositoryImpl(
      callLogDb: getIt<CallLogDb>(),
    ),
  );

  getIt.registerSingleton<CallingServerRepository>(
    CallingServerRepositoryImpl(
      callingApiService: getIt<CallingApiService>(),
      callingSocketService: getIt<CallingSocketService>(),
      socketCaller: getIt<SocketCaller>(),
    ),
  );

  getIt.registerSingleton<ChatRoomListServerRepository>(
    ChatRoomListServerRepositoryImpl(
      chatRoomListSocketService: getIt<ChatRoomListSocketService>(),
      chatRoomListApiService: getIt<ChatRoomListApiService>(),
      socketCaller: getIt<SocketCaller>(),
      roomDb: getIt<RoomDb>(),
      configDb: getIt<ConfigDb>(),
      messageDb: getIt<MessageDb>(),
      roomFileDb: getIt<RoomFileDb>(),
      roomMemberDb: getIt<RoomMemberDb>(),
      roomSubscriptionDb: getIt<RoomSubscriptionDb>(),
      offlineTaskDb: getIt<OfflineTaskDb>(),
      roomSubLocalRepository: GetIt.I<RoomSubLocalRepository>(),
      chatRoomLocalRepository: GetIt.I<ChatRoomLocalRepository>(),
    ),
  );

  getIt.registerSingleton<ChatListSearchServerRepository>(
    ChatListSearchServerRepositoryImpl(
      socketCaller: getIt<SocketCaller>(),
      chatListSearchApiService: getIt<ChatListSearchApiService>(),
      chatListSearchSocketService: getIt<ChatListSearchSocketService>(),
    ),
  );

  getIt.registerSingleton<ChatListSearchLocalRepository>(
    ChatListSearchLocalRepositoryImpl(
      recentSearchDb: getIt<RecentSearchDb>(),
    ),
  );
}

void provideUseCases() {
  GetIt.I
    ..registerFactory(
      () => AppShareBottomSheetShareUseCase(),
    )
    ..registerFactory(
      () => GenerateDataForStressTestUseCase(
        log: GetIt.I<LoggerService>(),
        currentUser: UserController.instance.currentUser()!,
        contactLocalRepository: GetIt.I<ContactLocalRepository>(),
        chatRoomLocalRepository: GetIt.I<ChatRoomLocalRepository>(),
        roomMemberLocalRepository: GetIt.I<RoomMemberLocalRepository>(),
        messageLocalRepository: GetIt.I<MessageLocalRepository>(),
        contactsController: Get.find<ContactsController>(),
        messageService: MessageService.instance,
      ),
    );

  provideReportUseCases();
  provideAuthUseCases();
  provideCoreUseCases();
  provideMediaGalleryUseCases();
  provideCallLogUseCases();
  provideCallingUseCases();
  provideAddContactUseCases();
}

void provideCoreUseCases() {
  final getIt = GetIt.instance;

  getIt.registerFactory(
    () => GetEnabledCountryListUseCase(
      coreServerRepository: getIt<CoreServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetPublicConfigUseCase(
      coreServerRepository: getIt<CoreServerRepository>(),
    ),
  );
}

void provideAuthUseCases() {
  final getIt = GetIt.instance;

  getIt.registerSingleton(
    ResetSocialAuthUseCase(
      socialAuthProviderRepository: getIt<SocialAuthProviderRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInWithGoogleProviderUseCase(
      socialAuthProviderRepository: getIt<SocialAuthProviderRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInWithGoogleServerUseCase(
      socialAuthServerRepository: getIt<SocialAuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignOutWithGoogleUseCase(
      socialAuthProviderRepository: getIt<SocialAuthProviderRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInWithAppleProviderUseCase(
      socialAuthProviderRepository: getIt<SocialAuthProviderRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInWithAppleServerUseCase(
      socialAuthServerRepository: getIt<SocialAuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInWithFacebookProviderUseCase(
      socialAuthProviderRepository: getIt<SocialAuthProviderRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInWithFacebookServerUseCase(
      socialAuthServerRepository: getIt<SocialAuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SignInToFirebaseUseCase(),
  );

  getIt.registerFactory(
    () => CheckUserExistUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => ClearOtpUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => DeleteAccountUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
      userDb: getIt<UserDb>(),
    ),
  );

  getIt.registerFactory(
    () => ForgotPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetForgotPasswordDisplayUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetOtpForgotPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetOtpSettingAccountUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetOtpSavedUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetOtpTwoFaLoginUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetSessionsListUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => DeleteSessionUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => DeleteSessionsListUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LinkAccountWithAppleUseCase(
      socialAuthServerRepository: getIt<SocialAuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LinkAccountWithEmailUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LinkAccountWithFacebookUseCase(
      socialAuthServerRepository: getIt<SocialAuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LinkAccountWithGoogleUseCase(
      socialAuthServerRepository: getIt<SocialAuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LoginPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => LoginUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => RegisterUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SaveOtpUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => SetPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyOtpLinkEmailUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyOtpLoginUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyOtpUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyOtpSettingAccountUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyUChatIdUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => OfficialAccountQRSignInVerifyTokenUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => CheckPasswordRequiredUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyPasswordSettingAccountUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => ValidateNewEmailSettingAccountUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => UpdateEmailSettingAccountUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => ValidateNewPasswordUseCase(
      repository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => UpdateNewPasswordUseCase(
      repository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => MultifactorValidateUseCase(
      repository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => MultifactorUpdateUseCase(
      repository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => GetOtpMethodForgotPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => VerifyTokenForgotPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => ValidateForgotPasswordUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );

  getIt.registerFactory(
    () => UpdateAccountSettingUseCase(
      authServerRepository: getIt<AuthServerRepository>(),
    ),
  );
}

void provideReportUseCases() {
  GetIt.I.registerFactory(
    () => ReportUseCase(
      reportRepository: GetIt.I<ReportRepository>(),
    ),
  );
}

void provideMediaGalleryUseCases() {
  final getIt = GetIt.instance;

  getIt.registerFactory<GetOneImageGalleryUseCase>(
    () => GetOneImageGalleryUseCase(),
  );

  getIt.registerFactory<GetMediaGalleryUseCase>(
    () => GetMediaGalleryUseCase(),
  );
}

void provideCallLogUseCases() {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<CallLogRelatedDataHelper>(
    () => CallLogRelatedDataHelper(
      contactLocalRepository: getIt<ContactLocalRepository>(),
      chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
    ),
  );

  getIt.registerFactory<GetCallLogsWithContactUseCase>(
    () => GetCallLogsWithContactUseCase(
      callLogServerRepository: getIt<CallLogServerRepository>(),
      callLogLocalRepository: getIt<CallLogLocalRepository>(),
      relatedDataHelper: getIt<CallLogRelatedDataHelper>(),
    ),
  );

  getIt.registerFactory<GetLocalCallLogsWithContactUseCase>(
    () => GetLocalCallLogsWithContactUseCase(
      callLogLocalRepository: getIt<CallLogLocalRepository>(),
      relatedDataHelper: getIt<CallLogRelatedDataHelper>(),
    ),
  );

  getIt.registerFactory<SearchCallLogsWithContactUseCase>(
    () => SearchCallLogsWithContactUseCase(
      callLogServerRepository: getIt<CallLogServerRepository>(),
      relatedDataHelper: getIt<CallLogRelatedDataHelper>(),
    ),
  );

  getIt.registerFactory<SearchLocalCallLogsWithContactUseCase>(
    () => SearchLocalCallLogsWithContactUseCase(
      callLogLocalRepository: getIt<CallLogLocalRepository>(),
      relatedDataHelper: getIt<CallLogRelatedDataHelper>(),
    ),
  );

  getIt.registerFactory<DeleteSelectedCallLogsUseCase>(
    () => DeleteSelectedCallLogsUseCase(
      callLogLocalRepository: getIt<CallLogLocalRepository>(),
      callLogServerRepository: getIt<CallLogServerRepository>(),
    ),
  );

  getIt.registerFactory<ClearAllCallLogsUseCase>(
    () => ClearAllCallLogsUseCase(
      callLogLocalRepository: getIt<CallLogLocalRepository>(),
      callLogServerRepository: getIt<CallLogServerRepository>(),
    ),
  );
}

void provideCallingUseCases() {
  final getIt = GetIt.instance;

  getIt.registerFactory(
    () => StartCallUseCase(
      callingServerRepository: getIt<CallingServerRepository>(),
      callController: UChatCallController.instance,
      permissionController: PermissionController.instance,
      userController: UserController.instance,
      callKitController: UChatCallkitIncoming.instance,
      config: ConfigDb.instance.authenticated,
    ),
  );

  getIt.registerFactory(
    () => DeclineCallUseCase(
      callingServerRepository: getIt<CallingServerRepository>(),
    ),
  );
}

void provideAddContactUseCases() {
  final getIt = GetIt.instance;

  getIt.registerFactory(
    () => AcceptFriendRequestedUseCase(),
  );

  getIt.registerFactory(
    () => AcceptGroupInvitedUseCase(),
  );

  getIt.registerFactory(
    () => ApproveGroupRequestedUseCase(),
  );

  getIt.registerFactory(
    () => DeclineFriendRequestedUseCase(),
  );

  getIt.registerFactory(
    () => GetFriendRequestedListUseCase(),
  );

  getIt.registerFactory(
    () => GetGroupInvitedListUseCase(),
  );

  getIt.registerFactory(
    () => GetGroupRequestedListUseCase(),
  );

  getIt.registerFactory(
    () => RejectGroupRequestedUseCase(),
  );
}

void provideFlowManager() {
  GetIt.I.registerFactory(
    () => SettingAccountForgotPasswordFlowManager(
      user: UserController.instance.currentUser.value,
      getOtpMethodForgotPasswordUseCase: GetIt.I<GetOtpMethodForgotPasswordUseCase>(),
      verifyTokenForgotPasswordUseCase: GetIt.I<VerifyTokenForgotPasswordUseCase>(),
    ),
  );
}
