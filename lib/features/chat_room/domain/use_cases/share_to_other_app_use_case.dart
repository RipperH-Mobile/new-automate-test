import 'package:extended_image_library/extended_image_library.dart';
import 'package:flutter/services.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/exception_handler.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/core/services/sharing/sharing_service.dart';
import 'package:uchat/entities/enum/message_type.dart';
import 'package:uchat/features/chat_room/domain/params/share_to_other_app_params.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/use_cases/use_case.dart';

final _log = useLogger();

class ShareToOtherAppUseCase extends UseCase<bool, ShareToOtherAppParams> {
  ShareToOtherAppUseCase();

  @override
  Future<Either<Exception, bool>> call(ShareToOtherAppParams params) async {
    List<XFile> xFileList = <XFile>[];
    String shareText = '';

    try {
      /// Case share message from chat room.
      if (params.data.messageList != null) {
        for (final selection in params.data.messageList!) {
          if (UChatConstant.canShareToOtherAppTypeList.contains(selection.message.type) &&
              selection.fileIdList?.isNotEmpty == true) {
            for (final fileId in selection.fileIdList!) {
              String fileUrl = FileService().getFileUrl(fileId);

              //NOTE. The response result is a Uint8List which is not a String but a bytes.
              final Uint8List imageUint8List = await FileService.instance.downloadFile(fileUrl);
              //NOTE. Name the path where it will be placed.
              final String path = (await getApplicationDocumentsDirectory()).path;

              final imageFile = File('$path/${fileUrl.split('/').last}');

              //NOTE. Create a file from Uint8List to the machine before sending.
              await imageFile.writeAsBytes(imageUint8List);
              final file = selection.message.files?.firstWhereOrNull((e) => e.id == fileId);
              xFileList.add(
                XFile(
                  imageFile.path,
                  name: file?.name,
                  mimeType: file?.mime,
                  bytes: imageUint8List,
                ),
              );
            }
          } else if (selection.message.type == MessageType.text) {
            // TODO (share) handle message type link and emoji here too.
            shareText += '${selection.message.message}\n';
          } else {
            _log.w(
                'Share message type ${selection.message.type} to other app is not supported. Skipping share message id : ${selection.message.id}');
          }
        }
      }

      /// Case share image from album
      if (params.data.albumImageList != null) {
        for (final image in params.data.albumImageList!.images) {
          if (image.imageUrl == null) continue;
          String fileUrl = image.imageUrl!;

          //NOTE. The response result is a Uint8List which is not a String but a bytes.
          final Uint8List imageUint8List = await FileService.instance.downloadFile(fileUrl);
          //NOTE. Name the path where it will be placed.
          final String path = (await getApplicationDocumentsDirectory()).path;

          final imageFile = File('$path/${fileUrl.split('/').last}');

          //NOTE. Create a file from Uint8List to the machine before sending.
          await imageFile.writeAsBytes(imageUint8List);
          xFileList.add(
            XFile(
              imageFile.path,
              name: image.imageName,
              mimeType: image.mimeType,
              bytes: imageUint8List,
            ),
          );
        }
      }

      /// Case send new message such as share contact from room detail.
      if (params.data.newMessage != null &&
          [
            MessageType.text,
          ].contains(params.data.newMessage?.type)) {
        shareText += '${params.data.newMessage?.message}';
      }

      /// Case send new file such as share my qr code.
      final fileInfo = params.data.newFile;
      if (fileInfo != null) {
        final fileByte = await fileInfo.bytes;
        final filePath = await fileInfo.path;
        if (filePath != null) {
          final fileName = await fileInfo.name;
          final fileMime = await fileInfo.mime;

          xFileList.add(
            XFile(
              filePath,
              name: fileName,
              mimeType: fileMime,
              bytes: fileByte,
            ),
          );
        }
      }

      if (xFileList.isEmpty && shareText.isEmpty) {
        return Left(NullResponseException());
      }

      if (xFileList.isEmpty && shareText.isNotEmpty) {
        final result = await GetIt.I<SharingService>().shareToOtherApp(
          text: shareText,
        );
        return Right(result.status == ShareResultStatus.success);
      } else {
        final result = await GetIt.I<SharingService>().shareToOtherApp(
          text: shareText.isNotEmpty ? shareText : null,
          files: xFileList,
        );
        return Right(result.status == ShareResultStatus.success);
      }
    } catch (e, stackTrace) {
      _log.e('ShareToOtherAppUseCase error.', e, stackTrace);
      return Left(ExceptionHandler.handle(e));
    }
  }
}
