import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/gen/assets.gen.dart';

class DebugSendSequenceMessageInput extends StatelessWidget {
  final void Function() onSend;
  final void Function() onCancel;
  final GlobalKey formKey;
  final TextEditingController delayController;
  final TextEditingController amountController;
  final bool isSending;

  const DebugSendSequenceMessageInput({
    super.key,
    required this.onSend,
    required this.onCancel,
    required this.formKey,
    required this.delayController,
    required this.amountController,
    required this.isSending,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Assets.vectors.bombMessage.svg(width: 64, height: 64)
                ),
                const SizedBox(height: 24),
                Text(
                  'How many messages do you want to send?'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 48),
                TextFormField(
                  controller: delayController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  readOnly: isSending,
                  decoration: InputDecoration(
                    labelText: 'Delay (milliseconds)'.tr,
                    hintText: 'Enter delay value'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter delay value'.tr;
                    }
                    final number = int.tryParse(value);
                    if (number == null) {
                      return 'Please enter numbers only'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  readOnly: isSending,
                  decoration: InputDecoration(
                    labelText: 'Amount (10-500)'.tr,
                    hintText: 'Enter amount'.tr,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount'.tr;
                    }
                    final number = int.tryParse(value);
                    if (number == null) {
                      return 'Please enter numbers only'.tr;
                    }
                    if (number < 10) {
                      return 'Amount must not be less than 10'.tr;
                    }
                    if (number > 500) {
                      return 'Amount must not exceed 100'.tr;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: onCancel,
                      child: Text('Close'.tr),
                    ),
                    ElevatedButton(
                      onPressed: onSend,
                      child: (isSending)
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(Get.context!).colorScheme.onPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text('Sending...'.tr),
                              ],
                            )
                          : Text('Send'.tr),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
