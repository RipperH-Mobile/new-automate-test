import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/api/api.dart';
import 'package:uchat/core/data/models/enums/api_exception_type.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/album/domain/params/rename_album_param.dart';
import 'package:uchat/features/album/domain/use_cases/rename_album_use_case.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_album_rename_arguments.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomDetailAlbumRenameController extends GetxController {
  String tag;

  ChatRoomDetailAlbumRenameController({required this.tag});

  TextEditingController textFieldController = TextEditingController();
  String roomId = '';
  String albumId = '';
  String oldAlbumName = '';

  final enableDoneButton = false.obs;
  final albumName = ''.obs;

  ChatRoomController get chatRoomController {
    return Get.find<ChatRoomController>(tag: tag);
  }

  @override
  void onInit() {
    final arg = Get.arguments as ChatRoomDetailAlbumRenameArguments;
    roomId = arg.roomId;
    albumId = arg.albumId;
    oldAlbumName = arg.oldAlbumName;
    albumName(arg.oldAlbumName);
    textFieldController.text = arg.oldAlbumName;

    super.onInit();
  }

  void onTextFieldChanged(String value) {
    albumName(value);
    updateEnableRenameButton();
  }

  void onClearTextField() {
    textFieldController.clear();
    albumName('');
    updateEnableRenameButton();
  }

  void updateEnableRenameButton() {
    enableDoneButton(albumName.isNotEmpty && albumName() != oldAlbumName);
  }

  void handleDonePressed(BuildContext context) async {
    try {
      if (chatRoomController.roomCapability.value.disableAlbumMenu == true) {
        UChatNewDialog.showPermissionDeniedDialog(context: context);
        return;
      }

      await UChatLoading.show();
      await GetIt.I<RenameAlbumUseCase>().call(RenameAlbumParam(
        albumId: albumId,
        roomId: roomId,
        newAlbumName: albumName(),
      ));
      Get.back();
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } on ApiException catch (e, stackTrace) {
      if (e.exceptionType == ApiExceptionType.permissionDenied) {
        UChatNewDialog.showPermissionDeniedDialog(context: Get.context!);
      } else {
        _log.e('Rename album error.', e, stackTrace);
        UChatNewDialog.showGeneralErrorDialog(
          context: Get.context!,
          e: e,
        );
      }
    } catch (e, stackTrace) {
      _log.e('Rename album error.', e, stackTrace);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e is Exception ? e : null,
      );
    } finally {
      await UChatLoading.hide();
    }
  }
}
