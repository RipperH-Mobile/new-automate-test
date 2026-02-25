import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/toast_with_undo_controller.dart';
import 'package:uchat/widgets/app_text.dart';

class ToastWithUndo extends StatelessWidget {
  final String title;
  final String description;
  final Function onTapUndo;

  const ToastWithUndo({
    super.key,
    required this.title,
    required this.description,
    required this.onTapUndo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
        gradient: LinearGradient(
          stops: [0, 0.15],
          colors: context.theme.appGradientColors.gradientBlackGray,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      padding: const EdgeInsets.all(AppSpace.space3),
      child: Container(
        constraints: const BoxConstraints(minHeight: AppSpace.space6),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  color: Get.context!.theme.appColors.textPrimaryInverse,
                  strokeWidth: AppSpace.space05,
                ),
                GetBuilder<ToastWithUndoController>(
                  id: 'countdown_text',
                  builder: (controller) {
                    return Container(
                      padding: const EdgeInsets.all(AppSpace.space2),
                      decoration: BoxDecoration(
                        color: Get.context!.theme.appColors.textPrimaryInverse,
                        shape: BoxShape.circle,
                      ),
                      child: AppText.caption1Bold(
                        controller.countdown.value.toString(),
                        context: Get.context!,
                        color: Get.context!.theme.appColors.textDarker,
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(width: AppSpace.space3),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.body3Bold(
                    title,
                    context: context,
                    color: context.theme.appColors.textInformationInverse,
                  ),
                  AppText.caption1(
                    description,
                    context: context,
                    color: context.theme.appColors.textInformationInverse,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                onTapUndo();
              },
              child: AppText.body3Bold(
                'Undo'.tr,
                context: context,
                color: context.theme.appColors.textInformationInverse,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
