import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:vm_service/vm_service_io.dart';

class MemoryHelper {
  static void clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// 2. สั่ง Force Garbage Collection ผ่าน VM Service
  static Future<void> forceGC() async {
    try {
      final info = await Service.getInfo();
      final serverUri = info.serverUri;

      if (serverUri != null) {
        final wsUri = _convertToWebSocketUrl(serverUri);
        final service = await vmServiceConnectUri(wsUri.toString());
        final vm = await service.getVM();

        // สั่ง GC ทุก Isolate (ปกติ Main Isolate คือตัวที่บวม)
        for (final isolateRef in vm.isolates!) {
          await service.getAllocationProfile(isolateRef.id!, gc: true);
        }
        service.dispose();
      }
    } catch (e) {
      debugPrint('⚠️ Force GC Failed: $e');
    }
  }

  /// Helper แปลง URL
  static Uri _convertToWebSocketUrl(Uri serviceUri) {
    final pathSegments = <String>[...serviceUri.pathSegments];
    if (pathSegments.isNotEmpty && pathSegments.last == '') {
      pathSegments.removeLast();
    }
    pathSegments.add('ws');
    return serviceUri.replace(scheme: 'ws', pathSegments: pathSegments);
  }

  /// ฟังก์ชันรวม: เรียกทีเดียวจบ
  static Future<void> purge() async {
    clearImageCache();
    await forceGC();
    debugPrint('🧹 Memory Purged Successfully');
  }
}
