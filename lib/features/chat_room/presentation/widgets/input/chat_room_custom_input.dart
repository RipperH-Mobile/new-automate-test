import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/chat_room_custom_input_type.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_gif_input.dart';
import 'package:uchat/features/chat_room/presentation/widgets/input/chat_room_sticker_input.dart';
import 'package:uchat/features/chat_room/presentation/widgets/swipe_bar.dart';
import 'package:uchat/gen/assets.gen.dart';

class ChatRoomCustomInput extends GetView<ChatRoomInputController> {
  final Function(StickerSendingEntity, {int loopCount}) onSendSticker;
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  static const inputNavigationHeight = 48.0;

  const ChatRoomCustomInput({
    super.key,
    required this.onSendSticker,
    required this.onSendGif,
    this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<Widget> childrenx = [];
        if (controller.isInputModeCustomInput && controller.customInputType() == ChatRoomCustomInputType.sticker) {
          childrenx = [
            ChatRoomStickerInput(
              onSendSticker: onSendSticker,
              controllerTag: controllerTag,
              swipeBar: SwipeBar(
                offsetHeight:
                    ChatRoomStickerInput.stickerHeaderHeight + (controller.previewSticker.value != null ? 120 : 0),
                onVerticalPositionUpdate: (inversePositionDy) {
                  controller.swipeKeyboardHeight(inversePositionDy + ChatRoomStickerInput.stickerHeaderHeight);
                },
                onVerticalDragEnd: (inversePositionDy) {
                  if (controller.previewSticker.value != null) {
                    controller.swipeKeyboardHeight(0);
                  } else if (inversePositionDy > 0.50.sh) {
                    controller.swipeKeyboardHeight(0.65.sh);
                  } else {
                    controller.swipeKeyboardHeight(0);
                  }
                },
              ),
            ),
            _buildCustomInputSelector(context),
          ];
        } else if (controller.isInputModeCustomInput && controller.customInputType() == ChatRoomCustomInputType.gif) {
          childrenx = [
            ChatRoomGifInput(
              onSendGif: onSendGif,
              controllerTag: controllerTag,
              swipeBar: SwipeBar(
                offsetHeight: ChatRoomGifInput.headerHeight + (controller.previewSticker.value != null ? 120 : 0),
                onVerticalPositionUpdate: (inversePositionDy) {
                  controller.swipeKeyboardHeight(inversePositionDy + ChatRoomGifInput.headerHeight);
                },
                onVerticalDragEnd: (inversePositionDy) {
                  if (controller.previewSticker.value != null) {
                    controller.swipeKeyboardHeight(0);
                  } else if (inversePositionDy > 0.50.sh) {
                    controller.swipeKeyboardHeight(controller.customInputHeightExpanded);
                  } else {
                    controller.swipeKeyboardHeight(0);
                  }
                },
              ),
            ),
            _buildCustomInputSelector(context),
          ];
        }

        return Obx(() {
          return AnimatedContainer(
            color: Colors.transparent,
            duration: const Duration(milliseconds: ChatRoomInputController.keyboardAnimationDuration),
            curve: Curves.decelerate,
            height: controller.useBottomPadding ? controller.keyboardHeight : 0,
            child: Stack(
              children: childrenx,
            ),
          );
        });
      },
    );
  }

  Widget _buildCustomInputSelector(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: Get.mediaQuery.viewPadding.bottom),
        child: Container(
          padding: const EdgeInsets.only(
            bottom: AppSpace.space1,
          ),
          height: inputNavigationHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(
                  AppRadius.roundedFull,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 40,
                    sigmaY: 40,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.space1,
                    ),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundStickerSelect.withValues(alpha: 0.45),
                      // TODO: fix shadow
                      boxShadow: [
                        const BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildIcon(
                            assetPath: Assets.vectors.stickerCircle.path,
                            type: ChatRoomCustomInputType.sticker,
                            context: context,
                          ),
                          _buildIcon(
                            assetPath: Assets.vectors.gifBox.path,
                            type: ChatRoomCustomInputType.gif,
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon({
    required String assetPath,
    required ChatRoomCustomInputType type,
    required BuildContext context,
  }) {
    return Obx(
      () {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpace.space1,
              horizontal: AppSpace.space4,
            ),
            decoration: controller.customInputType() == type
                ? BoxDecoration(
                    color: context.theme.appColors.backgroundStickerSelect,
                    borderRadius: BorderRadius.circular(
                      AppRadius.roundedFull,
                    ),
                  )
                : null,
            child: SvgPicture.asset(
              assetPath,
              colorFilter: ColorFilter.mode(
                context.theme.appColors.iconInverse,
                BlendMode.srcIn,
              ),
              width: AppSize.size8,
              height: AppSize.size8,
            ),
          ),
          onTap: () {
            if (type == ChatRoomCustomInputType.sticker) {
              GetIt.I<TaxonomyService>().sendEvent(EventName.clickStickerIcon);
            } else {
              GetIt.I<TaxonomyService>().sendEvent(EventName.clickGifIcon);
            }
            controller.customInputType(type);
            controller.clearPreviewSticker();
          },
        );
      },
    );
  }
}
