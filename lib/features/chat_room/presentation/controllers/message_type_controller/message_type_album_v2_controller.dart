import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/params/fetch_images_in_albums_param.dart';
import 'package:uchat/features/album/domain/params/get_album_param.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_images_in_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/get_album_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room/presentation/controllers/message_type_controller/message_type.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_image_list_arguments.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class MessageTypeAlbumV2Controller extends MessageTypeController {
  MessageTypeAlbumV2Controller({required super.initMessage});

  /// Is my message
  bool get isMyMessage => initMessage.mine == true;

  ChatRoomController? get chatRoomController {
    if (Get.isRegistered<ChatRoomController>(tag: initMessage.roomId)) {
      return Get.find<ChatRoomController>(tag: initMessage.roomId);
    }
    return null;
  }

  void openAlbumScreen(BuildContext context) async {
    if (chatRoomController?.isDirectRoom == true && chatRoomController?.contact()?.isBlocked == true) {
      _log.w('Can not open album screen because this contact is blocked');
      return;
    }
    String roomId = initMessage.roomId ?? '';
    String albumId = initMessage.meta?.albumId ?? '';

    await UChatLoading.show();
    try {
      /// Get album from local db
      final result = await GetIt.I<GetAlbumUseCase>().call(GetAlbumParam(albumId: albumId));
      if (result != null) {
        await UChatLoading.hide();

        /// If album is found in local db, use it to go to album screen.
        Get.toNamed(
          Routes.roomDetailAlbumImageList.replaceAll(':id', roomId).replaceAll(':albumId', albumId),
          arguments: ChatRoomDetailAlbumImageListArguments(roomId: roomId, album: result),
        );
      } else {
        /// If album is not found from local db, Call Fetch images from server to check if album is exists in server.
        /// This will work for now. But if ui need to show more data such as createdBy, createdAt, updatedAt we need
        /// to get album data from server.
        try {
          final serverResult = await GetIt.I<FetchImagesInAlbumUseCase>().call(FetchImagesInAlbumParam(
            albumId: albumId,
            pageSize: 1,
          ));
          await UChatLoading.hide();
          Get.toNamed(
            Routes.roomDetailAlbumImageList.replaceAll(':id', roomId).replaceAll(':albumId', albumId),
            arguments: ChatRoomDetailAlbumImageListArguments(
              roomId: roomId,
              album: AlbumEntity(
                albumName: initMessage.meta?.albumName ?? '',
                id: initMessage.meta?.albumId ?? '',
                accountId: '',
                roomId: initMessage.roomId ?? '',
                createdAt: null,
                updatedAt: null,
                createdBy: null,
                isSuccess: null,
                totalImages: serverResult?.total ?? 0,
              ),
            ),
          );
        } on ApiException catch (e, stackTrace) {
          await UChatLoading.hide();
          if (e.type == 'ERR_ALBUM_NOT_FOUND') {
            Get.toNamed(Routes.roomDetailAlbumNotFound);
          } else {
            _log.e('openAlbumScreen error with ApiException.', e, stackTrace);
            UChatNewDialog.showGeneralErrorDialog(
              context: Get.context!,
              e: e,
            );
          }
        } catch (e, stackTrace) {
          await UChatLoading.hide();
          _log.e('openAlbumScreen error.', e, stackTrace);
          UChatNewDialog.showGeneralErrorDialog(
            context: Get.context!,
            e: e is Exception ? e : null,
          );
        }
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('openAlbumScreen error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }
}
