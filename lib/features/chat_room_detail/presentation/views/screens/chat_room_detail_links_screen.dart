import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room_detail/data/models/requests/room_links_response.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/chat_room_detail_links_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/chat_room_detail_album_app_bar.dart';
import 'package:uchat/utils/fix_url.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class ChatRoomDetailLinksScreen extends GetView<ChatRoomDetailLinksController> {
  final String? roomTag;

  @override
  String? get tag => roomTag;

  const ChatRoomDetailLinksScreen({super.key, required this.roomTag});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ScaffoldBasic(
        appBar: ChatRoomDetailAlbumAppBar(
          title: 'Links'.tr,
          subtitle: '@linksCount links'.trParams({
            'linksCount': controller.linkCount.toString(),
          }),
        ),
        child: _buildLinks(),
      );
    });
  }

  PagedListView<int, RoomLinksResponse> _buildLinks() {
    return PagedListView<int, RoomLinksResponse>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, linkResult, index) {
          return GestureDetector(
            onTap: () async {
              await controller.openLink(linkResult.url);
            },
            child: Container(
              color: context.theme.appColors.backgroundNeutralLighter,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpace.space4,
                          vertical: AppSpace.space3,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(AppSpace.space2),
                          child: Builder(builder: (context) {
                            String? imageUrl = linkResult.images.isNotEmpty
                                ? linkResult.images.firstOrNull
                                : linkResult.favicons.firstOrNull;

                            if (imageUrl == null) {
                              return Container(
                                width: 40.spMin,
                                height: 40.spMin,
                                color: context.theme.appColors.backgroundGrayLight,
                              );
                            }

                            if (imageUrl.toLowerCase().endsWith('.svg')) {
                              //NOTE.if image is .svg type
                              return SizedBox(
                                width: 40.spMin,
                                height: 40.spMin,
                                child: SvgPicture.network(
                                  imageUrl,
                                  placeholderBuilder: (context) =>
                                      SpinKitCircle(color: context.theme.appColors.backgroundPrimary),
                                ),
                              );
                            }

                            return Image.network(
                              imageUrl,
                              width: 40.spMin,
                              height: 40.spMin,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }

                                final percentage = loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null;
                                return Container(
                                  width: 40.spMin,
                                  height: 40.spMin,
                                  color: context.theme.appColors.backgroundGrayLightest,
                                  padding: const EdgeInsets.all(AppSpace.space2),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      value: percentage,
                                      strokeCap: StrokeCap.round,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                final fixedUrl = fixUrl(imageUrl);

                                return UChatImage.network(fixedUrl, fit: BoxFit.cover, width: 40, height: 40,
                                    customLoadingWidget: (state) {
                                  return SpinKitCircle(
                                    color: context.theme.appColors.backgroundPrimary,
                                  );
                                }, customErrorWidget: (state) {
                                  return const SizedBox.shrink();
                                });
                              },
                            );
                          }),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: AppSpace.space4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: AppSpace.space3,
                              ),
                              AppText.body3Bold(
                                linkResult.title,
                                context: context,
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: AppSpace.space05,
                              ),
                              if (linkResult.description != '')
                                AppText.body4(
                                  linkResult.description,
                                  context: context,
                                  color: context.theme.appColors.textLight,
                                  maxLines: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              const SizedBox(
                                height: AppSpace.space1,
                              ),
                              AppText.body4(
                                linkResult.url,
                                context: context,
                                color: context.theme.appColors.linkText,
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: AppSpace.space3,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 40.spMin + AppSpace.space8,
                    ),
                    child: Divider(
                      height: AppSpace.spacePx,
                      color: context.theme.appColors.borderDark,
                      thickness: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (context) => _buildNotFound(context),
        firstPageProgressIndicatorBuilder: (context) => _buildLoadingIndicator(),
        newPageProgressIndicatorBuilder: (context) => _buildLoadingIndicator(),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          AppText.heading4(
            'No links'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDarkest,
          ),
          AppText.body3(
            'No links have been shared in this\nchat room yet.'.tr,
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
