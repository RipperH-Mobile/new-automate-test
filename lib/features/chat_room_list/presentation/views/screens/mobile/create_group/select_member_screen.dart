import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/domain/use_cases/add_member_to_chat_use_case.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/create_group/group_create_final_controller.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/create_group/select_member_controller.dart';
import 'package:uchat/features/chat_room_list/presentation/views/screens/mobile/create_group/group_create_final_screen.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/last_chat_contacts.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/search_input.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/searched_contacts.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/searched_contacts_label.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/selected_contacts.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/selected_contacts_add_to_folder.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/tab_directs.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/tab_groups.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/animation/transition/right_transition.dart';
import 'package:uchat/widgets/app/app_bar_close_button.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class SelectMemberScreen extends GetView<SelectMemberController> {
  const SelectMemberScreen({
    super.key,
  });

  //TODO: can refactor this screen @mickey
  @override
  Widget build(BuildContext context) {
    if (!UChatScreenUtil.instance.isMobile) {
      return _buildCreateGroupDesktopUI(context);
    }
    return Obx(
      () => ScaffoldBasic(
        appBar: AppBarDefault(
          title: controller.isManageFolder() == true
              ? 'Add Chats'.tr
              : controller.selectedContacts.isEmpty
                  ? 'Choose friends'.tr
                  : '@count selected'.trParams({
                      'count': controller.selectedContacts.length.toString(),
                    }),
          leadingButton: AppControlButton.back(
            context: context,
            onTap: () => controller.handleBack(context),
          ),
          actionButton: controller.isManageFolder() == true
              ? AppControlButton.forward(
                  context: context,
                  label: 'Done'.tr,
                  onTap: controller.selectedGroupsAndContacts.isEmpty
                      ? null
                      : () {
                          controller.handleManageFolderAddChatDone();
                        },
                  actionColor: controller.selectedGroupsAndContacts.isEmpty
                      ? context.theme.appColors.textDisable
                      : context.theme.appColors.textPrimary,
                )
              : AppControlButton.forward(
                  context: context,
                  isBold: true,
                  label: controller.fromSendContact.value
                      ? 'Share'.tr
                      : controller.fromRoomDetailInvite.value
                          ? 'Done'.tr
                          : 'Next'.tr,
                  onTap: controller.selectedContacts.isNotEmpty
                      ? controller.fromSendContact.value
                          ? () {
                              controller.handleShareContacts();
                            }
                          : controller.fromRoomDetailInvite.value
                              ? () {
                                  controller.handleInviteToRoom(
                                    addMemberToChatUseCase: GetIt.I<AddMemberToChatUseCase>(),
                                  );
                                }
                              : () {
                                  controller.handleCreateGroup();
                                }
                      : null,
                  actionColor: controller.selectedContacts.isEmpty
                      ? context.theme.appColors.textDisable
                      : context.theme.appColors.textPrimary,
                ),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: context.theme.appColors.backgroundNeutralLightest,
        child: controller.isManageFolder() == true ? _buildBodyManageFolder(context) : _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        SearchInput(),
        const SelectedContacts(),
        Expanded(
          // using ListView instead of SingleChildScrollView is shacking on desktop dialog.
          child: controller.searchContactNotFound.value
              ? _buildNotFound(context)
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (c, index) {
                    return Column(
                      children: [
                        Obx(
                          () {
                            if (controller.searchText.value.isEmpty) {
                              return controller.lastChatContacts.isNotEmpty
                                  ? Column(
                                      children: [
                                        SearchedContactsLabel(
                                          isAllContacts: false,
                                        ),
                                        const LastChatContacts(),
                                      ],
                                    )
                                  : const SizedBox.shrink();
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        SearchedContactsLabel(
                          isAllContacts: true,
                        ),
                        const SearchedContacts(),
                      ],
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText.body2Bold(
            'No results found'.tr,
            context: context,
            color: context.theme.appColors.textDark,
          ),
          const SizedBox(height: AppSpace.space2),
          AppText.body4(
            'Please try searching again with different \nkeywords or check your spelling'.tr,
            context: context,
            color: context.theme.appColors.textLight,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kToolbarHeight * 1.5, width: double.infinity),
        ],
      ),
    );
  }

  Widget _buildManageFolderAction() {
    return Padding(
      padding: EdgeInsets.only(right: 20.spMin),
      child: Center(
        child: Obx(
          () => GestureDetector(
            onTap: controller.selectedGroupsAndContacts.isEmpty
                ? null
                : () {
                    controller.handleManageFolderAddChatDone();
                  },
            child: Text(
              'Done'.tr,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: controller.selectedGroupsAndContacts.isEmpty ? Colors.grey : UTheme.color.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateGroupDesktopUI(context) {
    return ScaffoldBasic(
      appBar: AppBarWithCallHeader<PreferredSizeWidget>(
        centerTitle: true,
        title: AppBarTitle(title: controller.isManageFolder() == true ? 'Add Chats'.tr : 'Create Group'.tr),
        actions: controller.isManageFolder() == true
            ? [_buildManageFolderAction()]
            : [
                AppBarCloseButton(
                  onPressed: () => controller.handleBack(context),
                  roundedBg: true,
                )
              ],
      ),
      backgroundColor: Colors.white,
      child: controller.isManageFolder() == true
          ? _buildBodyManageFolder(context)
          : Obx(
              () {
                return Column(
                  children: [
                    Expanded(
                      child: AnimatedSwitcher(
                        transitionBuilder: fromRightTransitionBuilder,
                        duration: const Duration(milliseconds: 300),
                        child: controller.isLastPage()
                            ? GetBuilder(
                                init: GroupCreateFinalController(),
                                builder: (ctl) {
                                  return const GroupCreateFinalScreen();
                                },
                              )
                            : _buildBody(Get.context!),
                      ),
                    ),
                    const Divider(
                      height: 2,
                      thickness: 2,
                    ),
                    InkWell(
                      hoverColor: UTheme.color.primary.withValues(alpha: 0.2),
                      onTap: () {
                        if (controller.isLastPage()) {
                          final createGroupFinalCtl = Get.find<GroupCreateFinalController>();
                          createGroupFinalCtl.handleCreateGroupToServer();
                        } else {
                          controller.isLastPage(true);
                        }
                      },
                      child: SizedBox(
                        width: Get.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              controller.isLastPage() ? 'Create'.tr : 'Next'.tr,
                              style: TextStyle(
                                color: UTheme.color.primary,
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildBodyManageFolder(BuildContext context) {
    return Column(
      children: [
        SearchInput(),
        SizedBox(
          height: 20.spMin,
        ),
        const SelectedContactsAddToFolder(),
        Obx(() {
          return Expanded(
            // using ListView instead of SingleChildScrollView is shacking on desktop dialog.
            child: controller.groups.isEmpty && controller.contacts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Contact not found'.tr,
                        ),
                        Text(
                          'The user you were looking for was not found, \nplease check the user again.'.tr,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff999999),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: 1,
                    itemBuilder: (c, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Group'.tr),
                                Row(
                                  children: [
                                    Text('Select'.tr),
                                    Obx(() {
                                      return controller.selectedGroupsAndContacts.isNotEmpty
                                          ? Text(' ${controller.selectedGroupsAndContacts.length}')
                                          : const Text('');
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const TabGroups(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Contacts'.tr),
                                const SizedBox(),
                              ],
                            ),
                          ),
                          const TabDirects(),
                        ],
                      );
                    },
                  ),
          );
        }),
      ],
    );
  }
}
