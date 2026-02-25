import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/interfaces.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets.dart';

import 'create_chat_controller.dart';

class CreateChatMobileScreen extends GetView<CreateChatController> {
  const CreateChatMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
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
          return [
            AppBarWithCallHeader<SliverAppBar>(
              centerTitle: true,
              title: AppBarTitle(title: 'Choose Friend'.tr),
              leading: AppBarBackButton(
                onPressed: () => controller.handleBack(),
              ),
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
      _buildContactList(),
    ];
  }

  Widget _buildSearchInput() {
    return SliverAppBar(
      backgroundColor: const Color(0xffF9F9F9),
      floating: true,
      automaticallyImplyLeading: false,
      snap: true,
      pinned: false,
      toolbarHeight: 32.spMin,
      elevation: 0,
      flexibleSpace: SizedBox(
        height: 65.spMin,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            15.0.spMin,
            22.0.spMin,
            15.0.spMin,
            0.spMin,
          ),
          child: Obx(() {
            controller.keyword();
            return SearchBox(
              color: UTheme.color.scaffoldInput,
              focusNode: controller.searchInputFocus,
              searchController: controller.searchController,
              onSuffixPressed: controller.handleClearSearch,
              borderRadius: BorderRadius.circular(12.r),
            );
          }),
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
