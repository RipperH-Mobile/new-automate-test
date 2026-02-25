// import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/message_reaction_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/emoji_item.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/customize_emoji_bottom_sheet.dart';
import 'package:uchat/widgets/sheet/uchat_bottom_sheet.dart';

class MessageReactionPopup extends GetView<MessageReactionController> {
  static double height = UChatDimensions.emojiBlockHeight;

  final String messageTag;

  @override
  String get tag => messageTag;

  const MessageReactionPopup({
    super.key,
    required this.messageTag,
  });

  @override
  Widget build(BuildContext context) {
    final selectedReactionList = controller.message.value?.selectedReactionList ?? [];
    final emojiList = UserController.instance.currentUser.value!.accountDefaultEmojiItems ?? [];

    // 4. Added a ScaleTransition for the overall popup scaling animation
    return Container(
      height: UChatDimensions.emojiBlockHeight,
      padding: EdgeInsets.symmetric(
        horizontal: UChatDimensions.emojiMenuItemXPadding,
      ),
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightest,
        borderRadius: BorderRadius.circular(AppRadius.roundedFull),
        border: Border.all(
          color: context.theme.appColors.borderInput,
          width: UChatDimensions.emojiBlockBorderWidth,
        ),
      ),
      child: Center(
        child: Row(
          spacing: UChatDimensions.emojiMenuItemSpace,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: emojiList.map((e) {
            final emojiItemId = e.emojiItemId;
            if (emojiItemId == null) return const SizedBox.shrink();

            return EmojiItem.mobile(
              context: context,
              fileId: e.fileId,
              selected: selectedReactionList.contains(emojiItemId),
              onTap: () {
                Get.back();
                controller.selectEmoji(emojiItemId);
              },
              size: UChatDimensions.emojiMenuItemWidth,
            );
          }).toList()
            ..add(_buildExpandButton(
              context,
              () async {
                Get.back();

                final message = controller.message.value;
                if (message == null) return;

                // Slight delay to ensure smooth transition
                await Future.delayed(const Duration(milliseconds: 350));
                UChatBottomSheet.showBottomSheet(
                  context: Get.context!,
                  widget: CustomizeEmojiBottomSheet(
                    message: message,
                  ),
                  isScrollControlled: true,
                );
              },
            )),
        ),
      ),
    );
  }

  Widget _buildExpandButton(BuildContext context, Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.chevron_right_rounded,
        color: context.theme.appColors.icon,
        size: 24,
      ),
    );
  }
}
