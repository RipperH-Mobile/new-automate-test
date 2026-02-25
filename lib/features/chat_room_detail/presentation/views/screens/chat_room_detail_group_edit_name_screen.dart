import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/room_detail_edit_controller.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class ChatRoomDetailGroupEditNameScreen extends GetView<RoomDetailEditController> {
  const ChatRoomDetailGroupEditNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: RoomDetailAppBar(
          titleText: 'Edit group name'.tr,
          isSecret: false,
          action: controller.nameText.isNotEmpty ? controller.handleUpdateGroupRoom : () {},
          actionText: 'Done'.tr,
          actionTextColors:
              controller.nameText.isNotEmpty ? context.theme.appColors.textPrimary : context.theme.appColors.textLight,
          // onSearchPressed: controller.handleOpenSearch,
        ),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: _buildBody(context),
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ),
      );
    });
  }

  Widget _buildBody(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space4),
            child: AppTextField.withClear(
              labelText: 'Name'.tr,
              hintText: 'Enter name'.tr,
              textEditController: controller.nameTextController,
              inputType: TextInputType.text,
              onChanged: controller.onChangedName,
              // focusNode: controller.focusNode,
              maxLength: 30,
              isShowIcon: controller.nameText.isNotEmpty ? true : false,
              onIconTap: controller.handleClearTextField,
            ),
          ),
        ],
      ),
    );
  }
}
