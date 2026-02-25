import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uchat/api/http.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/chat_room/data/models/models/message_file_model.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/sticker/domain/abstracts/sticker_pack_entity.dart';
import 'package:uchat/features/sticker/domain/entities/store_sticker_pack_entity.dart';
import 'package:uchat/features/sticker/presentation/views/widgets/sticker_item_preview/sticker_item_preview.dart';
import 'package:uchat/utils/extension/extension.dart';

class UChatSharingItemPreviewer<T> extends StatelessWidget {
  final List<T> fileList;
  final List<String> messageSelection;
  final Widget? customPreviewWidget;

  const UChatSharingItemPreviewer({
    super.key,
    this.fileList = const [],
    this.messageSelection = const [],
    this.customPreviewWidget,
  });

  Color get backgroundColor => const Color(0xFFF9F9F9);

  Color get borderColor => const Color(0xFFE6E6E6);

  String get titlePreview {
    if (messageSelection.isNotEmpty && fileList.isNotEmpty) {
      return '@count file@s and text'.trParams({
        'count': fileList.length.toString(),
        's': fileList.length > 1 ? 's' : '',
      });
    }

    if (fileList.isNotEmpty) {
      final file = fileList.first;
      if (file is StickerPackEntity) {
        return file.name.isNotEmpty ? file.name : 'UChat company';
      }

      if (file is MessageFileModel || file is MediaFileModel) {
        return '@count file@s'.trParams({
          'count': fileList.length.toString(),
          's': fileList.length > 1 ? 's' : '',
        });
      }
    }

    return '';
  }

  /// Get the preview text for the subtitle.
  /// If there are multiple files, it will show the file names.
  /// If there are multiple messages, it will show the messages.
  /// If there are both files and messages, it will show the files first and then the messages.
  String get subTitlePreview {
    String text = '';

    final int fileLength = fileList.length;
    final int msgLength = messageSelection.length;

    for (var i = 0; i < fileLength; i++) {
      final file = fileList[i];

      if (file is StoreStickerPackEntity) {
        text += 'UChat company';
      }

      if (file is MessageFileModel) {
        if (i != fileLength - 1) {
          text += '${file.longShortName}\n';
        } else {
          text += '${file.longShortName}';
        }
      }

      if (file is MediaFileModel) {
        if (i != fileLength - 1) {
          text += '${file.fileName}\n';
        } else {
          text += file.fileName;
        }
      }
    }

    if (msgLength == 0) {
      return text;
    }

    text += '\n';
    for (var i = 0; i < msgLength; i++) {
      if (i != msgLength - 1) {
        text += '${messageSelection[i]}\n';
      } else {
        text += messageSelection[i];
      }
    }

    return text;
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Row();
    EdgeInsets padding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 14,
    );

    if (customPreviewWidget != null) {
      content = customPreviewWidget!;
    } else {
      if (fileList.isNotEmpty) {
        final firstFile = fileList.first;

        // This is preview file widget for MessageFileModel
        if (firstFile is MessageFileModel) {
          content = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.spMin),
                child: Builder(
                  builder: (context) {
                    final areaSize = 72.spMin;
                    Widget previewMediaArea;

                    if ([MessageFileType.image, MessageFileType.video, MessageFileType.gif].contains(firstFile.type)) {
                      String fileUrl = firstFile.url ?? firstFile.apiFileUrl!;

                      if (firstFile.type == MessageFileType.video) {
                        fileUrl =
                            firstFile.thumbnailPath ?? FileService.instance.getFileUrl(firstFile.thumbnailFileId ?? '');
                      }

                      previewMediaArea = SizedBox(
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
                      final fileIconSize = 60.spMin;
                      final filePath = firstFile.url ?? firstFile.apiFileUrl!;
                      previewMediaArea = Container(
                        width: areaSize,
                        height: areaSize,
                        padding: const EdgeInsets.all(18),
                        color: const Color(0xFFE6E6E6),
                        child: SizedBox(
                          width: fileIconSize,
                          height: fileIconSize,
                          child: Image.asset(
                            FileService.instance.getFileIcon(
                              isLockedFile: false,
                              filename: filePath,
                            ),
                            cacheHeight: fileIconSize.cacheSize,
                          ),
                        ),
                      );
                    }

                    if (fileList.length == 1) {
                      return previewMediaArea;
                    }

                    return Stack(
                      children: [
                        previewMediaArea,
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
                    if (titlePreview.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5.spMin,
                        ),
                        child: Text(
                          titlePreview,
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
                      subTitlePreview,
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
          );
        }

        if (firstFile is MediaFileModel) {
          content = Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.spMin),
                child: Builder(
                  builder: (context) {
                    final areaSize = 72.spMin;
                    Widget previewMediaArea;

                    if ([
                      MessageFileType.image,
                      MessageFileType.video,
                      MessageFileType.gif,
                    ].contains(firstFile.fileType)) {
                      String fileUrl = firstFile.url;

                      if (firstFile.fileType == MessageFileType.video) {
                        fileUrl = firstFile.thumbnailPath ?? '';
                      }

                      previewMediaArea = SizedBox(
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
                      final fileIconSize = 60.spMin;
                      final filePath = firstFile.url;
                      previewMediaArea = Container(
                        width: areaSize,
                        height: areaSize,
                        padding: const EdgeInsets.all(18),
                        color: const Color(0xFFE6E6E6),
                        child: SizedBox(
                          width: fileIconSize,
                          height: fileIconSize,
                          child: Image.asset(
                            FileService.instance.getFileIcon(
                              isLockedFile: false,
                              filename: filePath,
                            ),
                            cacheHeight: fileIconSize.cacheSize,
                          ),
                        ),
                      );
                    }

                    if (fileList.length == 1) {
                      return previewMediaArea;
                    }

                    return Stack(
                      children: [
                        previewMediaArea,
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
                    if (titlePreview.isNotEmpty) ...[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 5.spMin,
                        ),
                        child: Text(
                          titlePreview,
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
                      subTitlePreview,
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
          );
        }

        // This is preview file widget for StickerPackModel
        if (firstFile is StoreStickerPackEntity) {
          content = Row(
            children: [
              StickerItemPreview(
                packId: firstFile.id,
                fileId: firstFile.coverId,
                width: 72.spMin,
                height: 72.spMin,
              ),
              SizedBox(
                width: 8.spMin,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titlePreview,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.spMin,
                    ),
                  ),
                  SizedBox(
                    height: 5.spMin,
                  ),
                  Text(
                    subTitlePreview,
                    style: TextStyle(
                      fontSize: 13.spMin,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      } else {
        padding = const EdgeInsets.all(12);
        content = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              subTitlePreview,
              style: TextStyle(
                color: const Color(0xFF333333),
                fontSize: 12.spMin,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        );
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
        ),
      ),
      constraints: BoxConstraints(minHeight: 100.spMin),
      padding: padding,
      child: content,
    );
  }
}
