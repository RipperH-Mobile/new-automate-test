import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailMenu extends StatelessWidget {
  final String title;
  final bool hasBottomDivider;
  final bool showArrow;
  final String? description;
  final Widget? icon;
  final Function onTap;
  final String? mediaCount;
  final bool isPhotoAndVideo;
  final String? photoCount;
  final String? videoCount;
  final String? roomName;
  final Color? textColor;

  const ChatRoomDetailMenu({
    super.key,
    required this.title,
    this.hasBottomDivider = false,
    this.showArrow = false,
    this.description,
    this.icon,
    required this.onTap,
    this.mediaCount,
    this.isPhotoAndVideo = false,
    this.photoCount,
    this.videoCount,
    this.roomName,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: Get.width,
        // height: 48.spMin,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpace.space3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: AppSpace.space4,
                        ),
                        Center(child: icon ?? const SizedBox()),
                        SizedBox(
                          width: icon != null ? AppSpace.space4 : AppSpace.space0,
                        ),
                        AppText.body1(
                          title.tr,
                          context: context,
                          // color: textRed == true ? context.theme.appColors.textError : context.theme.appColors.textDark,
                          color: textColor ?? context.theme.appColors.textDarkest,
                        ),
                        if (roomName != null)
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(left: AppSpace.space2),
                              child: AppText.body1(
                                roomName!,
                                context: context,
                                color: textColor,
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  isPhotoAndVideo == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText.body1(
                              mediaCount ?? '',
                              context: context,
                              color: context.theme.appColors.textLight,
                            ),
                            SizedBox(
                              width: 8.spMin,
                            ),
                            AppText.body1(
                              description?.tr ?? '',
                              context: context,
                              color: context.theme.appColors.textLight,
                            ),
                            Assets.vectors.arrowForwardIos.svg(
                              width: AppSpace.space6,
                              colorFilter: ColorFilter.mode(
                                context.theme.appColors.iconLighter,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              width: AppSpace.space4,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AppText.body1(
                              '@photoCount photos, @videoCount videos'.trParams(
                                {
                                  'photoCount': photoCount ?? '',
                                  'videoCount': videoCount ?? '',
                                },
                              ),
                              context: context,
                              color: context.theme.appColors.textLight,
                            ),
                            Assets.vectors.arrowForwardIos.svg(
                              width: AppSpace.space6,
                              colorFilter: ColorFilter.mode(
                                context.theme.appColors.iconLighter,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(
                              width: AppSpace.space4,
                            ),
                          ],
                        ),
                ],
              ),
            ),
            hasBottomDivider == true
                ? Padding(
                    padding: EdgeInsets.only(
                      left: icon != null ? AppSpace.space8 + 24 : AppSpace.space4,
                    ), // 24 is icon size
                    child: Container(
                      height: 1,
                      color: context.theme.appColors.border,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
