import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:uchat/entities/enums.dart';
import 'package:uchat/features/media/media_viewer/data/model/media_file_model.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/features/media/media_viewer/presentation/view/widget/uchat_image_provider.dart';
import 'package:uchat/utils/uchat_image.dart';

class ImageWidget extends StatelessWidget {
  final MediaFileModel roomFile;
  final bool isCurrentIndexShowing;

  const ImageWidget({
    super.key,
    required this.roomFile,
    required this.isCurrentIndexShowing,
  });

  @override
  Widget build(BuildContext context) {
    final imageWidgetSize = 100.spMin;
    if (roomFile.fileType == MessageFileType.video) {
      late Widget child;
      if (roomFile.thumbnailPath != null) {
        // If file path is not null, Show thumbnail from local device.
        child = ClipRRect(
          borderRadius: BorderRadius.circular(8.spMin),
          child: Container(
            width: imageWidgetSize,
            height: imageWidgetSize,
            decoration: BoxDecoration(
              image: UChatImageProvider(
                provider: UChatImage.networkProvider(
                  roomFile.thumbnailPath!,
                ),
                width: roomFile.width,
                height: roomFile.height,
              ).build(),
            ),
          ),
        );
      } else {
        // Otherwise use thumbnail from server.
        child = ClipRRect(
          borderRadius: BorderRadius.circular(8.spMin),
          child: Container(
            width: imageWidgetSize,
            height: imageWidgetSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.spMin),
              image: UChatImageProvider(
                provider: UChatImage.networkProvider(
                  FileService().getFileUrl(roomFile.thumbnailPath ?? ''),
                ),
                width: roomFile.width,
                height: roomFile.height,
              ).build(),
            ),
          ),
        );
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(8.spMin),
        child: Stack(
          children: [
            child,
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(8.spMin),
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            if (!isCurrentIndexShowing)
              Container(
                color: Colors.black.withValues(alpha: 0.6),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(16),
                // ),
              ),
          ],
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.spMin),
        child: Container(
          width: imageWidgetSize,
          height: imageWidgetSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.spMin),
            image: UChatImageProvider(
              provider: UChatImage.networkProvider(roomFile.url),
              width: roomFile.width,
              height: roomFile.height,
            ).build(),
          ),
          child: !isCurrentIndexShowing
              ? Stack(
                  children: [
                    Container(
                      color: Colors.black.withValues(alpha: 0.6),
                    ),
                  ],
                )
              : null,
        ),
      );
    }
  }
}
