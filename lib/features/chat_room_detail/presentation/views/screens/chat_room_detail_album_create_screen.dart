import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_album_create_controller.dart';
import 'package:uchat/features/media_gallery/presentation/views/screens/media_gallery.dart';

class ChatRoomDetailAlbumCreateScreen extends GetView<ChatRoomDetailAlbumCreateController> {
  final String controllerTag;

  @override
  String? get tag => controllerTag;

  const ChatRoomDetailAlbumCreateScreen({
    super.key,
    required this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaGallery(
        showDragHandle: false,
        appBarActionType: MediaGalleryAppBarActionType.back,
        doneButtonType: MediaGalleryDoneButtonType.next,
        filterMediaType: MediaGalleryFilterMediaType.image,
        onDoneCallback: controller.openConfirmScreen,
        enablePickingUnsupportedTypeOnAndroid: false,
      ),
    );
  }
}
