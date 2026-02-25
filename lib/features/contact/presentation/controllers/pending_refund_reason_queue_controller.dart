import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets.dart';

import 'reason_refund_coin_controller.dart';

final _log = useLogger();

class PendingRefundReasonQueueController extends GetxController {
  final List<Map<String, dynamic>> _queue = [];
  bool _isProcessing = false;

  void addRefundReasonToQueue(String transactionId, int coinAmount) {
    _queue.add({'transactionId': transactionId, 'coinAmount': coinAmount});
    if (!_isProcessing) {
      processQueue();
    }
  }

  Future<void> processQueue() async {
    try {
      if (_queue.isNotEmpty && !_isProcessing) {
        _isProcessing = true;
        final item = _queue.removeAt(0);
        if (UChatScreenUtil.instance.isMobile) {
          await Get.bottomSheet(
            PopScope(
              canPop: false,
              child: GetBuilder<ReasonRefundCoinController>(
                init: ReasonRefundCoinController(),
                builder: (ctl) {
                  return ReasonRefundCoinBottomSheetWidget(
                    refundedTransactionId: item['transactionId'],
                    coinAmount: item['coinAmount'],
                  );
                },
              ),
            ),
            isScrollControlled: true,
            isDismissible: false,
            enableDrag: false,
          );
        } else {
          await UChatDialog.showCustomDialog(
            init: ReasonRefundCoinController(),
            child: (_) => PopScope(
              canPop: false,
              child: ReasonRefundCoinBottomSheetWidget(
                refundedTransactionId: item['transactionId'],
                coinAmount: item['coinAmount'],
              ),
            ),
            barrierDismissible: false,
          );
        }

        _isProcessing = false;
      }
    } catch (e, stackTrace) {
      _log.d(
        'can not processQueue for refund',
        e,
        stackTrace,
      );
    }
  }
}
