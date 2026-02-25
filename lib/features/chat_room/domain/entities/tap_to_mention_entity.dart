import 'package:flutter/material.dart';

class TapToMentionEntity {
  String text;
  TextSelection? cursorPos;

  TapToMentionEntity({
    required this.text,
    this.cursorPos,
  });
}
