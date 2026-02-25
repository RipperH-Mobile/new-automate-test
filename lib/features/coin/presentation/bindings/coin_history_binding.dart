import 'package:get/get.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_history_controller.dart';

class CoinHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CoinHistoryController>(CoinHistoryController());
  }
}
