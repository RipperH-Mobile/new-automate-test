import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:uchat/widgets/effect/blur_box.dart';

class VideoDurationText extends StatelessWidget {
  final int durationMs;
  final EdgeInsets? outerPadding;
  final EdgeInsets? textPadding;
  final double? blurWeight;
  final double? borderRadius;

  const VideoDurationText({
    super.key,
    required this.durationMs,
    this.outerPadding,
    this.textPadding,
    this.blurWeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding != null ? outerPadding! : EdgeInsets.all(Get.height / 166.5),
      child: Container(
        // blurBox(
        // blurWeight: blurWeight != null ? blurWeight! : Get.height / 186.4,
        // borderRadius: BorderRadius.circular(
        //     borderRadius != null ? borderRadius! : Get.height / 166.5),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .5),
          borderRadius: BorderRadius.circular(borderRadius != null ? borderRadius! : Get.height / 166.5),
        ),
        child: Padding(
          padding: textPadding != null
              ? textPadding!
              : EdgeInsets.symmetric(
                  horizontal: Get.height / 166.5,
                  vertical: Get.height / 233,
                ),
          child: Text(
            durationText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.spMin,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }

  String get durationText {
    final duration = Duration(
      milliseconds: durationMs,
    );

    if (duration.inMinutes >= 60) {
      // show in format 00:00:00 (hh:mm:ss)
      return duration.toString().split('.').first.padLeft(8, '0');
    } else {
      // show in format 00:00 (mm:ss)
      return duration.toString().split('.').first.substring(2);
    }
  }
}
