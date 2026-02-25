import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/connectivity_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/room_file_type.dart';
import 'package:uchat/features/chat_room_detail/domain/entities/room_file_entity.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/blurhash.dart';
import 'package:uchat/utils/extension/extension.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailMediaItem extends StatelessWidget {
  final VoidCallback onTap;
  final RoomFileEntity roomFile;

  const ChatRoomDetailMediaItem({super.key, required this.onTap, required this.roomFile});

  /// Get the duration text
  ///
  /// This value is used to generate the duration text of the video
  ///
  /// - If the duration is greater than or equal to 60 minutes, return the duration in format `00:00:00 (hh:mm:ss)`
  /// - If the duration is less than 60 minutes, return the duration in format `00:00 (mm:ss)`
  String get durationText {
    final duration = Duration(
      milliseconds: roomFile.file.duration?.toInt() ?? 0,
    );

    if (duration.inMinutes >= 60) {
      // show in format 00:00:00 (hh:mm:ss)
      return duration.toString().split('.').first.padLeft(8, '0');
    } else {
      // show in format 00:00 (mm:ss)
      return duration.toString().split('.').first.substring(2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        transitionOnUserGestures: true,
        tag: MediaViewerService.instance.generateMediaHeroTag(
          openFrom: MediaViewerOpenFrom.roomDetail,
          heroTag: roomFile.file.heroTag ?? roomFile.file.apiFileUrl ?? roomFile.file.url ?? '',
        ),
        child: Builder(
          builder: (context) {
            final file = roomFile.file;
            final errorStateWidget = SizedBox(
              child: Assets.vectors.iconBlankImage.svg(),
            );
            if (ConnectivityController.instance.isOffline) {
              return errorStateWidget;
            }

            ImageProvider<Object> imageProvider;
            if (file.type?.toRoomFileType == RoomFileType.video) {
              if (file.thumbnailPath != null) {
                imageProvider = FileImage(File(file.thumbnailPath!));
              } else {
                imageProvider = UChatImage.networkProvider(
                  FileService.instance.getFileUrl(file.thumbnailFileId ?? ''),
                );
              }
            } else {
              imageProvider = UChatImage.networkProvider(file.apiFileUrl ?? '');
            }

            final previewImage = ExtendedImage(
              key: ValueKey('chat_room_detail_media-${roomFile.id}-${roomFile.messageSeq}'),
              image: ExtendedResizeImage.resizeIfNeeded(
                provider: imageProvider,
                cacheWidth: file.thumbnailWidth?.toInt().cacheSize,
                cacheHeight: file.thumbnailHeight?.toInt().cacheSize,
              ),
              width: 200.spMin,
              height: 200.spMin,
              filterQuality: FilterQuality.low,
              fit: BoxFit.cover,
              loadStateChanged: (state) {
                final loadState = state.extendedImageLoadState;
                Widget imageChild = const SizedBox.shrink();
                if (loadState == LoadState.loading) {
                  if (file.blurhash != null) {
                    imageChild = BlurHash(
                      key: ValueKey('chat_room_detail_media_blurhash-${roomFile.id}-${roomFile.messageSeq}'),
                      hash: blurhashDefault(file.blurhash),
                    );
                  } else {
                    imageChild = const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }

                if (loadState == LoadState.failed) {
                  imageChild = errorStateWidget;
                }

                if (loadState == LoadState.completed) {
                  imageChild = SizedBox(
                    child: state.completedWidget,
                  );
                }

                return AnimatedSwitcher(
                  key: ValueKey(
                    'chat_room_detail_media-memory_image_element_switcher-${roomFile.id}-${roomFile.messageSeq}',
                  ),
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeIn,
                  child: imageChild,
                );
              },
            );

            if (roomFile.type == RoomFileType.video) {
              return Stack(
                children: [
                  previewImage,
                  Positioned(
                    right: AppSpace.space1,
                    bottom: AppSpace.space1,
                    child: RepaintBoundary(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpace.space2,
                            vertical: AppSpace.space05,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xFF0E1216).withValues(alpha: .8),
                                const Color(0xFF333942).withValues(alpha: .8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                          ),
                          child: AppText.body3(
                            durationText,
                            context: context,
                            color: context.theme.appColors.textPrimaryInverse,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return previewImage;
            }
          },
        ),
      ),
    );
  }
}
