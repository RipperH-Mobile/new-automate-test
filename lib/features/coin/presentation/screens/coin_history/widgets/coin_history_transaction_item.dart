import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/domain/entities/coin_transaction_entity.dart';
import 'package:uchat/features/coin/domain/enums/coin_transaction_type.dart';
import 'package:uchat/widgets/app_text.dart';

class CoinHistoryTransactionItem extends StatelessWidget {
  final CoinTransactionEntity transaction;

  const CoinHistoryTransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.body1(
                  transaction.title,
                  context: context,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                AppText.body4(
                  transaction.datetime,
                  context: context,
                ),
              ],
            ),
          ),
          AppSpace.space8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Builder(builder: (context) {
                if (transaction.type == CoinTransactionType.topUp) {
                  return AppText.body1(
                    '+@coinAmount Coins'.trParams({
                      'coinAmount': transaction.totalAmount.toString(),
                    }),
                    context: context,
                    color: context.theme.appColors.textSuccess,
                  );
                }

                return AppText.body1(
                  '-@coinAmount Coins'.trParams({
                    'coinAmount': transaction.amount.toString(),
                  }),
                  context: context,
                  color: context.theme.appColors.textLight,
                );
              }),
              if (transaction.type == CoinTransactionType.topUp)
                AppText.body4(
                  transaction.bonus != null && transaction.bonus! > 0
                      ? 'Package @coinAmount(+@coinBonus)'.trParams({
                          'coinAmount': transaction.amount.toString(),
                          'coinBonus': transaction.bonus.toString(),
                        })
                      : 'Package @coinAmount'.trParams({
                          'coinAmount': transaction.amount.toString(),
                        }),
                  context: context,
                  color: context.theme.appColors.textLight,
                  maxLines: 1,
                  textOverflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
