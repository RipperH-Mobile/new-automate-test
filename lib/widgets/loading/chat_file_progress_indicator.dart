import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';

class ChatFileProgressIndicator extends StatelessWidget {
  final void Function()? onTap;
  final double progress;
  final bool showStopIcon;
  final double stopIconSize;
  final double? indicatorRadius;
  final double? sizeBox;
  final double outerLineWidth;
  final double innerLineWidth;
  final bool isInfiniteLoading;
  final Color? backgroundColor;
  final bool isShowBackgroundStopIcon;
  final Widget? stopIcon;

  const ChatFileProgressIndicator({
    super.key,
    this.onTap,
    this.progress = 0,
    this.showStopIcon = true,
    this.stopIconSize = 40,
    this.outerLineWidth = 4.5,
    this.innerLineWidth = 3.5,
    this.indicatorRadius,
    this.sizeBox,
    this.isInfiniteLoading = false,
    this.backgroundColor,
    this.isShowBackgroundStopIcon = false,
    this.stopIcon,
  });

  @override
  Widget build(BuildContext context) {
    if (progress >= 1) return const SizedBox.shrink();
    if (isInfiniteLoading && progress < 1 && onTap == null) {
      return CircularPercentIndicator(
        animationDuration: 250,
        radius: indicatorRadius ?? 25.spMin,
        lineWidth: outerLineWidth,
        animation: true,
        animateFromLastPercent: true,
        percent: 0.0,
        progressColor: Colors.white,
        backgroundColor: backgroundColor ?? Colors.transparent,
        circularStrokeCap: CircularStrokeCap.round,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0),
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (progress < 1 && onTap != null)
              Center(
                child: Container(
                  height: (indicatorRadius ?? 13.spMin) * 2,
                  width: (indicatorRadius ?? 13.spMin) * 2,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.theme.appColors.borderProgress,
                      width: innerLineWidth,
                    ),
                  ),
                  child: showStopIcon ? _buildDefaultStopButton(context) : null,
                ),
              ),
            if (isInfiniteLoading)
              _buildInfiniteLoading()
            else
              CircularPercentIndicator(
                animationDuration: 250,
                radius: indicatorRadius ?? 25.spMin,
                lineWidth: outerLineWidth,
                animation: true,
                animateFromLastPercent: true,
                percent: progress,
                progressColor: Colors.white,
                backgroundColor: backgroundColor ?? Colors.transparent,
                circularStrokeCap: CircularStrokeCap.round,
              )
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultStopButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpace.space2),
      decoration: BoxDecoration(
        color: isShowBackgroundStopIcon ? Colors.white : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: context.theme.appColors.borderProgress,
          width: innerLineWidth - 2.8,
        ),
      ),
      child: stopIcon ??
          Assets.vectors.stop.svg(
            height: AppSize.size3,
            width: AppSize.size3,
          ),
    );
  }

  Widget _buildInfiniteLoading() {
    return SizedBox(
      height: (indicatorRadius ?? 13.spMin) * 2,
      width: (indicatorRadius ?? 13.spMin) * 2,
      child: CircularProgressIndicator(
        strokeWidth: outerLineWidth,
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
