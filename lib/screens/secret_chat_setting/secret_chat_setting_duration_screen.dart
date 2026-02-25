import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/screens/secret_chat_setting/secret_chat_setting_controller.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app/app_bar_close_button.dart';

class SecretChatSettingDurationScreen extends GetView<SecretChatSettingController> {
  final String? roomTag;
  const SecretChatSettingDurationScreen({super.key, this.roomTag});

  @override
  String? get tag => roomTag ?? Get.parameters['id'];

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: _buildAppBar(),
      backgroundColor: UChatScreenUtil.instance.isDesktopPlatform
          ? UTheme.color.secretRoomSettingBlueAccent
          : UTheme.color.secretRoomBackground,
      child: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    if (UChatScreenUtil.instance.isDesktopPlatform) {
      return ScaffoldBasic.appBarBasic(
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0A2A5E),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.spMin),
          child: Row(
            children: [
              Text(
                'Secret chat duration'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: UTheme.color.secretRoomText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Image.asset(
                  'assets/images/lock_icon_yellow.png',
                ),
              ),
            ],
          ),
        ),
        actions: [
          AppBarCloseButton(
            onPressed: () => Get.back(),
            roundedBg: true,
            backgroundColor: const Color(0xFF0D3E78),
            iconColor: const Color(0xFF77ACE5),
          ),
        ],
      );
    }
    return AppBar(
      iconTheme: IconThemeData(color: UTheme.color.secretRoomText),
      backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
      title: Row(
        children: [
          Text(
            'Secret chat duration'.tr,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: UTheme.color.secretRoomText,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Image.asset(
              'assets/images/lock_icon_yellow.png',
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Obx(() {
            bool isEnable = controller.selectedExpireIn() != null;
            return Container(
              decoration: BoxDecoration(
                color: isEnable ? const Color(0xFFDDE9FF) : const Color(0xFF0B2955),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: isEnable
                    ? () {
                        controller.handleChangeExpireAt();
                      }
                    : null,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 8.spMin, horizontal: 12.spMin),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Save'.tr,
                  style: const TextStyle(
                    color: Color(0xFF496A9D),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (UChatScreenUtil.instance.isDesktopPlatform) {
      return Column(
        children: [
          ..._buildExpiredInChoices(),
          const Expanded(
            child: SizedBox(),
          ),
          Obx(() {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: PrimaryBasicButton(
                onPressed: controller.handleChangeExpireAt,
                title: 'Save'.tr,
                width: double.infinity,
                buttonColor: controller.selectedExpireIn() == null ? const Color(0xFF0B2955) : const Color(0xFFDDE9FF),
                textStyle: controller.selectedExpireIn() == null
                    ? const TextStyle(color: Color(0xFF496A9D))
                    : const TextStyle(color: Color(0xFF0B2955)),
              ),
            );
          }),
        ],
      );
    }
    return Column(
      children: [
        SizedBox(height: 24.spMin),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20.spMin),
            child: Text(
              'This secret chat will disappear at the specified time'.tr,
              style: TextStyle(color: UTheme.color.secretRoomHeaderText),
            ),
          ),
        ),
        SizedBox(height: 16.spMin),
        ..._buildExpiredInChoices(),
      ],
    );
  }

  List<Widget> _buildExpiredInChoices() {
    return controller.activeExpireInList.map(
      (element) {
        return Obx(
          () {
            int index = controller.activeExpireInList.indexOf(element);

            return Column(
              children: [
                UChatRowMenu(
                  title: Duration(seconds: element).durationTextWithUnit,
                  titleTextStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  prefixWidget: Radio<int>(
                    value: element,
                    groupValue: controller.selectedExpireIn(),
                    onChanged: (value) {
                      controller.selectedExpireIn(value);
                    },
                    fillColor: WidgetStateProperty.resolveWith(
                      (state) => controller.selectedExpireIn() == element ? Colors.white : const Color(0xFF1E82E5),
                    ),
                  ),
                  onTap: () {
                    controller.selectedExpireIn(element);
                  },
                  hasBottomBorder: index == controller.activeExpireInList.length - 1,
                  hasTopBorder: true,
                  backgroundColor: UTheme.color.secretRoomSettingBlueAccent,
                  borderColor: UTheme.color.secretRoomDivider,
                  showArrow: false,
                ),
              ],
            );
          },
        );
      },
    ).toList();
  }
}
