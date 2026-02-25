import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class AddContactIconMenu extends StatelessWidget {
  final Widget icon;
  final String title;
  final void Function() onPressed;

  const AddContactIconMenu({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpace.space6.spMin,
          AppSpace.space2.spMin,
          AppSpace.space6.spMin,
          AppSpace.space2.spMin,
        ),
        child: Column(
          children: [
            icon,
            AppText.body3(title.tr, context: context),
          ],
        ),
      ),
    );
  }
}
