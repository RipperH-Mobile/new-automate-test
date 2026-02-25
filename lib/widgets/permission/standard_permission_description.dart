import 'dart:io';

import 'package:flutter/material.dart';

class StandardPermissionDescription extends StatelessWidget {
  const StandardPermissionDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDescription(context),
          ...buildSettingDescription(context),
        ],
      ),
    );
  }

  String get description {
    return '';
  }

  bool get requireSettingDescription {
    return false;
  }

  Widget buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        description,
        textAlign: TextAlign.center,
      ),
    );
  }

  List<Widget> buildSettingDescription(BuildContext context) {
    if (!requireSettingDescription) {
      return [];
    }

    if (!Platform.isIOS) {
      return iosSettingDescription(context);
    }

    return androidSettingDescription(context);
  }

  List<Widget> iosSettingDescription(BuildContext context) {
    return [];
  }

  List<Widget> androidSettingDescription(BuildContext context) {
    return [];
  }

  Widget buildDescriptionWithIcon(
    String description,
    Icon icon,
    BuildContext context,
  ) {
    return Column(
      children: [
        const SizedBox(
          width: 10,
          height: 20,
        ),
        Center(
          child: icon,
        ),
        const SizedBox(
          width: 10,
          height: 10,
        ),
        Center(
          child: Text(description),
        )
      ],
    );
  }
}
