import 'package:flutter/material.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/input/no_emoji_text_input_formatter.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController textController;
  final bool isPasswordObscured;
  final VoidCallback togglePasswordVisibility;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool showWarning;
  final String labelText;
  final String hintText;
  final Color normalBorderColor;
  final Color errorBorderColor;
  final Color suffixIconColor;

  const PasswordInputField({
    super.key,
    required this.textController,
    required this.isPasswordObscured,
    required this.togglePasswordVisibility,
    this.validator,
    this.onChanged,
    required this.showWarning,
    required this.labelText,
    required this.hintText,
    required this.normalBorderColor,
    required this.errorBorderColor,
    required this.suffixIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: showWarning ? errorBorderColor : normalBorderColor),
        borderRadius: BorderRadius.circular(AppSpace.space3),
      ),
      child: TextFormField(
        controller: textController,
        obscureText: isPasswordObscured,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: suffixIconColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
        ),
        validator: validator,
        onChanged: onChanged,
        inputFormatters: [NoEmojiTextInputFormatter()],
      ),
    );
  }
}
