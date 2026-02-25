import 'package:get/get.dart';
import 'package:uchat/features/coin/presentation/controllers/coin_store_controller.dart';

class CoinStoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CoinStoreController>(CoinStoreController());
  }
}
