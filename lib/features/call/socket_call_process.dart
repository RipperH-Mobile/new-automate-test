import 'package:flutter/foundation.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/param/call_attribute_param.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/data/data_source/remote/room_call_service.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/utils/enum.dart';

final _log = useLogger();

class SocketCallProcess {
  factory SocketCallProcess() => instance;

  SocketCallProcess.internal();

  static final SocketCallProcess instance = SocketCallProcess.internal();

  UChatCallController get callCtl => Get.find<UChatCallController>();

  Future<void> processCallSocket(RoomCallModel roomCall) async {
    switch (roomCall.type) {
      case SocketCallType.acceptCallNotification:
        final call = callCtl.callCtlList.firstWhereOrNull(
          (element) => element.callData.roomCallId == roomCall.roomCallId,
        );
        if (call?.callData.callState != CallState.connected) {
          call?.callState = CallState.paused;
        }
        break;
      case SocketCallType.declineCallNotification:
        final userCtl = UserController.instance;
        if (userCtl.currentUser()?.currentSessionKeyId != roomCall.callOnSessionKeyId) {
          await useCallPerformance().startPerformanceCallingMissed(
            CallAttributesParams(
              roomCallId: roomCall.roomCallId,
              roomType: roomCall.roomType?.value,
              callType: roomCall.callType?.value,
              receivingFrom: ReceiveMethod.socket,
            ),
          );
          debugPrint('call FlutterCallkitIncoming to end call: socket');
          await FlutterCallkitIncoming.endCall(roomCall.roomCallId!);
          useCallPerformance().stopPerformanceCallingMissed(
            receiveMethod: ReceiveMethod.socket,
          );

          for (final call in [...callCtl.callCtlList]) {
            if (call.callData.roomCallId == roomCall.roomCallId) {
              await call.disconnect('Call declined via socket');
            }
          }
          callCtl.closeAnyCallScreen();
        }
        break;
      case SocketCallType.ringingCallNotification:
        if (Get.isRegistered<UChatLiveKitController>(tag: roomCall.roomId)) {
          final liveKitCallCtl = Get.find<UChatLiveKitController>(tag: roomCall.roomId);
          liveKitCallCtl.callState = CallState.connecting;
        }
        break;
      case SocketCallType.callNotification:
        // This condition should handle from server!!
        if (UserController.instance.currentUser()?.accountSettings?.call?.allowCallKit != true) {
          return;
        }
        if (GetPlatform.isAndroid) {
          await useCallPerformance().startPerformanceCallingIncomingCall(
            CallAttributesParams(
              roomCallId: roomCall.roomCallId,
              roomType: roomCall.roomType?.value,
              callType: roomCall.callType?.value,
              receivingFrom: ReceiveMethod.socket,
            ),
          );
          callCtl.openIncomingCallScreen(roomCall);
        }
        try {
          await RoomCallService.instance.ringingCall(roomCall.roomCallId!);
        } catch (e) {
          _log.e('Error ringing call: $e');
        }
        break;
      case SocketCallType.ringingTimeoutCallNotification:
        break;
      case SocketCallType.cancelCallNotification:
        callCtl.closeAnyCallScreen();
        break;
      default:
        break;
    }
  }
}
