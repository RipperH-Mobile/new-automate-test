import 'package:share_plus/share_plus.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';

abstract class SharingService {
  Future<bool?> share({required ShareBottomSheetDataEntity data});
  Future<ShareResult> shareToOtherApp({String? text, List<XFile>? files});
}
