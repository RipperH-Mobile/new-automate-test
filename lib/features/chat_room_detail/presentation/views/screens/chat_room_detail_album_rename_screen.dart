import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_rename_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class ChatRoomDetailAlbumRenameScreen extends GetView<ChatRoomDetailAlbumRenameController> {
  final String controllerTag;

  const ChatRoomDetailAlbumRenameScreen({
    super.key,
    required this.controllerTag,
  });

  @override
  String? get tag => controllerTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: ChatRoomDetailAlbumAppBar(
        title: 'Rename album'.tr,
        actions: [
          Obx(() {
            return TextButton(
              onPressed: controller.enableDoneButton()
                  ? () {
                      controller.handleDonePressed(context);
                    }
                  : null,
              child: AppText.button1Bold(
                'Done'.tr,
                color: controller.enableDoneButton()
                    ? context.theme.appColors.textPrimary
                    : context.theme.appColors.textDisable,
                context: context,
              ),
            );
          }),
        ],
      ),
      child: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(AppSpace.space4),
          child: AppTextField.withClear(
            labelText: 'Album Name'.tr,
            hintText: 'e.g. Vacation Photos'.tr,
            inputType: TextInputType.text,
            maxLength: 30,
            onChanged: controller.onTextFieldChanged,
            isShowIcon: controller.albumName.isNotEmpty,
            onIconTap: controller.onClearTextField,
            textEditController: controller.textFieldController,
          ),
        );
      }),
    );
  }
}
