import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/permission/standard_permission_description.dart';

class CameraPermissionDescription extends StandardPermissionDescription {
  final String requestDescription;
  final bool useSettingDescription;

  @override
  String get description {
    return requestDescription;
  }

  @override
  bool get requireSettingDescription {
    return useSettingDescription;
  }

  const CameraPermissionDescription({
    super.key,
    required this.requestDescription,
    this.useSettingDescription = false,
  });

  @override
  List<Widget> iosSettingDescription(BuildContext context) {
    return [
      buildDescriptionWithIcon(
        '1. Select camera permission setting'.tr,
        const Icon(Icons.settings),
        context,
      ),
      buildDescriptionWithIcon(
        '2. Toggle permission on'.tr,
        const Icon(Icons.camera_alt_outlined),
        context,
      ),
    ];
  }

  @override
  List<Widget> androidSettingDescription(BuildContext context) {
    return iosSettingDescription(context);
  }
}
