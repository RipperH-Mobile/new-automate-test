import 'dart:collection';

import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/chat_room/domain/params/get_message_from_server_param.dart';
import 'package:uchat/features/chat_room/domain/repositories/message_local_repository.dart';
import 'package:uchat/features/chat_room/domain/use_cases/get_message_from_server_use_case.dart';

import '../entities/message_entity.dart';

class GetAllSentMessageParams {
  final String roomId;
  final int? limit;
  final int? sequenceLessThan;
  final int? sequenceGreaterThan;
  final bool isMyNote;
  final String? emojiTagId;
  final int sequenceOfVeryFirstMessageInRoom;
  final bool useDefaultMessageLoadLimit;

  GetAllSentMessageParams({
    required this.roomId,
    this.sequenceOfVeryFirstMessageInRoom = 0,
    this.limit,
    this.sequenceLessThan,
    this.sequenceGreaterThan,
    this.isMyNote = false,
    this.emojiTagId,
    this.useDefaultMessageLoadLimit = true,
  });
}

class GetAllSentMessageUseCase {
  final MessageLocalRepository messageLocalRepository;

  GetAllSentMessageUseCase({
    required this.messageLocalRepository,
  });

  final _log = useLogger();

  Future<List<MessageEntity>> call(GetAllSentMessageParams params) async {
    try {
      final newMessages = HashMap<String, MessageEntity>();
      int lastMessageSequence = 0;
      int? loadLimit = params.limit;

      if (params.useDefaultMessageLoadLimit || loadLimit == null) {
        loadLimit = UChatConstant.messageLoadLimit;
      }

      final useGreaterThanOrEqual = params.sequenceGreaterThan == params.sequenceOfVeryFirstMessageInRoom;

      try {
        final messages = await messageLocalRepository.getAllSentMessage(
          roomId: params.roomId,
          limit: loadLimit,
          sequenceLessThan: params.sequenceLessThan,
          sequenceGreaterThan: params.sequenceGreaterThan,
          useGreaterThanOrEqual: useGreaterThanOrEqual,
          isMyNote: params.isMyNote,
          emojiTagId: params.emojiTagId,
        );

        lastMessageSequence = messages.lastOrNull?.sequence ?? 0;
        for (final message in messages) {
          final messageRef = message.ref;

          if (messageRef != null) {
            newMessages.putIfAbsent(messageRef, () => message);
          }
        }
      } catch (e, stackTrace) {
        _log.w('Call getAllSentMessage local error.', e, stackTrace);
      }

      final isMessageNotReachLimit = newMessages.length < loadLimit;
      final isMessageIsNotTheVeryFirst = lastMessageSequence > (params.sequenceOfVeryFirstMessageInRoom);

      // If there is no message or message is not reach limit, then get message from server
      if (newMessages.isEmpty || isMessageNotReachLimit && isMessageIsNotTheVeryFirst) {
        try {
          GetMessageFromServerParam getMessageFromServerParam = GetMessageFromServerParam(roomId: params.roomId);
          if (params.sequenceLessThan != null) {
            getMessageFromServerParam = getMessageFromServerParam.copyWith(onlyPrevious: true);
          }

          // Call getMessageFromServerUseCase
          final latestMessages = await GetIt.I<GetMessageFromServerUseCase>().call(getMessageFromServerParam);
          if (latestMessages?.isNotEmpty == true) {
            for (final message in latestMessages!) {
              final messageRef = message.ref;

              if (messageRef != null) {
                newMessages.putIfAbsent(messageRef, () => message);
              }
            }
          }
        } catch (e, stackTrace) {
          _log.e('Call getMessageFromServerUseCase error.', e, stackTrace);
        }
      }

      return newMessages.values.toList();
    } catch (e, stackTrace) {
      _log.e('Error when getting all sent messages', e, stackTrace);
      return <MessageEntity>[];
    }
  }
}
