import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class AppBulletItem extends StatelessWidget {
  const AppBulletItem({
    super.key,
    required this.text,
    required this.isChecked,
  });

  final String text;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        isChecked
            ? Assets.vectors.check12.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.iconPrimary,
                  BlendMode.srcIn,
                ),
              )
            : Assets.vectors.dot8.svg(),
        const SizedBox(
          width: AppSpace.space1,
        ),
        AppText.body3(
          text,
          context: context,
          color: isChecked ? context.theme.appColors.textPrimary : null,
        ),
      ],
    );
  }
}
