import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension.dart';

class StickerPrice extends StatelessWidget {
  final double price;
  final TextStyle? textStyle;

  const StickerPrice({super.key, required this.price, this.textStyle});

  @override
  Widget build(BuildContext context) {
    if (price != 0) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.vectors.iconUchatCoin.svg(width: 20.spMin, height: 20.spMin),
          AppSpace.space1.horizontalSpace,
          Text(
            price.toNumberFormat(),
            style: textStyle ?? context.theme.appTexts.body3Bold,
          ),
        ],
      );
    } else {
      return Text(
        'Free'.tr,
        style: textStyle?.copyWith(color: context.theme.appColors.textPrimary) ??
            context.theme.appTexts.body3Bold.copyWith(
              color: context.theme.appColors.textPrimary,
            ),
      );
    }
  }
}
