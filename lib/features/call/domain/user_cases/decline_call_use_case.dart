import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/features/call/data/models/requests/decline_call_request.dart';
import 'package:uchat/features/call/data/models/requests/leave_group_call_request.dart';
import 'package:uchat/features/call/domain/params/decline_call_param.dart';
import 'package:uchat/features/call/domain/repositories/calling_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class DeclineCallUseCase extends SimpleUseCase<void, DeclineCallParam> {
  DeclineCallUseCase({
    required this.callingServerRepository,
  });

  final CallingServerRepository callingServerRepository;

  @override
  Future<void> call(DeclineCallParam params) async {
    try {
      if (params.roomCallModel.roomType == RoomType.group) {
        await callingServerRepository.leaveGroupCall(
          LeaveGroupCallRequest(
            roomId: params.roomCallModel.roomId!,
          ),
        );
      } else {
        await callingServerRepository.declineCall(
          DeclineCallRequest(
            roomCallId: params.roomCallModel.roomCallId!,
            liveKitRoomSID: params.roomCallModel.liveKitRoomSID!,
            isCancel: params.isCancel,
          ),
        );
      }
    } catch (e, st) {
      _log.e('Decline call use case error', e, st);
    }
  }
}
