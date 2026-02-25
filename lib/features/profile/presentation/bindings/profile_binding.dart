import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/add_contact_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_local_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_profile_server_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/get_room_by_account_id_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_subscription_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/open_direct_chat_and_save_to_db_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/add_friend_in_group_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/block_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/unblock_contact_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:uchat/features/profile/presentation/controllers/profile_controller.dart';

class ProfileBindingV2 implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileControllerV2>(
      ProfileControllerV2(
        accountId: Get.parameters['id'] ?? '',
        args: Get.arguments,
        log: useLogger(),
        taxonomyService: GetIt.I<TaxonomyService>(),
        startCallUseCase: GetIt.I<StartCallUseCase>(),
        getProfileLocalUseCase: GetIt.I<GetProfileLocalUseCase>(),
        getProfileServerUseCase: GetIt.I<GetProfileServerUseCase>(),
        updateProfileUseCase: GetIt.I<UpdateProfileUseCase>(),
        getRoomByAccountIdUseCase: GetIt.I<GetRoomByAccountIdUseCase>(),
        addContactUseCase: GetIt.I<AddContactUseCase>(),
        getRoomSubscriptionUseCase: GetIt.I<GetRoomSubscriptionUseCase>(),
        openDirectChatAndSaveToDbUseCase: GetIt.I<OpenDirectChatAndSaveToDbUseCase>(),
        addFriendInGroupUseCase: GetIt.I<AddFriendInGroupUseCase>(),
        blockContactUseCase: GetIt.I<BlockContactUseCase>(),
        unblockContactUseCase: GetIt.I<UnblockContactUseCase>(),
        toggleMuteRoomUseCase: GetIt.I<ToggleMuteRoomUseCase>(),
      ),
    );
  }
}
