import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/chat_room_list/presentation/controllers/search/chat_search_messages_controller.dart';
import 'package:uchat/features/chat_room_list/presentation/views/widgets/search/searched_message_item.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/widgets/app_bar/app_bar_default.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class ChatListSearchMessageScreen extends GetView<ChatSearchMessagesController> {
  const ChatListSearchMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      backgroundColor: context.theme.appColors.backgroundNeutralLightest,
      appBar: AppBarDefault(
          title: 'Search'.tr,
          leadingButton: AppControlButton.back(
            context: context,
            onTap: () => Get.back(),
          )),
      child: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomScrollView(
              slivers: [
                _buildHeadText(context),
                _messages(),
              ],
            ),
            Obx(() {
              if (controller.isLoadingMoreMessage.value) {
                return Container(
                  padding: const EdgeInsets.all(AppSpace.space4),
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundGray.withValues(alpha: .8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    width: AppSize.size12,
                    height: AppSize.size12,
                    child: CircularProgressIndicator(
                      color: context.theme.appColors.iconInverse,
                      strokeWidth: 4,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }

  PagedSliverList<int, MessageCollection> _messages() {
    return PagedSliverList<int, MessageCollection>(
      pagingController: controller.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) {
          final message = item.message;
          if (message != null) {
            final displayMessage = message.displayMarkUp(getDisplay: true);
            if (!displayMessage.contains(controller.args.keyword)) {
              return const SizedBox.shrink();
            }
          }

          return SearchedMessageItem(
            message: item,
            onPressed: () {
              controller.handleJumpToMessage(item);
            },
            subtitleHighlight: controller.args.keyword,
          );
        },
        firstPageProgressIndicatorBuilder: (context) => _loadingIndicator(),
        newPageProgressIndicatorBuilder: (context) => _loadingIndicator(),
      ),
    );
  }

  Widget _buildHeadText(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.spMin,
            vertical: 12.spMin,
          ),
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style.copyWith(
                    color: const Color(0xFF808080),
                    fontSize: 15,
                  ),
              children: [
                TextSpan(
                  text: ' "${controller.args.keyword}" ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '@count messages found'.trParams({
                    'count': controller.args.searchResult.foundMessageCount.toString(),
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: UTheme.color.primary,
      ),
    );
  }
}
