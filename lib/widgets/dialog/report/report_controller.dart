import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/data_sources/remote/chat_room_api_service.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/features/chat_room/data/models/requests/send_report_request.dart';
import 'package:uchat/features/contact/data/models/collections/contact_collection.dart';
import 'package:uchat/utils/handle_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/utils/uchat_utils.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/dialog/report/report_confirm_dialog.dart';
import 'package:uchat/widgets/dialog/report/report_dialog.dart';

final _log = useLogger();

class ReportController extends GetxController {
  ReportType reportType;
  ContactCollection? contact;
  RoomCollection? room;
  MessageCollection? message;

  final pageViewController = PageController();
  final reportRemarkTextController = TextEditingController();
  final reportRemarkText = ''.obs;
  final reportRemarkFocus = FocusNode();
  final canSendReport = false.obs;
  final reportTopic = ReportTopic.other.obs;

  bool get isMobile => UChatScreenUtil.instance.isMobile;

  ReportController({
    required this.reportType,
    this.contact,
    this.room,
    this.message,
  });

  @override
  void onClose() {
    pageViewController.dispose();
    reportRemarkTextController.dispose();
    reportRemarkFocus.dispose();
    super.onClose();
  }

  String getReportDialogTitle() {
    switch (reportType) {
      case ReportType.reportBug:
        return 'Report a problem'.tr;
      case ReportType.reportGroup:
        return 'Report a group'.tr;
      case ReportType.reportMessage:
        return 'Report a message'.tr;
      case ReportType.reportUser:
        return 'Report a user'.tr;
    }
  }

  String getReportDialogDescription() {
    switch (reportType) {
      case ReportType.reportBug:
        return 'Specify the issues you\'d like to report for our team to investigate'.tr;
      case ReportType.reportGroup:
        return 'Specify the issues you\'d like to report to the group for our team to investigate. We will not let the person being reported know who made the report'
            .tr;
      case ReportType.reportMessage:
        return 'Specify the issues you\'d like to report with the message for our team to investigate. We will not let the person being reported know who made the report'
            .tr;
      case ReportType.reportUser:
        return 'Specify the issues you\'d like to report with the user for our team to investigate. We will not inform the person being reported who made the report.'
            .tr;
    }
  }

  String getFriendOrRoomName() {
    if (reportType == ReportType.reportUser) {
      return contact?.nickname ?? contact?.showName ?? 'UNKNOWN'.tr;
    } else if (reportType == ReportType.reportGroup) {
      return room?.title ?? 'UNKNOWN'.tr;
    }
    return '';
  }

  String get reportTopicText {
    if ([ReportType.reportUser, ReportType.reportGroup].contains(reportType)) {
      switch (reportTopic.value) {
        case ReportTopic.other:
          return reportRemarkText.value;
        case ReportTopic.childAbuse:
          return 'Child abuse'.tr.toLowerCase();
        case ReportTopic.copyRight:
          return 'Copy right'.tr.toLowerCase();
        case ReportTopic.pornography:
          return 'Obscenity'.tr.toLowerCase();
        case ReportTopic.spam:
          return 'Spam'.tr.toLowerCase();
        case ReportTopic.violence:
          return 'Violence'.tr.toLowerCase();
      }
    } else {
      return reportRemarkText.value;
    }
  }

  /// Open report dialog.
  /// When report type is [ReportType.reportUser] contact is required.
  /// When report type is [ReportType.reportGroup] room is required.
  /// When report type is [ReportType.reportMessage] message is required.
  /// If callBackOnOpen is true Get.back() will be called on open report dialog.
  static Future<void> handleOpenDialog({
    required BuildContext context,
    required ReportType reportType,
    ContactCollection? contact,
    RoomCollection? room,
    MessageCollection? message,
    bool callBackOnOpen = false,
  }) async {
    if (callBackOnOpen) {
      Get.back();
    }
    if (!Get.isRegistered<ReportController>()) {
      Get.put<ReportController>(ReportController(
        reportType: reportType,
        contact: contact,
        room: room,
        message: message,
      ));
    } else {
      final controller = Get.find<ReportController>();
      controller.reportType = reportType;
      controller.contact = contact;
      controller.room = room;
      controller.message = message;
    }

    if (UChatScreenUtil.instance.isMobile) {
      showCupertinoModalBottomSheet<bool>(
        context: context,
        backgroundColor: const Color(0xFFF9F9F9),
        barrierColor: Colors.black.withValues(alpha: 0.7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return const ReportDialog();
        },
      );
    } else {
      UChatDialog.showCustomDialog(
        child: (_) => const ReportDialog(),
      );
    }
  }

  void onChangedRemark(String? text) {
    final text = reportRemarkTextController.value.text.trim();
    canSendReport.value = text.isNotEmpty;
    reportRemarkText.value = text;
  }

  void clearRemark() {
    reportRemarkTextController.clear();
    reportRemarkText.value = '';
    canSendReport.value = false;
  }

  void closeReportModal() {
    clearRemark();
    Get.back();
  }

  void handleSelectTopic({
    required ReportTopic topic,
  }) {
    _log.i('selectedTopic: $topic');
    reportTopic.value = topic;
    if (topic == ReportTopic.other) {
      pageViewController.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      reportRemarkFocus.requestFocus();
    } else {
      if (isMobile) {
        Get.back();
      }
      handleConfirmReport(Get.context!);
    }
  }

  void handleSendOtherReport() {
    // clearRemark();
    if (isMobile) {
      Get.back();
    }
    handleConfirmReport(Get.context!);
  }

  Future<void> handleConfirmReport(BuildContext context) async {
    if (isMobile) {
      showCupertinoModalBottomSheet<bool>(
        context: context,
        backgroundColor: const Color(0xFFF9F9F9),
        barrierColor: Colors.black.withValues(alpha: 0.7),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (_) {
          return const ReportConfirmDialog();
        },
      );
    } else {
      UChatDialog.showCustomDialog(
        child: (_) => const ReportConfirmDialog(),
      );
    }
  }

  void handleBackToPrevious() {
    handleOpenDialog(
      context: Get.context!,
      reportType: reportType,
      contact: contact,
      room: room,
      message: message,
      callBackOnOpen: true,
    );
  }

  Future<void> handleSendReport() async {
    try {
      UChatLoading.show();
      final remarkText = reportRemarkText.value.isNotEmpty ? reportRemarkText.value : null;
      MetaSendReportRequest meta = MetaSendReportRequest();

      if (reportType == ReportType.reportMessage) {
        meta = meta.copyWith(
          roomId: message?.roomId,
          messageId: message?.id,
        );
      }

      if (reportType == ReportType.reportGroup) {
        meta = meta.copyWith(
          roomId: room?.id,
        );
      }

      if (reportType == ReportType.reportUser) {
        meta = meta.copyWith(
          userId: contact?.id,
        );
      }

      final reportRequest = OpenSupportTicketRequest(
        type: reportType,
        topic: reportTopic.value,
        remark: remarkText,
        meta: meta,
      );

      // TODO (refactor clean) Move this logic to use case ?
      await GetIt.I<ChatRoomApiService>().openSupportTicket(
        reportRequest,
      );
      clearRemark();
      if (isMobile) {
        Get.back();
      } else {
        handleCloseAllReportDialogs();
      }
      UChatLoading.hide();
      await UChatDialog.showDialog(
        title: 'Received a report'.tr,
        description: 'Our team will check the message and proceed according to the terms of use'.tr,
        cancelButtonColor: const Color(0xFFE6E6E6),
        cancelText: 'Close'.tr,
        showConfirmButton: false,
      );
    } catch (e, stackTrace) {
      handleException(e, onUnknownException: () {
        _log.e('handleSendReport error.', e, stackTrace);
        UChatLoading.failed();
      });
    }
  }

  void handleCloseAllReportDialogs() {
    UChatUtils.instance.closeAllDialogs();
  }
}
