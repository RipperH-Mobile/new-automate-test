import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/widgets.dart';

import '../../controllers/create_group/select_member_controller.dart';

class LastChatContacts extends GetView<SelectMemberController> {
  const LastChatContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.lastChatContacts.length,
        itemBuilder: (BuildContext context, int index) {
          ContactCollection currentContact = controller.lastChatContacts.elementAt(index);

          return Obx(() {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.space0,
                  ),
                  child: ContactListItemSelectable<ContactInterface>(
                    showStatusMessage: true,
                    data: currentContact,
                    heroTag: 'create-group-recent-chat-list-${currentContact.id}',
                    isChecked: controller.selectedContacts.any((element) => element.id == currentContact.id),
                    reachedMaxSelected: controller.limitMember,
                    enable: !(controller.limitMember),
                    onPressed: () {
                      controller.handleSelectCheckbox(currentContact);
                    },
                    checkBoxPadding: const EdgeInsets.only(right: 0),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpace.space0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: AppSpace.space8 + AppRadius.rounded3xl + AppRadius.rounded3xl,
                  ),
                  child: Divider(
                    thickness: AppSize.sizePx,
                    height: 0.7,
                    color: context.theme.appColors.borderDisable,
                  ),
                ),
              ],
            );
          });
        },
      );
    });
  }
}
