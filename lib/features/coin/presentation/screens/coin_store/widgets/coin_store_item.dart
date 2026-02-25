import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/domain/entities/coin_package_entity.dart';
import 'package:uchat/features/coin/presentation/screens/coin_store/widgets/coin_item_badge.dart';
import 'package:uchat/features/coin/presentation/screens/coin_store/widgets/coin_price_badge.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/extension/extension_number.dart';

class CoinStoreItem extends StatelessWidget {
  final VoidCallback? onTap;
  final CoinPackageEntity coinPackage;

  const CoinStoreItem({super.key, required this.coinPackage, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: AppSpace.space05),
              child: Assets.vectors.iconUchatCoin.svg(
                width: 20.w,
                height: 20.h,
              ),
            ),
            AppSpace.space2.horizontalSpace,
            RichText(
              text: TextSpan(
                style: context.theme.appTexts.body1Bold.copyWith(
                  fontSize: 16.sp,
                  color: context.theme.appColors.textDarkest,
                ),
                children: [
                  TextSpan(
                    text: coinPackage.coin.toNumberFormat(),
                  ),
                  if (coinPackage.hasBonusCoin)
                    TextSpan(
                      text: '(+${coinPackage.bonus.toNumberFormat()})',
                      style: context.theme.appTexts.body1Bold.copyWith(
                        color: context.theme.appColors.textLighter,
                        fontSize: 16.sp,
                      ),
                    ),
                ],
              ),
            ),
            AppSpace.space1.horizontalSpace,
            if (coinPackage.isBadgeVisible)
              CoinItemBadge(
                text: coinPackage.badgeText,
              ),
            const Spacer(),
            CoinPriceBadge(
              coinPrice: coinPackage.price,
              currencySymbol: coinPackage.currencySymbol,
              currencyCode: coinPackage.currencyCode,
            ),
          ],
        ),
      ),
    );
  }
}
