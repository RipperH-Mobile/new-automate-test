import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/controllers/mobile_contact_list_screen_controller.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/input/search_box.dart';

// final _log = useLogger();

class MobileContactListScreen extends GetView<MobileContactListScreenController> {
  const MobileContactListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.95;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Obx(() => _buildBody(context, width)),
    );
  }

  AppBarDefault _buildAppBar(BuildContext context) {
    return AppBarDefault(
      title: 'Select contact'.tr,
      leadingButton: AppControlButton.back(
        context: context,
        showIcon: false,
      ),
      actionButton: AppControlButton.forward(
        context: context,
        label: 'Close'.tr,
        onTap: () => Get.back(),
      ),
    );
  }

  Column _buildBody(BuildContext context, double width) {
    return Column(
      children: [
        _buildSearchBar(context, width),
        _buildContactList(context),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.space4,
      ),
      child: Container(
        height: AppSize.size10,
        decoration: ShapeDecoration(
          color: context.theme.appColors.backgroundNeutralLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
          ),
        ),
        child: SearchBox(
          color: context.theme.appColors.backgroundNeutralLight,
          searchController: controller.textController,
          label: 'Search'.tr,
          hasSuffix: controller.searchTerm.value.isNotEmpty,
          onSuffixPressed: controller.clearSearch,
        ),
      ),
    );
  }

  Widget _buildContactList(BuildContext context) {
    final contactsList = controller.filteredContacts;
    return Expanded(
      child: contactsList.isEmpty
          ? _buildNotFound(context)
          : ListView.separated(
              itemCount: contactsList.length + 1,
              itemBuilder: (context, index) {
                // If index == length, return final divider
                if (index == contactsList.length) {
                  return Padding(
                    padding: const EdgeInsets.only(left: AppSpace.space4),
                    child: Divider(
                      thickness: AppSize.sizePx,
                      height: 0,
                      color: context.theme.appColors.borderDisable,
                    ),
                  );
                }

                // Otherwise, return the normal contact tile
                final contact = contactsList[index];
                return _buildContactTile(context, contact);
              },
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(left: AppSpace.space4),
                child: Divider(
                  thickness: AppSize.sizePx,
                  height: 0,
                  color: context.theme.appColors.borderDisable,
                ),
              ),
            ),
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

  Widget _buildContactTile(BuildContext context, Contact contact) {
    return ListTile(
      title: AppText.title2(
        contact.displayName,
        context: context,
        color: context.theme.appColors.textDarkest,
      ),
      subtitle: AppText.body3(
        contact.phones.isNotEmpty ? contact.phones.first.number : 'No phone number'.tr,
        context: context,
        color: context.theme.appColors.textDark,
      ),
      onTap: () {
        controller.shareContact([contact]);
      },
    );
  }
}
