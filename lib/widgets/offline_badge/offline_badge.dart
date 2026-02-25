import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/utils/extension/extension_number.dart';
import 'package:uchat/widgets/app_text.dart';

class OfflineBadge extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? bgBoxColor;
  final Color? iconColor;
  final Color? bgColor;
  final double? boxRadius;
  final double? bgHeight;
  final double? bgWidth;
  final double? iconSize;
  final TextStyle? textStyle;
  final MainAxisAlignment? mainAxisAlignment;
  final bool? isConnecting;
  final bool? isRoomList;
  final Function()? onPressed;
  final bool isFitSize;
  final bool? isChatRoom;

  const OfflineBadge({
    super.key,
    this.padding,
    this.margin,
    this.bgBoxColor,
    this.iconColor,
    this.bgColor,
    this.boxRadius,
    this.bgHeight,
    this.bgWidth,
    this.iconSize,
    this.textStyle,
    this.mainAxisAlignment,
    this.isConnecting,
    this.isRoomList,
    this.onPressed,
    this.isFitSize = false,
    this.isChatRoom = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = buildWidget(context);
    if (isFitSize) {
      child = IntrinsicWidth(
        child: child,
      );
    }
    double? customBgHeight = bgHeight;
    if (customBgHeight == null) {
      if (GetPlatform.isMacOS) {
        customBgHeight ??= 45.spMin;
      }

      if (GetPlatform.isWindows) {
        customBgHeight ??= 45.spMin;
      }

      if (GetPlatform.isAndroid) {
        customBgHeight ??= 50.spMin;
      }

      if (GetPlatform.isIOS) {
        customBgHeight ??= 50.spMin;
      }
    }

    return Container(
      height: customBgHeight ?? 64,
      width: isFitSize ? null : (bgWidth ?? Get.width),
      color: bgColor ?? Colors.white,
      margin: margin ?? EdgeInsets.zero,
      padding: padding ??
          EdgeInsets.only(
            left: 10.spMin,
            right: 10.spMin,
            top: 2.spMin,
            bottom: 2.spMin,
          ),
      child: child,
    );
  }

  Widget buildWidget(BuildContext context) {
    return Container(
      padding: (isRoomList ?? true)
          ? EdgeInsets.only(left: 20.spMin, right: 11.spMin)
          : (isConnecting ?? false)
              ? EdgeInsets.only(left: 10.spMin)
              : null,
      decoration: BoxDecoration(
        color: bgBoxColor ?? const Color(0xff292929),
        borderRadius: BorderRadius.all(Radius.circular(boxRadius ?? 12)),
      ),
      child: Padding(
        padding: isFitSize ? EdgeInsets.symmetric(horizontal: 8.0.spMin) : EdgeInsets.zero,
        child: isConnecting ?? false
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Connecting...'.tr,
                    style: textStyle ??
                        const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (isChatRoom ?? false) SizedBox(width: 20.spMin),
                  Container(
                    margin: EdgeInsets.only(right: 10.spMin),
                    height: 25.spMin,
                    width: 25.spMin,
                    child: const CircularProgressIndicator(
                      color: Colors.amber,
                      strokeWidth: 3.5,
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          (isRoomList ?? true)
                              ? 'assets/images/offline_small_moon.png'
                              : 'assets/images/chat_room_moon.png',
                          height: iconSize ?? 20.spMin,
                          width: iconSize ?? 20.spMin,
                          cacheWidth: iconSize?.cacheSize ?? 20.spMin.cacheSize,
                        ),
                        SizedBox(width: 10.spMin),
                        Expanded(
                          child: AppText.body3Bold(
                            (isRoomList ?? true) ? 'Unable to connect to the network'.tr : 'You\'re on offline mode'.tr,
                            context: context,
                            textOverflow: TextOverflow.ellipsis,
                            color: context.theme.appColors.textPrimaryInverse,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isRoomList ?? true,
                    child: GestureDetector(
                      onTap: onPressed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpace.space015,
                          horizontal: AppSpace.space3,
                        ),
                        decoration: BoxDecoration(
                          color: context.theme.appColors.backgroundNeutralLightestPressed,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSpace.space3),
                          ),
                        ),
                        child: AppText.body3Bold(
                          'Try again'.tr,
                          context: context,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
