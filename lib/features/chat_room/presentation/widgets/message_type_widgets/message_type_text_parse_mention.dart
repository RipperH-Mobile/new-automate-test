import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:rive/rive.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/features/chat_room/data/models/interfaces/room_interface.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/chat_room/utils/match_text_helper.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

// ignore: must_be_immutable
class MentionTextParse extends StatelessWidget {
  final String? message;
  final RoomInterface? room;
  final String pattern;
  final TextStyle style;
  final TextStyle styleMatch;
  final TextStyle? styleOverflowStr;
  final bool isOnTapEnable;
  final int? maxLines;
  final TextOverflow? overflow;
  final EdgeInsetsGeometry padding;
  final bool showTypingAnimation;
  final String? searchHighlightText;

  String? overflowStr;
  bool isMe;
  bool isChatMessage;
  bool isSecretRoom;
  bool isReply;
  bool selectable;

  void Function()? overflowStrToggle;
  void Function()? onReplyTap;

  MentionTextParse({
    super.key,
    required this.message,
    this.room,
    this.isOnTapEnable = true,
    this.pattern = mentionRegexPattern,
    this.styleMatch = const TextStyle(
      color: Colors.green,
      fontSize: 12,
    ),
    this.style = const TextStyle(
      color: Colors.green,
      fontSize: 15,
    ),
    this.styleOverflowStr,
    this.maxLines,
    this.overflow,
    this.padding = EdgeInsets.zero,
    this.showTypingAnimation = false,
    this.isMe = false,
    this.isChatMessage = false,
    this.overflowStr,
    this.isSecretRoom = false,
    this.isReply = false,
    this.selectable = false,
    this.overflowStrToggle,
    this.searchHighlightText,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    return _buildChildWidget();
  }

  MatchTextBuilder _matchTextBuilder(BuildContext context) {
    return MatchTextBuilder(
      appColorTheme: context.theme.appColors,
      appTextTheme: context.theme.appTexts,
      pattern: pattern,
      styleMatch: styleMatch,
      isMe: isMe,
      isSecretRoom: isSecretRoom,
      isChatMessage: isChatMessage,
      isReply: isReply,
      onReplyTap: onReplyTap,
      styleOverflowStr: styleOverflowStr,
      overflowStrToggle: overflowStrToggle,
      room: room,
    );
  }

  Widget _buildChildWidget() {
    return ClipRect(
      child: AbsorbPointer(
        absorbing: !isOnTapEnable,
        child: Padding(
          padding: padding,
          child: Wrap(
            children: [
              Builder(builder: (context) {
                String text = '';
                if (message != null) {
                  text += message!;
                }
                if (overflowStr != null) {
                  // add space between message and overflowStr to fix url parsing bug when the message ending with url.
                  text += ' $overflowStr';
                }
                return ParsedText(
                  selectable: selectable,
                  text: text,
                  style: style.copyWith(
                    fontSize: style.fontSize,
                    fontFamily: UTheme.messageFontFam,
                  ),
                  overflow: overflow ?? TextOverflow.clip,
                  maxLines: maxLines,
                  parse: <MatchText>[
                    _matchTextBuilder(context).buildMentionMatchText(),
                    _matchTextBuilder(context).buildSystemMessageDisplayNameMatchText(styleMatch),
                    _matchTextBuilder(context).buildShowMoreLessMatchText(),
                    _matchTextBuilder(context).buildUrlMatchText(),
                    _matchTextBuilder(context).buildEmailMatchText(),
                    _matchTextBuilder(context).buildPhoneMatchText(),
                    // Use custom regex to detect url in the text
                    // ParsedType.URL from this lib can not detect some of url with %, ( or ) in the url
                    // but keep it here for now just in case ?
                    // uncomment if in case
                    //_buildUrlMatchText(),

                    if (UChatScreenUtil.instance.isDesktop && searchHighlightText?.isNotEmpty == true)
                      _matchTextBuilder(context).buildSearchHighlightText(searchHighlightText!),
                  ],
                );
              }),
              if (showTypingAnimation && UChatScreenUtil.instance.isMobile) _buildTypingAnimation()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypingAnimation() {
    return const Padding(
      padding: EdgeInsets.only(left: 4),
      child: SizedBox(
        width: 36,
        height: 16,
        child: RiveAnimation.asset('assets/riv/typing_dot.riv'),
      ),
    );
  }
}
