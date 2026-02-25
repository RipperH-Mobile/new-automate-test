import 'package:flutter/material.dart';
import 'package:uchat/widgets/permission/standard_permission_description.dart';

class StoragePermissionDescription extends StandardPermissionDescription {
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

  const StoragePermissionDescription({
    super.key,
    required this.requestDescription,
    this.useSettingDescription = false,
  });

  @override
  List<Widget> iosSettingDescription(BuildContext context) {
    return [];
  }

  @override
  List<Widget> androidSettingDescription(BuildContext context) {
    return [];
  }
}
