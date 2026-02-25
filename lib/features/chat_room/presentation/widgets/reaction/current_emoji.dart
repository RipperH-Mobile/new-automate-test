import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/customize_reaction_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/emoji_item.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/emoji_item_customizing.dart';

class CurrentEmoji extends GetView<CustomizeReactionController> {
  const CurrentEmoji({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UChatDimensions.emojiCustomizeItemSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your reactions'.tr,
            style: TextStyle(
              color: const Color(0xFF333333),
              fontSize: 14.spMin,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 12.spMin,
          ),
          Obx(
            () {
              if (controller.customizing.value) {
                return _buildCustomizeEmojiList();
              } else {
                return _buildDefaultEmojis();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildCustomizeEmojiList() {
    return Column(
      children: [
        GridView.count(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 6,
          mainAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
          crossAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
          children: List.generate(
            controller.customizingEmojiList.length,
            (index) => Obx(
              () {
                final item = controller.customizingEmojiList[index];
                return EmojiItemCustomizing(
                  fileId: item.fileId,
                  onTap: () {
                    controller.selectCustomizeEmoji(index);
                  },
                  active: controller.currentYourCustomizeEmojiIndex.value == index,
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 8.spMin,
        ),
        Text(
          'Tap an emoji and select a new emoji to replace it.'.tr,
          style: TextStyle(
            color: const Color(0xFF808080),
            fontSize: 12.spMin,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDefaultEmojis() {
    return GridView.count(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 6,
      mainAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
      crossAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
      children: List.generate(
        controller.accountDefaultEmojiItems.length,
        (index) {
          final item = controller.accountDefaultEmojiItems[index];
          return EmojiItem.mobileCustomize(
            onTap: () {
              controller.selectEmoji(item.emojiItemId ?? '');
              Get.back();
            },
            fileId: item.fileId,
            size: UChatDimensions.emojiCustomizeItemSize,
            selected: controller.message.selectedReactionList?.contains(item.emojiItemId) ?? false,
          );
        },
      ),
    );
  }
}
