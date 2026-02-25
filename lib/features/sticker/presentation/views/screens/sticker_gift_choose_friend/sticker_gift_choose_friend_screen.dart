import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/sticker/presentation/controllers/sticker_gift_choose_friend_controller.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_gift_contact_tile.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerGiftChooseFriendScreen extends GetView<StickerGiftChooseFriendController> {
  const StickerGiftChooseFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.elevationSurface,
      appBar: AppBar(
        title: Text(
          'Choose friends'.tr,
          style: context.theme.appTexts.title3.copyWith(color: context.theme.appColors.textDarkest),
        ),
        // size 20 is the size for back button + space2 is for additional left padding to match the other widget in this screen.
        leadingWidth: AppSize.size20 + AppSpace.space2,
        // TODO (sticker favorite) Change this widget to use shared back button widget.
        leading: IconButton(
          icon: Row(
            children: [
              // Additional padding on the left to push the back button to the right.
              const SizedBox(width: AppSpace.space2),
              Assets.vectors.chevronBackIos.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.iconPrimary,
                  BlendMode.srcIn,
                ),
              ),
              Text(
                'Back'.tr,
                style: context.theme.appTexts.button1.copyWith(
                  color: context.theme.appColors.textPrimary,
                ),
              ),
            ],
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppSpace.space2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
              child: AppSearchBox(
                onChanged: controller.onSearchTextFieldChanged,
                controller: controller.searchTextFieldController,
              ),
            ),
            const SizedBox(height: AppSpace.space6),
            Expanded(
              child: GetBuilder<StickerGiftChooseFriendController>(
                id: StickerGiftChooseFriendIds.body,
                builder: (controller) {
                  if (controller.contactList.isEmpty &&
                      controller.recentChatList.isEmpty &&
                      controller.searchTextFieldController.text.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        left: AppSpace.space8,
                        right: AppSpace.space8,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText.body2Bold(
                            'No results found'.tr,
                            context: context,
                            color: context.theme.appColors.textDark,
                          ),
                          AppText.body4(
                            'Please try searching again with different keywords or check your spelling'.tr,
                            context: context,
                            color: context.theme.appColors.textLight,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: AppSpace.space4),
                    child: CustomScrollView(
                      slivers: [
                        GetBuilder<StickerGiftChooseFriendController>(
                          id: StickerGiftChooseFriendIds.recentChatText,
                          builder: (controller) {
                            if (controller.recentChatList.isEmpty) {
                              return const SliverToBoxAdapter(
                                child: SizedBox.shrink(),
                              );
                            }

                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: AppSpace.space2),
                                child: AppText.subtitle1(
                                  'Recent chats'.tr,
                                  context: context,
                                  color: context.theme.appColors.textDarkest,
                                ),
                              ),
                            );
                          },
                        ),
                        GetBuilder<StickerGiftChooseFriendController>(
                          id: StickerGiftChooseFriendIds.recentChatList,
                          builder: (controller) {
                            return SliverList.builder(
                              itemCount: controller.recentChatList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final contact = controller.recentChatList[index];

                                return StickerGiftContactTile(
                                  onTap: () {
                                    controller.handleGiftSticker(contact);
                                  },
                                  contact: contact,
                                );
                              },
                            );
                          },
                        ),
                        GetBuilder<StickerGiftChooseFriendController>(
                          id: StickerGiftChooseFriendIds.recentChatList,
                          builder: (controller) {
                            return const SliverToBoxAdapter(
                              child: SizedBox(
                                height: AppSpace.space6,
                              ),
                            );
                          },
                        ),
                        GetBuilder<StickerGiftChooseFriendController>(
                          id: StickerGiftChooseFriendIds.contactText,
                          builder: (controller) {
                            if (controller.contactList.isEmpty &&
                                controller.searchTextFieldController.text.isNotEmpty) {
                              return const SliverToBoxAdapter(
                                child: SizedBox.shrink(),
                              );
                            }

                            return SliverToBoxAdapter(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: AppSpace.space2),
                                child: Row(
                                  children: [
                                    AppText.subtitle1(
                                      'Friends'.tr,
                                      context: context,
                                      color: context.theme.appColors.textDarkest,
                                    ),
                                    AppText.subtitle1(
                                      ' ${controller.contactList.length}',
                                      context: context,
                                      color: context.theme.appColors.textLight,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        GetBuilder<StickerGiftChooseFriendController>(
                          id: StickerGiftChooseFriendIds.contactList,
                          builder: (controller) {
                            if (controller.contactList.isEmpty &&
                                controller.searchTextFieldController.text.isNotEmpty) {
                              return const SliverToBoxAdapter(
                                child: SizedBox.shrink(),
                              );
                            }

                            return SliverList.builder(
                              itemCount: controller.contactList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final contact = controller.contactList[index];

                                return StickerGiftContactTile(
                                  onTap: () {
                                    controller.handleGiftSticker(contact);
                                  },
                                  contact: contact,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
