import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/features/chat_room/domain/entities/sticker_sending_entity.dart';
import 'package:uchat/features/chat_room/domain/use_cases/debug_send_sample_sticker_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';

class DebugSendSampleStickerConfigController extends GetxController {
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

  void sendSampleSticker({
    required StickerSendingEntity sticker,
    required Function(StickerSendingEntity, {int loopCount}) onSendSticker,
  }) {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    final delay = int.parse(delayController.text);
    final loopCount = int.parse(loopCountController.text);

    Get.back();

    GetIt.I<DebugSendSampleStickerUseCase>().call(
      DebugSendSampleStickerParams(
        delay: delay,
        loopCount: loopCount,
        onSendSticker: onSendSticker,
        sticker: sticker,
      ),
    );
  }
}

class DebugSendSampleStickerConfigDialog extends StatelessWidget {
  final StickerSendingEntity sticker;
  final Function(StickerSendingEntity, {int loopCount}) onSendSticker;
  final VoidCallback? onSend;
  final VoidCallback? onCancel;

  const DebugSendSampleStickerConfigDialog({
    super.key,
    required this.sticker,
    required this.onSendSticker,
    this.onSend,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DebugSendSampleStickerConfigController>(
      init: DebugSendSampleStickerConfigController(),
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
                      'Debug Send Sample Sticker Config'.tr,
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
                              ctl.sendSampleSticker(
                                onSendSticker: onSendSticker,
                                sticker: sticker,
                              );
                              onSend?.call();
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
