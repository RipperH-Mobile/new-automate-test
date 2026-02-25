import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/file_manager/file_manager.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/room_list_item_selectable.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/button/basic_button.dart';
import 'package:uchat/widgets/contacts/contact_list_item_selectable.dart';
import 'package:uchat/widgets/input/app_text_field.dart';
import 'package:uchat/widgets/input/search_box.dart';
import 'package:uchat/widgets/share/widgets/share_create_profile_helper.dart';
import 'package:uchat/widgets/sheet/share_to_uchat_controller.dart';

class ShareToUChatBottomSheet extends GetView<ShareToUChatController> {
  const ShareToUChatBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: Get.height * 0.85,
          decoration: BoxDecoration(
            color: UTheme.color.bottomSheetBackground,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: controller.selectedList().isNotEmpty ? 8 : 16,
                    ),
                    child: Container(
                      width: 65.spMin,
                      height: 5.spMin,
                      decoration: BoxDecoration(
                        color: UTheme.color.bottomSheetBar,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                _buildHeader(),
                const SizedBox(height: 16),
                _buildPreview(),
                _buildCaptionTextField(),
                _buildSelectedRow(),
                _buildSearchTextField(),
                Expanded(child: _buildContactList()),
                _buildShareButton(),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Text(
            'Share To'.tr,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCaptionTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
      child: TextField(
        controller: controller.captionCtl,
        inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxMessageInputLength)],
        minLines: 1,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Write message'.tr,
          hintStyle: const TextStyle(
            color: Color(0xFF999999),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ),
    );
  }

  Widget _buildSelectedRow() {
    return Obx(() {
      return AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: Container(
          width: Get.width,
          padding: EdgeInsets.only(
            bottom: controller.selectedList().isNotEmpty ? 12.spMin : 0,
          ),
          child: SingleChildScrollView(
            controller: controller.scrollCtl,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: List.generate(
                controller.selectedList().length,
                (index) {
                  final data = controller.selectedList()[index];
                  return ProfilePreviewItem(
                    isCheck: false,
                    data: data,
                    displayName: '',
                    avatar: '',
                    maxLines: 1,
                    sizeFactor: 0.6,
                    onTap: () {
                      controller.handleSelect(data);
                    },
                    showCloseIcon: true,
                  );
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: SearchBox(
        searchController: controller.searchCtl,
        onSuffixPressed: () {
          controller.searchCtl.clear();
          controller.onSearchChange('');
        },
        onChanged: (value) {
          controller.onSearchChange(value);
        },
        color: const Color(0xFFF2F2F2),
      ),
    );
  }

  Widget _buildContactList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        // height: Get.height * 0.3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildLatestShare(),
              _buildOaList(),
              _buildGroupList(),
              _buildFriendList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLatestShare() {
    return Obx(() {
      if (controller.latestShareList().isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          if (controller.latestShareList().isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Latest share'.tr),
            ),
          ...List.generate(
            controller.latestShareList().length,
            (index) {
              final RoomCollection room = controller.latestShareList()[index];
              final roomSub = controller.roomSubs.firstWhereOrNull((element) {
                return element.roomId == room.id;
              });
              final bool isChecked = controller.selectedList().firstWhereOrNull((element) {
                    return element is RoomCollection && element.id == room.id;
                  }) !=
                  null;

              return RoomListItemSelectable(
                room: room,
                roomSub: roomSub,
                isChecked: isChecked,
                onPressed: () {
                  controller.handleSelect(room);
                },
                padding: const EdgeInsets.all(0), // disable default padding
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Widget _buildOaList() {
    return Obx(() {
      if (controller.oaList.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          if (controller.oaList().isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Official Account'.tr),
            ),
          ...List.generate(
            controller.oaList().length,
            (index) {
              ContactCollection data = controller.oaList()[index];
              bool isChecked = controller.selectedList().firstWhereOrNull((element) {
                    return element is ContactCollection && element.id == data.id;
                  }) !=
                  null;

              return ContactListItemSelectable<ContactInterface>(
                data: data,
                isChecked: isChecked,
                onPressed: () {
                  controller.handleSelect(data);
                },
                padding: const EdgeInsets.all(0), // disable default padding
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Widget _buildGroupList() {
    return Obx(() {
      if (controller.groupList.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          if (controller.groupList().isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Group'.tr),
            ),
          ...List.generate(
            controller.groupList().length,
            (index) {
              final RoomCollection room = controller.groupList()[index];
              final roomSub = controller.roomSubs.firstWhereOrNull((element) {
                return element.roomId == room.id;
              });
              bool isChecked = controller.selectedList().firstWhereOrNull((element) {
                    return element is RoomCollection && element.id == room.id;
                  }) !=
                  null;

              return RoomListItemSelectable(
                room: room,
                roomSub: roomSub,
                isChecked: isChecked,
                onPressed: () {
                  controller.handleSelect(room);
                },
                padding: const EdgeInsets.all(0), // disable default padding
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Widget _buildFriendList() {
    return Obx(() {
      if (controller.friendList().isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          if (controller.friendList().isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Friends'.tr),
            ),
          ...List.generate(
            controller.friendList().length,
            (index) {
              ContactCollection data = controller.friendList()[index];
              bool isChecked = controller.selectedList().firstWhereOrNull((element) {
                    return element is ContactCollection && element.id == data.id;
                  }) !=
                  null;
              return ContactListItemSelectable<ContactInterface>(
                data: data,
                isChecked: isChecked,
                onPressed: () {
                  controller.handleSelect(data);
                },
                padding: const EdgeInsets.all(0), // disable default padding
              );
            },
          ),
          const SizedBox(height: 8),
        ],
      );
    });
  }

  Widget _buildPreview() {
    Widget previewWidget;
    if (controller.fileList().isNotEmpty) {
      previewWidget = _buildPreviewFile();
    } else {
      previewWidget = _buildPreviewText();
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        border: Border.all(
          color: const Color(0xFFE6E6E6),
        ),
      ),
      constraints: BoxConstraints(
        minHeight: 100.spMin,
      ),
      width: Get.width,
      padding: const EdgeInsets.all(8),
      child: previewWidget,
    );
  }

  Widget _buildPreviewFile() {
    if (controller.fileList().length == 1 && controller.shareContent.isEmpty) {
      Widget previewIcon;
      File file = controller.fileList().first;
      String mime = lookupMimeType(file.path) ?? '';
      String fileType;
      int fileSize = file.lengthSync();
      String fileSizeStr = FileService.instance.fileSizeStr(fileSize);
      if (isImageTypeSupported(mime)) {
        previewIcon = Image.file(
          controller.fileList().first,
          width: 40,
          height: 40,
        );
        fileType = 'Image'.tr;
      } else if (mime.contains(RegExp(r'video/'))) {
        previewIcon = const Icon(
          Icons.video_file,
          size: 40,
        );
        fileType = 'Video'.tr;
      } else if (mime.contains(RegExp(r'audio/'))) {
        previewIcon = const Icon(
          Icons.audio_file,
          size: 40,
        );
        fileType = 'Audio'.tr;
      } else {
        previewIcon = SizedBox(
          width: 40,
          height: 40,
          child: Image.asset(
            // isLockedFile แค่ใส่ไว้เฉยๆ ยังไม่ได้เช็คความถูกต้อง
            FileService.instance.getFileIcon(
              isLockedFile: false,
              filename: file.path,
            ),
          ),
        );
        fileType = 'File'.tr;
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            previewIcon,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    basename(file.path),
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$fileType | $fileSizeStr',
                    style: const TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      String fileNameList = '';
      String previewTitle = '';
      if (controller.shareContent().isEmpty) {
        previewTitle = '@count file@s'.trParams({
          'count': controller.fileList().length.toString(),
          's': controller.fileList().length > 1 ? 's' : '',
        });
      } else {
        previewTitle = '@count file@s and text'.trParams({
          'count': controller.fileList().length.toString(),
          's': controller.fileList().length > 1 ? 's' : '',
        });
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            previewTitle,
            style: const TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.fileList().fold(fileNameList, (previousValue, element) {
              if (previousValue.isNotEmpty) {
                return '$previousValue, ${basename(element.path)}';
              } else {
                return basename(element.path);
              }
            }),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF808080),
              fontSize: 12,
            ),
          ),
          if (controller.shareContent().isNotEmpty) ...[
            const SizedBox(
              height: 8,
            ),
            Text(
              controller.shareContent(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF808080),
                fontSize: 12,
              ),
            ),
          ]
        ],
      );
    }
  }

  Widget _buildPreviewText() {
    // TODO call server for website data here
    // ignore: dead_code
    if (controller.shareContent().isURL && false) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 10,
        ),
        child: Row(
          children: [
            // TODO change this to if this website has thumbnail or icon
            if (true)
              UChatImage.network(
                'web thumbnail / icon here',
              ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'website title here',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF333333),
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.shareContent(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          controller.shareContent(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF333333),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      );
    }
  }

  Widget _buildShareButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: BasicButton(
        buttonColor: controller.selectedList().isNotEmpty
            ? UTheme.color.normalRoomSendMoreIconActive
            : const Color(
                0xFF77A5FF,
              ),
        title: 'Send'.tr,
        textStyle: const TextStyle(color: Colors.white),
        width: Get.width,
        onPressed: controller.selectedList().isNotEmpty
            ? () {
                controller.handleShare();
              }
            : null,
      ),
    );
  }
}
