import 'package:device_marketing_names/device_marketing_names.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/auth/data/models/requests/delete_session_request.dart';
import 'package:uchat/features/auth/data/models/requests/get_sessions_list_request.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_session_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/delete_sessions_list_use_case.dart';
import 'package:uchat/features/auth/domain/use_cases/get_sessions_list_use_case.dart';
import 'package:uchat/screens/setting_devices_manager/macbook_marketing_name.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class SettingDevicesManagerController extends GetxController {
  final String actionToken;

  SettingDevicesManagerController({
    required this.actionToken,
  });

  final isPreparingData = true.obs;
  final PagingController<int, GetSessionsListResponse> pagingController = PagingController(firstPageKey: 0);
  final _actionToken = ''.obs;
  final totalDevice = 0.obs;

  @override
  void onInit() async {
    await preparingData();

    super.onInit();
  }

  @override
  void onClose() async {
    pagingController.dispose();
    super.onClose();
  }

  Future<void> preparingData() async {
    _actionToken.value = actionToken;

    if (_actionToken.value != '') {
      pagingController.addPageRequestListener((page) {
        _getAllLoggedInDevicesList(page);
      });
    }
  }

  Future<void> _getAllLoggedInDevicesList(int page) async {
    try {
      final response = await GetIt.I<GetSessionsListUseCase>().call(GetSessionsListRequest(
        actionToken: _actionToken.value,
        page: page + 1,
      ));

      if (response != null) {
        totalDevice.value = response.total;
        final isLastPage = page + 1 >= response.totalPages;
        if (isLastPage) {
          pagingController.appendLastPage(response.data!.toList());
        } else {
          pagingController.appendPage(response.data!.toList(), page + 1);
        }
      }
    } catch (e, stackTrace) {
      _log.e('_getAllLoggedInDevicesList error.', e, stackTrace);
    }
  }

  String getBrand(String deviceBrand) {
    if (deviceBrand.isEmpty) return 'UNKNOWN'.tr;

    if (deviceBrand.toLowerCase().contains('mac')) {
      return 'Mac';
    } else if (deviceBrand.toLowerCase().contains('window')) {
      return 'Window';
    }

    return deviceBrand;
  }

  String getMarketingName(String deviceOS, String deviceMarketingName) {
    if (deviceOS.isEmpty || deviceMarketingName.isEmpty) return 'UNKNOWN'.tr;

    if (deviceOS.contains('window')) return deviceMarketingName;
    if (deviceOS.contains('mac')) return getMacMarketingName(deviceMarketingName);

    DeviceType device;

    if (deviceOS.contains('ios')) {
      device = DeviceType.ios;
    } else {
      device = DeviceType.android;
    }

    String marketingName = DeviceMarketingNames().getNamesFromModel(
      device,
      deviceMarketingName,
    );

    return marketingName;
  }

  String getLastLogInAt(DateTime notiDateTime) {
    Duration dateTime = DateTime.now().difference(notiDateTime);

    // Second
    int timeDiff = dateTime.inSeconds;
    if (timeDiff >= 0 && timeDiff < 60) {
      return '@number @time ago'.trParams({
        'number': timeDiff.toString(),
        'time': timeDiff > 1 ? 'seconds'.tr : 'second'.tr,
      });
    }

    // Minute
    timeDiff = dateTime.inMinutes;
    if (timeDiff >= 1 && timeDiff < 60) {
      return '@number @time ago'.trParams({
        'number': timeDiff.toString(),
        'time': timeDiff > 1 ? 'minutes'.tr : 'minute'.tr,
      });
    }

    // Hour
    timeDiff = dateTime.inHours;
    if (timeDiff >= 1 && timeDiff < 24) {
      return '@number @time ago'.trParams({
        'number': timeDiff.toString(),
        'time': timeDiff > 1 ? 'hours'.tr : 'hour'.tr,
      });
    }

    // Day
    timeDiff = dateTime.inDays;
    if (timeDiff >= 1 && timeDiff < 30) {
      return '@number @time ago'.trParams({
        'number': timeDiff.toString(),
        'time': timeDiff > 1 ? 'days'.tr : 'day'.tr,
      });
    }

    // One month or more
    return notiDateTime.format('E d LLL y, HH:mm');
  }

  String getLocation(String loginLocation) {
    return loginLocation.isNotEmpty ? loginLocation : 'UNKNOWN'.tr;
  }

  void showDialogConfirmLogoutDevice(GetSessionsListResponse? data) async {
    final sessionId = data?.sessionId ?? '';

    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Log out of @device'.trParams({
        'device': getBrand(data?.deviceModel ?? ''),
      }),
      description: 'Do you want to log out from your @device?'.trParams({
        'device': getBrand(data?.deviceModel ?? ''),
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Logout'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<DeleteSessionUseCase>().call(DeleteSessionRequest(
            actionToken: _actionToken.value,
            sessionId: sessionId,
          ));

          //NOTE.need to have update(); because need to trigger UI to know list have update
          //Can not use pagingController.refresh because if user logout just 1 device all of the data list have start fetching again
          pagingController.itemList?.removeWhere((element) => element.sessionId == sessionId);
          totalDevice.value--;
          update();
        } catch (e, stackTrace) {
          handleException(e, onUnknownException: () {
            _log.e('onLogoutFromDevice error.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
            );
          });
        }
      },
    );
  }

  void showDialogConfirmLogoutAllDevices() async {
    UChatNewDialog.showDialog(
      context: Get.context!,
      title: 'Log out all device'.tr,
      description: 'Do you want to log out from all your devices?'.tr,
      cancelText: 'Cancel'.tr,
      confirmText: 'Logout'.tr,
      confirmTextColor: Get.context!.theme.appColors.textError,
      cancelTextColor: Get.context!.theme.appColors.textLight,
      isDestructive: true,
      onConfirm: () async {
        try {
          await GetIt.I<DeleteSessionsListUseCase>().call(_actionToken.value);

          pagingController.refresh();
        } catch (e, stackTrace) {
          handleException(e, onUnknownException: () {
            _log.e('onLogoutFromAllDevices error.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
            );
          });
        }
      },
    );
  }
}
