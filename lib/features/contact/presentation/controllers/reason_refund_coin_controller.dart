import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/coin/coin.dart';
import 'package:uchat/features/contact/presentation/controllers/pending_refund_reason_queue_controller.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class ReasonRefundCoinController extends GetxController {
  final TextEditingController reasonController = TextEditingController();
  final isReasonInvalid = true.obs;

  void checkTextField(String text) {
    isReasonInvalid.value = text.length < 20;
  }

  void sendRefundReason(String transactionId) async {
    try {
      if (isReasonInvalid.value) return;

      await GetIt.I<SendCoinRefundReasonUseCase>().call(CoinRefundReasonRequest(
        reason: reasonController.text.trim(),
        transactionId: transactionId,
      ));

      Get.back();
      UChatNewDialog.showSendReasonRefundCoinSuccess();
    } on ApiException catch (e, stackTrace) {
      if (e.type == 'ERR_COIN_REFUND_ALREADY_REFUNDED') {
        UChatNewDialog.sendAlreadySubmitReasonRefundCoin();
      } else {
        Get.back();

        handleException(e, onUnknownException: () {
          _log.e('ApiException : sendRefundReason error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
          );
        });
      }
    } catch (e, stackTrace) {
      Get.back();

      handleException(e, onUnknownException: () {
        _log.e('sendRefundReason error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
        );
      });
    }
    // Process the next item in the queue
    // Notify the queue controller to show the next bottom sheet
    final queueController = Get.put(PendingRefundReasonQueueController());

    await queueController.processQueue();
  }
}
