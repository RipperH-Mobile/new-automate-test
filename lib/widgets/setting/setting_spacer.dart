import 'package:flutter/material.dart';
import 'package:uchat/utils/dimensions.dart';

class SettingSpacer extends StatelessWidget {
  final double? height;
  const SettingSpacer({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height ?? 20.0.hr);
  }
}
