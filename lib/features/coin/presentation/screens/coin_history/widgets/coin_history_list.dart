import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/coin/domain/enums/coin_history_tab.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_history_controller.dart';
import 'package:uchat/features/coin/presentation/screens/coin_history/widgets/coin_history_transaction_item.dart';
import 'package:uchat/widgets/app_text.dart';

class CoinHistoryList extends StatelessWidget {
  final CoinHistoryTab tab;

  const CoinHistoryList({super.key, required this.tab});

  String get id {
    switch (tab) {
      case CoinHistoryTab.all:
        return CoinHistoryIds.coinHistoryAllList;
      case CoinHistoryTab.purchase:
        return CoinHistoryIds.coinHistoryPurchaseList;
      case CoinHistoryTab.usage:
        return CoinHistoryIds.coinHistoryUsageList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoinHistoryController>(
      id: id,
      builder: (ctl) {
        final scrollController = switch (tab) {
          CoinHistoryTab.all => ctl.allScrollController,
          CoinHistoryTab.purchase => ctl.purchaseScrollController,
          CoinHistoryTab.usage => ctl.usageScrollController,
        };

        final items = ctl.coinTransactionSet[tab] ?? {};

        if (items.isEmpty) {
          final noItemString = switch (tab) {
            CoinHistoryTab.all => 'No history'.tr,
            CoinHistoryTab.purchase => 'No purchase history'.tr,
            CoinHistoryTab.usage => 'No usage history'.tr,
          };

          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.space20),
              child: AppText.body2Bold(
                noItemString,
                context: context,
                textAlign: TextAlign.center,
                color: context.theme.appColors.textDarkest,
              ),
            ),
          );
        }

        return ListView.builder(
          key: PageStorageKey('${tab.value}_List'),
          controller: scrollController,
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: AppSpace.space6),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items.elementAt(index);
            return CoinHistoryTransactionItem(transaction: item);
          },
        );
      },
    );
  }
}
