import 'dart:core';

import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';

class ShareToOtherAppParams<T> {
  ShareBottomSheetDataEntity data;

  ShareToOtherAppParams({
    required this.data,
  });
}
