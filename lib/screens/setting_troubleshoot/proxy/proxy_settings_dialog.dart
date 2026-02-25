import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'proxy_settings_controller.dart';

class ProxySettingsDialog extends GetWidget<ProxySettingsController> {
  const ProxySettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context),
      ),
    );
  }

  Widget contentBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Proxy Settings'.tr,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Enable Toggle
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Enable'.tr, style: const TextStyle(fontSize: 16)),
                  Switch(
                    value: controller.isEnabled.value,
                    onChanged: controller.updateEnable,
                  ),
                ],
              )),

          const SizedBox(height: 12),

          // IP Field
          TextField(
            decoration: InputDecoration(
              labelText: 'IP Address'.tr,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: controller.updateIp,
            controller: TextEditingController(text: controller.ip.value),
          ),

          const SizedBox(height: 12),

          // Port Field
          TextField(
            decoration: InputDecoration(
              labelText: 'Port'.tr,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onChanged: controller.updatePort,
            keyboardType: TextInputType.number,
            controller: TextEditingController(text: controller.port.value.toString()),
          ),

          const SizedBox(height: 20),

          Text(
            'When changing the proxy settings, please restart the app for the changes to take effect.'.tr,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),

          const SizedBox(height: 20),

          // Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Cancel'.tr),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  controller.saveConfig();
                  Get.back();
                },
                child: Text('Save'.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
