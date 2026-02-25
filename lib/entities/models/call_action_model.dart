import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallActionModel {
  final Widget enableWidget;
  final Widget? disableWidget;
  final Widget? popupWidget;
  final Future<void> Function()? onTap;
  final void Function() onLongTap;
  final Color bgColor;
  final Color? borderColor;
  final bool isDisableTwoElementAnimated;
  final RxBool? ensureEnableRef;
  final void Function(BuildContext context)? onTapPopover;

  const CallActionModel({
    required this.enableWidget,
    required this.onTap,
    required this.onLongTap,
    required this.bgColor,
    this.ensureEnableRef,
    this.isDisableTwoElementAnimated = false,
    this.borderColor,
    this.disableWidget,
    this.onTapPopover,
    this.popupWidget,
  });
}