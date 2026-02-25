import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:uchat/widgets/effect/blur_box.dart';

class VideoPlayIcon extends StatelessWidget {
  final double? height;
  final double? width;
  final double? iconSize;

  const VideoPlayIcon({
    super.key,
    this.height,
    this.width,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? Get.height / 25,
      height: height ?? Get.height / 25,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: .5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.play_arrow_rounded,
            size: iconSize ?? 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
