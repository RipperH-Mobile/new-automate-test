import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/features/report/data/models/enum/report_topic.dart';
import 'package:uchat/features/report/data/models/enum/report_type.dart';
import 'package:uchat/features/report/data/models/report_response.dart';
import 'package:uchat/features/report/domain/use_cases/report_use_case.dart';
import 'package:uchat/features/report/presentation/controller/leave_remark_controller.dart';
import 'package:uchat/features/report/presentation/controller/select_topic_controller.dart';
import 'package:uchat/features/report/presentation/views/main_dialog.dart';
import 'package:uchat/routes/app_pages.dart';
import 'package:uchat/widgets/loading/loading.dart';

// TODO: Refactor this controller
class MainDialogController extends GetxController {
  ReportType reportType;
  String displayName;
  String? roomId;
  String? messageId;
  String? userId;
  bool? isOwnerInGroup;
  bool enableLeaveGroup = true;
  int reportStep = 0;

  ReportUseCase reportUserCase = GetIt.I<ReportUseCase>();

  MainDialogController(
      {required this.reportType,
      required this.displayName,
      this.isOwnerInGroup,
      this.roomId,
      this.messageId,
      this.userId});

  var pageViewController = PageController();

  int get step {
    return reportStep;
  }

  @override
  void onClose() {
    pageViewController.dispose();
    Get.find<SelectTopicController>().dispose();
    super.onClose();
  }

  void init() {
    if (Get.isRegistered<SelectTopicController>()) {
      Get.find<SelectTopicController>().init();
    } else {
      Get.put<SelectTopicController>(SelectTopicController()).init();
    }
    if (Get.isRegistered<LeaveRemarkController>()) {
      Get.find<LeaveRemarkController>().init();
    } else {
      Get.put<LeaveRemarkController>(LeaveRemarkController()).init();
    }
  }

  void onChangePage(int index) {
    reportStep = reportStep + index;
    pageViewController.animateToPage(
      reportStep,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void handleConfirmReportTopic(ReportTopic topic) {
    reportUserCase.setReportTopic(topic);
    onChangePage(1);
  }

  void handleLeaveRemark(String remark) {
    reportUserCase.setRemark(remark);
    onChangePage(1);
  }

  void clearRemark() {
    reportUserCase.setRemark('');
  }

  Future<ReportResponse> handleReport() async {
    reportUserCase.setReportType(reportType);
    reportUserCase.setId(roomId, messageId, userId);

    var response = await reportUserCase.sendReportTicket();

    return response;
  }

  Future<void> handleBlock() async {
    reportUserCase.blockFriend();
  }

  Future<void> handleLeaveGroup() async {
    await reportUserCase.leaveGroup();
  }

  Future<void> closeDialog() async {
    clearRemark();
    Get.back();
  }

  void backToHomeIfNeeded() async {
    if (roomId == null) {
      return;
    }
    if (Get.currentRoute != Routes.home) {
      Get.until((route) => route.settings.name == Routes.home);
    }
    clearRemark();
    UChatLoading.success(message: 'Leave.'.tr);
  }

  static Future<void> handleOpenDialog({
    required BuildContext context,
    required ReportType reportType,
    required String displayName,
    bool? isOwnerInGroup,
    String? userId,
    String? roomId,
    String? messageId,
    bool enableLeaveGroup = true,
  }) async {
    if (!Get.isRegistered<MainDialogController>()) {
      final controller = Get.put<MainDialogController>(MainDialogController(
        reportType: reportType,
        displayName: displayName,
        roomId: roomId,
        messageId: messageId,
        userId: userId,
        isOwnerInGroup: isOwnerInGroup,
      ));
      controller.reportStep = 0;
      controller.roomId = roomId;
      controller.messageId = messageId;
      controller.userId = userId;
      controller.isOwnerInGroup = isOwnerInGroup;
      controller.enableLeaveGroup = enableLeaveGroup;
      controller.init();
    } else {
      final controller = Get.find<MainDialogController>();
      controller.reportType = reportType;
      controller.displayName = displayName;
      controller.reportStep = 0;
      controller.roomId = roomId;
      controller.messageId = messageId;
      controller.userId = userId;
      controller.isOwnerInGroup = isOwnerInGroup;
      controller.enableLeaveGroup = enableLeaveGroup;
      controller.init();
    }

    showCupertinoModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      expand: false,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      topRadius: const Radius.circular(0),
      builder: (_) {
        return const MainDialog();
      },
    );
  }
}
