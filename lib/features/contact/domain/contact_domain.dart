//------------------------------------Entities for Contact feature------------------------------------------------------------------------
export 'package:uchat/features/contact/domain/entities/contact_entity.dart';

//------------------------------------Parameters for Contact feature------------------------------------------------------------------------
export 'package:uchat/features/contact/domain/params/block_contact_params.dart';
export 'package:uchat/features/contact/domain/params/contact_params.dart';
export 'package:uchat/features/contact/domain/params/get_contact_name_params.dart';
export 'package:uchat/features/contact/domain/params/get_contact_params.dart';
export 'package:uchat/features/contact/domain/params/get_friend_contact_params.dart';
export 'package:uchat/features/contact/domain/params/put_contact_params.dart';
export 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';
export 'package:uchat/features/contact/domain/params/search_official_account_contact_params.dart';
export 'package:uchat/features/contact/domain/params/unblock_contact_params.dart';
export 'package:uchat/features/contact/domain/params/update_contact_params.dart';

//------------------------------------Interfaces for Contact feature------------------------------------------------------------------------
export 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
export 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';

//------------------------------------Use cases for Contact feature------------------------------------------------------------------------
export 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/add_friend_in_group_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/check_if_requesting_friend_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/clear_collection_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/decline_friend_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/delete_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/delete_contact_without_txn_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_all_online_friends_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_blocked_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_can_chat_with_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_can_show_in_share_contact_sort_by_display_name_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_contact_name_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_friend_contact_by_id_sync_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_friend_contact_by_id_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_friend_contact_list_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_friend_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_friend_request_list_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_hidden_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/get_official_account_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/hide_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/put_all_contact_without_txn_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/put_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/put_contact_without_txn_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/put_or_update_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/remove_friend_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/search_can_chat_with_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/search_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/search_friend_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/search_official_account_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/unblock_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/unhide_contact_use_case.dart';
export 'package:uchat/features/contact/domain/use_cases/update_nickname_use_case.dart';
