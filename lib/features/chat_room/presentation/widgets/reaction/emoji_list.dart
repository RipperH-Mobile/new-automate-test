import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_dimensions.dart';
import 'package:uchat/constants/uchat_duration.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/customize_reaction_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/reaction/emoji_item.dart';

class EmojiList extends GetView<CustomizeReactionController> {
  const EmojiList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: UChatDimensions.emojiCustomizeItemSpace,
        right: UChatDimensions.emojiCustomizeItemSpace,
        top: 16.spMin,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              controller.currentEmojiPackage.value?.nameLocale ?? '',
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 14.spMin,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 12.spMin,
          ),
          Expanded(
            child: Obx(
              () {
                return AnimatedSwitcher(
                  duration: UChatDuration.switcherDuration,
                  child: controller.loading.value ? _buildEmojiShimmer() : _buildEmojiList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEmojiList() {
    final emojiItems = controller.emojiList[controller.currentEmojiPackage.value?.id ?? ''] ?? [];
    final customizing = controller.customizing.value;
    return KeyedSubtree(
      key: const ValueKey('emojis'),
      child: GridView.builder(
        key: ValueKey('emojis_${controller.currentEmojiPackage.value?.id}'),
        padding: EdgeInsets.only(
          bottom: 16.spMin,
        ),
        itemCount: emojiItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
          crossAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
        ),
        itemBuilder: (context, index) {
          final item = emojiItems[index];
          final selected = controller.message.selectedReactionList?.contains(item.emojiItem.id);
          return EmojiItem.mobileCustomize(
            fileId: item.emojiItem.fileId,
            active: item.active || !customizing,
            selected: (selected ?? false) && !customizing,
            size: UChatDimensions.emojiCustomizeItemSize,
            onTap: () {
              if (customizing) {
                controller.changeEmoji(index);
              } else {
                controller.selectEmoji(item.emojiItem.id ?? '');
                Get.back();
              }
            },
          );
        },
      ),
    );
  }

  GridView _buildEmojiShimmer() {
    return GridView.builder(
      key: const ValueKey('shimmer'),
      padding: EdgeInsets.only(
        bottom: 16.spMin,
      ),
      itemCount: 30,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        mainAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
        crossAxisSpacing: UChatDimensions.emojiCustomizeItemSpace,
      ),
      itemBuilder: (context, index) {
        return EmojiItem.mobileCustomize(
          size: UChatDimensions.emojiCustomizeItemSize,
          showShimmer: true,
        );
      },
    );
  }
}
