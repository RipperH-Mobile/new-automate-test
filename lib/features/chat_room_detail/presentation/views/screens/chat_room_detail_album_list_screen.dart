import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_list_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_list_item.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ChatRoomDetailAlbumListScreen extends GetView<ChatRoomDetailAlbumListController> {
  final String? roomTag;

  @override
  String? get tag => roomTag;

  const ChatRoomDetailAlbumListScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: ChatRoomDetailAlbumAppBar(
          title: 'Album'.tr,
          subtitle: controller.isAlbumDataInitCompleted()
              ? '@count albums'.trParams({
                  'count': controller.albumCount.toString(),
                })
              : null,
          actions: [
            if (controller.isDisableAlbumMenu == false)
              TextButton(
                onPressed: () {
                  controller.openCreateAlbumScreen(context);
                },
                child: AppText.button1Bold(
                  'Add'.tr,
                  color: context.theme.appColors.textPrimary,
                  context: context,
                ),
              ),
          ],
        ),
        child: PagedListView<int, AlbumEntity>.separated(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (BuildContext context, _, int index) {
              return Obx(() {
                final album = controller.albumList[index];
                final task = controller.albumTasks.firstWhereOrNull((e) => e?.albumId == album.id);

                return ChatRoomDetailAlbumListItem(
                  isDisableAlbumMenu: controller.isDisableAlbumMenu,
                  album: album,
                  onTap: () {
                    controller.openAlbumDetailScreen(album);
                  },
                  onAddItemsPressed: (bool isPopOver) {
                    controller.openAddItemToAlbumBottomSheet(album.id!, context, isPopOver: isPopOver);
                  },
                  onRenamePressed: () {
                    controller.openRenameScreen(album.albumName!, album.id!, context);
                  },
                  onDownloadAlbumPressed: () {
                    controller.downloadAlbum(album, context);
                  },
                  onDeletePressed: () {
                    controller.deleteAlbum(album.id!, context);
                  },
                  showLoading: task?.albumId == album.id,
                  type: task?.type,
                  status: task?.status,
                  loadingText: task?.uiString ?? '',
                  currentProgress: task?.currentProgress ?? 0,
                  maxProgress: task?.totalImages ?? 1,
                  onProgressPressed: () {
                    controller.handleProgressPressed(album, context);
                  },
                  animation: controller.allAnimation[album.id ?? ''],
                );
              });
            },
            noItemsFoundIndicatorBuilder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText.title2(
                    'No album yet'.tr,
                    color: context.theme.appColors.textDarkest,
                    context: context,
                  ),
                  if (controller.isDisableAlbumMenu == false) ...[
                    AppText.body3(
                      'Create an album to share photos with chat.'.tr,
                      color: context.theme.appColors.textDark,
                      context: context,
                    ),
                    const SizedBox(
                      height: AppSpace.space4,
                      width: double.infinity, // Make column take full width of the screen.
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.appColors.buttonPrimary,
                        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                      ),
                      child: TextButton(
                        onPressed: () {
                          controller.openCreateAlbumScreen(context);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpace.space4,
                            vertical: AppSpace.space2,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: AppText.body4Bold(
                          'Add new album'.tr,
                          color: context.theme.appColors.textPrimaryInverse,
                          context: context,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            },
            firstPageProgressIndicatorBuilder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ShimmerLoading(
                      enable: true,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpace.space4),
                  Expanded(
                    child: ShimmerLoading(
                      enable: true,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: AppSpace.space4);
          },
        ),
      );
    });
  }
}
