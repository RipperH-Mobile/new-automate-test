import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/themes/themes.dart';

// TODO (improve) Refactor this widget to take custom validation method.
class SetupPasswordField extends StatefulWidget {
  final String firstTitle;
  final String secondTitle;
  final String conditionSubtitle;
  final String notMatchSubtitle;
  final String passwordMatchSubtitle;
  final String duplicateSubtitle;
  final bool showConditionSubtitle;
  final bool showNotMatchSubtitle;
  final bool showDuplicateSubtitle;
  final bool validateFirstTextField;
  final bool showEyeButton;
  final bool showCheckMarkButton;
  final Function(String) onNewPasswordChanged;
  final Function(String) onConfirmPasswordChanged;
  final Function(bool)? onPasswordValidationChanged; // Callback for validation changes
  final double? spacingBetween; // distance between first text field and second text field.
  final int? maxLength;

  const SetupPasswordField({
    super.key,
    required this.firstTitle,
    required this.secondTitle,
    required this.conditionSubtitle,
    required this.notMatchSubtitle,
    required this.onNewPasswordChanged,
    required this.onConfirmPasswordChanged,
    this.passwordMatchSubtitle = 'Password and verification match.',
    this.duplicateSubtitle = 'New password matches the current password, Please try again.',
    this.showConditionSubtitle = false,
    this.showNotMatchSubtitle = false,
    this.showDuplicateSubtitle = false,
    this.validateFirstTextField = true,
    this.showEyeButton = true,
    this.showCheckMarkButton = true,
    this.onPasswordValidationChanged,
    this.spacingBetween,
    this.maxLength,
  });

  @override
  SetupPasswordFieldState createState() => SetupPasswordFieldState();
}

class SetupPasswordFieldState extends State<SetupPasswordField> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  bool _isValidFirstPassword = false;
  bool _isValidSecondPassword = false;
  bool _isFirstTextFieldObscure = true;
  bool _isSecondTextFieldObscure = true;
  int firstTextFieldCharacterLength = 0;

  @override
  void initState() {
    super.initState();
    _firstController.addListener(_onFirstPasswordChanged);
    _secondController.addListener(_onSecondPasswordChanged);
  }

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _onFirstPasswordChanged() {
    setState(() {
      // If text is longer than max length remove the last character.
      if (widget.maxLength != null && _firstController.text.characters.length > widget.maxLength!) {
        _firstController.text = _firstController.text.characters.skipLast(1).string;
      }
      firstTextFieldCharacterLength = _firstController.text.characters.length;
    });

    bool isValid;
    if (widget.validateFirstTextField) {
      isValid = _validatePassword(_firstController.text);
    } else {
      // If first text field doesn't need validation, Always set isValid to true.
      isValid = true;
    }
    setState(() {
      _isValidFirstPassword = isValid;
    });
    widget.onNewPasswordChanged(_firstController.text);
    _onSecondPasswordChanged(validateOnly: true);
    widget.onPasswordValidationChanged?.call(_isValidFirstPassword && _isValidSecondPassword);
  }

  void _onSecondPasswordChanged({bool validateOnly = false}) {
    setState(() {
      // If text is longer than max length remove the last character.
      if (widget.maxLength != null && _secondController.text.characters.length > widget.maxLength!) {
        _secondController.text = _secondController.text.characters.skipLast(1).string;
      }
    });
    final isMatch = _firstController.text == _secondController.text;
    setState(() {
      _isValidSecondPassword = _firstController.text.isNotEmpty && isMatch;
    });
    widget.onConfirmPasswordChanged(_secondController.text);
    if (!validateOnly) {
      widget.onPasswordValidationChanged?.call(_isValidFirstPassword && _isValidSecondPassword);
    }
  }

  bool _validatePassword(String password) {
    // Ensure the password has at least 10 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character
    final regex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\x20-\x2F\x3A-\x40\x5B-\x60\x7B-\x7E]).{10,}$');
    return regex.hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.firstTitle.tr,
              style: TextStyle(
                color: const Color(0xFF808080),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (widget.maxLength != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$firstTextFieldCharacterLength/${widget.maxLength}',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 14.sp,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Container(
          width: 390.w,
          height: 55.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1.w,
                // border color
                color: _firstController.text.isNotEmpty && !_isValidFirstPassword
                    ? const Color(0xFFFF1552)
                    : widget.showDuplicateSubtitle && _firstController.text.isNotEmpty
                        ? const Color(0xFFFF1552)
                        : const Color(0xFFE6E6E6),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: TextField(
            controller: _firstController,
            obscureText: _isFirstTextFieldObscure,
            textAlignVertical: TextAlignVertical.center,
            maxLength: widget.maxLength,
            style: TextStyle(fontSize: 16.sp),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.firstTitle.tr,
              contentPadding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 16.h),
              suffixIconConstraints: const BoxConstraints(),
              // checked icon
              suffixIcon: _buildFirstSuffixIcon(),
              counterText: '',
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        SizedBox(
          height: 36.h,
          // Subtitle condition
          child: widget.showDuplicateSubtitle && _firstController.text.isNotEmpty
              ? Text(
                  widget.duplicateSubtitle.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFFF1552),
                  ),
                )
              : widget.showConditionSubtitle
                  ? Text(
                      widget.conditionSubtitle.tr,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: _firstController.text.isEmpty
                            ? Colors.grey
                            : (_isValidFirstPassword ? UTheme.color.primary : const Color(0xFFFF1552)),
                      ),
                    )
                  : Text(
                      widget.conditionSubtitle.tr,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: _firstController.text.isEmpty
                            ? Colors.grey
                            : (_isValidFirstPassword ? UTheme.color.primary : const Color(0xFFFF1552)),
                      ),
                    ),
        ),
        SizedBox(
          height: widget.spacingBetween ?? 26.h,
        ),

        Text(
          widget.secondTitle.tr,
          style: TextStyle(
            color: const Color(0xFF808080),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 12.h,
        ),

        Container(
          width: 390.w,
          height: 55.h,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                // The border is red if the first password is empty and the second is not, or if the passwords don't match.
                // Otherwise, keep it gray.
                width: 1.w,
                color: (_firstController.text.isEmpty && _secondController.text.isNotEmpty) ||
                        (!_isValidSecondPassword && _secondController.text.isNotEmpty)
                    ? const Color(0xFFFF1552)
                    : const Color(0xFFE6E6E6),
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
          child: TextField(
            controller: _secondController,
            obscureText: _isSecondTextFieldObscure,
            textAlignVertical: TextAlignVertical.center,
            maxLength: widget.maxLength,
            style: TextStyle(fontSize: 16.sp),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.secondTitle.tr,
              contentPadding: EdgeInsets.fromLTRB(12.w, 16.h, 12.w, 16.h),
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: _buildSecondSuffixIcon(),
              counterText: '',
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),

        // Adjusted subtitle logic with fixed height container
        Container(
          height: 20.h, // Reserve fixed height for subtitle
          alignment: Alignment.centerLeft,
          child: _firstController.text.isEmpty && _secondController.text.isNotEmpty && widget.showNotMatchSubtitle
              ? Text(
                  widget.notMatchSubtitle.tr,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFFF1552),
                  ),
                )
              : !_isValidSecondPassword && _secondController.text.isNotEmpty && widget.showNotMatchSubtitle
                  ? Text(
                      widget.notMatchSubtitle.tr,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFFF1552),
                      ),
                    )
                  : _secondController.text.isNotEmpty &&
                          _isValidSecondPassword &&
                          _validatePassword(_firstController.text) &&
                          widget.showNotMatchSubtitle &&
                          !widget.showDuplicateSubtitle
                      ? Text(
                          // 'New password and confirm password are matching',
                          widget.passwordMatchSubtitle.tr,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: UTheme.color.primary,
                          ),
                        )
                      : const SizedBox(), // Empty container to maintain the layout
        ),
        SizedBox(
          height: 38.h, // Adjust this height to maintain consistent overall spacing
        ),
      ],
    );
  }

  Widget _buildFirstSuffixIcon() {
    return Wrap(
      children: [
        if (widget.showCheckMarkButton &&
            _firstController.text.isNotEmpty &&
            !widget.showDuplicateSubtitle &&
            _isValidFirstPassword)
          _buildCheckMarkIcon(),
        if (widget.showEyeButton)
          _buildEyeIcon(
            () {
              setState(() {
                _isFirstTextFieldObscure = !_isFirstTextFieldObscure;
              });
            },
            _isFirstTextFieldObscure,
          ),
      ],
    );
  }

  Widget _buildSecondSuffixIcon() {
    return Wrap(
      children: [
        if (widget.showCheckMarkButton &&
            _secondController.text.isNotEmpty &&
            _isValidSecondPassword &&
            (!widget.validateFirstTextField || _validatePassword(_firstController.text)) &&
            !widget.showDuplicateSubtitle)
          _buildCheckMarkIcon(),
        if (widget.showEyeButton)
          _buildEyeIcon(
            () {
              setState(() {
                _isSecondTextFieldObscure = !_isSecondTextFieldObscure;
              });
            },
            _isSecondTextFieldObscure,
          ),
      ],
    );
  }

  Widget _buildCheckMarkIcon() {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Image.asset(
        'assets/images/v2/new_checked_icon.png',
        width: 20.w,
        height: 20.h,
      ),
    );
  }

  Widget _buildEyeIcon(Function onTap, bool isHidden) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: GestureDetector(
        child: Icon(
          isHidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: const Color(0xFFB3B3B3),
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
