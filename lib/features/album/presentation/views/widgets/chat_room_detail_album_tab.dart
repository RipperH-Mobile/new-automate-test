import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_error_image_box.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

/// Album tab in chat room detail.
/// [previewAlbum] is the data used to display first few album cover, album name and image count in album of this room.
/// [albumCount] is how many album are there in this room. This is used in the grey text.
/// [onTap] is what to do after tapping anywhere in this widget.
/// [enable] is enable tapping and showing preview album or not.
class ChatRoomDetailAlbumTab extends StatelessWidget {
  final List<AlbumEntity> previewAlbum;
  final int albumCount;
  final Function onTap;
  final bool enable;

  const ChatRoomDetailAlbumTab({
    super.key,
    required this.previewAlbum,
    required this.albumCount,
    required this.onTap,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (enable) {
          onTap();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
          color: context.theme.appColors.backgroundNeutralLightest,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.space3),

              /// Album tab row. This include icon, album text, album count text and arrow icon.
              child: Row(
                children: [
                  const SizedBox(
                    width: AppSpace.space4,
                  ),
                  Center(
                    child: Assets.vectors.iconRoomDetailAlbumTab.svg(
                      colorFilter: ColorFilter.mode(
                        enable ? context.theme.appColors.icon : context.theme.appColors.textLightest,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: AppSpace.space4,
                  ),
                  Expanded(
                    child: AppText.body1(
                      'Album'.tr,
                      color: enable ? context.theme.appColors.textDarkest : context.theme.appColors.textLightest,
                      context: context,
                    ),
                  ),
                  if (albumCount > 0 && enable)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space1),
                      child: AppText.body1(
                        '@count albums'.trParams({
                          'count': albumCount.toString(),
                        }),
                        color: context.theme.appColors.textLighter,
                        context: context,
                      ),
                    ),
                  Assets.vectors.arrowForwardIos.svg(
                    width: AppSpace.space6,
                    colorFilter: ColorFilter.mode(
                      enable ? context.theme.appColors.iconLighter : context.theme.appColors.iconDisable,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    width: AppSpace.space4,
                  ),
                ],
              ),
            ),

            /// Preview album area
            if (previewAlbum.isNotEmpty == true && enable) ...[
              /// Divider for preview album
              Padding(
                padding: const EdgeInsets.only(left: AppSpace.space8 + 24), // 24 is icon size
                child: Container(
                  height: 1,
                  color: context.theme.appColors.border,
                ),
              ),
              Container(
                /// 90 is the size of cover in Design. space4 * 2 is the size of padding on top and bottom.
                /// height is needed to be specific here because otherwise ListView will throw hasSize error.
                height: 90.spMin + AppSpace.space4 * 2,
                padding: const EdgeInsets.only(
                  top: AppSpace.space4,
                  bottom: AppSpace.space4,
                ),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: AppSpace.space4),
                  itemCount: previewAlbum.length,
                  itemBuilder: (BuildContext context, int index) {
                    final album = previewAlbum[index];

                    /// 172.spMin and 90.spMin come from Design.
                    final itemWidth = 172.spMin;
                    final itemHeight = 90.spMin;

                    return ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                        ),
                        child: Stack(
                          children: [
                            /// Album cover.
                            if (album.imageCoverPath.isEmpty)
                              SizedBox(
                                width: itemWidth,
                                height: itemHeight,
                                child: Center(
                                  child: AppText.body4Bold(
                                    'No items'.tr,
                                    color: context.theme.appColors.textLight,
                                    context: context,
                                  ),
                                ),
                              )
                            else
                              UChatImage.network(
                                album.imageCoverPath,
                                fit: BoxFit.cover,
                                width: itemWidth,
                                height: itemHeight,
                                customErrorWidget: (state) {
                                  return const AlbumErrorImageBox();
                                },
                              ),

                            /// Black gradient on top of album cover.
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: const Alignment(0, 1),
                                  end: const Alignment(0.00, -1.00),
                                  colors: [
                                    Colors.black.withValues(alpha: 0.8),
                                    Colors.black.withValues(alpha: 0),
                                  ],
                                ),
                              ),
                              width: itemWidth,
                              height: itemHeight,
                            ),

                            /// Album name and how many image in this album.
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SizedBox(
                                width: itemWidth,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: AppSpace.space3,
                                    right: AppSpace.space3,
                                    bottom: AppSpace.space2,
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: AppText.caption1Bold(
                                          album.albumName ?? '',
                                          color: Colors.white,
                                          textOverflow: TextOverflow.ellipsis,
                                          context: context,
                                          strutStyle: const StrutStyle(height: 1.5),
                                        ),
                                      ),
                                      AppText.caption1(
                                        ' ${album.totalImages.toString()}',
                                        color: Colors.white,
                                        context: context,
                                        strutStyle: const StrutStyle(height: 1.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: AppSpace.space2,
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
