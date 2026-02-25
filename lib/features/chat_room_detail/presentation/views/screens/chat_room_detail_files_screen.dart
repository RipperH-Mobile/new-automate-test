import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_files_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/features/media/media_viewer/domain/services/file_service.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailFilesScreen extends GetView<ChatRoomDetailFilesController> {
  final String? roomTag;

  @override
  String? get tag => roomTag;

  const ChatRoomDetailFilesScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: ChatRoomDetailAlbumAppBar(
          title: 'Files'.tr,
          subtitle: '@fileCount Files'.trParams({
            'fileCount': controller.fileCount.toString(),
          }),
        ),
        child: GetBuilder<ChatRoomDetailFilesController>(
          id: ChatRoomDetailFilesIds.fileListView,
          tag: tag,
          builder: (controller) {
            if (controller.isInitializing) {
              return _buildLoadingIndicator();
            } else if (controller.roomFiles.isEmpty) {
              return _buildNotFound(context);
            }

            return ListView.builder(
              controller: controller.scrollController,
              itemCount: controller.roomFiles.length,
              itemBuilder: (BuildContext context, int index) {
                final fileResult = controller.roomFiles[index];

                return GestureDetector(
                  onTap: () => controller.handleOpenFile(fileResult.file, index),
                  child: Container(
                    color: context.theme.appColors.backgroundNeutralLighter,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppSpace.space2,
                                bottom: AppSpace.space2,
                                left: AppSpace.space4,
                                right: AppSpace.space3,
                              ),
                              child: Stack(
                                children: [
                                  if (fileResult.file.isPasswordProtected == true)
                                    Assets.vectors.lockedFileCover.svg(
                                      height: AppSize.size16.spMin,
                                      width: AppSize.size16.spMin,
                                    )
                                  else if ((fileResult.file.thumbnailFileId ?? '').isNotEmpty)
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedLg)),
                                      child: UChatImage.network(
                                        FileService.instance.getFileUrl(fileResult.file.thumbnailFileId ?? ''),
                                        fit: BoxFit.cover,
                                        height: AppSize.size16.spMin,
                                        width: AppSize.size16.spMin,
                                        customLoadingWidget: (state) {
                                          return Container(
                                            color:
                                                context.theme.appColors.backgroundNeutralLight.withValues(alpha: 0.5),
                                            child: CupertinoActivityIndicator(
                                              radius: AppSize.size3,
                                              color: context.theme.appColors.backgroundNeutralLightPressed,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  else
                                    Assets.vectors.fileCoverDefault.svg(
                                      height: AppSize.size16.spMin,
                                      width: AppSize.size16.spMin,
                                    ),
                                  Obx(() {
                                    return Container(
                                      alignment: Alignment.center,
                                      height: AppSize.size16,
                                      width: AppSize.size16,
                                      decoration: BoxDecoration(
                                        color: controller.downloadStateList[index] == true
                                            ? Colors.black.withValues(alpha: 0.2)
                                            : Colors.transparent,
                                        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.roundedLg)),
                                      ),
                                      child: controller.downloadStateList[index] == true
                                          ? SizedBox(
                                              height: 30.spMin,
                                              width: 30.spMin,
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                  color: context.theme.appColors.backgroundNeutralLightest,
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    );
                                  }),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: AppSpace.space4),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 0.3,
                                      color: context.theme.appColors.borderDark,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    AppSpace.space3.verticalSpace,
                                    AppText.body3Bold(
                                      controller.getFileName(fileResult.file.name ?? ''),
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      context: context,
                                    ),
                                    2.verticalSpace,
                                    AppText.body4(
                                      controller.getFileExtensionFileSizeAndSentDate(fileResult.file),
                                      color: context.theme.appColors.textLight,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      context: context,
                                    ),
                                    AppText.body4(
                                      'Sent by ${controller.getSenderName(fileResult.accountId ?? '')}'.tr,
                                      color: context.theme.appColors.textLight,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      context: context,
                                    ),
                                    AppSpace.space3.verticalSpace,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );
    });
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.heading4(
            'No files'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDarkest,
          ),
          AppText.body3(
            'No files have been shared in this\nchat room yet.'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDark,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
