import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/app_text.dart';

class StickerUChatCoin extends StatelessWidget {
  final int coinCount;

  const StickerUChatCoin({super.key, required this.coinCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.roundedFull),
        border: Border.all(
          color: context.theme.appColors.border,
          width: 1.0,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space3, vertical: AppSpace.space2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.body3('My coins:'.tr, context: context),
          AppSpace.space1.horizontalSpace,
          AppText.body3Bold(coinCount.toNumberFormat(), context: context),
        ],
      ),
    );
  }
}
