import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:uchat/api/giphy/models/gif.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/cupertino_context_menu/cupertino_context_menu_widget_expanded.dart' as custom_context_menu;
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_search_box.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/domain/entities/gif_sending_entity.dart';
import 'package:uchat/features/chat_room/presentation/controllers/input/chat_room_gif_input_controller.dart';
import 'package:uchat/features/chat_room/presentation/widgets/swipe_bar.dart';
import 'package:uchat/features/media_gallery/presentation/views/widgets/media_gallery_context_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';

import 'chat_room_custom_input.dart';

class ChatRoomGifInput extends GetView<ChatRoomGifInputController> {
  final Function(GifSendingEntity, {int loopCount}) onSendGif;
  final SwipeBar swipeBar;
  final String? controllerTag;

  @override
  String? get tag => controllerTag;

  const ChatRoomGifInput({
    super.key,
    required this.onSendGif,
    required this.swipeBar,
    this.controllerTag,
  });

  static const double headerHeight = AppSearchBox.height;

  double get bottomPadding {
    final viewBottomPadding = Get.mediaQuery.viewPadding.bottom;
    final bottomPadding = ChatRoomCustomInput.inputNavigationHeight + viewBottomPadding + AppSpace.space8;
    return bottomPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space4,
              ),
              child: AppSearchBox(
                controller: controller.searchInputController,
                focusNode: controller.focusNode,
                onSubmitted: (_) {
                  controller.searchGif();
                },
              ),
            ),
            swipeBar,
          ],
        ),
        Expanded(
          child: Obx(
            () {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                padding: EdgeInsets.only(
                  bottom: bottomPadding,
                ),
                itemCount: controller.gifList.length,
                itemBuilder: (context, index) {
                  return _buildGifImage(
                    gif: controller.gifList[index],
                    context: context,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGifImage({
    required GiphyGif gif,
    required BuildContext context,
  }) {
    final image = UChatImage.network(
      gif.priorityUrl,
      cacheKey: '${gif.id}-thumbnail',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      customLoadingWidget: (state) {
        return Padding(
          padding: const EdgeInsets.all(
            AppSpace.space2,
          ),
          child: SpinKitRing(
            lineWidth: 2,
            color: context.theme.appColors.iconInverse,
          ),
        );
      },
      customErrorWidget: (state) {
        return GestureDetector(
          child: Icon(
            Icons.refresh,
            color: context.theme.appColors.iconError,
          ),
          onTap: () {
            state.reLoadImage();
          },
        );
      },
    );

    if (UserController.instance.enableTroubleshoot) {
      return custom_context_menu.CupertinoContextMenu.builder(
        actions: [
          MediaGalleryContextMenu(
            parentContext: context,
            text: 'Send'.tr,
            onTap: () {
              controller.onSendSampleGif(gif: gif, onSendGif: onSendGif);
            },
            tailing: Assets.vectors.send.svg(
              colorFilter: ColorFilter.mode(context.theme.appColors.icon, BlendMode.srcIn),
              width: 20.spMin,
              height: 20.spMin,
            ),
          )
        ],
        onJustTap: () {
          controller.selectGif(
            gif,
            onSendGif,
          );
        },
        builder: (_, __) {
          return image;
        },
      );
    } else {
      return GestureDetector(
        onTap: () {
          controller.selectGif(
            gif,
            onSendGif,
          );
        },
        child: image,
      );
    }
  }
}
