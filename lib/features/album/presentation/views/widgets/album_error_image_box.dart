import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/gen/assets.gen.dart';

class AlbumErrorImageBox extends StatelessWidget {
  const AlbumErrorImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.appColors.backgroundNeutralLightPressed,
      ),
      child: Center(
        child: Assets.vectors.iconImageOutline.svg(
          width: AppSize.size6,
          height: AppSize.size6,
        ),
      ),
    );
  }
}
