import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/controllers/pin_messages_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_actions_pin.dart';
import 'package:uchat/features/chat_room/presentation/widgets/pin/message_container_pin.dart';

class PinMessageList extends GetView<PinMessagesController> {
  const PinMessageList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.isLoadingMessage.value) {
          return Container(
            color: context.theme.appColors.elevationSurfaceChat,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.space14),
                child: CircularProgressIndicator(
                  strokeCap: StrokeCap.round,
                  color: context.theme.appColors.backgroundPrimary,
                ),
              ),
            ),
          );
        }

        if (controller.messages.isEmpty) {
          return const SizedBox.shrink();
        }

        return CupertinoScrollbar(
          thumbVisibility: true,
          thickness: 4,
          child: _buildMessageListView(),
        );
      },
    );
  }

  Widget _buildMessageListView() {
    return CustomScrollView(
      reverse: true,
      cacheExtent: 0,
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: AppSpace.space3,
            vertical: AppSpace.space4,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Obx(
                  () {
                    final pinMessage = controller.messages.elementAtOrNull(index);
                    if (pinMessage == null || pinMessage.message == null) {
                      return const SizedBox.shrink();
                    }

                    final messageContainer = MessageContainerPin(
                      pinedMessage: pinMessage,
                      onStatusTap: () => controller.onJumpToMessage(pinMessage),
                      messageActionsPin: MessageActionsPin(
                        isAbleToPinMessages: controller.isAbleToPinMessages,
                        onCopy: () {
                          Get.back();
                          controller.onCopyMessage(pinMessage);
                        },
                        onUnPin: () {
                          Get.back();
                          controller.onUnPinMessage(pinMessage);
                        },
                        onShare: () {
                          Get.back();
                          controller.onShareMessage(pinMessage);
                        },
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.only(top: AppSpace.space3),
                      child: messageContainer,
                    );
                  },
                );
              },
              childCount: controller.messages.length,
            ),
          ),
        ),
      ],
    );
  }
}
