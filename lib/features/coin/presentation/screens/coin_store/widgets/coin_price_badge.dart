import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/utils/extension/extension_number.dart';

class CoinPriceBadge extends StatelessWidget {
  final double coinPrice;
  final String? currencySymbol;
  final String? currencyCode;

  const CoinPriceBadge({super.key, required this.coinPrice, this.currencySymbol, this.currencyCode});

  String get currencySymbolOrDefault {
    return currencySymbol ?? '';
  }

  String get currencyCodeOrDefault {
    return currencyCode ?? '';
  }

  String get coinPriceFormatted {
    if (currencyCodeOrDefault.isNotEmpty) {
      return '${coinPrice.toNumberFormat()} $currencyCodeOrDefault';
    }

    if (currencySymbolOrDefault.isNotEmpty) {
      return '${coinPrice.toNumberFormat()} $currencySymbolOrDefault';
    }

    return coinPrice.toNumberFormat();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.theme.appColors.buttonPrimary,
        borderRadius: BorderRadius.circular(AppRadius.roundedLg),
        border: Border.all(
          color: context.theme.appColors.border,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpace.space2,
          vertical: AppSpace.space015,
        ),
        child: Text(
          coinPriceFormatted,
          style: context.theme.appTexts.body3Bold.copyWith(
            color: context.theme.appColors.textPrimaryInverse,
          ),
        ),
      ),
    );
  }
}
