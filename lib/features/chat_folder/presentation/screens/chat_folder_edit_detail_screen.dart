import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/features/chat_folder/presentation/widgets/chat_folder_room_row.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/widgets.dart';

import '../controllers/chat_folder_edit_detail_controller.dart';

class ChatFolderEditDetailScreen extends GetView<ChatFolderEditDetailController> {
  final String? folderId;

  const ChatFolderEditDetailScreen({super.key, this.folderId});

  @override
  String? get tag => folderId ?? Get.parameters['id'];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return UChatAdaptivePopScope(
        shouldAddCallback: controller.hasChanged,
        onWillPop: controller.handleOnWillPop,
        child: ScaffoldBasic(
          appBar: ScaffoldBasic.appBarBasic(
            title: Text('Folder'.tr),
            centerTitle: false,
            handleBack: controller.handleBack,
            actions: [
              Obx(() {
                return TextButton(
                  onPressed: controller.hasChanged && controller.ableToSave ? controller.handleOnSave : null,
                  child: Text(
                    'Save'.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: controller.hasChanged && controller.ableToSave
                          ? UTheme.color.primary
                          : const Color(0xFFB3B3B3),
                    ),
                  ),
                );
              }),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.spMin),
                UChatRowMenu(
                  title: 'Folder Name'.tr,
                  titleTailing: const Text(
                    '*',
                    style: TextStyle(
                      color: Color(0xFFFF1552),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  suffixWidget: Obx(() {
                    return Text(
                      '${controller.folderNameLength.value}/${controller.maxFolderNameLength}',
                    );
                  }),
                  showArrow: false,
                  bottomContent: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Container(
                            height: 56.spMin,
                            margin: EdgeInsets.zero,
                            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: controller.folderNameLength.value > 0
                                    ? const Color(0xFFE6E6E6)
                                    : const Color(0xFFFF1552),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: TextField(
                              controller: controller.folderNameController,
                              onChanged: controller.handleFolderNameChange,
                              autofocus: false,
                              keyboardType: TextInputType.name,
                              cursorColor: UTheme.color.primary,
                              textAlignVertical: TextAlignVertical.center,
                              style: TextStyle(
                                color: UTheme.color.scaffoldOnBackground,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                isDense: true,
                                counterText: '',
                                hintText: 'Enter Folder Name'.tr,
                                hintStyle: const TextStyle(
                                  color: Color(0xFFB3B3B3),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                border: InputBorder.none,
                                suffixIconConstraints: BoxConstraints(
                                  maxWidth: 36.spMin,
                                  maxHeight: 36.spMin,
                                ),
                                suffixIcon: Obx(() {
                                  if (controller.folderName.isEmpty) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return GestureDetector(
                                      onTap: controller.handleClearFolderName,
                                      child: Container(
                                        margin: EdgeInsets.only(right: 14.spMin),
                                        child: Image(
                                          image: ResizeImage(
                                            const AssetImage('assets/images/clear_icon.png'),
                                            width: 18.spMin.cacheSize,
                                          ),
                                          width: 18.spMin,
                                          height: 18.spMin,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ),
                            ),
                          );
                        }),
                        Obx(() {
                          if (controller.folderNameLength.value > 0) {
                            return const SizedBox.shrink();
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                'Please enter a folder name with 1 or more characters.'.tr,
                                style: const TextStyle(
                                  color: Color(0xFFFF1552),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.spMin),
                UChatRowHeader(
                  title: 'Chat List'.tr,
                  titleTailing: const Text(
                    '*',
                    style: TextStyle(
                      color: Color(0xFFFF1552),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                UChatRowMenu(
                  title: 'Add Chats'.tr,
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
                  onTap: () {
                    controller.handlerOpenCreateChatFolderScreen();
                  },
                ),
                Obx(() {
                  if (controller.currentChatRooms.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  return ChatFolderRoomRow(
                    rooms: controller.currentChatRooms,
                    onRemoveRoom: controller.handleRemoveRoom,
                  );
                }),
                UChatRowHeader(
                  title: 'Choose chats that will appear in this folder.'.tr,
                  titleTextStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF808080),
                  ),
                  height: 50.spMin,
                  hasBottomBorder: true,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
