import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class UChatCallConstant {
  /// Max image per message, default is `10` images
  static Size videoEndCallBtnSize = Size(85.spMin, 50.spMin);
  static Size voiceEndCallSize = Size(85.spMin, 64.spMin);

  static Size videoCallActionBtnSize = Size(80.spMin, 70.spMin);
  static Size voiceCallActionBtnSize = Size(110.spMin, 90.spMin);

  static double voicePanelHeight = 120.spMin;
  static double videoPanelHeight = 120.spMin;

  static double networkWeakWidgetHeight = 50.spMin;
  static double mutedMicWidgetHeight = 50.spMin;
}
