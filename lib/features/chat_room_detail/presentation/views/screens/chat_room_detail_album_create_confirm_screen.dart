import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/presentation/views/widgets/album_error_image_box.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_create_confirm_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/features/media_gallery/domain/model/media_asset.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/input/app_text_field.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ChatRoomDetailAlbumCreateConfirmScreen extends GetView<ChatRoomDetailAlbumCreateConfirmController> {
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  const ChatRoomDetailAlbumCreateConfirmScreen({
    super.key,
    this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: ChatRoomDetailAlbumAppBar(
        // Change app bar title based on whether user is uploading image to album or creating a new album.
        title: controller.existingAlbumName?.isNotEmpty == true ? 'Album'.tr : 'Create Album'.tr,
        actions: [
          Obx(() {
            return TextButton(
              onPressed: controller.enableAddButton()
                  ? () {
                      controller.handleAddButtonPressed(context);
                    }
                  : null,
              child: AppText.button1Bold(
                'Add'.tr,
                color: controller.enableAddButton()
                    ? context.theme.appColors.textPrimary
                    : context.theme.appColors.textDisable,
                context: context,
              ),
            );
          }),
        ],
      ),
      child: Column(
        children: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.all(AppSpace.space4),
              child: AppTextField.withClear(
                labelText: 'Album Name'.tr,
                hintText:
                    controller.existingAlbumName == null ? 'e.g. Vacation Photos'.tr : controller.existingAlbumName!,
                inputType: TextInputType.text,
                maxLength: 30,
                onChanged: controller.onTextFieldChanged,
                isShowIcon: controller.albumName.isNotEmpty,
                onIconTap: controller.onClearTextField,
                textEditController: controller.textFieldController,
                enable: controller.existingAlbumName == null,
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.only(left: AppSpace.space4),
            child: Row(
              children: [
                Obx(() {
                  return AppText.body3Bold(
                    '${controller.selectedImageCount} ',
                    color: context.theme.appColors.textDarkest,
                    context: context,
                  );
                }),
                AppText.body3(
                  'Photos'.tr,
                  color: context.theme.appColors.textDark,
                  context: context,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSpace.space2,
          ),
          Expanded(
            child: Obx(() {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: AppSpace.space05,
                  crossAxisSpacing: AppSpace.space05,
                ),
                itemCount: controller.selectedImageCount + (controller.enableAddImage() ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0 && controller.enableAddImage()) {
                    return GestureDetector(
                      onTap: () {
                        controller.openGalleryPicker();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.theme.appColors.backgroundNeutralLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Assets.vectors.iconAdd24.svg(
                            colorFilter: ColorFilter.mode(
                              context.theme.appColors.iconLight,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final int realIndex = index - (controller.enableAddImage() ? 1 : 0);

                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      imageItemPreview(context, realIndex),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            controller.removeImage(realIndex, context);
                          },

                          /// This line make padding of the below container tappable.
                          behavior: HitTestBehavior.opaque,

                          /// Padding for easier tapping.
                          child: Container(
                            padding: const EdgeInsets.all(AppSpace.space2),

                            /// Black circle background container.
                            child: Container(
                              decoration: BoxDecoration(
                                color: context.theme.appColors.blanket,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.all(AppSpace.space05),
                              child: Assets.vectors.xClose.svg(
                                colorFilter: ColorFilter.mode(
                                  context.theme.appColors.iconPrimaryInverse,
                                  BlendMode.srcIn,
                                ),
                                width: 14.spMin,
                                height: 14.spMin,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget imageItemPreview(BuildContext context, int index) {
    if (controller.selectedImages.isNotEmpty) {
      final mediaAsset = controller.selectedImages[index];
      final asset = mediaAsset.asset;
      if (mediaAsset.type == MediaType.image) {
        final size = Get.width / 3;
        final imageProvider = AssetEntityImageProvider(
          asset,
          isOriginal: false,
          thumbnailSize: ThumbnailSize(size.toInt(), size.toInt()),
        );
        return ExtendedImage(
          key: ValueKey('media_gallery_asset_view-${asset.id}'),
          image: imageProvider,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.high,
          loadStateChanged: (state) {
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return ShimmerLoading(
                  enable: true,
                  baseColor: context.theme.appColors.backgroundNeutralLight,
                  highlightColor: context.theme.appColors.backgroundNeutralLightest,
                  child: Container(
                    color: Colors.blue.shade100,
                    width: size,
                    height: size,
                  ),
                );
              case LoadState.failed:
                return Container(
                  color: context.theme.appColors.backgroundNeutralLightPressed,
                  child: Center(
                    child: Assets.vectors.photoOutlined.svg(),
                  ),
                );
              case LoadState.completed:
                return state.completedWidget;
            }
          },
        );
      } else {
        return const AlbumErrorImageBox();
      }
    }

    if (controller.selectedImagePathList.isNotEmpty) {
      final imagePath = controller.selectedImagePathList()[index];
      return UChatImage.file(
        imagePath,
        fit: BoxFit.cover,
        customErrorWidget: (state) {
          return const AlbumErrorImageBox();
        },
        // This will prevent out of memory error if lots of big images are selected.
        cacheWidth: 200,
      );
    }

    return const AlbumErrorImageBox();
  }
}
