import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_gif_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';

class DebugSendSampleGifConfigController extends GetxController {
  final delayController = TextEditingController(text: '100');
  final loopCountController = TextEditingController(text: '100');

  final formKey = GlobalKey<FormState>();

  ChatRoomController get chatRoomCtl => Get.find<ChatRoomController>();

  @override
  void onClose() {
    delayController.dispose();
    loopCountController.dispose();
    super.onClose();
  }

  void sendSampleGif({
    required GifSendingEntity gif,
    required Function(GifSendingEntity, {int loopCount}) onSendGif,
  }) {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    final delay = int.parse(delayController.text);
    final loopCount = int.parse(loopCountController.text);

    Get.back();

    GetIt.I<DebugSendSampleGifUseCase>().call(
      DebugSendSampleGifParams(
        delay: delay,
        loopCount: loopCount,
        onSendGif: onSendGif,
        gif: gif,
      ),
    );
  }
}

class DebugSendSampleGifConfigDialog extends StatelessWidget {
  final GifSendingEntity gif;
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final VoidCallback? onCancel;

  const DebugSendSampleGifConfigDialog({
    super.key,
    required this.gif,
    required this.onSendGif,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DebugSendSampleGifConfigController>(
      init: DebugSendSampleGifConfigController(),
      builder: (ctl) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: ctl.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Debug Send Sample Gif Config'.tr,
                      style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: ctl.delayController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Delay (ms)'.tr,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter delay'.tr;
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 0) {
                          return 'Must be a non-negative number'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: ctl.loopCountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Loop Count'.tr,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter loop count'.tr;
                        }
                        final number = int.tryParse(value);
                        if (number == null || number < 1) {
                          return 'Must be at least 1'.tr;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              onCancel?.call();
                            },
                            child: Text('Cancel'.tr),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              ctl.sendSampleGif(
                                gif: gif,
                                onSendGif: onSendGif,
                              );
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
