import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';

import '../../controllers/create_group/select_member_controller.dart';

class SearchedContacts extends GetView<SelectMemberController> {
  const SearchedContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.contacts.length,
        itemBuilder: (BuildContext context, int index) {
          ContactCollection currentContact = controller.contacts.elementAt(index);

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
                    heroTag: 'create-group-contact-list-${currentContact.id}',
                    isChecked: controller.selectedContacts.any((element) => element.id == currentContact.id),
                    reachedMaxSelected: controller.limitMember,
                    enable: !(controller.limitMember),
                    onPressed: () {
                      controller.handleSelectCheckbox(currentContact);
                      // controller.handleSelectCheckboxForAddToFolder(currentContact);
                    },
                    checkBoxPadding: const EdgeInsets.only(right: 0),
                    nameHighlightStr: controller.searchController.text,
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
