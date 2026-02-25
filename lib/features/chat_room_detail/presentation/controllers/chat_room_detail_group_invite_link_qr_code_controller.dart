import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uchat/controllers/permission_controller.dart';
import 'package:uchat/core/domain/entities/share_bottom_sheet_data_entity.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/entities/models/file_info_model.dart';
import 'package:uchat/features/chat_room/domain/chat_room_domain.dart';
import 'package:uchat/features/chat_room_detail/presentation/arguments/chat_room_detail_invite_link_qr_code_argument.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/invite_link_qr_code.dart';
import 'package:uchat/utils/vibrate.dart';
import 'package:uchat/widgets/loading/loading.dart';

final _log = useLogger();

class ChatRoomDetailGroupInviteLinkQrCodeIds {
  static const String roomName = 'room_name_group_invite_link_qr_code';
  static const String qrCodeSection = 'qr_code_section_group_invite_link_qr_code';
}

class ChatRoomDetailGroupInviteLinkQrCodeController extends GetxController {
  late String roomId;

  late RoomEntity room;
  late String inviteLink;

  bool isLoadingRoom = false;
  bool isDownloading = false;

  @override
  onInit() {
    super.onInit();

    initData();
  }

  Future<void> initData() async {
    if (Get.arguments is! ChatRoomDetailInviteLinkQrCodeArgument) {
      Get.back();
    } else {
      final args = Get.arguments as ChatRoomDetailInviteLinkQrCodeArgument;
      roomId = args.roomId;
      inviteLink = args.inviteLink;

      await getRoomToState();
    }
  }

  Future<void> getRoomToState() async {
    try {
      isLoadingRoom = true;
      update([ChatRoomDetailGroupInviteLinkQrCodeIds.roomName]);

      await Future.delayed(const Duration(milliseconds: 1000));
      final roomResult = await GetIt.I<GetRoomByIdUseCase>().call(ChatRoomParams(roomId: roomId));
      if (roomResult != null) {
        room = roomResult;
      } else {
        _log.w('Room not found in ChatRoomDetailGroupInviteLinkSettingController');
        Get.back();
      }

      isLoadingRoom = false;
      update([ChatRoomDetailGroupInviteLinkQrCodeIds.roomName]);
    } catch (e, stackTrace) {
      _log.e('getRoomToState in ChatRoomDetailGroupInviteLinkSettingController', e, stackTrace);
    }
  }

  Future<void> onShareQrCode() async {
    try {
      GetIt.I<VibrateUtil>().vibrateSelection();
      final qrImage = await capturedQRCode();
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/${roomId}_invite_link_qr_code.png').create();
      await file.writeAsBytes(qrImage);

      await GetIt.I<SharingService>().share(
        data: ShareBottomSheetDataEntity(
          newFile: await FileInfoModel.fromFile(file, 0),
        ),
      );
    } catch (e, stackTrace) {
      _log.e('onShareQrCode in ChatRoomDetailGroupInviteLinkQrCodeController', e, stackTrace);
    }
  }

  Future<void> onDownloadQrCode(BuildContext context) async {
    try {
      final result = await PermissionController.instance.requestGalleryPermissionDirect(context);
      if (!result || isDownloading) return;

      isDownloading = true;
      await UChatLoading.show();
      Uint8List? image = await capturedQRCode();

      final saveResult = await SaverGallery.saveImage(
        image.buffer.asUint8List(),
        fileName: 'my_uchat_qr',
        skipIfExists: false,
      );

      if (saveResult.isSuccess && context.mounted) {
        AppToast.showDownloadToast(
          context: context,
          title: 'Saved successfully'.tr,
          height: AppSize.size12.spMin,
        );

        isDownloading = false;
      }
    } catch (e, stackTrace) {
      _log.e('onDownloadQrCode in ChatRoomDetailGroupInviteLinkQrCodeController', e, stackTrace);
      if (context.mounted) {
        AppToast.hideToast(context);
      }

      isDownloading = false;
      _log.e('handleDownloadQr error.', e, stackTrace);
    } finally {
      UChatLoading.hide();
    }
  }

  Future<Uint8List> capturedQRCode() async {
    final ScreenshotController screenshotController = ScreenshotController();
    Uint8List image = await screenshotController.captureFromWidget(
      InviteLinkQrCode(inviteLink: inviteLink),
    );

    return image;
  }
}
