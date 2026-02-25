import 'package:get/get.dart';

enum CoinHistoryTab {
  all('All'),
  purchase('Purchase history'),
  usage('Usage history');

  final String value;

  const CoinHistoryTab(this.value);

  String get display {
    switch (this) {
      case CoinHistoryTab.all:
        return 'All'.tr;
      case CoinHistoryTab.purchase:
        return 'Purchase history'.tr;
      case CoinHistoryTab.usage:
        return 'Usage history'.tr;
    }
  }
}
