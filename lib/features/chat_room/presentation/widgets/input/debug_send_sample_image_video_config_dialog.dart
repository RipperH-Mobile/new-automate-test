import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';

class DebugSendSampleImageVideoConfigController extends GetxController {
  final delayController = TextEditingController(text: '100');
  final loopCountController = TextEditingController(text: '100');
  final numberOfImagesController = TextEditingController(text: '10');

  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    delayController.dispose();
    loopCountController.dispose();
    numberOfImagesController.dispose();
    super.onClose();
  }

  void generateMediaGalleryResult(AssetEntity asset) {
    if (formKey.currentState?.validate() != true) {
      return;
    }

    final delay = int.parse(delayController.text);
    final loopCount = int.parse(loopCountController.text);
    final imageAmount = int.parse(numberOfImagesController.text);

    MediaGalleryResult result;
    if (asset.type == AssetType.image) {
      result = MediaGalleryResult.fromAssets(
        List.generate(imageAmount, (_) => asset),
      );
    } else {
      result = MediaGalleryResult.fromAssets([asset]);
    }

    Get.back(result: [result, delay, loopCount]);
  }
}

class DebugSendSampleImageVideoConfigDialog extends StatelessWidget {
  final AssetEntity asset;

  const DebugSendSampleImageVideoConfigDialog({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DebugSendSampleImageVideoConfigController>(
      init: DebugSendSampleImageVideoConfigController(),
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
                      'Debug Send Sample Image/Video Config'.tr,
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
                    const SizedBox(height: 16.0),
                    if (asset.type == AssetType.image)
                      TextFormField(
                        controller: ctl.numberOfImagesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Number of Images'.tr,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter number of images'.tr;
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
                              Get.back();
                            },
                            child: Text('Cancel'.tr),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              ctl.generateMediaGalleryResult(asset);
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
