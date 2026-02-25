import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app/app_bar_close_button.dart';

import 'create_chat_controller.dart';

class CreateChatDesktopScreen extends GetView<CreateChatController> {
  const CreateChatDesktopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: Colors.white,
      bottomNavigationBar: ScaffoldBottomButtonContainer(
        child: Obx(() {
          return PrimaryBasicButton(
            isRounded: true,
            title: 'Create'.tr,
            onPressed: controller.selectedContacts.isEmpty ? null : () => controller.handleCreate(),
            buttonColor: controller.selectedContacts.isEmpty ? const Color(0xFFCCCCCC) : const Color(0xFF0056FD),
          );
        }),
      ),
      child: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          String title;
          switch (controller.selectCreateType) {
            case 'Chats':
              title = 'Create Chat'.tr;
              break;
            case 'SecretChat':
              title = 'Create a secret chat'.tr;
              break;
            default:
              title = 'Create Chat'.tr;
          }

          return [
            AppBarWithCallHeader<SliverAppBar>(
              centerTitle: true,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppBarTitle(
                    title: title,
                    fontSize: 20,
                  ),
                  if (controller.selectCreateType == 'SecretChat')
                    Text(
                      'Select a friend to create a secret chat room'.tr,
                      style: const TextStyle(
                        color: Color(0xFF999999),
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              leading: null,
              actions: [
                AppBarCloseButton(
                  onPressed: () => controller.handleBack(),
                  roundedBg: true,
                )
              ],
            ),
            _buildSearchInput(),
          ];
        },
        body: CustomScrollView(
          slivers: _buildBody(context),
        ),
      ),
    );
  }

  List<Widget> _buildBody(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.spMin,
          ),
          child: Obx(() {
            return RichText(
              text: TextSpan(
                text: 'Friends'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: ' ${controller.contacts.length.toString()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 8.spMin)),
      _buildContactList(),
    ];
  }

  Widget _buildSearchInput() {
    return SliverAppBar(
      floating: true,
      automaticallyImplyLeading: false,
      snap: true,
      pinned: false,
      // toolbarHeight: 32.spMin,
      elevation: 0,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(
          left: 16.spMin,
          right: 16.spMin,
          bottom: 16.spMin,
        ),
        child: SearchBox(
          color: const Color(0xFFF2F2F2),
          focusNode: controller.searchInputFocus,
          searchController: controller.searchController,
          onSuffixPressed: controller.handleClearSearch,
          borderRadius: BorderRadius.circular(12.r),
          label: 'Search'.tr,
        ),
      ),
    );
  }

  Widget _buildContactList() {
    return Obx(() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final contact = controller.contacts.elementAt(index);
            return Obx(() {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ContactListItemSelectable<ContactInterface>(
                  key: ValueKey(contact.id),
                  data: contact,
                  showStatusMessage: false,
                  isChecked: controller.selectedContacts.contains(contact),
                  onPressed: () => controller.handleSelectCheckbox(contact),
                  radioCheck: true,
                ),
              );
            });
          },
          childCount: controller.contacts.length,
        ),
      );
    });
  }
}
