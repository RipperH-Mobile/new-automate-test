import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/screens/setting_devices_manager/setting_devices_manager_controller.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class SettingDevicesManagerScreen extends GetView<SettingDevicesManagerController> {
  const SettingDevicesManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        backgroundColor: context.theme.appColors.backgroundNeutralLighterPressed,
        appBar: AppBarDefault(
          title: 'Manage all devices'.tr,
          leadingButton: AppControlButton.back(
            context: context,
            onTap: () => Get.back(),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpace.space4,
          ),
          child: CustomScrollView(
            slivers: [
              _buildSessions(),
              if (controller.totalDevice.value > 1)
                SliverToBoxAdapter(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: AppSpace.space4,
                        bottom: AppSpace.space6,
                      ),
                      child: GestureDetector(
                        onTap: controller.showDialogConfirmLogoutAllDevices,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpace.space3,
                            horizontal: AppSpace.space4,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.appColors.backgroundNeutralLightest,
                            borderRadius: BorderRadius.circular(AppSpace.space3),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText.body1(
                                'Logout All'.tr,
                                color: context.theme.appColors.textError,
                                context: context,
                              ),
                              Assets.vectors.iconArrowBackIos.svg()
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSessions() {
    return GetBuilder<SettingDevicesManagerController>(builder: (_) {
      return PagedSliverList<int, GetSessionsListResponse>(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, session, index) {
            return _itemContainer(session, index, context);
          },
          firstPageProgressIndicatorBuilder: (context) => _buildLoadingIndicator(),
          newPageProgressIndicatorBuilder: (context) => _buildLoadingIndicator(),
        ),
      );
    });
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _itemContainer(GetSessionsListResponse? data, int index, BuildContext context) {
    if (data == null) return const SizedBox.shrink();

    return Container(
      decoration: ShapeDecoration(
        color: context.theme.appColors.backgroundNeutralLightestPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: index == 0 ? const Radius.circular(AppSpace.space3) : Radius.zero,
            topRight: index == 0 ? const Radius.circular(AppSpace.space3) : Radius.zero,
            bottomLeft:
                index == controller.totalDevice.value - 1 ? const Radius.circular(AppSpace.space3) : Radius.zero,
            bottomRight:
                index == controller.totalDevice.value - 1 ? const Radius.circular(AppSpace.space3) : Radius.zero,
          ),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpace.space4,
              vertical: AppSpace.space3,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      getPathTypeOfDevice(data.deviceOS ?? ''),
                      const SizedBox(width: AppSpace.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.body1(
                              controller.getBrand(data.deviceModel ?? 'UNKNOWN'),
                              context: context,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                            AppText.body4(
                              controller.getLocation(data.loginLocation ?? 'UNKNOWN'),
                              color: context.theme.appColors.textLighter,
                              context: context,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              strutStyle: const StrutStyle(fontSize: 13),
                            ),
                            AppText.body4(
                              controller.getLastLogInAt((data.lastLoginAt ?? DateTime.now()).toLocal()),
                              color: context.theme.appColors.textLighter,
                              context: context,
                              strutStyle: const StrutStyle(fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _deviceActionButton(data, index != 0, context),
              ],
            ),
          ),
          if (index != controller.totalDevice.value - 1)
            Padding(
              padding: const EdgeInsets.only(
                left: AppSpace.space18,
              ),
              child: Divider(
                height: AppSpace.spacePx,
                color: context.theme.appColors.borderDark,
                thickness: 0.5,
              ),
            ),
        ],
      ),
    );
  }

  Widget _deviceActionButton(GetSessionsListResponse? data, bool isOthers, BuildContext context) {
    return TextButton(
      onPressed: isOthers ? () => controller.showDialogConfirmLogoutDevice(data) : null,
      style: TextButton.styleFrom(
        backgroundColor: isOthers
            ? context.theme.appColors.backgroundError
            : context.theme.appColors.backgroundPrimaryLightestPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isOthers ? AppSpace.space3 : AppSpace.space8),
        ),
      ),
      child: AppText.body4Bold(
        isOthers ? 'Logout'.tr : 'Active'.tr,
        color: isOthers ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textPrimary,
        context: context,
      ),
    );
  }

  Widget getPathTypeOfDevice(String deviceOS) {
    if (deviceOS.isNotEmpty) {
      final osName = deviceOS.toLowerCase();

      if (osName.contains('ipad')) {
        return Assets.vectors.iconIpad.svg();
      } else if (osName.contains('mac')) {
        return Assets.vectors.iconMac.svg();
      } else if (osName.contains('window')) {
        return Assets.vectors.iconWindow.svg();
      }
    }

    return Assets.vectors.iconIphone.svg();
  }
}
