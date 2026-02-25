import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/api/payloads/account/update_online_status.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/enums/platform_document.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/enum/online_status.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/file_info/file_info_list.dart';
import 'package:uchat/widgets/term_and_condition/term_bottom_sheet.dart';

final _log = useLogger();

class UChatBottomSheet {
  static Future<void> showSetOnlineStatusBottomSheet({
    required BuildContext context,
    bool isScrollControlled = false,
    void Function(OnlineStatus?)? onSelected,
    OnlineStatus? initialOnline,
  }) async {
    return await _create(
      context: context,
      widget: Builder(builder: (context) {
        var onlineStatus = initialOnline;
        return StatefulBuilder(builder: (context, setState) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Status'.tr,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Cancel'.tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: UTheme.color.blueCi,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.hr),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Text(
                  'Choose the status that you want to show while using UChat'.tr,
                  style: const TextStyle(
                    color: Color(0xFF808080),
                  ),
                ),
              ),
              SizedBox(height: 32.hr),
              UChatCheckBoxRowMenu(
                prefixWidget: Padding(
                  padding: EdgeInsets.all(8.hr),
                  child: CircleAvatar(
                    backgroundColor: AvatarWrapper.onlineColor,
                    radius: 4.hr,
                  ),
                ),
                height: 65.hr,
                title: 'Online'.tr,
                value: OnlineStatus.online,
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                selected: onlineStatus == OnlineStatus.online,
                onTap: (data) {
                  onSelected?.call(data);
                  setState(() {
                    if (data != null) {
                      onlineStatus = data;
                    }
                  });
                  Get.back();
                },
                hasBottomBorder: false,
              ),
              UChatCheckBoxRowMenu(
                prefixWidget: Padding(
                  padding: EdgeInsets.all(8.hr),
                  child: CircleAvatar(
                    backgroundColor: AvatarWrapper.busyColor,
                    radius: 4.hr,
                  ),
                ),
                height: 65.hr,
                title: 'Busy'.tr,
                value: OnlineStatus.busy,
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                selected: onlineStatus == OnlineStatus.busy,
                onTap: (data) {
                  onSelected?.call(data);
                  setState(() {
                    if (data != null) {
                      onlineStatus = data;
                    }
                  });
                  Get.back();
                },
                hasBottomBorder: false,
              ),
              UChatCheckBoxRowMenu(
                prefixWidget: Padding(
                  padding: EdgeInsets.all(8.hr),
                  child: CircleAvatar(
                    backgroundColor: AvatarWrapper.doNotDisturbColor,
                    radius: 4.hr,
                  ),
                ),
                height: 65.hr,
                title: 'Do not disturb'.tr,
                value: OnlineStatus.doNotDisturb,
                titleTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                selected: onlineStatus == OnlineStatus.doNotDisturb,
                onTap: (data) {
                  onSelected?.call(data);
                  setState(() {
                    if (data != null) {
                      onlineStatus = data;
                    }
                  });
                  Get.back();
                },
                hasTopBorder: true,
              ),
            ],
          );
        });
      }),
      isScrollControlled: isScrollControlled,
    );
  }

  static Future<T?> showFileSheet<T>({
    required BuildContext context,
    required FileInfoList fileInfoList,
  }) {
    return _create<T>(
      context: context,
      widget: SafeArea(
        child: Container(
          color: const Color(0xFFF9F9F9),
          constraints: BoxConstraints(
            minHeight: 0.5.sh,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 20.spMin,
                  right: 20.spMin,
                  bottom: 20.spMin,
                  top: 4.spMin,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      child: Text(
                        'Details'.tr,
                        style: TextStyle(
                          color: const Color(0xFF333333),
                          fontSize: 18.spMin,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Text(
                            'Cancel'.tr,
                            style: TextStyle(
                              color: const Color(0xFF999999),
                              fontSize: 18.spMin,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
                color: Color(0xFFF2F2F2),
              ),
              fileInfoList,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  static Future<T?> showTermAndConditionBottomSheet<T>({
    required BuildContext context,
    required String fileUrl,
    required Function onAccept,
  }) {
    return showCupertinoModalBottomSheet(
      context: Get.context!,
      isDismissible: false,
      enableDrag: false,
      builder: (BuildContext context) {
        return TermBottomSheet(
          type: PlatformDocumentType.termAndCondition.value,
          fileUrl: fileUrl,
          onAccept: onAccept,
        );
      },
    );
  }

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    required Widget widget,
    bool isScrollControlled = false,
  }) {
    return _create<T>(
      context: context,
      widget: widget,
      isScrollControlled: isScrollControlled,
    );
  }

  static Future<T?> _create<T>({
    required BuildContext context,
    required Widget widget,
    bool isScrollControlled = false,
  }) async {
    return showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.white,
      isScrollControlled: isScrollControlled,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [_buildBottomSheetNotch(), widget],
        );
      },
    );
  }

  /// Functions used only in this file.
  static Widget _buildBottomSheetNotch() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: 65,
        height: 6,
        decoration: ShapeDecoration(
          color: const Color(0xFFCCCCCC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  static Future<void> onTapOnlineStatus(OnlineStatus onlineStatus) async {
    final res = await AccountService().updateOnlineStatus(
      UpdateOnlineStatusRequest(onlineStatus: onlineStatus),
    );
    if (res != null) {
      UserController.instance.currentUser.value = UserController.instance.currentUser.value?.copyWith(
        onlineStatus: res.onlineStatus,
      );
      if (GetPlatform.isMobile) {
        UserController.instance.currentUser.refresh();
      }
      try {
        await UserDb().updateUser(UserCollection.fromEntity(UserController.instance.currentUser()!));
      } catch (e) {
        _log.e('update online status to local db error');
      }
    }
  }
}
