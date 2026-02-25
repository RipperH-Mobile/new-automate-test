import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';

class CreateAccountScreenLayout extends StatelessWidget {
  const CreateAccountScreenLayout({
    super.key,
    required this.children,
    this.onPressedBack,
    this.heading = '',
    this.subTitle = '',
    this.secondSubTitle = '',
  });

  final List<Widget> children;
  final void Function()? onPressedBack;
  final String heading;
  final String subTitle;
  final String secondSubTitle;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: AppBarDefault(
        title: 'Create Account'.tr,
        leadingButton: AppControlButton.back(
          context: context,
          onTap: onPressedBack ?? () => Get.back(),
        ),
      ),
      child: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: AppSpace.space6,
        right: AppSpace.space6,
        top: AppSpace.space4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText.heading4(
            heading,
            context: context,
          ),
          if (subTitle != '' || subTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpace.space2,
              ),
              child: AppText.body3(
                subTitle,
                context: context,
                color: context.theme.appColors.textLight,
              ),
            ),
          if (secondSubTitle != '' || secondSubTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(
                top: AppSpace.space2,
              ),
              child: AppText.body3(
                secondSubTitle,
                context: context,
                color: context.theme.appColors.textLight,
              ),
            ),
          const SizedBox(
            height: AppSpace.space6,
          ),
          ...children,
        ],
      ),
    );
  }
}
