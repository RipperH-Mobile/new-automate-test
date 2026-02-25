import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/entities/models/resolution.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/utils/datetime.dart';
import 'package:uchat/widgets/file_info/file_info_item.dart';
import 'package:uchat/widgets/sheet/uchat_bottom_sheet.dart';

class FileInfoList extends StatelessWidget {
  const FileInfoList({
    super.key,
    required this.items,
  });

  final List<FileInfoItem> items;

  static Future<T?> show<T>({
    required BuildContext context,
    required FileInfoList fileSheet,
  }) {
    return UChatBottomSheet.showBottomSheet<T>(
      context: context,
      widget: fileSheet,
      isScrollControlled: true,
    );
  }

  factory FileInfoList.file({
    int? size,
    String? sendByName,
    DateTime? bookmarkAt,
  }) {
    return FileInfoList(
      items: [
        if (bookmarkAt != null)
          FileInfoItem(
            title: 'Add to Bookmark'.tr,
            value: _formatDateTime(bookmarkAt),
          ),
        if (size != null)
          FileInfoItem(
            title: 'Size'.tr,
            value: FileService.instance.fileSizeStr(size),
          ),
        if (sendByName != null)
          FileInfoItem(
            title: 'Send by'.tr,
            value: sendByName,
          ),
      ],
    );
  }

  factory FileInfoList.image({
    int? size,
    Resolution? resolution,
    String? sendByName,
    DateTime? bookmarkAt,
  }) {
    return FileInfoList(
      items: [
        if (bookmarkAt != null)
          FileInfoItem(
            title: 'Add to Bookmark'.tr,
            value: _formatDateTime(bookmarkAt),
          ),
        if (size != null)
          FileInfoItem(
            title: 'Size'.tr,
            value: FileService.instance.fileSizeStr(size),
          ),
        if (resolution != null)
          FileInfoItem(
            title: 'resolution',
            value: '${resolution.width!.toInt()} x ${resolution.height!.toInt()}',
          ),
        if (sendByName != null)
          FileInfoItem(
            title: 'Send by'.tr,
            value: sendByName,
          ),
      ],
    );
  }

  factory FileInfoList.video({
    int? size,
    Resolution? resolution,
    String? sendByName,
    double? videoDuration,
    DateTime? bookmarkAt,
  }) {
    return FileInfoList(
      items: [
        if (bookmarkAt != null)
          FileInfoItem(
            title: 'Add to Bookmark'.tr,
            value: _formatDateTime(bookmarkAt),
          ),
        if (size != null)
          FileInfoItem(
            title: 'Size'.tr,
            value: FileService.instance.fileSizeStr(size),
          ),
        if (videoDuration != null)
          FileInfoItem(
            title: 'Clip duration'.tr,
            value: Duration(
              milliseconds: videoDuration.toInt(),
            ).formattedVideoTime,
          ),
        if (resolution != null)
          FileInfoItem(
            title: 'Resolution',
            value: '${resolution.width!.toInt()} x ${resolution.height!.toInt()}',
          ),
        if (sendByName != null)
          FileInfoItem(
            title: 'Send by'.tr,
            value: sendByName,
          ),
      ],
    );
  }

  factory FileInfoList.audio({
    int? size,
    String? sendByName,
    double? audioDuration,
    DateTime? bookmarkAt,
  }) {
    return FileInfoList(
      items: [
        if (bookmarkAt != null)
          FileInfoItem(
            title: 'Add to Bookmark'.tr,
            value: _formatDateTime(bookmarkAt),
          ),
        if (size != null)
          FileInfoItem(
            title: 'Size'.tr,
            value: FileService.instance.fileSizeStr(size),
          ),
        if (audioDuration != null)
          FileInfoItem(
            title: 'Clip duration'.tr,
            value: Duration(
              milliseconds: audioDuration.toInt(),
            ).formattedVideoTime,
          ),
        if (sendByName != null)
          FileInfoItem(
            title: 'Send by'.tr,
            value: sendByName,
          ),
      ],
    );
  }

  factory FileInfoList.link({
    String? sendByName,
    DateTime? bookmarkAt,
  }) {
    return FileInfoList(
      items: [
        if (bookmarkAt != null)
          FileInfoItem(
            title: 'Add to Bookmark'.tr, //1 ม.ค. 2024  15:30
            value: _formatDateTime(bookmarkAt),
          ),
        if (sendByName != null)
          FileInfoItem(
            title: 'Send by'.tr,
            value: sendByName,
          ),
      ],
    );
  }

  factory FileInfoList.location({
    String? sendByName,
    DateTime? bookmarkAt,
  }) {
    return FileInfoList(
      items: [
        if (bookmarkAt != null)
          FileInfoItem(
            title: 'Add to Bookmark'.tr, //1 ม.ค. 2024  15:30
            value: _formatDateTime(bookmarkAt),
          ),
        if (sendByName != null)
          FileInfoItem(
            title: 'Send by'.tr,
            value: sendByName,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        height: 0,
        thickness: 1,
        color: Color(0xFFF2F2F2),
      ),
      itemBuilder: (BuildContext context, int index) {
        return FileInfoItem(
          title: items[index].title,
          value: items[index].value,
        );
      },
    );
  }
}

String _formatDateTime(DateTime dateTime) {
  return dateTime.format('d MMM yyyy HH:mm');
}
