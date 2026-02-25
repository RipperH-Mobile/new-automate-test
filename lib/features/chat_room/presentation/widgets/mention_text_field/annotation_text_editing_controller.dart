import 'package:emoji_extension/emoji_extension.dart';
import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/annotation_model.dart';

class AnnotationTextEditingController extends TextEditingController {
  // The mapping of the annotations.
  Map<String, AnnotationModel> _mapping;

  String? _pattern;

  AnnotationTextEditingController(this._mapping) {
    _pattern = _mapping.keys.isNotEmpty ? "(${_mapping.keys.map((key) => RegExp.escape(key)).join('|')})" : null;
  }

  set mapping(Map<String, AnnotationModel> mapping) {
    _mapping = mapping;

    _pattern = "(${mapping.keys.map((key) => RegExp.escape(key)).join('|')})";
  }

  /// Check if the text has only emoji.
  ///
  /// Return `true` if the text has only emoji, otherwise `false`.
  bool get hasOnlyEmoji {
    return text.emojis.only;
  }

  /// Get the emoji count in the text.
  ///
  /// Return the emoji count in the text.
  int get emojiCount {
    return text.emojis.count;
  }

  Map<String, AnnotationModel> get mapping {
    return _mapping;
  }

  (String, List<String>) get markupText {
    List<String> mentionIds = [];

    if (_mapping.isEmpty) {
      return (text, mentionIds);
    }

    final markupText = text.splitMapJoin(
      RegExp('$_pattern'),
      onMatch: (Match match) {
        final key = _mapping.keys.firstWhere((element) {
          final reg = RegExp(element);
          return reg.hasMatch(match[0]!);
        });

        final mention = _mapping[match[0]!] ?? _mapping[key]!;
        mentionIds.add(mention.id ?? '');

        // Default markup format for mentions
        if (!mention.disableMarkup) {
          return mention.markupBuilder != null
              ? mention.markupBuilder!(mention.trigger, mention.id!, mention.display!, mention.displayNameValue!)
              : '${mention.trigger}[__${mention.id}__](__${mention.displayNameValue}__)';
        } else {
          return match[0]!;
        }
      },
      onNonMatch: (String text) {
        return text;
      },
    );

    return (markupText, mentionIds);
  }

  @override
  TextSpan buildTextSpan({BuildContext? context, TextStyle? style, bool? withComposing}) {
    if (_pattern == null || _pattern == '()') {
      return TextSpan(text: text, style: style);
    }

    final children = <InlineSpan>[];
    text.splitMapJoin(
      RegExp('$_pattern'),
      onMatch: (Match match) {
        if (_mapping.isNotEmpty) {
          final mention = _mapping[match[0]!] ??
              _mapping[_mapping.keys.firstWhere((element) {
                final reg = RegExp(element);

                return reg.hasMatch(match[0]!);
              })]!;

          children.add(
            TextSpan(
              text: match[0],
              style: style!.merge(mention.style),
            ),
          );
        }

        return '';
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return '';
      },
    );

    return TextSpan(style: style, children: children);
  }
}
