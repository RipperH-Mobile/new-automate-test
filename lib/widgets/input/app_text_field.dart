import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/utils.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';

/// Custom formatter that limits text length based on Unicode runes.
class ThaiLengthLimitingTextInputFormatter extends TextInputFormatter {
  final int maxLength;

  ThaiLengthLimitingTextInputFormatter(this.maxLength);

  /// Check if we're running in a unit test environment
  bool get _isUnitTestRun {
    // In unit tests, Platform.environment contains 'flutter_test'
    try {
      return Platform.environment.containsKey('FLUTTER_TEST') ||
          (kDebugMode && Platform.environment['FLUTTER_TEST'] != null);
    } catch (e) {
      // If Platform.environment throws (like in some test environments), assume it's a test
      return true;
    }
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Detect if a deletion occurred
    if (newValue.text.length < oldValue.text.length && (Platform.isAndroid || _isUnitTestRun)) {
      // 2. Check if this was a text selection deletion (not aggressive backspace)
      final bool hadSelection = oldValue.selection.end > oldValue.selection.start;

      if (hadSelection) {
        // This is a normal selection deletion - allow it
        // User selected text and pressed delete/backspace
        final int characterCount = newValue.text.runes.length;
        if (characterCount > maxLength) {
          return oldValue;
        }
        return newValue;
      }

      // 3. Handle aggressive backspace deletion (no previous selection)
      final int deletionStart = newValue.selection.start;
      final int deletionEnd = deletionStart + (oldValue.text.length - newValue.text.length);

      // Handle edge case: ensure deletion positions are valid
      if (deletionStart >= 0 && deletionEnd <= oldValue.text.length) {
        final String deletedSubstring = oldValue.text.substring(deletionStart, deletionEnd);
        final int lengthDiff = oldValue.text.length - newValue.text.length;

        // 4. Check if the deletion was "too aggressive" (more than 1 char)
        //    and involves Thai characters.
        //    (Standard Thai unicode range is \u0E00-\u0E7F)
        if (lengthDiff > 1 && _containsThai(deletedSubstring)) {
          // 5. Manually perform a "safe" deletion (remove only the last character before cursor)
          //    instead of accepting the system's multi-character deletion.

          // Find the proper deletion position (delete 1 character before cursor)
          final String beforeCursor = oldValue.text.substring(0, oldValue.selection.start);
          final String afterCursor = oldValue.text.substring(oldValue.selection.start);

          // Remove the last rune (character) from before cursor to handle Thai properly
          if (beforeCursor.isNotEmpty) {
            final List<int> beforeRunes = beforeCursor.runes.toList();
            beforeRunes.removeLast(); // Remove last character (rune)

            final String newBeforeCursor = String.fromCharCodes(beforeRunes);
            final String newText = newBeforeCursor + afterCursor;
            final int newCursorPosition = newBeforeCursor.length;

            return TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: newCursorPosition),
            );
          }
        }
      }
    }

    // Count characters using runes to support Thai languages consistently
    int characterCount = newValue.text.runes.length;

    if (characterCount > maxLength) {
      return oldValue;
    }

    return newValue;
  }

  bool _containsThai(String text) {
    // Regex for Thai unicode block (\u0E00-\u0E7F)
    final RegExp thaiPattern = RegExp(r'[\u0E00-\u0E7F]');

    // Handle empty or null strings
    if (text.isEmpty) return false;

    return thaiPattern.hasMatch(text);
  }
}

class AppTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final String? errorMsg;
  final TextEditingController? textEditController;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Color? borderColor;
  final TextInputType inputType;
  final Widget? suffixIcon;
  final bool obscureText;
  final Widget? errorWidget;
  final int? maxLength;
  final bool enable;
  final bool autoFocus;
  final int? minLines;
  final int? maxLines;
  final TextInputFormatter? customInputFormatter;

  const AppTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.errorMsg,
    this.textEditController,
    this.focusNode,
    this.onChanged,
    this.borderColor,
    required this.inputType,
    this.suffixIcon,
    this.obscureText = false,
    this.errorWidget,
    this.maxLength,
    this.enable = true,
    this.autoFocus = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.customInputFormatter,
  });

  factory AppTextField.withClear({
    Key? key,
    required TextEditingController textEditController,
    required String labelText,
    required String hintText,
    String? errorMsg,
    FocusNode? focusNode,
    Function(String)? onChanged,
    Color? borderColor,
    TextInputType inputType = TextInputType.text,
    Widget? errorWidget,
    bool obscureText = false,
    bool isShowIcon = false,
    Function()? onIconTap,
    int? maxLength,
    bool enable = true,
    bool autoFocus = false,
    int? minLines = 1,
    int? maxLines = 1,
  }) {
    return AppTextField(
      key: key,
      labelText: labelText,
      hintText: hintText,
      errorMsg: errorMsg,
      textEditController: textEditController,
      focusNode: focusNode,
      onChanged: onChanged,
      borderColor: borderColor,
      inputType: inputType,
      suffixIcon: isShowIcon && enable
          ? GestureDetector(
              onTap: onIconTap,
              child: Assets.vectors.closeSolid24.svg(),
            )
          : null,
      obscureText: obscureText,
      errorWidget: errorWidget,
      maxLength: maxLength,
      enable: enable,
      autoFocus: autoFocus,
      minLines: minLines,
      maxLines: maxLines,
    );
  }

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  late Color _borderColor;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateBorder();
  }

  void _onFocusChange() {
    setState(() {
      // for update border color
    });
  }

  void _updateBorder() {
    if ((widget.errorMsg != null && widget.errorMsg?.isNotEmpty == true) || widget.errorWidget != null) {
      _borderColor = context.theme.appColors.borderError;
    } else {
      _borderColor = _focusNode.hasFocus
          ? context.theme.appColors.borderSelected
          : widget.borderColor ?? context.theme.appColors.border;
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _updateBorder();

    final List<TextInputFormatter> inputFormatters = [];
    if (widget.maxLength != null) {
      inputFormatters.add(ThaiLengthLimitingTextInputFormatter(widget.maxLength!));
    }

    if (widget.customInputFormatter != null) {
      inputFormatters.add(widget.customInputFormatter!);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: ShapeDecoration(
            color: context.theme.appColors.backgroundNeutralLightest,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: _borderColor,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.roundedXl,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpace.space3,
              horizontal: AppSpace.space4,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.labelText,
                        style: TextStyle(
                          color: context.theme.appColors.textLight,
                        ),
                      ),
                      const SizedBox(
                        height: AppSpace.space1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: AppSpace.space6,
                        ),
                        child: TextField(
                          minLines: widget.minLines,
                          maxLines: widget.maxLines,
                          onChanged: widget.onChanged,
                          keyboardType: widget.inputType,
                          controller: widget.textEditController,
                          focusNode: _focusNode,
                          obscureText: widget.obscureText,
                          cursorColor: context.theme.appColors.textPrimary,
                          onTapOutside: (_) {
                            _focusNode.unfocus();
                          },
                          maxLength: widget.maxLength,
                          decoration: InputDecoration(
                            hintText: widget.hintText,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                            hintStyle: TextStyle(
                              color: context.theme.appColors.textDisable,
                            ),
                            counterText: '',
                          ),
                          style: TextStyle(
                            color: context.theme.appColors.textDarkest,
                          ),
                          inputFormatters: inputFormatters.isNotEmpty ? inputFormatters : null,
                          enabled: widget.enable,
                          autofocus: widget.autoFocus,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.suffixIcon != null) widget.suffixIcon!,
              ],
            ),
          ),
        ),
        if (widget.errorMsg != null && widget.errorMsg?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
            ),
            child: AppText.body3(
              widget.errorMsg!,
              context: context,
              color: context.theme.appColors.textError,
            ),
          ),
        if (widget.errorWidget != null) widget.errorWidget!,
      ],
    );
  }
}
