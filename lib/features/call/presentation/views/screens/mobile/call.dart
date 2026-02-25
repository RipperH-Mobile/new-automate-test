import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/call/call_controller.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/livekit/start_direct_call_controller.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/end_call_screen.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/incoming_call_screen.dart';
import 'package:uchat/features/call/livekit/start_group_call_controller.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';

import 'direct.dart';
import 'group.dart';

class CallScreen<C extends UChatLiveKitController> extends GetView<UChatCallController> {
  final RoomCallModel callData;
  final VoidCallback? onAnswerCall;
  final VoidCallback? onDeclineCall;

  const CallScreen({
    super.key,
    required this.callData,
    this.onAnswerCall,
    this.onDeclineCall,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.disconnecting() == true) {
          return EndCallScreen(
            callData: callData,
            duration: controller.callDuration(),
          );
        }

        if (callData.roomId?.isNotEmpty == true && Get.isRegistered<StartGroupCallCtl>(tag: callData.roomId)) {
          return GroupCallScreenImpl<StartGroupCallCtl>(
            roomId: callData.roomId!,
          );
        }

        if (callData.roomId?.isNotEmpty == true && Get.isRegistered<StartDirectCallCtl>(tag: callData.roomId)) {
          return DirectCallScreenImpl<StartDirectCallCtl>(
            roomId: callData.roomId!,
          );
        }

        if (onAnswerCall != null && onDeclineCall != null) {
          return IncomingCallScreen(
            callData: callData,
            onAnswerCall: onAnswerCall,
            onDeclineCall: onDeclineCall,
          );
        }

        return EndCallScreen(
          callData: callData,
          duration: controller.callDuration(),
        );
      },
    );
  }
}
