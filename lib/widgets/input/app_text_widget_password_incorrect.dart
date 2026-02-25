import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

class AppTextWidgetPasswordIncorrect extends StatelessWidget {
  final int errorCount;
  final String errorText;

  const AppTextWidgetPasswordIncorrect({super.key, this.errorCount = 0, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
            ),
            child: AppText.body3(
              errorText,
              context: context,
              color: context.theme.appColors.textError,
            ),
          ),
        if (errorCount > 2)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
            ),
            child: AppText.body3(
              'If you enter the wrong password too many times, for security reasons, we need to block access for 5 minutes (@count/5)'
                  .trParams(
                {
                  'count': errorCount.toString(),
                },
              ),
              context: context,
              color: context.theme.appColors.textError,
            ),
          ),
      ],
    );
  }
}
