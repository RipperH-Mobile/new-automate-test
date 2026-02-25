import 'dart:math';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';

import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type_audio_v2_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/message_reaction_popup.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class MessageTypeAudioV2 extends GetView<MessageTypeAudioV2Controller> {
  final MessageCollection message;
  final String messageTag;

  const MessageTypeAudioV2({
    super.key,
    required this.message,
    required this.messageTag,
  });

  @override
  String get tag => messageTag;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, c) {
      return ContextMenuWidget(
        forceAlignment: message.mine ? Alignment.centerLeft : Alignment.centerRight,
        width: c.maxWidth,
        childBoxConstraints: BoxConstraints(
          maxWidth: min(Get.width * 0.7, 270.spMin),
        ),
        longPressCallback: () {
          String mediaType = 'audio';
          if (message.type != null) {
            mediaType = EventProperty.getMessageTypeForEventParams(message.type!);
          }
          GetIt.I<TaxonomyService>()
              .sendEvent(EventName.longpressChatroom, eventProperties: EventProperty.longPressChatRoom(mediaType));
        },
        actions: controller.actions(message),
        topWidgetHeight: controller.canReact ? MessageReactionPopup.height : null,
        topWidget: controller.canReact
            ? MessageReactionPopup(
                messageTag: tag,
              )
            : null,
        child: Obx(() {
          return Container(
            width: min(Get.width * 0.7, 270.spMin),
            padding: const EdgeInsets.fromLTRB(
              AppSpace.space2,
              AppSpace.space2,
              AppSpace.space3,
              AppSpace.space2,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
              color: message.mine
                  ? controller.isPlaying.value
                      ? context.theme.appColors.backgroundPrimaryBolder
                      : context.theme.appColors.backgroundPrimary
                  : controller.isPlaying.value
                      ? context.theme.appColors.backgroundNeutralLightPressed
                      : context.theme.appColors.backgroundNeutralLight,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// [Play button section]
                Obx(() {
                  return GestureDetector(
                    onTap: () => controller.handlePlayButtonPressed(),
                    child: AnimatedScale(
                      scale: controller.playButtonScale.value,
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        height: AppSize.size8,
                        child: controller.isDownloading.value
                            ? _buildLoading(context)
                            : controller.isPlaying.value
                                ? message.mine
                                    ? Assets.vectors.whitePauseIcon.svg()
                                    : Assets.vectors.bluePauseIcon.svg()
                                : message.mine
                                    ? Assets.vectors.whitePlayIcon.svg()
                                    : Assets.vectors.bluePlayIcon.svg(),
                      ),
                    ),
                  );
                }),
                AppSpace.space2.horizontalSpace,

                /// [Waveforms section]
                Obx(() {
                  return Expanded(
                    child: controller.isFileReadyToPlay.value
                        ? AudioFileWaveforms(
                            size: const Size(double.maxFinite, AppSize.size6),
                            playerController: controller.playerController,
                            waveformType: controller.isShowFitWidth.value ? WaveformType.fitWidth : WaveformType.long,
                            enableSeekGesture: true,
                            playerWaveStyle: PlayerWaveStyle(
                              showSeekLine: true,
                              spacing: 6,
                              waveThickness: 2,
                              scaleFactor: 80,
                              fixedWaveColor: message.mine
                                  ? context.theme.appColors.iconInverse.withValues(alpha: 0.5)
                                  : context.theme.appColors.icon.withValues(alpha: 0.5),
                              liveWaveColor:
                                  message.mine ? context.theme.appColors.iconInverse : context.theme.appColors.icon,
                            ),
                          )
                        : message.mine
                            ? Assets.vectors.lightWaveform.svg()
                            : Assets.vectors.darkWaveform.svg(),
                  );
                }),
                AppSpace.space2.horizontalSpace,

                /// [Duration section]
                Obx(() {
                  return AppText.body4(
                    controller.currentDuration,
                    textAlign: TextAlign.center,
                    color:
                        message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    context: context,
                  );
                }),
              ],
            ),
          );
        }),
      );
    });
  }

  Widget buildVoiceAudio(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space2,
        AppSpace.space2,
        AppSpace.space3,
        AppSpace.space2,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
        color:
            message.mine ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundNeutralLight,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// [Play button section]
          message.mine ? Assets.vectors.whitePlayIcon.svg() : Assets.vectors.bluePlayIcon.svg(),
          AppSpace.space3.horizontalSpace,
          message.mine ? Assets.vectors.lightWaveform.svg() : Assets.vectors.darkWaveform.svg(),
          AppSpace.space2.horizontalSpace,

          /// [Duration section]
          AppText.body4(
            controller.currentDuration,
            textAlign: TextAlign.center,
            color: message.mine ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
            maxLines: 1,
            textOverflow: TextOverflow.ellipsis,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return SizedBox(
      height: AppSize.size8,
      width: AppSize.size8,
      child: CircularProgressIndicator(
        color: message.mine ? context.theme.appColors.iconPrimaryInverse : context.theme.appColors.backgroundPrimary,
      ),
    );
  }
}
