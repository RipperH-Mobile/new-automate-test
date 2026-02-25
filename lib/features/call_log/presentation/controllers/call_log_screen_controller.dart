import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/entities/enum/room_type.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/call/data/models/models/room_call_model.dart';
import 'package:uchat/features/call/domain/params/start_call_param.dart';
import 'package:uchat/features/call/domain/user_cases/start_call_use_case.dart';
import 'package:uchat/features/call/livekit/parent/uchat_livekit_controller.dart';
import 'package:uchat/features/call/utils/enum.dart';
import 'package:uchat/features/call_log/data/models/enum/call_action_type.dart';
import 'package:uchat/features/call_log/domain/entities/call_log_with_contact_entity.dart';
import 'package:uchat/features/call_log/domain/events/update_notify_new_call_log_event.dart';
import 'package:uchat/features/call_log/domain/use_cases/delete_selected_call_logs_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/get_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/domain/use_cases/get_local_call_logs_with_contact_use_case.dart';
import 'package:uchat/features/call_log/presentation/utils/call_log_tracer.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/routes/routes.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

final _log = useLogger();

class CallLogScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  static CallLogScreenController get instance => Get.find();

  ConnectivityController get connectivityCtl => ConnectivityController.instance;

  TabController? listTabController;
  ScrollController? allScrollController;
  ScrollController? missedScrollController;

  StreamSubscription? _updateNotifyCallLog;

  static const pageSize = 50;

  // Rx variables for call logs & pagination.
  final callLogs = <CallLogWithContactEntity>[].obs;
  final missedCallLogs = <CallLogWithContactEntity>[].obs;
  final allCurrentPage = 1.obs;
  final isLoadingAll = false.obs;
  final hasMoreAll = true.obs;
  final missedCurrentPage = 1.obs;
  final isLoadingMissed = false.obs;
  final hasMoreMissed = true.obs;

  // Observable new call count.
  final newCallCount = 0.obs;

  // Key for last seen time in storage.
  final String lastSeenKey = 'LAST_CALL_LOG_SEEN_TIME';

  final config = ConfigDb();

  @override
  void onInit() {
    super.onInit();
    _updateNotifyCallLog = eventBus.on<UpdateNotifyNewCallLogEvent>().listen((event) async {
      newCallCount.value = 1;
      await config.authenticated.saveConfig(
        key: lastSeenKey,
        value: newCallCount.value,
      );
    });
  }

  void onUserLoaded() async {
    try {
      listTabController ??= TabController(length: 2, vsync: this);
      allScrollController ??= ScrollController()..addListener(_onAllScroll);
      missedScrollController ??= ScrollController()..addListener(_onMissedScroll);
    } catch (e) {
      _log.e('Error initializing TabController: ', e);
    }

    newCallCount.value = await config.authenticated.getIntWithDefault(
      key: lastSeenKey,
      defaultValue: 0,
    );

    loadInitial();
  }

  @override
  void onClose() {
    allScrollController?.dispose();
    missedScrollController?.dispose();
    listTabController?.dispose();
    _updateNotifyCallLog?.cancel();
    super.onClose();
  }

  void _onAllScroll() {
    final controller = allScrollController;
    if (controller == null || !controller.hasClients) return;
    if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
      loadMoreAll();
    }
  }

  void _onMissedScroll() {
    final controller = missedScrollController;
    if (controller == null || !controller.hasClients) return;
    if (controller.position.pixels >= controller.position.maxScrollExtent - 200) {
      loadMoreMissed();
    }
  }

  /// Mark call logs as seen:
  /// Update to reset newCallCount, and clear lastSeenKey.
  Future<void> markCallLogsAsSeen() async {
    await config.authenticated.clearConfig(key: lastSeenKey);
    newCallCount.value = 0;
  }

  void handleSearch() async {
    Get.toNamed(Routes.callLogSearchScreen);
  }

  /// Load locally cached call logs and populate UI immediately before server fetch.
  Future<void> loadLocalCallLogs() async {
    try {
      final allResult = await GetIt.I<GetLocalCallLogsWithContactUseCase>().call(
        const GetLocalCallLogsWithContactUseCaseParams(limit: pageSize),
      );
      callLogs.assignAll(allResult);

      final missedResult = await GetIt.I<GetLocalCallLogsWithContactUseCase>().call(
        const GetLocalCallLogsWithContactUseCaseParams(
          limit: pageSize,
          callActionType: CallActionType.missed,
        ),
      );
      missedCallLogs.assignAll(missedResult);
    } catch (e, stackTrace) {
      _log.e('loadLocalCallLogs error in CallLogScreenController.', e, stackTrace);
    }
  }

  /// Refresh call logs from the server.
  Future<void> loadInitial() async {
    // Load cached call logs first.
    await loadLocalCallLogs();
    // Then, fetch from server to update data.
    await Future.wait([
      fetchCallLogs(reset: true),
      fetchMissedCallLogs(reset: true),
    ]);
  }

  Future<void> fetchMissedCallLogs({bool reset = false}) async {
    if (isLoadingMissed.value) return;
    if (reset) {
      missedCurrentPage.value = 1;
      hasMoreMissed.value = true;
    }
    if (!hasMoreMissed.value) return;

    isLoadingMissed.value = true;

    try {
      await CallLogTracer.trace(
        name: CallLogTraceNames.fetch,
        initialAttributes: {
          CallLogAttributeNames.callActionType: CallActionType.missed.value,
        },
        body: (trace) async {
          final fetchStopwatch = Stopwatch()..start();
          final result = await GetIt.I<GetCallLogsWithContactUseCase>().call(
            GetCallLogsWithContactUseCaseParams(
              page: missedCurrentPage.value,
              pageSize: pageSize,
              callActionType: CallActionType.missed,
            ),
          );
          fetchStopwatch.stop();

          final data = result.data?.toList() ?? [];
          if (missedCurrentPage.value == 1) {
            missedCallLogs.assignAll(data);
          } else {
            missedCallLogs.addAll(data);
          }

          if (missedCurrentPage.value >= result.totalPages) {
            hasMoreMissed.value = false;
          }

          trace.incrementMetric(CallLogMetricNames.fetchDuration, fetchStopwatch.elapsedMilliseconds);
          trace.incrementMetric(CallLogMetricNames.callLogsCount, data.length);
          trace.incrementMetric(CallLogMetricNames.pageNumber, missedCurrentPage.value);
          trace.incrementMetric(CallLogMetricNames.totalPages, result.totalPages);
        },
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('fetchMissedCallLogs error in CallLogScreenController.', e, stackTrace);
    } finally {
      isLoadingMissed.value = false;
    }
  }

  Future<void> loadMoreAll() async {
    if (!hasMoreAll.value || isLoadingAll.value) return;
    allCurrentPage.value++;
    await fetchCallLogs();
  }

  Future<void> loadMoreMissed() async {
    if (!hasMoreMissed.value || isLoadingMissed.value) return;
    missedCurrentPage.value++;
    await fetchMissedCallLogs();
  }

  Future<void> fetchCallLogs({bool reset = false}) async {
    if (isLoadingAll.value) return;
    if (reset) {
      allCurrentPage.value = 1;
      hasMoreAll.value = true;
    }
    if (!hasMoreAll.value) return;

    isLoadingAll.value = true;

    try {
      await CallLogTracer.trace(
        name: CallLogTraceNames.fetch,
        initialAttributes: {
          CallLogAttributeNames.callActionType: '',
        },
        body: (trace) async {
          final fetchStopwatch = Stopwatch()..start();
          final result = await GetIt.I<GetCallLogsWithContactUseCase>().call(
            GetCallLogsWithContactUseCaseParams(
              page: allCurrentPage.value,
              pageSize: pageSize,
            ),
          );
          fetchStopwatch.stop();

          final data = result.data?.toList() ?? [];

          if (allCurrentPage.value == 1) {
            callLogs.assignAll(data);
          } else {
            callLogs.addAll(data);
          }
          if (allCurrentPage.value >= result.totalPages) {
            hasMoreAll.value = false;
          }

          trace.incrementMetric(CallLogMetricNames.fetchDuration, fetchStopwatch.elapsedMilliseconds);
          trace.incrementMetric(CallLogMetricNames.callLogsCount, data.length);
          trace.incrementMetric(CallLogMetricNames.pageNumber, allCurrentPage.value);
          trace.incrementMetric(CallLogMetricNames.totalPages, result.totalPages);
        },
      );
    } on FailedHostLookupException catch (_) {
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    } catch (e, stackTrace) {
      _log.e('fetchCallLogs error in CallLogScreenController.', e, stackTrace);
    } finally {
      isLoadingAll.value = false;
    }
  }

  Future<void> deleteCallLog(BuildContext context, String callLogId) async {
    await CallLogTracer.trace(
      name: CallLogTraceNames.delete,
      initialAttributes: {
        CallLogAttributeNames.callLogId: callLogId,
      },
      body: (trace) async {
        await UChatNewDialog.showDialog(
          context: context,
          title: 'Delete this call'.tr,
          description: 'Permanently remove this call. This action can\'t be undone.'.tr,
          cancelText: 'Cancel'.tr,
          confirmText: 'Delete'.tr,
          confirmTextColor: context.theme.appColors.textError,
          cancelTextColor: context.theme.appColors.textLight,
          isDestructive: true,
          onConfirm: () async {
            try {
              final deleteStopwatch = Stopwatch()..start();
              await GetIt.I<DeleteSelectedCallLogsUseCase>().call(
                [callLogId],
              );
              deleteStopwatch.stop();

              callLogs.removeWhere((log) => log.id == callLogId);
              missedCallLogs.removeWhere((log) => log.id == callLogId);

              trace.incrementMetric(CallLogMetricNames.deleteDuration, deleteStopwatch.elapsedMilliseconds);
              trace.incrementMetric(CallLogMetricNames.logsDeletedCount, 1);
            } on FailedHostLookupException catch (_) {
              UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
            } catch (e, stackTrace) {
              _log.e('deleteCallLog error in CallLogScreenController.', e, stackTrace);
              UChatNewDialog.showGeneralErrorDialog(
                context: Get.context!,
                e: e is Exception ? e : null,
              );
            }
          },
        );
      },
    );
  }

  Future<void> handleCall(BuildContext context, CallLogWithContactEntity callLogModel) async {
    final confirmed = await UChatNewDialog.showDialog(
      context: context,
      title: 'Start @callType call'.trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
      }),
      description: 'Are you sure you want to start a @callType call with @displayName?'.trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      cancelText: 'Cancel'.tr,
      confirmText: 'Call'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      cancelTextColor: context.theme.appColors.textLight,
      isDestructive: true,
    );

    if (confirmed != true) {
      return;
    }

    // Check permissions (mic/camera)
    final passPerms = await checkPermissionBeforeCall(context, callLogModel.callType);
    if (!passPerms) return;

    // Check isDeletedUser
    if (callLogModel.contact?.isDeleted == true) {
      if (callLogModel.roomType == RoomType.group) {
        await checkIsInGroup(context, callLogModel);
        return;
      }
      await checkIsDeletedUser(context, callLogModel);
      return;
    }

    // Check isBlockedUser
    if (callLogModel.contact?.isBlocked == true) {
      await checkIsBlockedUser(context, callLogModel);
      return;
    }

    // Build image URL safely – fall back to empty string when IDs are missing.
    final String imageUrl;
    if (callLogModel.roomType == RoomType.group) {
      final photoId = callLogModel.room?.photoId;
      imageUrl = photoId != null ? FileService.instance.getFileUrl(photoId) : '';
    } else {
      final avatarId = callLogModel.contact?.avatarId;
      imageUrl = avatarId != null ? FileService.instance.getAvatarUrl(avatarId) : '';
    }

    final callData = RoomCallModel(
      imageBlurHash: callLogModel.room?.photoBlurhash,
      roomCallId: '',
      liveKitRoomSID: '',
      callState: CallState.idle,
      roomId: callLogModel.roomId,
      callType: callLogModel.callType,
      roomType: callLogModel.roomType,
      title: callLogModel.contact?.displayName,
      imageUrl: imageUrl,
      liveKitToken: '',
      callConnectionType:
          callLogModel.roomType == RoomType.group ? CallConnectionType.startGroup : CallConnectionType.start,
    );
    final param = StartCallParam(
      callData: callData,
    );
    await GetIt.I<StartCallUseCase>().call(param);
  }

  Future<bool> checkPermissionBeforeCall(BuildContext context, CallType callType) async {
    // For non-macOS devices, check permissions.
    if (!GetPlatform.isMacOS) {
      // Microphone permission
      bool micGranted = await PermissionController.instance.requestMicrophonePermissionDirect(context);
      if (!micGranted) {
        return false;
      }

      // Camera permission (for video calls)
      if (callType == CallType.video) {
        bool cameraGranted = await PermissionController.instance.requestCameraPermissionDirect(context);
        if (!cameraGranted) {
          return false;
        }
      }
    }

    return true;
  }

  Future<void> checkIsInGroup(BuildContext context, CallLogWithContactEntity callLogModel) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callLogModel.callType.value.capitalizeFirst ?? '',
      }),
      description: "You can't start a @callType call with \n@displayName because you are \nnot a member.".trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  Future<void> checkIsDeletedUser(BuildContext context, CallLogWithContactEntity callLogModel) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callLogModel.callType.value.capitalizeFirst ?? '',
      }),
      description:
          "You can't start a @callType call with \n@displayName because their account \nhas been deleted".trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  Future<void> checkIsBlockedUser(BuildContext context, CallLogWithContactEntity callLogModel) async {
    return UChatNewDialog.showSingleButtonDialog(
      context: context,
      title: 'Cannot Start @callType Call'.trParams({
        'callType': callLogModel.callType.value.capitalizeFirst ?? '',
      }),
      description:
          "You can't start a @callType call with \n@displayName because their account \nhas been blocked".trParams({
        'callType': callLogModel.callType.value.toLowerCase(),
        'displayName': callLogModel.contact?.displayName ?? 'Unknown'.tr,
      }),
      confirmText: 'Got it'.tr,
      confirmTextColor: context.theme.appColors.textPrimary,
      isDestructive: true,
      onConfirm: () async {
        Get.back();
      },
    );
  }

  void handleCallLogsSelectScreen() async {
    Get.toNamed(Routes.callLogSelectScreen);
  }
}
