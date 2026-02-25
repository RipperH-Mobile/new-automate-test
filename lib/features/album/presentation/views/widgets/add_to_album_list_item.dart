import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

class AddToAlbumListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? albumCoverUrl;
  final bool isCreateNewAlbum;

  const AddToAlbumListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.albumCoverUrl,
    this.isCreateNewAlbum = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpace.space4),
      child: Row(
        children: [
          Container(
            width: 72.spMin,
            height: 72.spMin,
            decoration: BoxDecoration(
              color: context.theme.appColors.backgroundNeutralLight,
              borderRadius: BorderRadius.circular(AppRadius.roundedLg),
            ),
            child: albumCoverUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.roundedLg),
                    child: UChatImage.network(
                      albumCoverUrl!,
                      width: 72.spMin,
                      height: 72.spMin,
                      fit: BoxFit.cover,
                    ),
                  )
                : Center(
                    child: isCreateNewAlbum
                        ? Assets.vectors.iconAdd24.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.iconLight, BlendMode.srcIn),
                          )
                        : Assets.vectors.iconPhotoSolid.svg(
                            colorFilter: ColorFilter.mode(context.theme.appColors.iconDisable, BlendMode.srcIn),
                          ),
                  ),
          ),
          const SizedBox(width: AppSpace.space4),
          Expanded(
            child: Container(
              /// AppSpace.space3 * 2 is top and bottom space.
              height: 72.spMin + AppSpace.space3 * 2,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: context.theme.appColors.border,
                  ),
                ),
              ),
              padding: const EdgeInsets.only(right: AppSpace.space4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.title3(
                    title,
                    color: context.theme.appColors.textDarkest,
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    context: context,
                  ),
                  if (subtitle != null)
                    AppText.body3(
                      subtitle!,
                      color: context.theme.appColors.textDark,
                      context: context,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
