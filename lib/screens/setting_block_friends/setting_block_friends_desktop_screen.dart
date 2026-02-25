import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/app_settings_controller.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/screens/setting_block_friends/setting_block_friends_controller.dart';
import 'package:uchat/screens/settings/widgets/setting_appbar.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/contacts/contact_list_item_with_button.dart';

class SettingBlockFriendsDesktopScreen extends GetView<SettingBlockFriendsController> {
  const SettingBlockFriendsDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appSettingsController = Get.find<AppSettingsController>();

    return ScaffoldBasic(
      appBar: buildSettingAppBar(
        title: 'Blocked accounts'.tr,
        centerTitle: true,
        leading: AppBarBackButton(
          onPressed: () => appSettingsController.setRoutesSettingRightPanel(routes: Routes.settingFriend),
          isShowTextBack: true,
        ),
      ),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: SettingSpacer(),
          ),
          _buildContactList(context: context),
        ],
      ),
    );
  }

  Widget _buildContactList({required BuildContext context}) {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final contact = controller.contacts.elementAt(index);

            BorderRadius borderRadius = BorderRadius.zero;
            if (controller.contacts.length == 1) {
              /// If There is only one contact.
              borderRadius = BorderRadius.circular(10);
            } else {
              /// If There are more than 1 contact.
              if (index == 0) {
                /// If this element is the first.
                borderRadius = BorderRadius.only(
                  topLeft: Radius.circular(10.spMin),
                  topRight: Radius.circular(10.spMin),
                );
              } else if (index == controller.contacts.length - 1) {
                /// If this element is the last.
                borderRadius = BorderRadius.only(
                  bottomLeft: Radius.circular(10.spMin),
                  bottomRight: Radius.circular(10.spMin),
                );
              } else {
                /// If this element is in the middle.
                borderRadius = BorderRadius.zero;
              }
            }

            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius,
                    border: Border(
                      top: const BorderSide(
                        color: Color(0xffE6E6E6),
                        width: 1,
                      ),
                      bottom: index == controller.contacts.length - 1
                          ? const BorderSide(
                              color: Color(0xffE6E6E6),
                              width: 1,
                            )
                          : BorderSide.none,
                      left: const BorderSide(
                        color: Color(0xffE6E6E6),
                        width: 1,
                      ),
                      right: const BorderSide(
                        color: Color(0xffE6E6E6),
                        width: 1,
                      ),
                    ),
                  ),
                  margin: const EdgeInsets.only(left: 31, right: 31),
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
                  child: ContactListItemWithButton<ContactInterface>(
                    key: ValueKey(contact.id),
                    data: contact,
                    showStatusMessage: true,
                    customBackgroundColor: Colors.white,
                    textInButtonColor: const Color(0xFF0056FF),
                    backgroundButtonColor: const Color(0xFFE6EFFF),
                    // onPressed: () => controller.handleUnhide(contact),
                    onPressed: () {
                      controller.handleUnblock(contact);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextButton(
                            onPressed: () {
                              controller.onConfirmUnBlock(contact);
                            },
                            style: ButtonStyle(
                              shape: WidgetStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              backgroundColor: WidgetStateProperty.all(
                                const Color(0xffE6EFFF),
                              ),
                            ),
                            child: Text(
                              'unblock'.tr,
                              style: const TextStyle(
                                color: Color(0xFF0056FF),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.spMin,
                        ),
                        TextButton(
                          onPressed: () {
                            controller.handleRemoveFriend(contact);
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              const Color(0xffFFEDEF),
                            ),
                          ),
                          child: Text(
                            'delete friend'.tr,
                            style: const TextStyle(
                              color: Color(0xffFF1552),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          childCount: controller.contacts.length,
        ),
      );
    });
  }
}
