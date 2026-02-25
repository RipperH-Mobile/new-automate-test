import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_asset_path.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/entities/interfaces/contact_interface.dart';
import 'package:uchat/features/chat_room/data/models/collections/room_collection.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';
import 'package:uchat/widgets/dialog/report/report_controller.dart';

class ReportConfirmDialog extends GetView<ReportController> {
  const ReportConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.isMobile)
              Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                    bottom: 25,
                    left: 20,
                    right: 20,
                  ),
                  height: 6.spMin,
                  width: 65.spMin,
                  decoration: BoxDecoration(
                    color: const Color(0xFFCCCCCC),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            if (controller.isMobile)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: controller.handleBackToPrevious,
                      child: Text(
                        'Back'.tr,
                        style: TextStyle(
                          color: UTheme.color.primary,
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      'Confirm reporting'.tr,
                      style: TextStyle(
                        fontSize: 18.spMin,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    InkWell(
                      onTap: controller.closeReportModal,
                      child: Text(
                        'Cancel'.tr,
                        style: TextStyle(
                          color: UTheme.color.primary,
                          fontSize: 16.spMin,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: controller.closeReportModal,
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(
                      width: 20.spMin,
                    ),
                    Expanded(
                      child: Text(
                        'Confirm reporting'.tr,
                        style: TextStyle(
                          fontSize: 18.spMin,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: controller.handleCloseAllReportDialogs,
                      child: SizedBox(
                        width: 30.spMin,
                        child: Image.asset(
                          UChatAssetPath.clearIcon,
                          cacheWidth: 30.cacheSize,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (controller.isMobile)
              const SizedBox(
                height: 20,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Builder(
                builder: (context) {
                  if (controller.reportType == ReportType.reportUser ||
                      controller.reportType == ReportType.reportGroup) {
                    return _buildReportUserOrGroupPreview();
                  } else if (controller.reportType == ReportType.reportMessage) {
                    return _buildReportMessagePreview();
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 10),
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: [..._buildConfirmMessage()],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: controller.isMobile
                  ? const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                    )
                  : const EdgeInsets.only(
                      top: 20,
                      left: 20,
                      right: 20,
                      bottom: 24,
                    ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      key: const ValueKey('confirm'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        disabledBackgroundColor: const Color(0xFFCCCCCC),
                        backgroundColor: UTheme.color.primary,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        fixedSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: controller.handleSendReport,
                      child: Text(
                        'Confirm'.tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.spMin,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReportUserOrGroupPreview() {
    return Row(
      children: [
        Builder(builder: (context) {
          if (controller.contact != null) {
            return AvatarWrapper<ContactInterface>(
              data: controller.contact,
              hasBorder: true,
              radius: 25,
            );
          } else if (controller.room != null) {
            return AvatarWrapper<RoomCollection>(
              data: controller.room,
              hasBorder: false,
              radius: 25,
              groupWidth: 25,
              groupHeight: 25,
            );
          }

          return const SizedBox.shrink();
        }),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Builder(
            builder: (context) {
              final bool hasOriginalStatusMessage = controller.contact?.originalStatusMessage != null &&
                  controller.contact!.originalStatusMessage!.isNotEmpty;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.getFriendOrRoomName(),
                    style: TextStyle(
                      color: const Color(0xFF4D4D4D),
                      fontSize: 14.spMin,
                      fontWeight: FontWeight.w500,
                      height: 1.6,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (hasOriginalStatusMessage)
                    Text(
                      controller.contact?.originalStatusMessage ?? '',
                      style: TextStyle(
                        color: const Color(0xFF4D4D4D),
                        fontSize: 12.spMin,
                        fontWeight: FontWeight.w400,
                        height: 1.6,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildReportMessagePreview() {
    // final message = controller.message;
    // TODO refactor message ui and use it here.
    return const SizedBox.shrink();
  }

  List<InlineSpan> _buildConfirmMessage() {
    if (controller.reportType == ReportType.reportBug) {
      return _buildReportBugConfirmMessage();
    } else if (controller.reportType == ReportType.reportMessage) {
      return _buildReportMessageConfirmMessage();
    } else if (controller.reportType == ReportType.reportUser || controller.reportType == ReportType.reportGroup) {
      return _buildReportUserOrGroupConfirmMessage();
    } else {
      return [];
    }
  }

  List<TextSpan> _buildReportUserOrGroupConfirmMessage() {
    return [
      TextSpan(
        text: 'You want to report'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextSpan(
        text: ' ${controller.getFriendOrRoomName()} ',
        style: TextStyle(
          color: const Color(0xFF333333),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: 'that this user is'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextSpan(
        text: ' ${controller.reportTopicText} ',
        style: TextStyle(
          color: const Color(0xFFFF1552),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: 'Is it right?'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];
  }

  List<TextSpan> _buildReportMessageConfirmMessage() {
    return [
      TextSpan(
        text: 'You want to report that this message from'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextSpan(
        text: ' ${controller.message?.displayName} ',
        style: TextStyle(
          color: const Color(0xFF333333),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: 'is'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextSpan(
        text: ' ${controller.reportTopicText} ',
        style: TextStyle(
          color: const Color(0xFFFF1552),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: 'Is it right?'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];
  }

  List<TextSpan> _buildReportBugConfirmMessage() {
    return [
      TextSpan(
        text: 'You want to report issue'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
      TextSpan(
        text: ' ${controller.reportRemarkText()} ',
        style: TextStyle(
          color: const Color(0xFFFF1552),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w600,
        ),
      ),
      TextSpan(
        text: 'Is it right?'.tr,
        style: TextStyle(
          color: const Color(0xFF666666),
          fontSize: 16.spMin,
          fontWeight: FontWeight.w400,
        ),
      ),
    ];
  }
}
