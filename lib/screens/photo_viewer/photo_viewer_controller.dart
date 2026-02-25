import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/entities/models/photo_viewer_data_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_member_collection.dart';
import 'package:uchat/features/chat_room/presentation/controllers/chat_room_controller.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_sync_use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/profile_image_editing.dart';
import 'package:uchat/widgets.dart';

final _log = useLogger();

// TODO: refactor
class PhotoViewerController extends GetxController {
  final showMenu = true.obs;
  final photoDataList = <PhotoViewerDataModel>[].obs;

  String? roomId;
  final index = 0.obs;

  final slidePageKey = GlobalKey<ExtendedImageSlidePageState>();
  var slideAxis = SlideAxis.both;
  String? tag;

  // enable download all photo in viewer. only used when open photo viewer from chat screen.
  bool enableDownloadAll = false;

  // whether this photo viewer is showing image that is sent from message
  bool isImageFromMessage = false;
  bool isGiphy = false;
  List<MessageCollection> messageList = [];

  PhotoViewerController({this.tag});

  bool get showShareButton {
    return !isGiphy;
  }

  bool get showDetailButton {
    return !isGiphy;
  }

  ChatRoomController? get roomCtl {
    try {
      return Get.find<ChatRoomController>(tag: roomId);
    } catch (e, stackTrace) {
      _log.e('get roomCtl error in PhotoViewerController', e, stackTrace);
      return null;
    }
  }

  void findAllOwnerName() {
    for (final photoData in photoDataList) {
      // find photo owner name if there is no owner name (when open photo viewer
      // from album or photo list)
      if (photoData.ownerId != null && photoData.ownerName == null) {
        // find contact from owner id
        final contact = GetIt.I<GetContactSyncUseCase>().call(photoData.ownerId!);
        if (contact != null) {
          if (contact.nickname != null) {
            // use nickname first if it exists
            if (contact.nickname!.isNotEmpty) {
              photoData.ownerName = contact.nickname;
            } else {
              photoData.ownerName = contact.showName;
            }
          } else if (contact.nickname == null) {
            // otherwise use show name (which is display name or username)
            photoData.ownerName = contact.showName;
          }
        } else if (photoData.ownerId == UserController.instance.currentUser()?.id) {
          // if current user is owner, use show name
          photoData.ownerName = UserController.instance.currentUser()?.displayName;
        } else {
          // if user is not current user and not friend with current user
          // find owner name from members in the room
          RoomMemberCollection? owner =
              roomCtl?.members.firstWhereOrNull((element) => element.accountId == photoData.ownerId);
          photoData.ownerName = owner?.account?.showName;
        }
      }
    }
  }

  void handleEditProfileImage(File file) {
    handleCropProfileImage(file);
    Get.back();
  }

  void handleShowDetails() {
    showUChatModalBottomSheet(
      menus: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Image Info.'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        if (photoDataList[index()].width != null && photoDataList[index()].height != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Size'.tr,
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  '${photoDataList[index()].width?.toInt()}x${photoDataList[index()].height?.toInt()}',
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 15.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Owner'.tr,
                strutStyle: const StrutStyle(
                  height: 1.5,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  photoDataList[index()].ownerName ?? 'UNKNOWN'.tr,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (photoDataList[index()].createdAt != null)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create at'.tr,
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  DateFormat('yyyy-MM-dd kk:mm').format(photoDataList[index()].createdAt!),
                  strutStyle: const StrutStyle(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void handleDeleteImage() async {
    // ! New request changed, old service incompatible with new api.
    // if (isImageFromMessage) {
    //   final isConfirm = await UChatDialog.showDeleteDialog(
    //     title: 'Delete Image'.tr,
    //     description: 'Do you want to delete this image?'.tr,
    //   );
    //
    //   if (isConfirm) {
    //     try {
    //       List<String>? fileIds = [
    //         if (!isGiphy) photoDataList[index()].imageId!,
    //       ];
    //       final req = UnsentMessageRequest(
    //         messageId: photoDataList[index()].messageId!,
    //         roomId: roomCtl?.roomId,
    //         groupFileIds: isGiphy ? null : fileIds,
    //       );
    //       await MessageService().unsentMessage(req);
    //       final message = await MessageDb().getMessageById(
    //         id: photoDataList[index()].messageId!,
    //       );
    //       roomCtl?.removeSendingMessage(
    //         message!,
    //         fileIds: fileIds,
    //       );
    //       Get.back();
    //     } catch (e, stackTrace) {
    //       _log.e('delete image error', e, stackTrace);
    //       handleException(e, onUnknownException: () {
    //         UChatDialog.showExceptionDialog(
    //           description: 'Delete image failed'.tr,
    //         );
    //       });
    //     }
    //   }
    // }
  }

  void handleSave({bool downloadAll = false}) async {
    // await downloadAndShareImage.download(selectedListUrl);
  }

  void showDownloadOptions() {
    if (photoDataList.length == 1) {
      handleSave();
      return;
    }
    showUChatModalBottomSheet(
      menus: <Widget>[
        UChatBottomSheetItem(
          label: 'Download all images (@count)'.trParams(
            {'count': photoDataList.length.toString()},
          ),
          onPressed: () {
            Get.back();
            handleSave(downloadAll: true);
          },
        ),
        UChatBottomSheetItem(
          label: 'Download only this image'.tr,
          onPressed: () {
            Get.back();
            handleSave();
          },
        ),
      ],
    );
  }

  void handleShare() async {
    // await downloadAndShareImage.share(selectedListUrl);
  }
}
