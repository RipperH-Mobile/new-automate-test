import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/fetch_room_member_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_all_member_in_room_use_case.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_room_by_id_use_case.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/find_group_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/chat_room_list_actions/toggle_mute_room_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/accept_room_handle_accept_use_case.dart';
import 'package:uchat/features/chat_room_list/domain/use_cases/group_actions/reject_room_use_case.dart';
import 'package:uchat/features/profile/presentation/controllers/group_profile_controller.dart';

class GroupProfileBinding implements Bindings {
  @override
  void dependencies() {
    final roomId = Get.parameters['id'] ?? '';

    Get.put<GroupProfileController>(
      GroupProfileController(
        roomId: roomId,
        log: GetIt.I<LoggerService>(),
        acceptRoomHandleAcceptUseCase: GetIt.I<AcceptRoomHandleAcceptUseCase>(),
        rejectRoomUseCase: GetIt.I<RejectRoomUseCase>(),
        toggleMuteRoomUseCase: GetIt.I<ToggleMuteRoomUseCase>(),
        startCallUseCase: GetIt.I<StartCallUseCase>(),
        getAllMemberInRoomUseCase: GetIt.I<GetAllMemberInRoomUseCase>(),
        fetchRoomMemberUseCase: GetIt.I<FetchRoomMemberUseCase>(),
        getRoomByIdUseCase: GetIt.I<GetRoomByIdUseCase>(),
        findGroupUseCase: GetIt.I<FindGroupUseCase>(),
        taxonomyService: GetIt.I<TaxonomyService>(),
      ),
    );
  }
}
