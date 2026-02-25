import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/entities/enum/message_file_type.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/extension/extension.dart';

Random r = Random();

class SharePreviewMediaMobile extends StatelessWidget {
  final List<MessageFileModel> fileList;
  final List<String> msgSelection;

  const SharePreviewMediaMobile({
    super.key,
    required this.fileList,
    required this.msgSelection,
  });

  Color get backgroundColor => const Color(0xFFF9F9F9);

  Color get borderColor => const Color(0xFFE6E6E6);

  // String get _buildTitlePreview {
  //   final fileNameList = fileList.map((e) => e.longShortName).toList();
  //   return fileNameList.join(', ');
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.spMin),
            child: Builder(
              builder: (context) {
                if (fileList.length > 1) {
                  return Stack(
                    children: [
                      previewMediaArea(),
                      Positioned.fill(
                        child: Container(
                          height: 72.spMin,
                          width: 72.spMin,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(16.spMin),
                          ),
                          child: Center(
                            child: Text(
                              '+${fileList.length - 1}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.spMin,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return previewMediaArea();
              },
            ),
          ),
          SizedBox(
            width: 16.spMin,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 5.spMin,
                ),
                if (_buildTitlePreview().isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: 5.spMin,
                    ),
                    child: Text(
                      _buildTitlePreview(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: const Color(0xFF333333),
                        fontWeight: FontWeight.w600,
                        fontSize: 16.spMin,
                      ),
                    ),
                  ),
                ],
                Text(
                  _buildSubTitlePreview(),
                  maxLines: 4,
                  style: TextStyle(
                    color: const Color(0xFF333333),
                    fontSize: 14.spMin,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget previewMediaArea() {
    final areaSize = 72.spMin;
    final firstFile = fileList.first;

    if ([MessageFileType.image, MessageFileType.video, MessageFileType.gif].contains(firstFile.type)) {
      String fileUrl = firstFile.url ?? firstFile.apiFileUrl!;

      if (firstFile.type == MessageFileType.video) {
        fileUrl = firstFile.thumbnailPath ?? FileService().getFileUrl(firstFile.thumbnailFileId ?? '');
      }

      return SizedBox(
        width: areaSize,
        height: areaSize,
        child: Image.network(
          fileUrl,
          headers: HttpCaller.instance.apiHeader,
          fit: BoxFit.cover,
          cacheWidth: 72.cacheSize,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }

            return Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Colors.grey.shade300,
              child: Container(
                width: areaSize,
                height: areaSize,
                color: Colors.white,
              ),
            );
          },
        ),
      );
    } else {
      return Container(
        width: areaSize,
        height: areaSize,
        padding: const EdgeInsets.all(18),
        color: const Color(0xFFE6E6E6),
        child: fileIconSelector(firstFile.url ?? firstFile.apiFileUrl!, false),
      );
    }

    //  else if (fileList.length > 1) {
    //   return Stack(
    //     children: [
    //       fileIconSelector(fileList.first.url ?? fileList.first.apiFileUrl!, false),
    //     ],
    //   );
    // } else {
    //   return fileIconSelector(fileList.first.url ?? fileList.first.apiFileUrl!, false);
    // }
    // isLockedFile แค่ใส่ไว้เฉยๆ ยังไม่ได้เช็คความถูกต้อง
  }

  Widget fileIconSelector(String path, bool isPasswordProtected) {
    double size = 60.spMin;

    Widget previewIcon = Icon(
      Icons.file_open_sharp,
      size: size,
    );

    previewIcon = SizedBox(
      width: size,
      height: size,
      child: Image.asset(
        FileService.instance.getFileIcon(
          // isLockedFile แค่ใส่ไว้เฉยๆ ยังไม่ได้เช็คความถูกต้อง
          isLockedFile: isPasswordProtected,
          filename: path,
        ),
        cacheHeight: size.cacheSize,
      ),
    );

    return previewIcon;
  }

  String _buildTitlePreview() {
    if (msgSelection.isNotEmpty && fileList.isNotEmpty) {
      return '@count file@s and text'.trParams({
        'count': fileList.length.toString(),
        's': fileList.length > 1 ? 's' : '',
      });
    }
    if (msgSelection.isNotEmpty) {
      // return '@count text@s'.trParams({
      //   'count': msgSelection.length.toString(),
      //   's': msgSelection.length > 1 ? 's' : '',
      // });
    }
    if (fileList.isNotEmpty) {
      return '@count file@s'.trParams({
        'count': fileList.length.toString(),
        's': fileList.length > 1 ? 's' : '',
      });
    }

    return '';
  }

  String _buildSubTitlePreview() {
    String text = '';
    final int fileLength = fileList.length;
    final int msgLength = msgSelection.length;
    for (var i = 0; i < fileLength; i++) {
      if (i != fileLength - 1) {
        text += '${fileList[i].longShortName}\n';
      } else {
        text += '${fileList[i].longShortName}';
      }
    }
    for (var i = 0; i < msgLength; i++) {
      if (i != msgLength - 1) {
        text += '${msgSelection[i]}\n';
      } else {
        text += msgSelection[i];
      }
    }
    return text;
  }
}
