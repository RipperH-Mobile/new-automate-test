import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/contact_item.dart';

import '../../controllers/create_group/select_member_controller.dart';

class SelectedContacts extends GetView<SelectMemberController> {
  const SelectedContacts({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final selectedLength = controller.selectedContacts.length;

      return AnimatedContainer(
        height: selectedLength > 0 ? 144.spMin : AppSpace.space6,
        curve: Curves.easeOutQuad,
        duration: const Duration(milliseconds: 200),
        child: _buildSelectedList(context),
        onEnd: () {
          if (selectedLength > 0) {
            controller.isShowSelectedList(true);
          } else {
            controller.isShowSelectedList(false);
          }
        },
      );
    });
  }

  Widget _buildSelectedList(BuildContext context) {
    final selectedLength = controller.selectedContacts.length;

    return Obx(() {
      return Visibility(
        visible: controller.isShowSelectedList(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpace.space4, AppSpace.space6, AppSpace.space4, AppSpace.space0),
          child: ListView.builder(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            itemCount: selectedLength,
            itemBuilder: (BuildContext context, int index) {
              double pr = (selectedLength - 1) > index ? 18.spMin : 0;
              final contact = controller.selectedContacts.elementAt(index);

              return FadeInRight(
                child: Padding(
                  padding: EdgeInsets.only(right: pr.spMin),
                  child: ContactItem(
                    key: Key('contact-${contact.id}'),
                    avatarUrl: contact.avatarUrl,
                    hasAvatar: contact.hasAvatar,
                    title: contact.name!,
                    contactId: contact.id!,
                    onDeleteMember: () {
                      controller.handleSelectCheckbox(contact);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
