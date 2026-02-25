import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/screens/files/widgets/file_item_widget.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/uchat_image.dart';

class FilePreviewWidget extends StatelessWidget {
  final List<String> fileMonthList;

  /// fileMonthList is month in List that need to show
  /// Example [December 2024, September 2024, June 2024, April 2023,]
  final Map<String, List<MessageFileModel>> fileGroupedObjMap;

  /// fileGroupedObjMap is Map<month,List<File>>
  /// Example {December : MessageFileModel(field data blah blah blah)}
  final Future<void> Function()? onRefresh;
  final bool hasMore;
  final bool isLoadingMoreFile;
  final Future<void> Function()? loadMoreFile;
  final Function(MessageFileModel)? onTap;
  final Function(MessageFileModel)? onDownloadFile;
  final Function(MessageFileModel)? onCancelDownloadFile;
  final Function(MessageFileModel)? onOpenFolder;

  const FilePreviewWidget({
    super.key,
    required this.fileMonthList,
    required this.fileGroupedObjMap,
    this.onRefresh,
    this.hasMore = false,
    this.isLoadingMoreFile = false,
    this.loadMoreFile,
    this.onTap,
    this.onDownloadFile,
    this.onCancelDownloadFile,
    this.onOpenFolder,
  });

  String fileSubtitle(MessageFileModel file) {
    final fileSizeText = FileService.instance.fileSizeStr(file.size);
    String formattedDate = '';
    if (file.createdAt != null) {
      formattedDate = file.createdAt?.format(
            'd MMM, y HH:mm',
            Get.locale?.toLanguageTag() ?? 'en-US',
          ) ??
          '';
    }

    if (file.downloadStatus == FileDownloadStatus.loading) {
      final fileSize = file.size ?? 0;
      final downloadProgress = file.downloadProgress;
      final downloadProgressText = FileService.instance.fileSizeStr((fileSize * downloadProgress).toInt());
      return '$downloadProgressText / $fileSizeText - $formattedDate';
    } else {
      return '${'Size'.tr} $fileSizeText - $formattedDate';
    }
  }

  String monthString(String month) {
    return DateFormat('MMMM y', Get.locale?.toLanguageTag() ?? 'en-US')
        .parse(month)
        .format('MMM y', Get.locale?.toLanguageTag() ?? 'en-US');
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return RefreshIndicator(
          onRefresh: () async {
            await onRefresh?.call();
          },
          child: ListView.builder(
            itemCount: fileMonthList.length + (hasMore ? 1 : 0),
            itemBuilder: (BuildContext context, int monthIndex) {
              if (monthIndex >= fileMonthList.length && hasMore && !isLoadingMoreFile) {
                loadMoreFile?.call();
                if (isLoadingMoreFile) {
                  return const Center(child: CircularProgressIndicator(strokeCap: StrokeCap.round));
                } else {
                  return const SizedBox.shrink();
                }
              } else if (monthIndex < fileMonthList.length) {
                final month = fileMonthList[monthIndex];
                final filesInMonth = fileGroupedObjMap[month]!;
                filesInMonth.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

                return Container(
                  color: const Color(0xFFF9F9F9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 40.spMin,
                        decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.spMin),
                            child: Text(
                              monthString(month),
                              style: TextStyle(
                                fontSize: 12.spMin,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF4D4D4D),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filesInMonth.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 5);
                        },
                        itemBuilder: (context, fileIndex) {
                          final file = filesInMonth[fileIndex];

                          late Widget fileIcon;

                          if (file.url?.isNotEmpty == true && file.isPasswordProtected != true) {
                            fileIcon = ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: UChatImage.network(
                                FileService().getFileUrl(file.url ?? ''),
                                fit: BoxFit.cover,
                                height: 50.spMin,
                                width: 50.spMin,
                              ),
                            );
                          } else {
                            fileIcon = Image.asset(
                              FileService.instance.getFileIcon(
                                isLockedFile: file.isPasswordProtected ?? false,
                                filename: file.name,
                              ),
                              cacheWidth: 50.cacheSize,
                            );
                          }

                          return FileItemWidget(
                            file: file,
                            subtitle: fileSubtitle(file),
                            downloadProgress: file.downloadProgress,
                            downloadStatus: file.downloadStatus,
                            onTapFile: () {
                              onTap?.call(file);
                            },
                            fileIcon: fileIcon,
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        );
      },
    );
  }
}
