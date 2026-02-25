import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/models.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';

final _log = useLogger();

class ResendMessageUseCase extends UseCase<dynamic, MessageCollection> {
  ResendMessageUseCase({
    required this.messageServerRepository,
    required this.messageLocalRepository,
  });

  final MessageServerRepository messageServerRepository;
  final MessageLocalRepository messageLocalRepository;

  @override
  Future<Either<dynamic, void>> call(MessageCollection params) async {
    try {
      params.isSendFailed = false;

      // remove failed message from db
      await messageLocalRepository.deleteMessageByRef(ref: params.ref!);

      // TODO: handle resend difference message type
      if ([
        MessageType.file,
        MessageType.image,
        MessageType.audio,
        MessageType.video,
      ].contains(params.type)) {
        final List<FileInfoModel> files = [];

        _log.d('resend file length --> ${params.files?.length}');
        for (MessageFileModel file in params.files ?? []) {
          _log.d(
            'message sent fail --> ${file.isSendFailed} : file url --> ${file.url}',
          );
          if (file.isSendFailed == true && file.url != null) {
            final fileInfo = FileInfoModel.fromMessageFile(file);
            files.add(fileInfo);
          }
        }

        _log.d('resend files [${files.length}]');
        if (files.isNotEmpty) {
          //use UseCase send file
        } else {
          Get.back();
          UChatDialog.showExceptionDialog(description: 'Resend message failed'.tr);
          _log.e('Can not resend failed message! files is empty');
          return const Left('Can not resend failed message! files is empty');
        }
      } else {
        //use UseCase send message
      }

      Get.back();
      return const Right(null);
    } catch (e, stackTrace) {
      _log.e('Can not resend failed message!.', e, stackTrace);
      Get.back();
      UChatDialog.showExceptionDialog(description: 'Resend message failed'.tr);
      return Left(e);
    }
  }
}
