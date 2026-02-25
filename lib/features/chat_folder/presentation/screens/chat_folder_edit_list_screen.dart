import 'package:flutter/material.dart' hide ReorderableList;
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/reorder.dart';
import 'package:uchat/widgets.dart';

import '../../domain/enums/chat_folder_type.dart';
import '../controllers/chat_folder_edit_list_controller.dart';

class ChatFolderEditListScreen extends GetView<ChatFolderEditListController> {
  const ChatFolderEditListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return UChatAdaptivePopScope(
        shouldAddCallback: controller.hasChanged,
        onWillPop: controller.handleOnWillPop,
        child: ScaffoldBasic(
          appBar: ScaffoldBasic.appBarBasic(
            title: Text('Edit Folder List'.tr),
            centerTitle: false,
            handleBack: controller.handleBack,
            actions: [
              Obx(() {
                return TextButton(
                  onPressed: controller.hasChanged ? controller.handleOnSaveData : null,
                  child: Text(
                    'Save'.tr,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: controller.hasChanged ? UTheme.color.primary : const Color(0xFFB3B3B3),
                    ),
                  ),
                );
              }),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.spMin),
              UChatRowHeader(
                title: 'Folder List'.tr,
              ),
              Expanded(
                child: Obx(() {
                  final tempList = controller.chatFolderTempList;

                  return ReorderableList(
                    onReorder: (current, target) => controller.onReorder(current as ReorderKey, target as ReorderKey),
                    onReorderDone: (item) => controller.onReorderDone(item as ReorderKey),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: tempList.length,
                      padding: EdgeInsets.only(bottom: 20.spMin),
                      itemBuilder: (context, index) {
                        final item = controller.chatFolderTempList[index].copyWith();
                        final isAllType = item.type == ChatFolderType.all;
                        const disableColor = Color(0xFFB3B3B3);

                        return ReorderableItem(
                          key: ValueKey(item.id),
                          childBuilder: (context, ReorderableItemState state) {
                            return UChatRowMenu(
                              title: item.displayName,
                              titleTextStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isAllType ? disableColor : const Color(0xFF333333),
                              ),
                              showArrow: false,
                              hasBottomBorder: true,
                              prefixWidget: ReorderableListener(
                                canStart: () {
                                  return !isAllType;
                                },
                                child: Icon(
                                  Icons.menu_rounded,
                                  color: isAllType ? disableColor : const Color(0xFF999999),
                                ),
                              ),
                              suffixWidget: GestureDetector(
                                onTap: () => controller.deleteTempChatFolder(item),
                                child: Container(
                                  width: 30.spMin,
                                  height: 30.spMin,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: isAllType ? disableColor : const Color(0xFFFF1552),
                                  ),
                                  child: const Icon(
                                    Icons.remove_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      );
    });
  }
}
