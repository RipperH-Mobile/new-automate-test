import 'package:flutter/rendering.dart';

class AnnotationModel {
  AnnotationModel({
    required this.trigger,
    this.style,
    this.id,
    this.display,
    this.displayNameValue,
    this.disableMarkup = false,
    this.markupBuilder,
  });

  TextStyle? style;
  String? id;
  String? display;
  String? displayNameValue;
  String trigger;
  bool disableMarkup;
  final String Function(String trigger, String mention, String value, String displayNameValue)? markupBuilder;
}
