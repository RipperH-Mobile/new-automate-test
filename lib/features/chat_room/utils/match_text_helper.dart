import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_text_theme.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/profile/presentation/arguments/profile_arguments.dart';
import 'package:uchat/features/profile/service/profile_service.dart';
import 'package:uchat/utils/extension/extension.dart';

class MatchTextBuilder {
  final AppColorsTheme appColorTheme;
  final AppTextTheme appTextTheme;
  final String pattern;
  final TextStyle styleMatch;
  final TextStyle? styleOverflowStr;
  final bool isMe;
  final bool isChatMessage;
  final bool isReply;
  final bool isSecretRoom;
  final void Function()? overflowStrToggle;
  final void Function()? onReplyTap;
  final RoomInterface? room;

  MatchTextBuilder({
    required this.appColorTheme,
    required this.appTextTheme,
    required this.pattern,
    required this.styleMatch,
    this.styleOverflowStr,
    this.isMe = false,
    this.isChatMessage = false,
    this.isReply = false,
    this.isSecretRoom = false,
    this.overflowStrToggle,
    this.onReplyTap,
    this.room,
  });

  MatchText buildMentionMatchText() {
    return MatchText(
      pattern: pattern,
      style: styleMatch,
      renderText: ({
        required String pattern,
        required String str,
      }) {
        return str.markupToDisplayRegExHelper(pattern: pattern);
      },
      onTap: (String output) async {
        if (isReply) {
          onReplyTap?.call();
          return;
        }

        Map<String, String> map = output.markupToDisplayRegExHelper(pattern: pattern);

        if (map['value'] == mentionAllUserId) return;

        final contactId = map['value'];

        if (contactId == null) return;

        final roomId = room?.id;

        if (roomId == null) {
          await GetIt.I<ProfileService>().openProfileScreen(
            contactId: contactId,
          );
        } else {
          await GetIt.I<ProfileService>().openProfileScreen(
            contactId: contactId,
            arguments: ProfileArgumentsV2(
              roomId: roomId,
              fromGroup: true,
            ),
          );
        }
      },
    );
  }

  MatchText buildShowMoreLessMatchText() {
    Color? matchColor = appColorTheme.textPrimary;
    if (!isMe) {
      if (isSecretRoom || isReply) {
        matchColor = appColorTheme.textDark;
      } else {
        matchColor = appColorTheme.textDarkest;
      }
    }
    TextStyle? matchStyle = styleOverflowStr ?? appTextTheme.body2Bold.copyWith(color: matchColor);
    return MatchText(
      onTap: (_) {
        if (isReply) {
          onReplyTap?.call();
          return;
        }

        overflowStrToggle?.call();
      },
      pattern: lessMoreRegexPattern,
      style: matchStyle,
      renderText: ({
        required String pattern,
        required String str,
      }) {
        return str.markupToDisplayRegExHelper(pattern: lessMoreRegexPattern);
      },
    );
  }

  MatchText buildUrlMatchText() {
    return MatchText(
      type: ParsedType.CUSTOM,
      pattern: UChatConstant.urlRegexPattern,
      style: isChatMessage ? _linkStyle : styleMatch,
      onTap: (url) => isReply ? onReplyTap?.call() : url.openInWebBrowser(),
    );
  }

  MatchText buildEmailMatchText() {
    return MatchText(
      type: ParsedType.EMAIL,
      style: isChatMessage ? _linkStyle : styleMatch,
      onTap: (url) => isReply ? onReplyTap?.call() : GetIt.I<UrlService>().mailTo(url),
    );
  }

  MatchText buildPhoneMatchText() {
    return MatchText(
      type: ParsedType.PHONE,
      style: isChatMessage ? _linkStyle : styleMatch,
      onTap: (url) => isReply ? onReplyTap?.call() : GetIt.I<UrlService>().tel(url),
    );
  }

  MatchText buildSearchHighlightText(String text) {
    return MatchText(
      pattern: text,
      style: const TextStyle(
        backgroundColor: Color(0xffFAD200),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  MatchText buildSystemMessageDisplayNameMatchText(TextStyle style) {
    return MatchText(
      onTap: (_) {},
      pattern: UChatConstant.systemMessageDisplayNameRegexPattern,
      style: style,
      renderText: ({
        required String pattern,
        required String str,
      }) {
        return str.markupToDisplayRegExHelper(pattern: UChatConstant.systemMessageDisplayNameRegexPattern);
      },
    );
  }

  TextStyle? get _linkStyle => appTextTheme.body2.copyWith(
        color: isMe ? appColorTheme.textPrimaryInverse : appColorTheme.linkText,
        decoration: TextDecoration.underline,
      );
}
