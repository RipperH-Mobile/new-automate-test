import 'package:fpdart/fpdart.dart';
import 'package:uchat/features/chat_room/domain/params/remove_failed_message_params.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';

class RemoveFailedMessageUseCase extends UseCase<void, RemoveFailedMessageParams> {
  final _log = useLogger();

  RemoveFailedMessageUseCase({
    required this.messageLocalRepository,
  });

  final MessageLocalRepository messageLocalRepository;

  @override
  Future<Either<Exception, void>> call(RemoveFailedMessageParams params) async {
    try {
      final message = params.message;
      final messageRef = message.ref;

      if (messageRef != null) {
        await messageLocalRepository.deleteMessageByRef(ref: messageRef);
      }
      return const Right(null);
    } catch (e, stackTrace) {
      _log.e('Error removing failed messages: ', e, stackTrace);
      return Left(e as Exception);
    }
  }
}
