import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/presentation/controllers/add_to_album_controller.dart';
import 'package:uchat/features/album/presentation/views/widgets/add_to_album_list_item.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/widgets.dart';

class AddToAlbumScreen extends GetView<AddToAlbumController> {
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  const AddToAlbumScreen({super.key, this.controllerTag});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      appBar: ChatRoomDetailAlbumAppBar(
        title: 'Add to Album'.tr,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                controller.handleCreateAlbum();
              },
              child: AddToAlbumListItem(
                title: 'Create new album'.tr,
                isCreateNewAlbum: true,
              ),
            ),
          ),
          PagedSliverList<int, AlbumEntity>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (BuildContext context, album, int index) {
                return GestureDetector(
                  onTap: () {
                    controller.handleAddToAlbum(album);
                  },
                  child: AddToAlbumListItem(
                    title: album.albumName ?? '',
                    subtitle: '@count Photos'.trParams({
                      'count': album.totalImages.toString(),
                    }),
                    albumCoverUrl: album.imageCoverPath.isNotEmpty ? album.imageCoverPath : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
