import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/call/presentation/views/widgets/livekit/sound_waveform_impl.dart';
import 'package:uchat/features/call/presentation/views/widgets/element/avatar.dart';
import 'package:uchat/features/call/utils/enum.dart';

class CallUserProfileWidget extends StatelessWidget {
  final UiCallState uiState;
  final String image;
  final String blurHash;
  final bool speaking;
  final double size;
  final bool showBorder;

  const CallUserProfileWidget({
    super.key,
    required this.uiState,
    required this.image,
    required this.blurHash,
    this.size = 120,
    this.speaking = false,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return buildUserProfile(uiState);
  }

  Widget buildUserProfile(UiCallState uiState) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Widget child;
        if ([UiCallState.voice, UiCallState.video].contains(uiState)) {
          // TODO: change to wave form
          child = SoundWaveFormRingingImpl(
            speaking: speaking,
            size: size,
            avatar: buildAvatarWidget(context),
          );
        } else {
          child = SizedBox(
            width: size,
            height: size,
            child: buildAvatarWidget(context),
          );
        }
        return Center(
          child: Padding(
            // avatarHeight is 100% of get.height
            // constraints.maxHeight is actual height of widget
            // so we need to calculate the padding to make sure the avatar is at the bottom of the widget
            padding: EdgeInsets.only(bottom: constraints.maxHeight * (size / 2) / Get.height),
            child: child,
          ),
        );
      },
    );
  }

  buildAvatarWidget(BuildContext context) {
    return Pulse(
      animate: speaking,
      infinite: speaking,
      to: 1.1,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: showBorder
              ? Border.all(
                  color: context.theme.appColors.borderLighter,
                  width: 1,
                )
              : null,
        ),
        child: AvatarWidget(
          blurHash: blurHash,
          radius: size / 2,
          avatar: image,
        ),
      ),
    );
  }
}
