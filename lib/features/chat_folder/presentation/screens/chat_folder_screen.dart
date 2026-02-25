import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:local_hero/local_hero.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/features/chat_folder/presentation/widgets/recommended_folders.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app/app_bar_close_button.dart';

import '../../domain/enums/chat_folder_type.dart';
import '../controllers/chat_folder_controller.dart';
import '../widgets/recommend_folder_widget.dart';

class ChatFolderScreen extends GetView<ChatFolderController> {
  const ChatFolderScreen({super.key});

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: ScaffoldBasic.appBarBasic(
        title: Text(
          'Manage folder'.tr,
          style: const TextStyle(
            color: Color(0xFF333333),
          ),
        ),
        centerTitle: false,
        actions: [
          if (!isMobile)
            Padding(
              padding: EdgeInsets.only(right: 8.spMin),
              child: AppBarCloseButton(
                onPressed: () {
                  Get.back();
                  Get.back();
                },
                roundedBg: true,
              ),
            )
        ],
      ),
      child: LocalHeroScope(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutBack,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 10.spMin),
              Obx(() {
                return UChatSwitchRowMenu(
                  height: 200.spMin,
                  value: controller.isAllowManageFolder.value,
                  onTap: controller.handleToggleManageFolder,
                  title: 'Folder'.tr,
                  titleTextStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                  subTitle:
                      'Enable chat folders to help you organize them. Easier to type your chat room on the Chats Tab\n\nYou can disable the Chats Tab and the folder you created will not disappear'
                          .tr,
                  isDesktop: true,
                );
              }),
              SizedBox(height: 10.spMin),
              GetBuilder<ChatFolderController>(
                  id: 'chat-folder-list-head',
                  builder: (controller) {
                    return UChatRowHeader(
                      title: 'Folder List'.tr,
                      suffixWidget: controller.showEditFolderListButton
                          ? InkWell(
                              onTap: controller.handleOpenChatFolderEditListScreen,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  'Edit Folder List'.tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: UTheme.color.primary,
                                  ),
                                ),
                              ),
                            )
                          : null,
                    );
                  }),
              UChatRowMenu(
                title: 'Create folder'.tr,
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF333333),
                ),
                prefixWidget: Image.asset(
                  UChatAssetPath.plusIcon,
                  color: UTheme.color.primary,
                  cacheWidth: 18.spMin.cacheSize,
                ),
                prefixWidgetSize: 18.spMin,
                hasBottomBorder: true,

                ///TODO:change number to get data from server
                onTap: controller.handlerOpenCreateChatFolderScreen,
              ),
              GetBuilder<ChatFolderController>(
                id: 'chat-folder-list',
                builder: (chatFolderController) {
                  if (chatFolderController.chatFolders.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return Column(
                    children: [
                      ...List.generate(chatFolderController.chatFolders.length, (index) {
                        final chatFolder = chatFolderController.chatFolders[index];
                        final titleTextStyle = const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        );

                        bool showArrow = true;
                        if (chatFolder.isRecommended == true || chatFolder.type == ChatFolderType.all) {
                          showArrow = false;
                        }

                        if (chatFolder.isRecommended == true) {
                          // To play the animate smoothly
                          // This widget should return the same widget in `RecommendedFolders`
                          // it's recommendFolderWidget
                          return recommendFolderWidget(
                            onPressed: () {
                              chatFolderController.addRecommendedFolder(chatFolder.type);
                            },
                            title: chatFolder.displayName,
                            subTitle: chatFolder.type.description,
                            type: chatFolder.type.value,
                            showAddButton: false,
                          );
                        }

                        return UChatRowMenu(
                          height: isMobile ? 69.spMin : 60.spMin,
                          title: chatFolder.name,
                          titleTextStyle: titleTextStyle,
                          subTitleTopSpace: 3.spMin,
                          subTitleTextStyle: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF808080),
                          ),
                          showArrow: showArrow,
                          hasBottomBorder: true,
                          onTap: showArrow
                              ? () {
                                  chatFolderController.handleOpenChatFolderEditDetailScreen(chatFolder);
                                }
                              : null,
                        );
                      }),
                      if (chatFolderController.showEditFolderListButton)
                        UChatRowHeader(
                          title: 'Tap "Edit Folder List" to reorder or delete your chat folders.'.tr,
                          titleTextStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF808080),
                          ),
                          height: 50.spMin,
                          hasBottomBorder: true,
                        ),
                    ],
                  );
                },
              ),
              SizedBox(height: 10.spMin),
              Obx(() {
                if (controller.remainingRecommendedFolders.isEmpty) {
                  return const SizedBox.shrink();
                }

                return RecommendedFolders(
                  recommendedFolders: controller.remainingRecommendedFolders,
                  addRecommendedFolder: controller.addRecommendedFolder,
                );
              }),
              SafeArea(
                top: false,
                child: SizedBox(height: 10.spMin),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
