import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_media_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_media_item.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailMediaScreen extends GetView<ChatRoomDetailMediaController> {
  final String? roomTag;

  @override
  String? get tag => roomTag;

  const ChatRoomDetailMediaScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: ChatRoomDetailAlbumAppBar(
          title: 'Media'.tr,
          subtitle: '@photoCount photos, @videoCount videos'.trParams({
            'photoCount': controller.photoCount().toString(),
            'videoCount': controller.videoCount().toString(),
          }),
        ),
        child: Obx(() {
          if (controller.isInitializing()) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (controller.mediaList.isEmpty) {
            return _buildNotFound(context);
          }

          return GridView.builder(
            controller: controller.scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: AppSpace.space05,
              crossAxisSpacing: AppSpace.space05,
            ),
            itemCount: controller.mediaList.length,
            itemBuilder: (_, index) {
              final roomFile = controller.mediaList[index];

              return ChatRoomDetailMediaItem(
                roomFile: roomFile,
                onTap: () => controller.openMedia(roomFile),
              );
            },
          );
        }),
      );
    });
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.heading4(
            'No media'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDarkest,
          ),
          AppText.body3(
            'No media have been shared in this\nchat room yet.'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDark,
          ),
        ],
      ),
    );
  }
}
