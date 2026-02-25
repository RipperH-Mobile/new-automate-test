import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/album/domain/entities/album_entity.dart';
import 'package:uchat/features/album/domain/params/download_image_for_add_to_album_param.dart';
import 'package:uchat/features/album/domain/params/fetch_albums_params.dart';
import 'package:uchat/features/album/domain/params/get_unfinished_album_task_param.dart';
import 'package:uchat/features/album/domain/use_cases/download_image_for_add_to_album_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/fetch_albums_use_case.dart';
import 'package:uchat/features/album/domain/use_cases/get_unfinished_album_task_use_case.dart';
import 'package:uchat/features/album/presentation/arguments/add_to_album_arguments.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_create_confirm_arguments.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class AddToAlbumController extends GetxController {
  final String tag;

  AddToAlbumController({required this.tag});

  String roomId = '';
  List<String> selectedFilesUrl = [];
  PagingController<int, AlbumEntity> pagingController = PagingController(firstPageKey: 1);

  @override
  void onInit() {
    final args = Get.arguments as AddToAlbumArguments;
    roomId = args.roomId;
    selectedFilesUrl = args.selectedFilesUrl;

    pagingController.addPageRequestListener((pageKey) {
      fetchAlbums(page: pageKey);
    });

    super.onInit();
  }

  Future<void> fetchAlbums({required int page}) async {
    try {
      final result = await GetIt.I<FetchAlbumsUseCase>().call(FetchAlbumsParams(
        roomId: roomId,
        page: page,
      ));
      if (result != null) {
        final dataList = result.data?.toList() ?? [];
        if (result.page >= result.totalPages) {
          pagingController.appendLastPage(dataList);
        } else {
          pagingController.appendPage(dataList, result.page + 1);
        }
      }
    } catch (e, stackTrace) {
      _log.e('fetchAlbums error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> handleAddToAlbum(AlbumEntity album) async {
    await UChatLoading.show();

    try {
      /// Check if there are any unfinished album tasks in the room.
      final unfinishedTaskResult = await GetIt.I<GetUnfinishedAlbumTaskUseCase>().call(GetUnfinishedAlbumTaskParam(
        roomId: album.roomId ?? '',
        albumId: album.id ?? '',
      ));

      /// If there are any unfinished album tasks in the room, show a toast and stop user from adding image into album.
      if (unfinishedTaskResult.isNotEmpty) {
        AppToast.showAlbumCannotDoItNowToast(Get.context!);
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('handleAddToAlbum error when checking for unfinishedTask.', e, stackTrace);
      AppToast.showAlbumCannotDoItNowToast(Get.context!);
    }

    try {
      /// Download image from message and save it to local storage.
      /// This will return list of file path.
      final result = await GetIt.I<DownloadImageForAddToAlbumUseCase>().call(
        DownloadImageForAddToAlbumParam(
          imagesUrl: selectedFilesUrl,
        ),
      );
      Get.toNamed(
        Routes.roomDetailAlbumCreateConfirm.replaceFirst(':id', roomId),
        arguments: ChatRoomDetailAlbumCreateConfirmArguments(
          roomId: roomId,
          imagePathList: result,
          enableAddImageButton: true,
          existingAlbumName: album.albumName,
          addToAlbumId: album.id,
        ),
      );
      await UChatLoading.hide();
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('handleAddToAlbum error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }

  Future<void> handleCreateAlbum() async {
    await UChatLoading.show();

    try {
      /// Download image from message and save it to local storage.
      /// This will return list of file path.
      final result = await GetIt.I<DownloadImageForAddToAlbumUseCase>().call(
        DownloadImageForAddToAlbumParam(
          imagesUrl: selectedFilesUrl,
        ),
      );
      await UChatLoading.hide();
      Get.toNamed(
        Routes.roomDetailAlbumCreateConfirm.replaceFirst(':id', roomId),
        arguments: ChatRoomDetailAlbumCreateConfirmArguments(
          roomId: roomId,
          imagePathList: result,
          enableAddImageButton: true,
        ),
      );
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      _log.e('handleCreateAlbum error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    }
  }
}
