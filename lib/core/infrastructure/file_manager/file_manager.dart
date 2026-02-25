import 'dart:io';

import 'package:uchat/constants/uchat_constant.dart';

bool isImageTypeSupported(String mime) {
  final supportedList =
      Platform.isAndroid ? UChatConstant.supportedImageMimeListAndroid : UChatConstant.supportedImageMimeListIos;
  return supportedList.contains(mime);
}

bool isVideoTypeSupported(String mime) {
  final supportedList =
      Platform.isAndroid ? UChatConstant.supportedVideoMimeListAndroid : UChatConstant.supportedVideoMimeListIos;
  return supportedList.contains(mime);
}
