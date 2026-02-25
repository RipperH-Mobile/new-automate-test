import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_message_use_case.dart';

class DebugSendSampleMessageConfigController extends GetxController {
  final FutureOr<void> Function({required String message, List<MessageLinkModel> links, int loopCount}) onSendText;

  DebugSendSampleMessageConfigController({required this.onSendText});

  final delayController = TextEditingController(text: '100');
  final characterAmountController = TextEditingController(text: '100');
  final loopCountController = TextEditingController(text: '100');

  SampleMessageType sampleMessageType = SampleMessageType.text;

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    delayController.dispose();
    characterAmountController.dispose();
    loopCountController.dispose();
    super.onClose();
  }

  Future<void> sendSampleMessage() async {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    final delay = int.parse(delayController.text);
    final characterAmount = int.parse(characterAmountController.text);
    final loopCount = int.parse(loopCountController.text);
    Get.back();

    GetIt.I<DebugSendSampleMessageUseCase>().call(
      DebugSendSampleMessageParams(
        delay: delay,
        characterAmount: characterAmount,
        loopCount: loopCount,
        sampleType: sampleMessageType,
        onSendText: onSendText,
      ),
    );
  }
}

class DebugSendSampleMessageConfigDialog extends StatelessWidget {
  final FutureOr<void> Function({required String message, List<MessageLinkModel> links, int loopCount}) onSendText;
  final VoidCallback? onCancel;

  const DebugSendSampleMessageConfigDialog({
    super.key,
    required this.onSendText,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DebugSendSampleMessageConfigController>(
      init: DebugSendSampleMessageConfigController(onSendText: onSendText),
      builder: (ctl) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Form(
                key: ctl.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Dropdown for SampleMessageType
                    DropdownButtonFormField<SampleMessageType>(
                      initialValue: ctl.sampleMessageType,
                      decoration: InputDecoration(
                        labelText: 'Sample Message Type'.tr,
                        border: const OutlineInputBorder(),
                      ),
                      items: SampleMessageType.values.map((type) {
                        String text;
                        switch (type) {
                          case SampleMessageType.text:
                            text = 'Text'.tr;
                            break;
                          case SampleMessageType.emoji:
                            text = 'Emoji'.tr;
                            break;
                        }
                        return DropdownMenuItem<SampleMessageType>(
                          value: type,
                          child: Text(text),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          ctl.sampleMessageType = value;
                        }
                      },
                    ),
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: ctl.delayController,
                      decoration: InputDecoration(
                        labelText: 'Delay (milliseconds)'.tr,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Character Amount max at [UChatConstant.maxMessageInputLength], min at 10
                    TextFormField(
                      controller: ctl.characterAmountController,
                      decoration: InputDecoration(
                        labelText: 'Character Amount'.tr,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter character amount'.tr;
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 10 || number > UChatConstant.maxMessageInputLength) {
                          return 'Must be between 10 and ${UChatConstant.maxMessageInputLength}'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// Loop Count max at 1000, min at 1
                    TextFormField(
                      controller: ctl.loopCountController,
                      decoration: InputDecoration(
                        labelText: 'Loop Count'.tr,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter loop count'.tr;
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 1 || number > 1000) {
                          return 'Must be between 1 and 1000'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: onCancel,
                            child: Text('Cancel'.tr),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () async {
                              await ctl.sendSampleMessage();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(40),
                              foregroundColor: Colors.white,
                              backgroundColor: Theme.of(context).primaryColor,
                            ),
                            child: Text('Send'.tr),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
