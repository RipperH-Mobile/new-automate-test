import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/presentation/chat_room_presentation.dart';

enum MentionSuggestionPosition { top, bottom }

class MentionTextField extends StatefulWidget {
  final bool hideSuggestionList;

  /// default text for the Mention Input.
  final String? defaultText;

  /// Triggers when the suggestion list visibility changed.
  final Function(bool)? onSuggestionVisibleChanged;

  /// List of Mention that the user is allowed to triggered
  final List<MentionMarkModel> mentions;

  /// Leading widgets to show before teh Input box, helps preserve the size
  /// size for the Portal widget size.
  final Widget? leading;

  /// Trailing widgets to show before teh Input box, helps preserve the size
  /// size for the Portal widget size.
  final Widget? trailing;

  /// Suggestion modal position, can be aligned to top or bottom.
  ///
  /// Defaults to [SuggestionPosition.bottom].
  final MentionSuggestionPosition suggestionPosition;

  /// Triggers when the suggestion was added by tapping on suggestion.
  final Function(Map<String, dynamic>)? onMentionAdd;

  /// Max height for the suggestion list
  ///
  /// Defaults to `300.0`
  final double suggestionListHeight;

  /// A Functioned which is triggered when ever the input changes
  /// but with the markup of the selected mentions
  ///
  /// This is an optional property.
  final ValueChanged<String>? onMarkupChanged;

  final void Function(String trigger, String value)? onSearchChanged;

  /// Decoration for the Suggestion list.
  final BoxDecoration? suggestionListDecoration;

  /// Focus node for controlling the focus of the Input.
  final FocusNode? focusNode;

  /// Should selecting a suggestion add a space at the end or not.
  final bool appendSpaceOnAdd;

  /// The decoration to show around the text field.
  final InputDecoration decoration;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// The type of action button to use for the keyboard.
  ///
  /// Defaults to [TextInputAction.newline] if [keyboardType] is
  /// [TextInputType.multiline] and [TextInputAction.done] otherwise.
  final TextInputAction? textInputAction;

  /// {@macro flutter.widgets.editableText.textCapitalization}
  final TextCapitalization textCapitalization;

  /// The style to use for the text being edited.
  ///
  /// This text style is also used as the base style for the [decoration].
  ///
  /// If null, defaults to the `subtitle1` text style from the current [Theme].
  final TextStyle? style;

  /// {@macro flutter.widgets.editableText.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.editableText.textAlign}
  final TextAlign textAlign;

  /// {@macro flutter.widgets.editableText.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutter.widgets.editableText.autofocus}
  final bool autofocus;

  /// {@macro flutter.widgets.editableText.autocorrect}
  final bool autocorrect;

  /// {@macro flutter.services.textInput.enableSuggestions}
  final bool enableSuggestions;

  /// {@macro flutter.widgets.editableText.maxLines}
  final int maxLines;

  /// {@macro flutter.widgets.editableText.minLines}
  final int? minLines;

  /// {@macro flutter.widgets.editableText.expands}
  final bool expands;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// {@macro flutter.widgets.editableText.showCursor}
  final bool? showCursor;

  /// If [maxLength] is set to this value, only the "current input length"
  /// part of the character counter is shown.
  static const int noMaxLength = -1;

  /// The maximum number of characters (Unicode scalar values) to allow in the
  /// text field.
  final int? maxLength;

  /// If true, prevents the field from allowing more than [maxLength]
  /// characters.
  ///
  /// If [maxLength] is set, [maxLengthEnforcement] indicates whether or not to
  /// enforce the limit, or merely provide a character counter and warning when
  /// [maxLength] is exceeded.
  final MaxLengthEnforcement maxLengthEnforcement;

  /// {@macro flutter.widgets.editableText.onChanged}
  final ValueChanged<String>? onChanged;

  /// {@macro flutter.widgets.editableText.onEditingComplete}
  final VoidCallback? onEditingComplete;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final ValueChanged<String>? onSubmitted;

  /// If false the text field is "disabled": it ignores taps and its
  /// [decoration] is rendered in grey.
  ///
  /// If non-null this property overrides the [decoration]'s
  /// [Decoration.enabled] property.
  final bool? enabled;

  /// {@macro flutter.widgets.editableText.cursorWidth}
  final double cursorWidth;

  /// {@macro flutter.widgets.editableText.cursorRadius}
  final Radius? cursorRadius;

  /// The color to use when painting the cursor.
  ///
  /// Defaults to [ThemeData.cursorColor] or [CupertinoTheme.primaryColor]
  /// depending on [ThemeData.platform] .
  final Color? cursorColor;

  /// The appearance of the keyboard.
  ///
  /// This setting is only honored on iOS devices.
  final Brightness? keyboardAppearance;

  /// {@macro flutter.widgets.editableText.scrollPadding}
  final EdgeInsets scrollPadding;

  /// {@macro flutter.widgets.editableText.enableInteractiveSelection}
  final bool enableInteractiveSelection;

  /// {@macro flutter.rendering.editable.selectionEnabled}
  bool get selectionEnabled => enableInteractiveSelection;

  /// Called for each distinct tap except for every second tap of a double tap.
  final GestureTapCallback? onTap;

  /// Called when the user taps outside of the text field.
  final void Function(PointerDownEvent)? onTapOutside;

  /// Callback that generates a custom [InputDecorator.counter] widget.
  ///
  /// See [InputCounterWidgetBuilder] for an explanation of the passed in
  /// arguments.  The returned widget will be placed below the line in place of
  /// the default widget built when [counterText] is specified.
  ///
  /// The returned widget will be wrapped in a [Semantics] widget for
  /// accessibility, but it also needs to be accessible itself.  For example,
  /// if returning a Text widget, set the [semanticsLabel] property.
  final InputCounterWidgetBuilder? buildCounter;

  /// {@macro flutter.widgets.editableText.scrollPhysics}
  final ScrollPhysics? scrollPhysics;

  /// {@macro flutter.widgets.editableText.scrollController}
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.autofillHints}
  /// {@macro flutter.services.autofill.autofillHints}
  final Iterable<String>? autofillHints;

  /// Custom input context menu
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  /// List of input formatters to apply to the input.
  final List<TextInputFormatter>? inputFormatters;

  /// The color to use when painting the cursor for errors.
  final Color? cursorErrorColor;

  final Offset suggestionOverlayOffset;

  /// This string is used to preview the text in the text field when the text field is not empty.
  /// But, It have text that longer than 50 characters, it will be shortened to the last 50 characters.
  ///
  /// For example, if the text is "Hello World! This is a long text that will be shortened.", it will be shortened to "...shortened.".
  final String previewText;

  /// Whether to show the preview text in the text field when the text field is not empty.
  /// Defaults to `false`.
  ///
  /// If `true`, the preview text will be shown in the text field when the text field is not empty.
  final bool showPreviewText;

  /// Custom suffix icon to show in the text field.
  final Widget? customSuffixIcon;

  static const iconAnimationDuration = Duration(milliseconds: 100);
  static const iconAnimationCurve = Curves.easeInOut;

  const MentionTextField({
    super.key,
    required this.mentions,
    this.defaultText,
    this.suggestionPosition = MentionSuggestionPosition.top,
    this.suggestionListHeight = 300.0,
    this.onMarkupChanged,
    this.onMentionAdd,
    this.onSearchChanged,
    this.leading,
    this.trailing,
    this.suggestionListDecoration,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.autofocus = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.readOnly = false,
    this.showCursor,
    this.maxLength,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.enabled,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.onTap,
    this.onTapOutside,
    this.buildCounter,
    this.scrollPhysics,
    this.scrollController,
    this.autofillHints,
    this.appendSpaceOnAdd = true,
    this.hideSuggestionList = false,
    this.onSuggestionVisibleChanged,
    this.contextMenuBuilder,
    this.inputFormatters,
    this.cursorErrorColor,
    this.suggestionOverlayOffset = Offset.zero,
    this.previewText = '',
    this.showPreviewText = false,
    this.customSuffixIcon,
  });

  @override
  State<MentionTextField> createState() => MentionTextFieldState();
}

class MentionTextFieldState extends State<MentionTextField> {
  late AnnotationTextEditingController textEditingController;
  late AnnotationTextEditingController _textPreviewEditingController;
  late ScrollController _scrollController;

  MentionLengthMap? _selectedMention;

  String _pattern = '';

  bool hasMention = false;

  bool hasUrl = false;

  List<String> urlMatches = [];

  final urlRegPattern = RegExp(UChatConstant.urlRegexPattern, multiLine: true);

  ValueNotifier<bool> showSuggestions = ValueNotifier(false);

  Map<String, AnnotationModel> _mapping = {};

  MentionLengthMap? get selectedMention => _selectedMention;

  String get currentText => textEditingController.text;

  @override
  void initState() {
    super.initState();
    _mapping = mapToAnnotation();
    textEditingController = AnnotationTextEditingController(_mapping);
    _textPreviewEditingController = AnnotationTextEditingController(_mapping);
    if (widget.defaultText != null) {
      textEditingController.text = widget.defaultText!;
    }

    textEditingController.addListener(inputListeners);
    textEditingController.addListener(suggestionListener);

    _textPreviewEditingController.addListener(inputListeners);
    _textPreviewEditingController.addListener(suggestionListener);
    _scrollController = ScrollController();

    widget.focusNode?.addListener(() {
      if (!widget.focusNode!.hasFocus) {
        showSuggestions.value = false;
      }

      if (widget.focusNode?.hasFocus == false) {
        EasyThrottle.throttle(
          'mention_text_field_preview_text',
          const Duration(milliseconds: 300),
          () async {
            if (textEditingController.text.isNotEmpty) {
              await updatePreviewText(textEditingController.text);
            }
          },
        );
      }
    });
  }

  @override
  dispose() {
    textEditingController.removeListener(inputListeners);
    textEditingController.removeListener(suggestionListener);
    textEditingController.dispose();
    showSuggestions.dispose();

    _textPreviewEditingController.removeListener(inputListeners);
    _textPreviewEditingController.removeListener(suggestionListener);
    _textPreviewEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    _mapping = mapToAnnotation();
    textEditingController.mapping = _mapping;
    _textPreviewEditingController.mapping = _mapping;

    super.didUpdateWidget(oldWidget);
  }

  Future<void> updatePreviewText(String text) async {
    if (_textPreviewEditingController.text.isEmpty && text.isEmpty) {
      return;
    }
    _textPreviewEditingController.text = text;

    if (!widget.showPreviewText) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (_scrollController.hasClients) {
        await _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
      }
    });
  }

  void inputListeners() {
    updatePreviewText(textEditingController.text);
    hasUrl = urlRegPattern.hasMatch(textEditingController.text);
    if (hasUrl) {
      urlMatches = urlRegPattern.allMatches(textEditingController.text).map((e) {
        return e.group(0)!;
      }).toList();
    } else {
      urlMatches.clear();
    }

    if (widget.onChanged != null) {
      widget.onChanged?.call(textEditingController.text);
    }

    if (widget.onMarkupChanged != null) {
      widget.onMarkupChanged?.call(textEditingController.markupText.$1);
    }

    if (widget.onSearchChanged != null && _selectedMention?.str != null) {
      final str = _selectedMention!.str.toLowerCase();

      widget.onSearchChanged?.call(str[0], str.substring(1));
    }
  }

  void suggestionListener() {
    final cursorPos = textEditingController.selection.baseOffset;

    if (cursorPos >= 0) {
      var pos = 0;

      final lengthMap = <MentionLengthMap>[];

      // split on each word and generate a list with start & end position of each word.
      textEditingController.value.text.split(RegExp(r'(\s)')).forEach((element) {
        if (element.isEmpty) {
          pos += 1;
          return;
        }
        // if first char is not trigger, skip it.
        if (!widget.mentions.map((e) => e.trigger).contains(element[0])) {
          pos += element.length + 1;
          return;
        }
        // if it has many @, find the last @ to be the start position other is 0
        final triggerRegExp = RegExp(widget.mentions.map((e) => e.trigger).join('|'));
        final lastIndex = element.lastIndexOf(triggerRegExp);
        final int startPosition = lastIndex != -1 ? pos + lastIndex : pos;
        final int endPosition = pos + element.length;
        lengthMap.add(
          MentionLengthMap(str: element, start: startPosition, end: endPosition),
        );

        pos = endPosition + 1;
      });

      final val = lengthMap.indexWhere((element) {
        _pattern = widget.mentions.map((e) => e.trigger).join('|');

        return element.end == cursorPos && element.str.toLowerCase().contains(RegExp(_pattern));
      });

      final bool isVisible = val != -1;
      showSuggestions.value = isVisible;

      if (widget.onSuggestionVisibleChanged != null) {
        widget.onSuggestionVisibleChanged!(isVisible);
      }

      setState(() {
        _selectedMention = val == -1 ? null : lengthMap[val];
      });
    }
  }

  Map<String, AnnotationModel> mapToAnnotation() {
    final data = <String, AnnotationModel>{};

    // Loop over all the mention items and generate a suggestions matching list
    for (final mentionMark in widget.mentions) {
      // if matchAll is set to true add a general regex pattern to match with
      if (mentionMark.matchAll) {
        data['${mentionMark.trigger}([A-Za-z0-9])*'] = AnnotationModel(
          style: mentionMark.style,
          id: null,
          display: null,
          trigger: mentionMark.trigger,
          disableMarkup: mentionMark.disableMarkup,
          markupBuilder: mentionMark.markupBuilder,
        );
      }

      final dataSorted = mentionMark.data.sorted((a, b) {
        return (b.display.length) - (a.display.length);
      });

      for (final info in dataSorted) {
        final style = mentionMark.style ?? info.style;
        data['${mentionMark.trigger}${info.display}'] = AnnotationModel(
          trigger: mentionMark.trigger,
          id: info.id,
          display: info.display,
          displayNameValue: info.nameValue,
          style: style,
          disableMarkup: mentionMark.disableMarkup,
          markupBuilder: mentionMark.markupBuilder,
        );
      }
    }

    return data;
  }

  void addMention(MentionInfoModel value) {
    final selectedMention = _selectedMention!;

    setState(() {
      _selectedMention = null;
    });

    final mark = widget.mentions.firstWhere(
      (element) => selectedMention.str.contains(element.trigger),
    );

    final bool isTriggerMarkBeforeStart =
        selectedMention.start > 0 ? textEditingController.value.text[selectedMention.start - 1] == mark.trigger : false;

    // find the text by range and replace with the new value.
    textEditingController.text = textEditingController.value.text.replaceRange(
      selectedMention.start,
      selectedMention.end,
      "${isTriggerMarkBeforeStart ? ' ' : ''}${mark.trigger}${value.display}${widget.appendSpaceOnAdd ? ' ' : ''}",
    );

    if (widget.onMentionAdd != null) widget.onMentionAdd?.call(value.toMap());

    // Move the cursor to next position after the new mentioned item.
    int nextCursorPosition = selectedMention.start + 1 + value.display.length;

    if (widget.appendSpaceOnAdd) nextCursorPosition++;
    textEditingController.selection = TextSelection.fromPosition(
      TextPosition(offset: nextCursorPosition),
    );

    if (widget.scrollController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.scrollController!.animateTo(
          widget.scrollController!.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      });
    }
  }

  Anchor get _anchor {
    if (widget.suggestionPosition == MentionSuggestionPosition.top) {
      return Aligned(
        follower: Alignment.bottomCenter,
        target: Alignment.topCenter,
        offset: widget.suggestionOverlayOffset,
      );
    } else {
      return Aligned(
        follower: Alignment.topCenter,
        target: Alignment.bottomCenter,
        offset: widget.suggestionOverlayOffset,
      );
    }
  }

  List<MentionInfoModel> findMentionList() {
    final selectedMention = _selectedMention!;
    final text = selectedMention.str.toLowerCase().replaceAll(RegExp(_pattern), '');

    final mention = _selectedMention != null
        ? widget.mentions.firstWhere(
            (element) => _selectedMention!.str.contains(element.trigger),
          )
        : widget.mentions[0];

    final mentionMark = mention.data.where(
      (element) {
        return element.display.toLowerCase().contains(text);
      },
    );

    if (mentionMark.isEmpty) {
      showSuggestions.value = false;
    }

    return mentionMark.toList();
  }

  String shortenText(String text) {
    if (text.length <= 25) return text;
    final formattedText = text.trim().split('\n').last;
    return '...${formattedText.substring(25)}';
  }

  @override
  Widget build(BuildContext context) {
    return PortalTarget(
      visible: showSuggestions.value && widget.hideSuggestionList == false,
      anchor: _anchor,
      portalFollower: ValueListenableBuilder<bool>(
        valueListenable: showSuggestions,
        builder: (_, show, __) {
          if (show == false) {
            return const SizedBox.shrink();
          }

          final items = findMentionList();
          if (items.isEmpty) {
            return const SizedBox.shrink();
          }

          return MentionSuggestionWidget(
            items: items,
            onSelected: addMention,
          );
        },
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (widget.leading != null)
            AnimatedSize(
              duration: MentionTextField.iconAnimationDuration,
              curve: MentionTextField.iconAnimationCurve,
              alignment: Alignment.centerRight,
              child: widget.leading,
            ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          Expanded(
            child: Stack(
              children: [
                ScrollConfiguration(
                  behavior: _MentionTextFieldScrollbarBehavior(),
                  child: widget.showPreviewText
                      ? TextField(
                          key: const ValueKey('mention_text_field_preview_text'),
                          maxLines: widget.maxLines,
                          minLines: widget.minLines,
                          maxLength: widget.maxLength,
                          keyboardType: widget.keyboardType,
                          keyboardAppearance: widget.keyboardAppearance,
                          textInputAction: widget.textInputAction,
                          textCapitalization: widget.textCapitalization,
                          style: widget.style,
                          textAlign: widget.textAlign,
                          textDirection: widget.textDirection,
                          readOnly: widget.readOnly,
                          showCursor: widget.showCursor,
                          autofocus: widget.autofocus,
                          autocorrect: widget.autocorrect,
                          maxLengthEnforcement: widget.maxLengthEnforcement,
                          cursorColor: widget.cursorColor,
                          cursorRadius: widget.cursorRadius,
                          cursorWidth: widget.cursorWidth,
                          cursorErrorColor: widget.cursorErrorColor,
                          buildCounter: widget.buildCounter,
                          autofillHints: widget.autofillHints,
                          decoration: widget.decoration,
                          expands: widget.expands,
                          onEditingComplete: widget.onEditingComplete,
                          onTap: widget.onTap,
                          onTapOutside: widget.onTapOutside,
                          enabled: widget.enabled,
                          enableInteractiveSelection: widget.enableInteractiveSelection,
                          enableSuggestions: widget.enableSuggestions,
                          scrollPadding: widget.scrollPadding,
                          scrollPhysics: widget.scrollPhysics,
                          controller: _textPreviewEditingController,
                          scrollController: _scrollController,
                          contextMenuBuilder: widget.contextMenuBuilder,
                          inputFormatters: widget.inputFormatters,
                        )
                      : TextField(
                          key: const ValueKey('mention_text_field_main'),
                          maxLines: widget.maxLines,
                          minLines: widget.minLines,
                          maxLength: widget.maxLength,
                          focusNode: widget.focusNode,
                          keyboardType: widget.keyboardType,
                          keyboardAppearance: widget.keyboardAppearance,
                          textInputAction: widget.textInputAction,
                          textCapitalization: widget.textCapitalization,
                          style: widget.style,
                          textAlign: widget.textAlign,
                          textDirection: widget.textDirection,
                          readOnly: widget.readOnly,
                          showCursor: widget.showCursor,
                          autofocus: widget.autofocus,
                          autocorrect: widget.autocorrect,
                          maxLengthEnforcement: widget.maxLengthEnforcement,
                          cursorColor: widget.cursorColor,
                          cursorRadius: widget.cursorRadius,
                          cursorWidth: widget.cursorWidth,
                          cursorErrorColor: widget.cursorErrorColor,
                          buildCounter: widget.buildCounter,
                          autofillHints: widget.autofillHints,
                          decoration: widget.decoration,
                          expands: widget.expands,
                          onEditingComplete: widget.onEditingComplete,
                          onTap: widget.onTap,
                          onTapOutside: widget.onTapOutside,
                          enabled: widget.enabled,
                          enableInteractiveSelection: widget.enableInteractiveSelection,
                          enableSuggestions: widget.enableSuggestions,
                          scrollController: widget.scrollController,
                          scrollPadding: widget.scrollPadding,
                          scrollPhysics: widget.scrollPhysics,
                          controller: textEditingController,
                          contextMenuBuilder: widget.contextMenuBuilder,
                          inputFormatters: widget.inputFormatters,
                        ),
                ),
                // use custom suffix icon because the suffix icon in the decoration can not be positioned
                if (widget.customSuffixIcon != null)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: widget.customSuffixIcon!,
                  ),
              ],
            ),
          ),
          const SizedBox(
            width: AppSpace.space2,
          ),
          if (widget.trailing != null)
            AnimatedSize(
              duration: MentionTextField.iconAnimationDuration,
              curve: MentionTextField.iconAnimationCurve,
              alignment: Alignment.centerRight,
              child: widget.trailing,
            ),
        ],
      ),
    );
  }
}

class _MentionTextFieldScrollbarBehavior extends ScrollBehavior {
  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    return RawScrollbar(
      thumbColor: const Color(0xFF7A7A7A),
      thickness: AppSize.size1,
      radius: const Radius.circular(AppRadius.roundedFull),
      padding: EdgeInsets.zero,
      controller: details.controller,
      minThumbLength: 40,
      child: child,
    );
  }
}
