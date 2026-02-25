import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/models/contact_model.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/chat_room_detail/presentation/controllers/room_detail_search_controller.dart';
import 'package:uchat/features/chat_room_detail/presentation/views/widgets/room_detail_app_bar.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';

class RoomDetailSearchScreen extends GetView<RoomDetailSearchController> {
  // The `roomTag` is using chat `roomId`.
  final String roomTag = Get.parameters['id'] ?? 'NEW_ROOM';

  RoomDetailSearchScreen({
    super.key,
  });

  @override
  String? get tag => roomTag;

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: RoomDetailAppBar(
        titleText: 'Search'.tr,
        isSecret: false,
      ),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppSpace.space2, horizontal: AppSpace.space4),
            height: AppSpace.space10,
            child: SearchBox(
              autofocus: true,
              color: context.theme.appColors.backgroundNeutralLight,
              searchController: controller.searchTextController.value,
              onChanged: (value) {
                controller.handleSearch();
              },
              onSuffixPressed: () {
                controller.clearSearch();
              },
              hasSuffix: false,
            ),
          ),
          _buildContentBody(context)
        ],
      );
    });
  }

  Widget _buildContentBody(BuildContext context) {
    if (controller.searchText.isEmpty) {
      return const SizedBox.shrink();
    }
    if (controller.searchNotFound.value) {
      return Expanded(child: _buildNotFound(context));
    } else {
      return Expanded(
        child: _buildMessages(context),
      );
    }
  }

  PagedListView<int, MessageCollection> _buildMessages(BuildContext context) {
    return PagedListView<int, MessageCollection>(
      pagingController: controller.pagingController,
      shrinkWrap: true,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, messageResult, index) {
          // Safely handle potential null accountId
          final accountId = messageResult.accountId;
          if (accountId == null) {
            return const SizedBox.shrink();
          }
          // Fetch the account using a null-aware operator
          final account = controller.getContact(accountId);

          return GestureDetector(
            onTap: () {
              controller.handleJumpToMessage(messageSearchResult: messageResult);
            },
            child: Container(
              color: context.theme.appColors.backgroundNeutralLightestPressed,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpace.space4),
                        child: AvatarWrapper<ContactModel>(
                          key: ValueKey('account-avatar-${messageResult.accountId}'),
                          data: account,
                          radius: AppSpace.space6,
                          hasBorder: false,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: AppText.subtitle1(
                                    messageResult.displayName,
                                    context: context,
                                    maxLines: 1,
                                    textOverflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: AppSpace.space4),
                                  child: AppText.caption1(
                                    dateString(messageResult.createdAt!),
                                    context: context,
                                    color: context.theme.appColors.textLighter,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: AppSpace.space1,
                            ),
                            buildMessageSearchResult(
                              context,
                              messageResult.searchMessage ?? messageResult.message ?? '',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpace.space20,
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
        firstPageProgressIndicatorBuilder: (context) => const CupertinoActivityIndicator(),
        newPageProgressIndicatorBuilder: (context) => const CupertinoActivityIndicator(),
      ),
    );
  }

  Widget _buildNotFound(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: Get.height / 3,
          ),
          AppText.body2Bold(
            'No results found'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textDark,
          ),
          AppText.body4(
            'Please try searching again with different\nkeywords or check your spelling'.tr,
            context: context,
            textAlign: TextAlign.center,
            color: context.theme.appColors.textLight,
          ),
        ],
      ),
    );
  }

  /// Date string formatter
  /// [date] is the date to be formatted
  /// [return] formatted date string
  String dateString(DateTime date) {
    final DateTime now = DateTime.now().toLocal();
    final DateTime yesterday = now.subtract(const Duration(days: 1));

    if (date.isSameDay(now)) {
      return date.format('HH:mm');
    } else if (date.isSameDay(yesterday)) {
      return 'Yesterday'.tr;
    } else {
      return date.format('MMM d, y');
    }
  }

  /// Message search result widget
  /// [message] is the message to be displayed
  /// [return] message search result widget
  Widget buildMessageSearchResult(BuildContext context, String message) {
    // If message is empty, return empty widget
    if (message.isEmpty) {
      return const SizedBox.shrink();
    }

    // Get search text from search text controller
    String keyword = controller.searchTextController.value.text;
    // use for calculate max length of message
    final int keywordSize = keyword.length;
    // use for determine how many character to be displayed
    final int maxLength = 45 - keywordSize;
    // use for determine how many character to be displayed before keyword if keyword is not at the beginning of message
    const int previousTextLength = 10;

    String displayMessage;
    try {
      // get display message with markup
      displayMessage = message.displayMarkUp(getDisplay: true);
    } catch (e) {
      displayMessage = message;
    }

    List<TextSpan> textSpanList = [];
    // Get all matches of keyword in display message
    final matches = keyword.toLowerCase().allMatches(displayMessage.toLowerCase());

    // If matches is empty, return display message
    if (matches.isEmpty) {
      return RichText(
        text: TextSpan(
          text: displayMessage,
          style: context.theme.appTexts.body4.copyWith(color: context.theme.appColors.textLighter),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }

    // If matches is not empty, add text span to text span list
    for (int i = 0; i < matches.length; i++) {
      final match = matches.elementAt(i);
      final nextMatch = matches.elementAtOrNull(i + 1);
      final endCurrentPhase = nextMatch?.start ?? displayMessage.length;

      // If match is at the beginning of message
      // add text span with color primary
      if (match.start == 0) {
        textSpanList.add(
          TextSpan(
            text: displayMessage.substring(match.start, match.end),
            style: context.theme.appTexts.body4.copyWith(color: context.theme.appColors.textPrimary),
          ),
        );
      }

      // If match is not at the beginning of message and not at the end of message
      // add text span with color primary
      if (match.start > 0 && match.end < displayMessage.length) {
        // match is the first match, but not at the beginning of message
        // add previous text
        if (i == 0) {
          textSpanList.add(
            addPreviousText(
              match: match,
              displayMessage: displayMessage,
              maxLength: maxLength,
              previousTextLength: previousTextLength,
            ),
          );
        }
        // add match text
        textSpanList.add(
          TextSpan(
            text: displayMessage.substring(match.start, match.end),
            style: context.theme.appTexts.body4.copyWith(color: context.theme.appColors.textPrimary),
          ),
        );
      }

      // If match is at the end of message
      //
      if (match.start > 0 && match.end == displayMessage.length) {
        if (i == 0) {
          textSpanList.add(
            addPreviousText(
              match: match,
              displayMessage: displayMessage,
              maxLength: maxLength,
              previousTextLength: previousTextLength,
            ),
          );
        }
        textSpanList.add(
          TextSpan(
            text: displayMessage.substring(match.start, match.end),
            style: context.theme.appTexts.body4.copyWith(color: context.theme.appColors.textPrimary),
          ),
        );
      }

      // If match is at the end of message and not at the beginning of message
      // add remaining text
      if (match.end < displayMessage.length) {
        textSpanList.add(
          TextSpan(
            text: displayMessage.substring(match.end, endCurrentPhase),
            style: context.theme.appTexts.body4,
          ),
        );
      }
    }

    // If display message is longer than max length
    // add ... at the beginning of message
    return RichText(
      text: TextSpan(
        children: textSpanList,
        style: context.theme.appTexts.body4.copyWith(color: context.theme.appColors.textLighter),
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// Add previous text to text span list
  /// [match] is the match of keyword in display message
  /// [displayMessage] is the display message
  /// [maxLength] is the max length of message to be displayed
  /// [previousTextLength] is the length of previous text to be displayed
  TextSpan addPreviousText({
    required Match match,
    required String displayMessage,
    required int maxLength,
    required int previousTextLength,
  }) {
    // If match is at the beginning of message
    // and message is longer than max length
    // add ... at the beginning of message
    // followed by previous text of [previousTextLength] length
    if (match.end >= maxLength) {
      return TextSpan(
        text: '...${displayMessage.substring(
          match.start - previousTextLength,
          match.start,
        )}',
      );
    } else {
      // If match is at the beginning of message and message is shorter than max length
      // add previous text
      return TextSpan(
        text: displayMessage.substring(0, match.start),
      );
    }
  }
}
