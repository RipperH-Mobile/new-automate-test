import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/data/models/models/album_task_type.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_error_image_box.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/album_grid_delegate.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';

class ChatRoomDetailAlbumListItem extends StatelessWidget {
  /// Data to display album in ui.
  final AlbumEntity album;

  /// onTap on anywhere on this list item.
  final Function onTap;

  /// onTap on pop over button.
  final Function(bool) onAddItemsPressed;
  final Function onRenamePressed;
  final Function onDownloadAlbumPressed;
  final Function onDeletePressed;

  /// Whether to show uploading / downloading ui.
  final bool showLoading;

  /// Task type. Used to show different icon.
  final AlbumTaskType? type;

  /// Task status. Used to show different icon.
  final AlbumTaskStatus? status;

  /// Text to show when [showLoading] is true.
  final String? loadingText;

  /// Number progress to show when [showLoading] is true.
  final int? currentProgress;

  /// Max progress to show when [showLoading] is true.
  final int? maxProgress;

  /// Function to call when cancel / retry icon is tap when [showLoading] is true.
  final Function? onProgressPressed;

  final Animation<double>? animation;

  final bool isDisableAlbumMenu;

  const ChatRoomDetailAlbumListItem({
    super.key,
    required this.album,
    required this.onTap,
    required this.onAddItemsPressed,
    required this.onRenamePressed,
    required this.onDownloadAlbumPressed,
    required this.onDeletePressed,
    this.showLoading = false,
    this.type,
    this.status,
    this.loadingText,
    this.currentProgress,
    this.maxProgress,
    this.onProgressPressed,
    this.animation,
    this.isDisableAlbumMenu = false,
  });

  /// Size of preview images of an album.
  /// AppSpace.space4 is the padding on the left and right side.
  /// imageSize come from width of the screen minus padding on both side and then divide by 2 because
  /// From design there should be two image on the screen.
  double get _imageSize => (Get.width - (AppSpace.space4 * 2)) / 2;

  int get previewCount => min(album.totalImages ?? 0, 10);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  if (previewCount > 0)
                    SizedBox(
                      /// GridView height is the size of preview image * 2 because there is two rows of preview image
                      /// and [AppSpace.space05] is spacing between row
                      height: _imageSize * 2 + AppSpace.space05,
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                        scrollDirection: Axis.horizontal,
                        gridDelegate: AlbumGridDelegate(
                          itemSize: _imageSize,
                          spacing: AppSpace.space05,
                          itemCount: previewCount,
                        ),
                        itemCount: previewCount,
                        itemBuilder: (BuildContext context, int index) {
                          bool hasTopLeftRadius = false;
                          bool hasBottomLeftRadius = false;
                          bool hasTopRightRadius = false;
                          bool hasBottomRightRadius = false;

                          hasTopLeftRadius = index == 0;
                          hasBottomRightRadius = index == previewCount - 1;
                          if (previewCount == 1) {
                            hasBottomLeftRadius = true;
                            hasTopRightRadius = true;
                          } else if (previewCount == 2) {
                            hasBottomLeftRadius = index == 0;
                            hasTopRightRadius = index == 1;
                          } else {
                            hasBottomLeftRadius = previewCount - index == previewCount - 1;
                            if (previewCount % 2 == 0) {
                              hasTopRightRadius = index == previewCount - 2;
                            } else {
                              hasTopRightRadius = index == previewCount - 1;
                            }
                          }
                          return ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: hasTopLeftRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
                              bottomLeft:
                                  hasBottomLeftRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
                              topRight: hasTopRightRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
                              bottomRight:
                                  hasBottomRightRadius ? const Radius.circular(AppRadius.roundedXl) : Radius.zero,
                            ),
                            child: album.lastTenImageInAlbum == null
                                ? const AlbumErrorImageBox()
                                : UChatImage.network(
                                    /// previewCount - 1 - index is to reverse list because in the data from server (and the data
                                    /// saved in local) index 0 is the oldest image. But the newest image have to be shown first.
                                    album.lastTenImageInAlbum![previewCount - 1 - index].imageUrl ?? '',
                                    fit: BoxFit.cover,
                                  ),
                          );
                        },
                      ),
                    )
                  else
                    Center(
                      child: Container(
                        height: _imageSize * 2 + AppSpace.space05,
                        width: _imageSize * 2 + AppSpace.space05,
                        decoration: BoxDecoration(
                          color: context.theme.appColors.backgroundNeutralLightPressed,
                          borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.body1(
                              'No items'.tr,
                              context: context,
                            ),
                            const SizedBox(
                              height: AppSpace.space2,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: context.theme.appColors.backgroundGrayLightPressed,
                                borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  onAddItemsPressed(false);
                                },
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpace.space4,
                                    vertical: AppSpace.space2,
                                  ),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: AppText.body4Bold(
                                  'Add items'.tr,
                                  color: context.theme.appColors.textPrimaryInverse,
                                  context: context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (showLoading)
                AnimatedOpacity(
                  /// Animate opacity to make status completed ui fade out.
                  opacity: status != AlbumTaskStatus.completed ? 1 : 0,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeInQuint,
                  child: GestureDetector(
                    onTap: () {
                      if (onProgressPressed != null) {
                        onProgressPressed!();
                      }
                    },
                    child: Container(
                      /// Container height is the size of preview image * 2 because there is two rows of preview image
                      /// and [AppSpace.space05] is spacing between row
                      height: _imageSize * 2 + AppSpace.space05,
                      width: Get.width,
                      margin: previewCount <= 4
                          ? const EdgeInsets.symmetric(horizontal: AppSpace.space4)
                          : const EdgeInsets.only(left: AppSpace.space4),
                      decoration: BoxDecoration(
                        color: context.theme.appColors.blanket,
                        borderRadius: previewCount <= 4
                            ? BorderRadius.circular(AppRadius.roundedXl)
                            : const BorderRadius.horizontal(
                                left: Radius.circular(AppRadius.roundedXl),
                                right: Radius.circular(AppRadius.roundedXl),
                              ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 56.spMin,
                            height: 56.spMin,
                            child: Stack(
                              children: [
                                Center(
                                  child: _ProgressIcon(
                                    type: type,
                                    status: status,
                                    animation: animation,
                                  ),
                                ),
                                SizedBox(
                                  width: 56.spMin,
                                  height: 56.spMin,
                                  child: CircularProgressIndicator(
                                    color: context.theme.appColors.borderLighter,
                                    value: currentProgress != null && maxProgress != null
                                        ? currentProgress! / (maxProgress! >= 1 ? maxProgress! : 1)
                                        : null,
                                    strokeWidth: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppText.title3(
                            /// Hide current progress and max progress text when status is success.
                            status == AlbumTaskStatus.completed
                                ? '$loadingText'
                                : '$loadingText $currentProgress/$maxProgress',
                            color: context.theme.appColors.textPrimaryInverse,
                            context: context,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          ColoredBox(
            // This container and color make the empty space between album name and album more button pressable.
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space4,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppSpace.space3,
                  top: AppSpace.space2,
                  bottom: AppSpace.space2,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.title2(
                            album.albumName ?? '',
                            textOverflow: TextOverflow.ellipsis,
                            context: context,
                          ),
                          AppText.body3(
                            '@count photos'.trParams({
                              'count': (album.totalImages ?? 0).toString(),
                            }),
                            context: context,
                          ),
                        ],
                      ),
                    ),
                    AlbumMoreButton(
                      isDisableAlbumMenu: isDisableAlbumMenu,
                      onRenamePressed: onRenamePressed,
                      onAddItemsPressed: () {
                        onAddItemsPressed(true);
                      },
                      onDownloadAlbumPressed: onDownloadAlbumPressed,
                      onDeletePressed: onDeletePressed,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// Separate this code into a widget because this way will make popover context work correctly.
class AlbumMoreButton extends StatelessWidget {
  final Function onRenamePressed;
  final Function onAddItemsPressed;
  final Function onDownloadAlbumPressed;
  final Function onDeletePressed;
  final bool isDisableAlbumMenu;

  const AlbumMoreButton({
    super.key,
    required this.onRenamePressed,
    required this.onAddItemsPressed,
    required this.onDownloadAlbumPressed,
    required this.onDeletePressed,
    this.isDisableAlbumMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        UChatPopover.open(
          context: context,
          // -160 come from trial and error. don't know how contentDxOffset work.
          contentDxOffset: -160.spMin,
          width: Get.width / 2,
          menu: [
            if (isDisableAlbumMenu == false)
              PopoverMenuItem(
                hasBottomDivider: true,
                onPressed: (_) async {
                  onRenamePressed();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.body1(
                      'Rename'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                    Assets.vectors.iconPencil.svg(
                      colorFilter: ColorFilter.mode(
                        context.theme.appColors.icon,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            if (isDisableAlbumMenu == false)
              PopoverMenuItem(
                hasBottomDivider: true,
                onPressed: (_) async {
                  onAddItemsPressed();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.body1(
                      'Add items'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                    Assets.vectors.iconPhotoSolid.svg(
                      colorFilter: ColorFilter.mode(
                        context.theme.appColors.icon,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            PopoverMenuItem(
              hasBottomDivider: true,
              onPressed: (_) async {
                onDownloadAlbumPressed();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.body1(
                    'Download album'.tr,
                    color: context.theme.appColors.textDarkest,
                    context: context,
                  ),
                  Assets.vectors.iconDownload.svg(
                    colorFilter: ColorFilter.mode(
                      context.theme.appColors.icon,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
            if (isDisableAlbumMenu == false)
              PopoverMenuItem(
                hasBottomDivider: true,
                onPressed: (_) async {
                  onDeletePressed();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.body1(
                      'Delete'.tr,
                      color: context.theme.appColors.textError,
                      context: context,
                    ),
                    Assets.vectors.iconTrash.svg(
                      colorFilter: ColorFilter.mode(
                        context.theme.appColors.iconError,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
      child: Container(
        color: Colors.transparent,
        // This container and color make the padding area pressable. This is for bigger button area for easier tap.
        padding: const EdgeInsets.symmetric(vertical: AppSpace.space2, horizontal: AppSpace.space3),
        child: Assets.vectors.iconMoreHorizontalCircle.svg(),
      ),
    );
  }
}

class _ProgressIcon extends StatelessWidget {
  final AlbumTaskType? type;
  final AlbumTaskStatus? status;
  final Animation<double>? animation;

  const _ProgressIcon({
    this.type,
    this.status,
    this.animation,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (status) {
      case AlbumTaskStatus.completed:
        child = Assets.vectors.iconAlbumSuccess.svg(
          key: const ValueKey('album_status_completed'),
        );
      case AlbumTaskStatus.inProgress:
        child = Assets.vectors.iconAlbumCancel.svg(
          key: const ValueKey('album_status_in_progress'),
        );
      case AlbumTaskStatus.failed:
        child = Assets.vectors.iconAlbumRetry.svg(
          key: const ValueKey('album_status_failed'),
        );
      default:
        child = const SizedBox();
    }
    if (animation == null) return child;

    /// This animation is used to shake a failed status icon.
    return AnimatedBuilder(
      animation: animation!,
      child: child,
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          // space6 is the distance of left / right shake.
          offset: Offset(AppSpace.space6 * calculateShake(animation!.value), 0),
          child: child,
        );
      },
    );
  }

  /// convert 0-1 to 0-1-0
  /// https://stackoverflow.com/a/68449136
  double calculateShake(double value) {
    return (2 * (0.5 - (0.5 - Curves.bounceOut.transform(value)).abs()));
  }
}
