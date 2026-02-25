import 'package:flutter/material.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

import 'no_emoji_text_input_formatter.dart';

class AppTextFieldPassword extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController? textEditController;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final Color? borderColor;
  final TextInputType? inputType;
  final Widget? errorWidget;

  const AppTextFieldPassword({
    super.key,
    required this.labelText,
    required this.hintText,
    this.textEditController,
    this.focusNode,
    this.onChanged,
    this.borderColor,
    this.inputType,
    this.errorWidget,
  });

  @override
  State<AppTextFieldPassword> createState() => _AppTextFieldPasswordState();
}

class _AppTextFieldPasswordState extends State<AppTextFieldPassword> {
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      labelText: widget.labelText,
      hintText: widget.hintText,
      textEditController: widget.textEditController,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      borderColor: widget.borderColor,
      inputType: TextInputType.text,
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            isObscureText = !isObscureText;
          });
        },
        child: isObscureText ? Assets.vectors.visibleOffSolid.svg() : Assets.vectors.visibleOnSolid.svg(),
      ),
      errorWidget: widget.errorWidget,
      obscureText: isObscureText,
      customInputFormatter: NoEmojiTextInputFormatter(),
    );
  }
}
