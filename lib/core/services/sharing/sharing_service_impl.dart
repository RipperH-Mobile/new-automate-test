import 'dart:ui';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/presentation/controllers/app_share_bottom_sheet_controller.dart';
import 'package:uchat/core/presentation/widgets/app_share_bottom_sheet.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';

class SharingServiceImpl implements SharingService {
  final shareInstance = SharePlus.instance;

  @override
  Future<ShareResult> shareToOtherApp({String? text, List<XFile>? files}) async {
    final params = ShareParams(
      text: text,
      files: files,
      sharePositionOrigin: Rect.fromLTWH(0, 0, Get.width, Get.height),
    );

    return await shareInstance.share(params);
  }

  @override
  Future<bool?> share({required ShareBottomSheetDataEntity data}) async {
    return await Get.bottomSheet(
      GetBuilder(
        init: AppShareBottomSheetController(data: data),
        builder: (ctl) {
          return const AppShareBottomSheet();
        },
      ),
      isScrollControlled: true,
    );
  }
}
