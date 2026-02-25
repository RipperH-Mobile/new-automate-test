import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_primary_button.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/data/models/models/album_task_status.dart';
import 'package:uchat/features/album/domain/entities/album_image_entity.dart';
import 'package:uchat/features/album/domain/entities/album_task_entity.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_error_image_box.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_loading_toast.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_image_list_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/popover_menu/uchat_popover.dart';
import 'package:uchat/widgets/popover_menu/widgets/pop_over_menu_item.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ChatRoomDetailAlbumImageListScreen extends GetView<ChatRoomDetailAlbumImageListController> {
  final String controllerTag;

  @override
  String? get tag => controllerTag;

  const ChatRoomDetailAlbumImageListScreen({
    super.key,
    required this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: ChatRoomDetailAlbumAppBar(
          title: controller.isMultiSelecting()
              ? '@count items Selected'.trParams({
                  'count': controller.selectedImages.length.toString(),
                })
              : controller.album()?.albumName ?? '',
          subtitle: controller.isMultiSelecting()
              ? null
              : '@count photos'.trParams({
                  'count': controller.album()?.totalImages.toString() ?? '0',
                }),
          onLeadingPressed: controller.onBackPressed,
          actions: [
            if (controller.isMultiSelecting())
              Padding(
                padding: const EdgeInsets.only(right: AppSpace.space4),
                child: TextButton(
                  onPressed: controller.handleSelectAllOrClearAllPressed,
                  child: AppText.button1Bold(
                    controller.selectedImages.length ==
                            min(controller.album()?.totalImages ?? 0, UChatConstant.albumUploadLimit)
                        ? 'Clear all'.tr
                        : 'Select all'.tr,
                    color: context.theme.appColors.textPrimary,
                    context: context,
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: AppSpace.space4),
                child: _AlbumAppbarMoreButton(
                  isDisableAlbumMenu: controller.isDisableAlbumMenu,
                  onSelectPressed: () {
                    Get.back();
                    controller.handleStartSelect(context);
                  },
                  onAddItemsPressed: () {
                    controller.openAddItemToAlbumBottomSheet(context, openFromPopOver: true);
                  },
                  onRenamePressed: () {
                    controller.openRenameScreen(context);
                  },
                  onDownloadAlbumPressed: () {
                    controller.downloadAlbum(context);
                  },
                  onDeletePressed: () {
                    controller.deleteAlbum(context);
                  },
                ),
              ),
          ],
        ),
        child: Stack(
          children: [
            _AlbumImageGrid(
              controllerTag: controllerTag,
            ),
            _BottomRow(
              isDisableAlbumMenu: controller.isDisableAlbumMenu,
              isMultiSelecting: controller.isMultiSelecting(),
              albumName: controller.album()?.albumName ?? '',
              onDeletePressed: () {
                controller.deleteSelectedImages(context);
              },
              onSharePressed: () {
                controller.shareSelectedImages();
              },
              onDownloadPressed: () {
                controller.downloadImages(context);
              },
              onAddImagePressed: () {
                controller.openAddItemToAlbumBottomSheet(context);
              },
              onUndoPressed: () {
                controller.cancelCurrentTask(context);
              },
              task: controller.albumTask(),
            ),
          ],
        ),
      );
    });
  }
}

/// Separate this code into a widget because this way will make popover context work correctly.
class _AlbumAppbarMoreButton extends StatelessWidget {
  final Function onSelectPressed;
  final Function onRenamePressed;
  final Function onAddItemsPressed;
  final Function onDownloadAlbumPressed;
  final Function onDeletePressed;
  final bool isDisableAlbumMenu;

  const _AlbumAppbarMoreButton({
    required this.onSelectPressed,
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

          /// -186 come from trial and error. don't know how contentDxOffset work.
          contentDxOffset: -186.spMin,
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
                  onSelectPressed();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText.body1(
                      'Select'.tr,
                      color: context.theme.appColors.textDarkest,
                      context: context,
                    ),
                    Assets.vectors.iconCheckCircle.svg(
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
      child: Assets.vectors.iconMoreHorizontalCircle.svg(),
    );
  }
}

class _AddImageButton extends StatelessWidget {
  final Function onPressed;

  const _AddImageButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: context.theme.appGradientColors.gradientBlue,
          ),
          shape: BoxShape.circle,
        ),
        width: 72.spMin,
        height: 72.spMin,
        child: Center(
          child: Assets.vectors.iconAdd24.svg(
            colorFilter: ColorFilter.mode(
              context.theme.appColors.iconInverse,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

class _MultiSelectButtonRow extends StatelessWidget {
  final Function onDeletePressed;
  final Function onSharePressed;
  final Function onDownloadPressed;
  final bool isDisableAlbumMenu;

  const _MultiSelectButtonRow({
    required this.onDeletePressed,
    required this.onSharePressed,
    required this.onDownloadPressed,
    this.isDisableAlbumMenu = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundNeutralLighter,
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      child: Padding(
        // Cover safe area with this container's background color.
        padding: EdgeInsets.only(
          bottom: Get.mediaQuery.padding.bottom,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (isDisableAlbumMenu == false)
              IconButton(
                onPressed: () {
                  onDeletePressed();
                },
                icon: Assets.vectors.iconTrash.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.iconError,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            IconButton(
              onPressed: () {
                onSharePressed();
              },
              icon: Assets.vectors.iconShare.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.icon,
                  BlendMode.srcIn,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                onDownloadPressed();
              },
              icon: Assets.vectors.iconDownload.svg(
                colorFilter: ColorFilter.mode(
                  context.theme.appColors.icon,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AlbumImageGrid extends GetView<ChatRoomDetailAlbumImageListController> {
  final String controllerTag;

  @override
  String? get tag => controllerTag;

  const _AlbumImageGrid({required this.controllerTag});

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      pagingController: controller.pagingController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: AppSpace.space05,
        crossAxisSpacing: AppSpace.space05,
      ),
      builderDelegate: PagedChildBuilderDelegate<AlbumImageEntity>(
        itemBuilder: (BuildContext context, AlbumImageEntity item, int index) {
          if (item.imageUrl == null) {
            return const AlbumErrorImageBox();
          }

          int selectedIndex = -1;
          if (controller.isMultiSelecting()) {
            selectedIndex = controller.selectedImages.indexOf(item);
          }

          return Hero(
            tag: item.hero,
            child: GestureDetector(
              onTap: () {
                if (controller.isMultiSelecting()) {
                  controller.handleSelectImage(index);
                } else {
                  controller.openMediaViewer(item);
                }
              },
              onLongPress: () {
                controller.handleLongPressImage(context, item, isDisableAlbumMenu: controller.isDisableAlbumMenu);
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: UChatImage.network(
                      key: ValueKey(item.imageId),
                      item.imageUrl!,
                      fit: BoxFit.cover,
                      customErrorWidget: (state) {
                        return const AlbumErrorImageBox();
                      },
                    ),
                  ),
                  if (controller.isMultiSelecting())
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppSpace.space2, top: AppSpace.space2),
                          child: Container(
                            width: 28.spMin,
                            height: 28.spMin,
                            decoration: BoxDecoration(
                              color: selectedIndex >= 0
                                  ? context.theme.appColors.backgroundPrimary
                                  : context.theme.appColors.neutral32,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.theme.appColors.borderLighter,
                                width: 1,
                              ),
                            ),
                            child: selectedIndex >= 0
                                ? Center(
                                    child: AppText.body3Bold(
                                      '${selectedIndex + 1}',
                                      context: context,
                                      color: context.theme.appColors.textPrimaryInverse,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (BuildContext context) {
          return Column(
            children: [
              Expanded(
                child: _NoImageWidget(
                  onAddItemPressed: () {
                    controller.openAddItemToAlbumBottomSheet(context);
                  },
                ),
              ),

              /// This is the same as the size of App bar.
              /// Because there is app bar taking space on top of this screen and the center of the remaining
              /// space will not be the same as the center of the screen.
              /// So we need to add this space to have the same space on top and bottom making the remaining
              /// space center of the screen.
              const SafeArea(
                child: SizedBox(
                  height: AppSpace.space16,
                ),
              ),
            ],
          );
        },
        firstPageProgressIndicatorBuilder: (BuildContext context) {
          return SizedBox(
            width: Get.width,
            height: Get.height,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: AppSpace.space05,
                crossAxisSpacing: AppSpace.space05,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return ShimmerLoading(
                  enable: true,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white,
                  ),
                );
              },
            ),
          );
        },
        firstPageErrorIndicatorBuilder: (context) {
          return Center(
            child: AppText.body1(
              context: context,
              'This album has been deleted'.tr,
            ),
          );
        },
      ),
    );
  }
}

class _NoImageWidget extends StatelessWidget {
  final Function onAddItemPressed;

  const _NoImageWidget({
    required this.onAddItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppText.heading4(
          'No items'.tr,
          color: context.theme.appColors.textDarkest,
          context: context,
        ),
        const SizedBox(height: AppSpace.space1),
        AppText.body3(
          'Add photos to albums and share them in chat.'.tr,
          color: context.theme.appColors.textLight,
          context: context,
        ),
        const SizedBox(height: AppSpace.space4),
        AppPrimaryButton.roundedL(
          onPressed: () {
            onAddItemPressed();
          },
          buttonText: 'Add items'.tr,
          textColor: context.theme.appColors.textPrimaryInverse,
          buttonColor: context.theme.appColors.backgroundGrayLightPressed,
          padding: const EdgeInsets.symmetric(
            vertical: AppSpace.space2,
            horizontal: AppSpace.space4,
          ),
          mainAxisSize: MainAxisSize.min,
        ),
      ],
    );
  }
}

class _BottomRow extends StatelessWidget {
  final bool isMultiSelecting;
  final String albumName;
  final Function onDeletePressed;
  final Function onSharePressed;
  final Function onDownloadPressed;
  final Function onAddImagePressed;
  final Function onUndoPressed;
  final AlbumTaskEntity? task;
  final bool isDisableAlbumMenu;

  const _BottomRow({
    required this.isMultiSelecting,
    required this.albumName,
    required this.onDeletePressed,
    required this.onSharePressed,
    required this.onDownloadPressed,
    required this.onAddImagePressed,
    required this.onUndoPressed,
    this.task,
    this.isDisableAlbumMenu = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isDisableAlbumMenu == true) {
      return const SizedBox.shrink();
    }

    Widget child;
    // If there are no task or current task has failed don't show loading toast.
    // TODO (album) Improve to show failed toast here for better retry ux in this screen.
    if (task != null && task?.status != AlbumTaskStatus.failed) {
      return AlbumLoadingToast(
        type: task!.type!,
        status: task!.status!,
        albumName: albumName,
        onUndoPressed: () {
          onUndoPressed();
        },
        currentProgress: task?.currentProgress ?? 0,
        maxProgress: task?.totalImages ?? 1,
        isToast: false,
      );
    } else {
      if (isMultiSelecting) {
        child = _MultiSelectButtonRow(
          isDisableAlbumMenu: isDisableAlbumMenu,
          onDeletePressed: onDeletePressed,
          onSharePressed: onSharePressed,
          onDownloadPressed: onDownloadPressed,
        );
      } else {
        child = SafeArea(
          child: _AddImageButton(
            onPressed: onAddImagePressed,
          ),
        );
      }
    }
    return Align(
      alignment: Alignment.bottomCenter,
      child: child,
    );
  }
}
