import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room/domain/entities/message_reaction_entity.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/reaction/message_reaction_bottom_sheet_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class MessageReactionBottomSheet extends GetView<MessageReactionBottomSheetController> {
  const MessageReactionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // top: isFullDialog,
      bottom: false,
      child: Container(
        // height: Get.height * 0.85,
        width: Get.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildBottomSheetBar(),
        SizedBox(height: 10.spMin),
        _buildHeader(),
        SizedBox(height: 10.spMin),
        _buildEmojiCategoriesList(),
        SizedBox(height: 10.spMin),
        Obx(() => controller.isFetchingForMsgReact() ? _buildLoadingItem() : _buildReactionList()),
      ],
    );
  }

  Widget _buildReactionList() {
    final newList = controller.selectedId() == 'All'
        ? controller.allReactionList()
        : controller.allReactionList.where((e) => e.emojiId == controller.selectedId()).toList();

    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: newList.length,
          itemBuilder: (BuildContext context, int index) {
            return _buildListItem(newList, index, newList.length);
          },
        ),
      ),
    );
  }

  Widget _buildLoadingItem() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildListItem(List<MessageReactionEntity> reactionList, int index, int length) {
    final String? currentUserId = UserController.instance.currentUser()!.id;

    return Column(
      children: [
        if (index == 0) _buildDivider(),
        Container(
          height: 74.spMin,
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: 20.spMin, vertical: 10.spMin),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  AvatarWrapper(
                    radius: 20,
                    imageAvatarId: reactionList[index].avatarPath ?? '',
                  ),
                  SizedBox(width: 12.spMin),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        reactionList[index].displayName ?? '',
                        style: TextStyle(
                          fontSize: 14.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if ((reactionList[index].accountId ?? '') == currentUserId && controller.canReact)
                        GestureDetector(
                          onTap: () => controller.onRemove(
                            emojiId: reactionList[index].emojiId ?? '',
                            accountId: reactionList[index].accountId ?? '',
                            length: length,
                          ),
                          child: Container(
                            height: 20,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              'Tap to remove'.tr,
                              style: TextStyle(
                                color: UTheme.color.primary,
                                fontSize: 10.spMin,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ],
              ),
              _buildEmojis(reactionList[index].fileId ?? '', isList: true),
            ],
          ),
        ),
        _buildDivider(),
      ],
    );
  }

  Widget _buildEmojiCategoriesList() {
    return Obx(() {
      final length = controller.emojiCategoriesList.length;
      final newList = controller.emojiCategoriesList;

      Widget child;

      child = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0) ...[
                _buildEmojiCategoriesListItem(
                  emojiId: 'All',
                  count: controller.totalReactions.toString(),
                ),
                SizedBox(width: 12.spMin),
              ],
              _buildEmojiCategoriesListItem(
                emojiId: newList[index].emojiId ?? '',
                fileId: newList[index].fileId ?? '',
                count: (newList[index].amount).toString(),
              ),
            ],
          );
        },
      );

      return Container(
        height: 36,
        padding: EdgeInsets.only(top: 10.spMin),
        child: child,
      );
    });
  }

  Widget _buildEmojiCategoriesListItem({
    required String emojiId,
    required String count,
    String fileId = '',
  }) {
    return Obx(() {
      final isSelected = controller.selectedId() == emojiId;

      return GestureDetector(
        onTap: () => controller.onSelectCategory(emojiId),
        child: Container(
          height: 30.spMin,
          padding: EdgeInsets.symmetric(horizontal: 10.spMin),
          margin: emojiId == 'All' ? EdgeInsets.only(left: 12.spMin) : EdgeInsets.only(right: 12.spMin),
          decoration: BoxDecoration(
            color: isSelected ? UTheme.color.primary : const Color(0xFFE6E6E6),
            borderRadius: BorderRadius.circular(20.spMin),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              emojiId == 'All'
                  ? Text(
                      emojiId.tr,
                      style: TextStyle(
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    )
                  : _buildEmojis(fileId),
              SizedBox(width: 8.spMin),
              Text(
                count,
                style: TextStyle(
                  fontSize: 12.spMin,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildEmojis(String fileId, {bool isList = false}) {
    final size = isList ? 35.spMin : 24.spMin;

    return UChatImage.network(
      FileService.instance.getEmojiUrl(fileId),
      width: size.spMin,
      height: size.spMin,
      customErrorWidget: (p0) => ShimmerLoading(
        enable: true,
        child: Container(
          width: size.spMin,
          height: size.spMin,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetBar() {
    return Container(
      width: 65.spMin,
      height: 6.spMin,
      margin: EdgeInsets.symmetric(horizontal: 20.spMin, vertical: 15.spMin),
      decoration: BoxDecoration(
        color: UTheme.color.bottomSheetBar,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.spMin),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Reactions'.tr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.spMin,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.close,
                color: const Color(0xFFB3B3B3),
                size: 30.spMin,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 1.5,
      width: Get.width,
      color: const Color(0xFFF9F9F9),
    );
  }
}
