import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/performance_tracing_service.dart';

void registerSendingMsgPerformanceService() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.mainTrace.value),
    instanceName: SendingMsgTracingName.mainTrace.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.putMessageToLocal.value),
    instanceName: SendingMsgTracingName.putMessageToLocal.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.encryptTrace.value),
    instanceName: SendingMsgTracingName.encryptTrace.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.sendMessageProcessing.value),
    instanceName: SendingMsgTracingName.sendMessageProcessing.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.sendMessageToServerNetWork.value),
    instanceName: SendingMsgTracingName.sendMessageToServerNetWork.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.createMessageCollectionTypeFile.value),
    instanceName: SendingMsgTracingName.createMessageCollectionTypeFile.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.createSendMultiFileMessageRequest.value),
    instanceName: SendingMsgTracingName.createSendMultiFileMessageRequest.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.compressingVideoFile.value),
    instanceName: SendingMsgTracingName.compressingVideoFile.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.compressingImageFile.value),
    instanceName: SendingMsgTracingName.compressingImageFile.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.getFileInfo.value),
    instanceName: SendingMsgTracingName.getFileInfo.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.sendOneFileToServer.value),
    instanceName: SendingMsgTracingName.sendOneFileToServer.value,
  );
  getIt.registerSingleton<SendingMsgPerformanceServiceImpl>(
    SendingMsgPerformanceServiceImpl(tracingName: SendingMsgTracingName.generateMessageFile.value),
    instanceName: SendingMsgTracingName.generateMessageFile.value,
  );
}

enum SendingMsgTracingName {
  mainTrace('performance_send_msg_1_1_flutter'),
  sendMessageProcessing('performance_send_msg_1_1_flutter_send_message_processing'),
  sendMessageToServerNetWork('performance_send_msg_1_1_flutter_send_to_server_network'),
  putMessageToLocal('performance_send_msg_1_1_flutter_put_to_local'),
  createMessageCollectionTypeFile('performance_send_msg_1_1_flutter_create_msg_collection_file'),
  createSendMultiFileMessageRequest('performance_send_msg_1_1_flutter_create_multi_file_request'),
  compressingImageFile('performance_send_msg_1_1_flutter_compress_image_file'),
  compressingVideoFile('performance_send_msg_1_1_flutter_compress_video_file'),
  getFileInfo('performance_send_msg_1_1_flutter_get_file_info'),
  sendOneFileToServer('performance_send_msg_1_1_flutter_send_one_file_to_server'),
  encryptTrace('performance_send_msg_1_1_flutter_encrypt'),
  generateMessageFile('performance_send_msg_1_1_flutter_generate_message_file');

  final String value;
  const SendingMsgTracingName(this.value);
}

enum SendingMsgMetricName {
  fileAmount('file_amount'),
  messageSizeInBytes('message_size_in_bytes');

  final String value;
  const SendingMsgMetricName(this.value);
}

enum SendingMsgAttributeName {
  loopCount('loop_count'),
  messageRef('message_ref'),
  fileRef('file_ref'),
  messageType('message_type'),
  messageSizeInBytes('message_size_in_bytes'),
  messageSizeAfterCompressInBytes('message_size_after_compress_in_bytes'),
  networkType('network_type');

  final String value;
  const SendingMsgAttributeName(this.value);
}

class SendingMsgPerformanceServiceImpl extends PerformanceTracingService {
  SendingMsgPerformanceServiceImpl({required super.tracingName});

  static SendingMsgPerformanceServiceImpl get mainTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.mainTrace.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get putMessageToLocalTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.putMessageToLocal.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get encryptTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.encryptTrace.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get sendMessageProcessingTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.sendMessageProcessing.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get sendMessageToServerNetWorkTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.sendMessageToServerNetWork.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get createMessageCollectionTypeFileTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.createMessageCollectionTypeFile.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get createSendMultiFileMessageRequestTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.createSendMultiFileMessageRequest.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get compressingVideoFileTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.compressingVideoFile.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get compressingImageFileTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.compressingImageFile.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get getFileInfoTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.getFileInfo.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get sendOneFileToServerTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.sendOneFileToServer.value,
    );
  }

  static SendingMsgPerformanceServiceImpl get generateMessageFileTrace {
    return GetIt.I<SendingMsgPerformanceServiceImpl>(
      instanceName: SendingMsgTracingName.generateMessageFile.value,
    );
  }

  void putTraceAttributes({
    required String messageRef,
    required String messageType,
    bool isEmoji = false,
    String? fileRef,
    int messageSizeInBytes = 0,
    int loopCount = 1,
  }) {
    activeTrace.putAttribute(SendingMsgAttributeName.messageRef.value, messageRef);
    activeTrace.putAttribute(SendingMsgAttributeName.messageType.value, isEmoji ? 'EMOJI' : messageType);

    if (messageSizeInBytes > 0) {
      activeTrace.putMetric(SendingMsgMetricName.messageSizeInBytes.value, messageSizeInBytes);
    }
    activeTrace.putAttribute(SendingMsgAttributeName.loopCount.value, loopCount.toString());
    if (fileRef != null && fileRef.isNotEmpty) {
      activeTrace.putAttribute(SendingMsgAttributeName.fileRef.value, fileRef);
    }
  }
}
