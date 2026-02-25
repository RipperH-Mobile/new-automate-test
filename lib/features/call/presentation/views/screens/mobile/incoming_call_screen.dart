import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/call_performance_service.dart';
import 'package:uchat/core/infrastructure/analytics/enum/receive_method.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/participant_image_background.dart';
import 'package:uchat/features/call/presentation/views/screens/mobile/direct_call_layout.dart';
import 'package:uchat/features/call/presentation/views/widgets/panels/call_action_panel_incoming.dart';
import 'package:uchat/features/call/presentation/views/widgets/app_bar/app_bar_mobile.dart';
import 'package:uchat/features/call/presentation/views/widgets/component/call_user_profile.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/call_status.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/call_title.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';

class IncomingCallScreen extends StatelessWidget {
  final RoomCallModel callData;
  final VoidCallback? onAnswerCall;
  final VoidCallback? onDeclineCall;

  const IncomingCallScreen({
    super.key,
    required this.callData,
    this.onAnswerCall,
    this.onDeclineCall,
  });

  @override
  Widget build(BuildContext context) {
    // สั่งให้ทำงานหลังจาก Frame build เสร็จ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      useCallPerformance().stopPerformanceCallingIncomingCall(
        receiveMethod: ReceiveMethod.socket,
      );
    });
    return DirectCallLayout(
      body: Stack(
        children: [
          ParticipantImageBackground(
            image: callData.imageUrl ?? '',
            blurHash: callData.imageBlurHash ?? '',
          ),
          CallUserProfileWidget(
            uiState: UiCallState.voice,
            image: callData.imageUrl ?? '',
            blurHash: callData.imageBlurHash ?? '',
            size: 168,
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: CallStatusWidget(
                status: 'Ringing...'.tr,
              ),
            ),
          ),
        ],
      ),
      appBar: CallAppBarMobile(
        title: CallTitleWidget(
          title: callData.title ?? 'Unknown user'.tr,
        ),
        // status: CallStatusWidget(
        //   status: 'Ringing...'.tr,
        // ),
        showBackButton: false,
      ),
      actionsControl: CallActionPanelIncomingWidget(
        isVideo: callData.callType == CallType.video,
        onAnswer: () {
          String callType = callData.callType == CallType.video ? 'video' : 'voice';
          GetIt.I<TaxonomyService>()
              .sendEvent(EventName.callAccepted, eventProperties: EventProperty.callAccepted('in-app', callType));
          onAnswerCall?.call();
        },
        onDecline: () {
          onDeclineCall?.call();
        },
      ),
    );
  }
}
