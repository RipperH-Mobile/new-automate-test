import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/screens/contact_selection/contact_selection_controller.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app/app_bar_close_button.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class ContactSelectionScreen extends GetView<ContactSelectionController> {
  final String? roomId;

  const ContactSelectionScreen({
    super.key,
    this.roomId,
  });

  @override
  String? get tag => roomId ?? Get.parameters['id'];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.95;
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          if (UChatScreenUtil.instance.isMobile) ...[
            const Padding(padding: EdgeInsets.only(top: 24)),
            _buildSearchBar(width),
            const SizedBox(height: 10),
          ],
          _buildContactList(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    final isMobile = UChatScreenUtil.instance.isMobile;
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: isMobile ? 0.5 : 0,
      centerTitle: false,
      titleSpacing: 30.spMin,
      title: isMobile ? Text('Share UCHAT friend'.tr) : Text('Friend list'.tr),
      actions: [
        if (isMobile)
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  controller.onLeadingBack();
                },
                child: Text(
                  'Done'.tr,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: UTheme.color.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        else
          AppBarCloseButton(
            onPressed: () => Get.back(),
            roundedBg: true,
          ),
      ],
    );
  }

  Widget _buildSearchBar(double width) {
    return Container(
      width: width,
      height: 42,
      decoration: ShapeDecoration(
        color: const Color(0xFFF2F2F2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: TextField(
          inputFormatters: [ThaiLengthLimitingTextInputFormatter(UChatConstant.maxSearchInputLength)],
          controller: controller.searchController,
          onChanged: (term) => controller.handleSearchContact(),
          decoration: InputDecoration(
            hintText: 'Search...'.tr,
            border: InputBorder.none,
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFF808080),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactList() {
    return Expanded(
      child: Obx(
        () => ListView.builder(
          itemCount: controller.displayedContacts.length,
          itemBuilder: (context, index) {
            final contact = controller.displayedContacts[index];
            return contactSelectionTab(contact);
          },
        ),
      ),
    );
  }

  Widget contactSelectionTab(ContactCollection contact) {
    return Obx(
      () => ListTile(
        leading: AvatarWrapper<ContactInterface>(
          data: contact,
          radius: 25,
        ),
        title: Text(
          contact.displayName ?? 'UNKNOWN'.tr,
          style: TextStyle(
            color: UTheme.color.contactItemTitle,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          contact.statusMessage,
          style: TextStyle(
            color: UTheme.color.contactItemSubtitle,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: controller.selectedContacts.contains(contact)
            ? Container(
                width: 84,
                height: 33,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF2F2F2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Shared'.tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: UTheme.color.pageSubtitle,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            : Container(
                width: 70,
                height: 33,
                decoration: ShapeDecoration(
                  color: const Color(0xFFE6EFFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    controller.handleShareContactDirectly(contact);
                  },
                  child: Center(
                    child: Text(
                      'Share'.tr,
                      style: TextStyle(
                        color: UTheme.color.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
