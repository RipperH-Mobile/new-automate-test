import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/sanitize_thai_text.dart';
import 'package:uchat/utils/uchat_utils.dart';
import 'package:uchat/widgets/app_text.dart';

class RoomDetailProfileSection extends StatelessWidget {
  final String roomName;
  final bool isShowSubTitle;
  final Widget? roomAvatar;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final int? subTitleMaxLines;
  final bool isShowCopyIcon;
  final bool isOfficialAccount;
  final bool isSystem;

  const RoomDetailProfileSection({
    super.key,
    required this.roomName,
    required this.isShowSubTitle,
    this.roomAvatar,
    this.subTitle,
    this.subTitleStyle,
    this.subTitleMaxLines,
    this.isShowCopyIcon = false,
    this.isOfficialAccount = false,
    this.isSystem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: Get.width,
      constraints: BoxConstraints(minHeight: isSystem ? 196.spMin : 220.spMin),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.spMin, vertical: 20.spMin),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfileImage(),
                  ],
                ),
                SizedBox(height: 15.spMin),
                _buildRoomName(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage() {
    return Expanded(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Builder(
            builder: (_) {
              return roomAvatar ?? const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRoomName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ClipRect(
                  child: Padding(
                    padding: EdgeInsets.only(top: AppSpace.spacePx, right: AppSpace.spacePx, bottom: 0.5.spMin),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isOfficialAccount)
                          Container(
                            margin: const EdgeInsets.only(
                              top: AppSpace.spacePx,
                              right: AppSpace.space1,
                            ),
                            child: Assets.vectors.oaIconBlue.svg(
                              width: AppSpace.space4,
                              height: AppSpace.space4,
                            ),
                          ),
                        Expanded(
                          child: AppText.heading4(
                            context: context,
                            sanitizeThaiText(roomName),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (subTitle != null && isShowSubTitle) ...[
            SizedBox(height: 5.spMin),
            GestureDetector(
              onTap: () => UChatUtils.instance.copyToClipboard(subTitle ?? ''),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: AppText.heading4(
                      context: context,
                      subTitle ?? '',
                      color: context.theme.appColors.textDarkest.withValues(alpha: 0.5),
                      maxLines: subTitleMaxLines ?? 2,
                      textAlign: TextAlign.center,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (isShowCopyIcon) ...[
                    SizedBox(width: 5.spMin),
                    Icon(
                      Icons.copy_rounded,
                      color: Colors.grey.shade600,
                      size: 16.spMin,
                    ),
                  ]
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}
