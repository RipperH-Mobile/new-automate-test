import 'package:get_it/get_it.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/api/socket.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/repositories/chat_room_local_repository.dart';
import 'package:uchat/features/contact/data/data_source/remote/contact_http_service.dart';
import 'package:uchat/features/contact/data/data_source/remote/contact_socket_service.dart';
import 'package:uchat/features/contact/data/repositories/contact_local_repository_impl.dart';
import 'package:uchat/features/contact/data/repositories/contact_server_repository_impl.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_block_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/get_room_direct_is_vibranium_shield_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/repair_contacts_without_phone_number_use_case.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';

import '../data/data_source/local/contact_db.dart';
import '../domain/repositories/contact_server_repository.dart';
import '../domain/use_cases/add_contact_use_case.dart';
import '../domain/use_cases/add_friend_in_group_use_case.dart';
import '../domain/use_cases/block_contact_use_case.dart';
import '../domain/use_cases/check_if_requesting_friend_use_case.dart';
import '../domain/use_cases/clear_collection_use_case.dart';
import '../domain/use_cases/decline_friend_use_case.dart';
import '../domain/use_cases/delete_contact_use_case.dart';
import '../domain/use_cases/delete_contact_without_txn_use_case.dart';
import '../domain/use_cases/get_all_online_friends_use_case.dart';
import '../domain/use_cases/get_blocked_contact_use_case.dart';
import '../domain/use_cases/get_can_chat_with_contact_use_case.dart';
import '../domain/use_cases/get_can_show_in_share_contact_sort_by_display_name_use_case.dart';
import '../domain/use_cases/get_contact_name_use_case.dart';
import '../domain/use_cases/get_contact_sync_use_case.dart';
import '../domain/use_cases/get_contact_use_case.dart';
import '../domain/use_cases/get_friend_contact_by_id_sync_use_case.dart';
import '../domain/use_cases/get_friend_contact_by_id_use_case.dart';
import '../domain/use_cases/get_friend_contact_list_use_case.dart';
import '../domain/use_cases/get_friend_contact_use_case.dart';
import '../domain/use_cases/get_friend_request_list_use_case.dart';
import '../domain/use_cases/get_hidden_contact_use_case.dart';
import '../domain/use_cases/get_official_account_contact_use_case.dart';
import '../domain/use_cases/hide_contact_use_case.dart';
import '../domain/use_cases/put_all_contact_without_txn_use_case.dart';
import '../domain/use_cases/put_contact_use_case.dart';
import '../domain/use_cases/put_contact_without_txn_use_case.dart';
import '../domain/use_cases/put_or_update_contact_use_case.dart';
import '../domain/use_cases/remove_friend_use_case.dart';
import '../domain/use_cases/search_can_chat_with_contact_use_case.dart';
import '../domain/use_cases/search_contact_use_case.dart';
import '../domain/use_cases/search_friend_contact_use_case.dart';
import '../domain/use_cases/search_official_account_contact_use_case.dart';
import '../domain/use_cases/unblock_contact_use_case.dart';
import '../domain/use_cases/unhide_contact_use_case.dart';
import '../domain/use_cases/update_nickname_use_case.dart';

Future<void> registerContactSingletonDependencies() async {
  final getIt = GetIt.instance;
  final httpCaller = getIt<HttpCaller>();
  final socketCaller = getIt<SocketCaller>();

  // Register Data sources
  final contactDb = getIt.registerSingleton<ContactDb>(ContactDb());
  getIt.registerSingleton<ContactHttpService>(ContactHttpService(httpCaller: httpCaller));
  getIt.registerSingleton<ContactSocketService>(ContactSocketService(socketCaller: socketCaller));

  // Register Repositories
  getIt.registerSingleton<ContactLocalRepository>(ContactLocalRepositoryImpl(contactDb: contactDb));
  getIt.registerSingleton<ContactServerRepository>(ContactServerRepositoryImpl());
}

Future<void> registerContactFactoryDependencies() async {
  final getIt = GetIt.instance;

  // Register use case
  getIt.registerFactory(
    () => AddContactUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => AddFriendInGroupUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => BlockContactUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(() => CheckIfRequestingFriendUseCase());
  getIt.registerFactory(() => ClearCollectionUseCase());
  getIt.registerFactory(() => DeclineFriendUseCase());
  getIt.registerFactory(() => DeleteContactUseCase());
  getIt.registerFactory(() => DeleteContactWithoutTxnUseCase());
  getIt.registerFactory(
    () => GetAllOnlineFriendsUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetBlockedContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetCanChatWithContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetCanShowInShareContactSortByDisplayNameUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetContactSyncUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(() => GetContactNameUseCase(
        contactLocalRepository: getIt<ContactLocalRepository>(),
        chatRoomLocalRepository: getIt<ChatRoomLocalRepository>(),
      ));
  getIt.registerFactory(
    () => GetFriendContactByIdSyncUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetFriendContactByIdUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetFriendContactListUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetFriendContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetFriendRequestListUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetHiddenContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetOfficialAccountContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetRoomDirectIsBlockUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => GetRoomDirectIsVibraniumShieldUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => HideContactUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => PutAllContactWithoutTxnUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => PutContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => PutContactWithoutTxnUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => PutOrUpdateContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => RemoveFriendUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => SearchCanChatWithContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => SearchContactUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => SearchFriendContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => SearchOfficialAccountContactUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
    ),
  );
  getIt.registerFactory(
    () => UnblockContactUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(
    () => UnhideContactUseCase(
      contactServerRepository: getIt<ContactServerRepository>(),
    ),
  );
  getIt.registerFactory(() => UpdateNicknameUseCase());
  getIt.registerFactory(
    () => RepairContactsWithoutPhoneNumberUseCase(
      contactLocalRepository: getIt<ContactLocalRepository>(),
      profileServerRepository: getIt<ProfileServerRepository>(),
      log: getIt<LoggerService>(),
    ),
  );
}
