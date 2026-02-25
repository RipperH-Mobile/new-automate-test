import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/contact_item.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/screens.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class GroupCreateFinalScreen extends GetView<GroupCreateFinalController> {
  const GroupCreateFinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!UChatScreenUtil.instance.isMobile) {
      return ScaffoldBasic(child: _buildBody(context));
    }
    return Obx(
      () => ScaffoldBasic(
        appBar: _buildAppBar(context),
        backgroundColor: context.theme.appColors.backgroundNeutralLightest,
        child: _buildBody(context),
      ),
    );
  }

  AppBarDefault _buildAppBar(BuildContext context) {
    return AppBarDefault(
      title: 'New Group'.tr,
      leadingButton: AppControlButton.back(
        context: context,
        onTap: () => Get.back(),
      ),
      actionButton: AppControlButton.forward(
        context: context,
        isBold: true,
        label: 'Create'.tr,
        onTap: controller.groupName().trim().isNotEmpty ? () => controller.handleCreateGroupToServer() : null,
        actionColor:
            controller.groupName.isEmpty ? context.theme.appColors.textDisable : context.theme.appColors.textPrimary,
      ),
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildAvatar(context),
            Expanded(child: _buildGroupInput(context)),
          ],
        ),
        _buildSelectedContactHeader(context),
        _buildSelectedContactList(context),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final avatarRadius = AppSize.size10;

    return Padding(
      padding: const EdgeInsets.only(
        top: AppSpace.space6,
        bottom: AppSpace.space10,
        left: AppSpace.space4,
      ),
      child: SizedBox(
        width: avatarRadius * 2,
        height: avatarRadius * 2,
        child: GestureDetector(
          onTap: () {
            controller.handleGroupProfilePicker(context);
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: avatarRadius * 2,
                height: avatarRadius * 2,
                child: Obx(
                  () {
                    // Check for local file image
                    if (controller.selectedAvatar.value.path.isNotEmpty) {
                      return AvatarWrapper<File>(
                        imageFile: controller.selectedAvatar.value,
                        radius: avatarRadius,
                        hasBorder: true,
                      );
                    }
                    // Check for network image
                    else if (controller.selectedAvatarUrl.value.isNotEmpty) {
                      return AvatarWrapper<String>(
                        imageUrl: controller.selectedAvatarUrl.value,
                        radius: avatarRadius,
                        hasBorder: true,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  // If user hasn't picked a local or network avatar yet
                  final noLocalOrNetworkSelected =
                      controller.selectedAvatar().path.isEmpty && controller.selectedAvatarUrl().isEmpty;

                  if (!noLocalOrNetworkSelected) {
                    // If the user has already chosen something, return an empty widget here
                    return const SizedBox.shrink();
                  }

                  // If we don't have a random default avatar (maybe still fetching or list was empty),
                  // fall back to old asset
                  if (controller.randomDefaultGroupAvatar.value.isEmpty) {
                    return Assets.vectors.iconNoAvatar.svg();
                  }

                  // Otherwise, show the randomly chosen default avatar from the server
                  return AvatarWrapper<String>(
                    imageUrl: controller.randomDefaultGroupAvatar.value,
                    radius: avatarRadius,
                    hasBorder: true,
                  ).fadeIn(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeIn,
                  );
                }),
              ),
              Positioned(
                right: 0,
                bottom: AppSpace.space1,
                child: Material(
                  elevation: 1,
                  shape: const CircleBorder(),
                  child: Container(
                    height: AppSize.size6,
                    width: AppSize.size6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.theme.appColors.backgroundNeutralBolderPressed,
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                      image: ResizeImage(
                        const AssetImage(
                          'assets/images/v2/mini_camera_icon.png',
                        ),
                        width: 13.spMin.toInt(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGroupInput(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildGroupName(context),
          // ..._buildAccessType(context),
        ],
      ),
    );
  }

  List<Widget> _buildGroupName(BuildContext context) {
    return [
      const SizedBox(
        height: AppSpace.space6,
      ),
      AppText.body3(
        'Group name'.tr,
        context: context,
        color: context.theme.appColors.textLight,
      ),
      const SizedBox(
        height: AppSpace.space2,
      ),
      TextField(
        controller: controller.groupNameController,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxGroupNameInputLength)],
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Enter your group name'.tr,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: TextStyle(
            color: context.theme.appColors.textLightest,
            fontSize: 16.spMin,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          counterText: '',
        ),
        style: TextStyle(
          color: context.theme.appColors.textDarkest,
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
        cursorColor: context.theme.appColors.iconPrimary,
        cursorWidth: AppSize.sizePx,
      ),
      const SizedBox(
        height: AppSpace.space12,
      ),
    ];
  }

  Widget _buildSelectedContactHeader(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
        margin: const EdgeInsets.only(bottom: AppSpace.space4),
        child: Row(
          children: [
            AppText.body3Bold(
              '${'Members'.tr} ',
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
            AppText.body3Bold(
              SelectMemberController.to.selectedContacts.length.toString(),
              context: context,
              color: context.theme.appColors.textLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedContactList(BuildContext context) {
    return Obx(
      () => Expanded(
        child: Container(
          alignment: Alignment.topLeft,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
            itemCount: SelectMemberController.to.selectedContacts.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 5,
            ),
            itemBuilder: (BuildContext context, int index) {
              final currentContact = SelectMemberController.to.selectedContacts.elementAt(index);
              bool isOnlyOneContact = SelectMemberController.to.selectedContacts.length == 1;

              return Padding(
                padding: const EdgeInsets.only(right: AppSpace.space4),
                child: ContactItem(
                  key: Key('contact-${currentContact.id}'),
                  avatarUrl: currentContact.avatarUrl,
                  hasAvatar: currentContact.hasAvatar,
                  title: currentContact.name!,
                  contactId: currentContact.id!,
                  showDeleteButton: !isOnlyOneContact,
                  onDeleteMember: () {
                    SelectMemberController.to.handleSelectCheckbox(currentContact);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
