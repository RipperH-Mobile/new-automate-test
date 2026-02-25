import 'dart:collection';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/services/messaging/message_queue_request_item.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_file_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_message_request_interface.dart';
import 'package:uchat/features/chat_room/data/models/send_message_payload/send_multi_file_message_request.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';

typedef OnPrecessMessageRequestFunction<T extends SendMessageRequestInterface> = Future<void> Function(T req);

typedef SendingFileRequestMap = Map<String?, SendFileMessageRequest>;

class MessageQueueService {
  static const String instanceNameMessage = 'Message';
  static const String instanceNameMedia = 'Media';

  final _log = useLogger();

  static MessageQueueService messageInstance = GetIt.I<MessageQueueService>(instanceName: instanceNameMessage);
  static MessageQueueService mediaInstance = GetIt.I<MessageQueueService>(instanceName: instanceNameMedia);

  final _sendMessageQueueRunning = HashMap<String, bool>();
  final _sendMessageQueueProcess = HashMap<String, Future<void>?>();
  final _sendMessageQueue = HashMap<String, List<MessageQueueRequestItem>>();

  final SendingFileRequestMap sendingFileRequests = {};

  /// To check if the message is in the queue or not
  ///
  /// [roomId] is the room id of the message
  /// [messageRef] is the reference of the message
  ///
  /// Return [bool] if the message is in the queue or not
  bool inMessageQueue(String roomId, String messageRef) {
    _sendMessageQueue.putIfAbsent(roomId, () => []);

    try {
      return _sendMessageQueueRunning[messageRef] ?? false;
    } on StateError catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// To add message to the queue
  ///
  /// [messageRequest] is the message to be added to the queue
  ///
  /// Return [void]
  Future<void> addMessageToQueue<T extends SendMessageRequestInterface>({
    required T messageRequest,
    required OnPrecessMessageRequestFunction<T> onProcessing,
  }) async {
    final roomId = messageRequest.roomId;

    // add the message to the queue and set the message as running in the queue
    _sendMessageQueueProcess.putIfAbsent(roomId, () => null);
    _sendMessageQueue.putIfAbsent(roomId, () => []);

    if (onProcessing is OnPrecessMessageRequestFunction<SendMultiFileMessageRequest> &&
        messageRequest is SendMultiFileMessageRequest) {
      final onProcessingFunction = onProcessing as OnPrecessMessageRequestFunction<SendMultiFileMessageRequest>;
      final item = MessageQueueRequestItem<SendMultiFileMessageRequest>(
        roomId: roomId,
        messageRef: messageRequest.ref,
        messageRequest: messageRequest,
        onProcessing: onProcessingFunction,
      );
      _sendMessageQueue[roomId]?.add(item);
    }

    if (onProcessing is OnPrecessMessageRequestFunction<SendMessageRequest> && messageRequest is SendMessageRequest) {
      final onProcessingFunction = onProcessing as OnPrecessMessageRequestFunction<SendMessageRequest>;
      final item = MessageQueueRequestItem<SendMessageRequest>(
        roomId: roomId,
        messageRef: messageRequest.ref,
        messageRequest: messageRequest,
        onProcessing: onProcessingFunction,
      );
      _sendMessageQueue[roomId]?.add(item);
    }

    _sendMessageQueueRunning.assign(messageRequest.ref, true);

    if (_sendMessageQueueProcess[roomId] != null) {
      return _sendMessageQueueProcess[roomId];
    }

    try {
      // process the message queue
      _sendMessageQueueProcess[roomId] = _processSendMessageQueue(roomId: roomId);
      await _sendMessageQueueProcess[roomId];
    } catch (e, stackTrace) {
      _log.e(
        UChatLogMessage(
          message: 'Process message queue error.',
          error: e,
          stackTrace: stackTrace,
          additionalData: {
            'remainQueue': _sendMessageQueue[roomId]?.length,
          },
        ),
      );
    } finally {
      _sendMessageQueueProcess[roomId] = null;
    }
  }

  /// To process the message queue in the room
  ///
  /// [roomId] is the room id of the message
  /// [onProcessing] is the function to process the message in the queue
  ///
  /// Return [void]
  Future<void> _processSendMessageQueue({required String roomId}) async {
    try {
      if (_sendMessageQueueProcess[roomId] != null) return;
      _sendMessageQueue.putIfAbsent(roomId, () => []);

      // loop until the queue is empty
      while (_sendMessageQueue[roomId]?.isNotEmpty == true) {
        // get the first message in the queue and remove it from the queue
        final messageQueueItem = _sendMessageQueue[roomId]?.removeAt(0);

        if (messageQueueItem == null) {
          continue;
        }

        final messageRef = messageQueueItem.messageRef;

        try {
          if (messageQueueItem is MessageQueueRequestItem<SendMultiFileMessageRequest>) {
            final requestData = messageQueueItem.messageRequest;
            final onProcessing = messageQueueItem.onProcessing;

            for (final request in requestData.requestList) {
              sendingFileRequests[request.refFile] = request;
            }

            await onProcessing.call(requestData);
          }

          if (messageQueueItem is MessageQueueRequestItem<SendMessageRequest>) {
            final requestData = messageQueueItem.messageRequest;
            final onProcessing = messageQueueItem.onProcessing;

            // process the message as needed by the function passed
            await onProcessing.call(requestData);
          }
        } catch (e, stackTrace) {
          // Log error but continue processing remaining messages in queue
          // The onSendFail callback should have already been called to mark the message as failed
          _log.e(
            UChatLogMessage(
              message: 'Error processing message in queue, continuing with next message.',
              error: e,
              stackTrace: stackTrace,
              additionalData: {
                'messageRef': messageRef,
                'roomId': roomId,
                'remainingInQueue': _sendMessageQueue[roomId]?.length,
              },
            ),
            e,
            stackTrace,
          );
        }

        // remove the message from the running queue and stop the metric
        _sendMessageQueueRunning.remove(messageRef);
      }
      _log.d('after _sendMessageQueue: $roomId');
    } catch (e, stackTrace) {
      _log.e('Error in _processSendMessageQueue', e, stackTrace);
    }
  }

  /// To cancel the message in the queue
  ///
  /// [refFile] is the reference of the message file
  /// [foreCancelUpload] is the flag to cancel the upload request
  ///
  /// This method will cancel the message in the queue by calling the [onSendFail] function
  void cancelSendFile({
    required String? refMessage,
    required String? refFile,
    required String? roomId,
    bool foreCancelUpload = false,
  }) {
    try {
      if (refFile == null) {
        return;
      }

      // get the message request and file request
      final messageQueueItem = _sendMessageQueue[roomId]?.firstWhereOrNull(
        (item) => item.messageRequest.ref == refMessage,
      );
      final fileRequest = sendingFileRequests[refFile];
      if (fileRequest == null) {
        final messageRequest = messageQueueItem?.messageRequest;
        if (messageRequest is SendMultiFileMessageRequest) {
          // Cancel any in-progress video compression (FFmpegKit session)
          if (foreCancelUpload) {
            FileService.instance.cancelVideoCompression();
          }

          // remove the message from the running queue
          for (final req in messageRequest.requestList) {
            // remove the message from the running queue and call the onSendFail function
            // for making message to be failed
            sendingFileRequests.remove(req.refFile);
            req.onSendFail?.call();
            if (foreCancelUpload) {
              req.cancelToken?.cancel();
            }
          }

          _sendMessageQueueRunning.remove(refMessage);
          _sendMessageQueue[roomId]?.removeWhere((item) => item.messageRequest.ref == refMessage);
        }
        return;
      }

      // remove the message from the running queue
      sendingFileRequests.remove(refFile);
      // call the onSendFail function to cancel the message
      fileRequest.onSendFail?.call();

      if (foreCancelUpload) {
        // Cancel any in-progress video compression (FFmpegKit session)
        FileService.instance.cancelVideoCompression();
        // if the file is uploading, cancel the upload request
        fileRequest.cancelToken?.cancel();
      }
    } catch (e, stackTrace) {
      _log.e('cancelSendFile error', e, stackTrace);
    }
  }
}
