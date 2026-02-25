import 'dart:typed_data';

import 'package:super_clipboard/super_clipboard.dart';

class PasteBoardImageEntity {
  Uint8List? image;
  bool isSelected;
  int index;
  double percentage;
  bool isTooLarge;
  FileFormat? format;

  PasteBoardImageEntity({
    this.image,
    required this.isSelected,
    required this.index,
    required this.percentage,
    this.isTooLarge = false,
    this.format,
  });
}
