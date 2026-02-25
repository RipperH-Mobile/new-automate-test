import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/contact/presentation/views/widgets/basic_text_button.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/utils/date.dart';
import 'package:uchat/widgets/avatar/avatar_wrapper.dart';

class SearchedMessageItem extends StatelessWidget {
  final MessageCollection message;
  final void Function()? onPressed;
  final String? subtitleHighlight;
  final bool? isSearchResult;

  const SearchedMessageItem({
    super.key,
    required this.message,
    this.onPressed,
    this.subtitleHighlight,
    this.isSearchResult = false,
  });

  @override
  Widget build(BuildContext context) {
    String? name = message.displayName;
    String? url;

    if (message.accountId != null) {
      url = AccountService().getUserPublicAvatar(message.accountId!);
    } else {
      url = message.account?.avatarUrl;
    }

    // Map to store last known avatarId for each accountId
    Map<String, String> lastAvatarIds = {};

    bool hasAvatarIdChanged(String accountId, String? newAvatarId) {
      // Get the last known avatarId
      String? lastAvatarId = lastAvatarIds[accountId];

      // Update the lastAvatarIds map with the new avatarId
      lastAvatarIds[accountId] = newAvatarId ?? '';

      // Compare and return if there's a change
      return lastAvatarId != newAvatarId;
    }

    if (message.accountId != null) {
      if (hasAvatarIdChanged(message.accountId!, message.account?.avatarId)) {
        CachedNetworkImage.evictFromCache(url!);
      }
    }

    return BasicTextButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        Slidable.of(context)?.close();
        onPressed?.call();
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: AppSpace.space4,
        ),
        height: 80,
        child: Row(
          children: [
            AvatarWrapper(
              radius: 24,
              imageUrl: url,
              id: message.accountId,
            ),
            const SizedBox(width: 14),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: UTheme.textTheme.messageTitle.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Builder(
                          builder: (context) {
                            const maxPrevCharacter = 150;
                            int prevMsgCharacter = 0;
                            String? displayText;

                            // Use searchMessage if available, otherwise fall back to message
                            displayText = message.searchMessage ?? message.message;

                            if (displayText != null) {
                              // Adjust the substring to the specified length
                              if (displayText.length > maxPrevCharacter) {
                                prevMsgCharacter = maxPrevCharacter;
                              } else {
                                prevMsgCharacter = displayText.length;
                              }
                            }

                            return _buildSubtitle(
                              context,
                              displayText?.substring(0, prevMsgCharacter) ?? '',
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  isSearchResult == false
                      ? Container(
                          padding: const EdgeInsets.fromLTRB(0, AppSpace.space3, AppSpace.space4, AppSpace.space3),
                          child: Text(
                            getDateStr(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xffb7b7b8),
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.fromLTRB(0, AppSpace.space3, AppSpace.space4, AppSpace.space3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                getDateStr(),
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xffb7b7b8),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                message.timeString ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xffb7b7b8),
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  String getDateStr() {
    String dateFormat = '';

    if (message.createdAt != null) {
      final DateTime now = DateTime.now().toLocal();

      if (message.createdAt!.isSameDay(now)) {
        if (isSearchResult == true) {
          dateFormat = 'Today'.tr;
        } else {
          dateFormat = message.createdAt!.format('HH:mm');
        }
      } else if (message.createdAt!.isSameYear(now)) {
        dateFormat = message.createdAt!.format('E, dd MMM');
      } else {
        dateFormat = message.createdAt!.format('d MMM y');
      }
    }

    return dateFormat;
  }

  Widget _buildSubtitle(BuildContext context, String message) {
    if (subtitleHighlight != null) {
      String displayMessage;
      try {
        displayMessage = message.displayMarkUp(getDisplay: true);
      } catch (e) {
        displayMessage = message;
      }
      List<TextSpan> textSpanList = [];
      final matches = subtitleHighlight!.toLowerCase().allMatches(displayMessage.toLowerCase());
      int lastMatchEnd = 0;
      for (int i = 0; i < matches.length; i++) {
        final match = matches.elementAt(i);
        if (match.start != lastMatchEnd) {
          textSpanList.add(
            TextSpan(
              text: displayMessage.substring(lastMatchEnd, match.start),
            ),
          );
        }
        textSpanList.add(
          TextSpan(
            text: displayMessage.substring(match.start, match.end),
            style: TextStyle(color: UTheme.color.blueCi),
          ),
        );
        if (i == matches.length - 1 && match.end != displayMessage.length) {
          textSpanList.add(
            TextSpan(
              text: displayMessage.substring(match.end, displayMessage.length),
            ),
          );
        }
        lastMatchEnd = match.end;
      }

      //NOTE:case text length > 150 and keyword at 151 152,
      //TextSpanList will empty and show nothing. So at least need to show displayMessage.
      if (textSpanList.isEmpty) {
        textSpanList.add(
          TextSpan(
            text: displayMessage,
          ),
        );
      }

      return RichText(
        text: TextSpan(
          children: textSpanList,
          style: DefaultTextStyle.of(context).style.merge(UTheme.textTheme.messageStatus).copyWith(
                color: UTheme.color.onTextButtonSecondary,
              ),
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return Text(
        message,
        overflow: TextOverflow.ellipsis,
        style: UTheme.textTheme.messageStatus.copyWith(
          color: UTheme.color.onTextButtonSecondary,
        ),
      );
    }
  }
}
