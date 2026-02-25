import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/widgets/permission/standard_permission_description.dart';

class GalleryPermissionDescription extends StandardPermissionDescription {
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

  const GalleryPermissionDescription({
    super.key,
    required this.requestDescription,
    this.useSettingDescription = false,
  });

  @override
  List<Widget> iosSettingDescription(BuildContext context) {
    return [
      buildDescriptionWithIcon(
        '1. Select photos permission setting'.tr,
        const Icon(Icons.settings),
        context,
      ),
      buildDescriptionWithIcon(
        '2. Allow photos permission'.tr,
        const Icon(Icons.photo_album),
        context,
      ),
    ];
  }

  @override
  List<Widget> androidSettingDescription(BuildContext context) {
    return iosSettingDescription(context);
  }
}
