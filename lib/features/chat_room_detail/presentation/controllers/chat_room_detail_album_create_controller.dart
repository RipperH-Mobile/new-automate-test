import 'package:get/get.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_create_arguments.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_create_confirm_arguments.dart';
import 'package:uchat/features/media_gallery/domain/model/media_gallery_result.dart';
import 'package:uchat/routes/routes.dart';

class ChatRoomDetailAlbumCreateController extends GetxController {
  String tag;

  ChatRoomDetailAlbumCreateController({required this.tag});

  String roomId = '';
  final hasGalleryPermission = false.obs;

  @override
  void onInit() {
    final arg = Get.arguments as ChatRoomDetailAlbumCreateArguments;
    roomId = arg.roomId;
    hasGalleryPermission(arg.hasGalleryPermission);

    super.onInit();
  }

  Future<void> openConfirmScreen(MediaGalleryResult result, {int loopCount = 1}) async {
    await Get.toNamed(
      Routes.roomDetailAlbumCreateConfirm.replaceAll(':id', roomId),
      arguments: ChatRoomDetailAlbumCreateConfirmArguments(
        roomId: roomId,
        imagePathList: [],
        selectedMediaResult: result.images,
      ),
    );
  }
}
