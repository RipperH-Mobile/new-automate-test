// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:uchat/features/chat_room/presentation/widgets/mention_text_field/mention_info_model.dart';

@immutable
class MentionMarkModel {
  const MentionMarkModel({
    required this.trigger,
    this.data = const [],
    this.style,
    this.matchAll = false,
    this.suggestionBuilder,
    this.disableMarkup = false,
    this.markupBuilder,
  });

  /// A single character that will be used to trigger the suggestions.
  final String trigger;

  /// List of Map to represent the suggestions shown to the user
  ///
  /// You need to provide two properties `id` & `display` both are [String]
  /// You can also have any custom properties as you like to build custom suggestion
  /// widget.
  final List<MentionInfoModel> data;

  /// Style for the mention item in Input.
  final TextStyle? style;

  /// Should every non-suggestion with the trigger character be matched
  final bool matchAll;

  /// Should the markup generation be disabled for this Mention Item.
  final bool disableMarkup;

  /// Build Custom suggestion widget using this builder.
  final Widget Function(MentionInfoModel info)? suggestionBuilder;

  /// Allows to set custom markup for the mentioned item.
  final String Function(String trigger, String mention, String value, String displayNameValue)? markupBuilder;

  MentionMarkModel copyWith({
    String? trigger,
    List<MentionInfoModel>? data,
    TextStyle? style,
    bool? matchAll,
    bool? disableMarkup,
    Widget Function(MentionInfoModel info)? suggestionBuilder,
    String Function(String trigger, String mention, String value, String displayNameValue)? markupBuilder,
  }) {
    return MentionMarkModel(
      trigger: trigger ?? this.trigger,
      data: data ?? this.data,
      style: style ?? this.style,
      matchAll: matchAll ?? this.matchAll,
      disableMarkup: disableMarkup ?? this.disableMarkup,
      suggestionBuilder: suggestionBuilder ?? this.suggestionBuilder,
      markupBuilder: markupBuilder ?? this.markupBuilder,
    );
  }
}
