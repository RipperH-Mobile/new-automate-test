// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/uchat_image.dart';

class FileItemWidget extends StatelessWidget {
  final MessageFileModel file;
  final FileDownloadStatus? downloadStatus;
  final double downloadProgress;
  final VoidCallback onTapFile;
  final String subtitle;
  final Widget? fileIcon;

  const FileItemWidget({
    super.key,
    required this.file,
    required this.downloadStatus,
    required this.downloadProgress,
    required this.onTapFile,
    required this.subtitle,
    this.fileIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFile,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Color.fromARGB(40, 128, 128, 128)),
              ),
              color: const Color(0xFFF2F2F2),
              shadowColor: Colors.black,
              elevation: 0,
              child: ListTile(
                leading: Material(
                  elevation: 0.2,
                  borderRadius: BorderRadius.circular(12),
                  color: const Color(0xFFE6E6E6),
                  child: SizedBox(
                    width: 49.spMin,
                    height: 49.spMin,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 35.spMin,
                          width: 35.spMin,
                          child: fileIcon ??
                              (file.thumbnailFileId?.isNotEmpty == true && file.isPasswordProtected != true
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: UChatImage.network(
                                        FileService().getFileUrl(file.thumbnailFileId ?? ''),
                                        fit: BoxFit.cover,
                                        height: 50.spMin,
                                        width: 50.spMin,
                                      ),
                                    )
                                  : Image.asset(
                                      FileService().getFileIcon(
                                        isLockedFile: file.isPasswordProtected ?? false,
                                        filename: file.name,
                                      ),
                                      cacheWidth: 35.spMin.cacheSize,
                                    )),
                        ),
                        if (downloadStatus == FileDownloadStatus.loading)
                          Positioned(
                            right: 12,
                            bottom: 12,
                            child: SizedBox(
                              width: 25.spMin,
                              height: 25.spMin,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.spMin,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                title: Text(
                  file.name ?? 'UNKNOWN'.tr,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF808080),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onTap: onTapFile,
              ),
            ),
            if (downloadStatus == FileDownloadStatus.loading)
              Positioned.fill(
                left: 5,
                top: 5,
                right: 5,
                bottom: 5,
                child: LiquidLinearProgressIndicator(
                  value: downloadProgress,
                  valueColor: const AlwaysStoppedAnimation(Color.fromARGB(72, 0, 0, 0)),
                  backgroundColor: const Color(0x44FFFFFF),
                  borderColor: const Color(0x44FFFFFF),
                  borderWidth: -1.0,
                  borderRadius: 20.0,
                  direction: Axis.vertical,
                  center: Text('${(downloadProgress * 100).round()}%'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
