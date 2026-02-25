import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';

class AppShareBottomSheetShareParam {
  ShareBottomSheetDataEntity data;
  List<ShareTargetEntity> selectedTargetList;
  String? captionText;

  AppShareBottomSheetShareParam({
    required this.data,
    required this.selectedTargetList,
    this.captionText,
  });
}
