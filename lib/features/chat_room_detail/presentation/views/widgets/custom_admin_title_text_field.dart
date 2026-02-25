import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/input/app_text_field.dart';

class CustomAdminTitleTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function(String) onChanged;
  final String? errorMsg;

  const CustomAdminTitleTextField({
    super.key,
    required this.textEditingController,
    required this.onChanged,
    this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4),
      child: AppTextField(
        labelText: 'Custom Title'.tr,
        hintText: 'Admin'.tr,
        inputType: TextInputType.text,
        textEditController: textEditingController,
        borderColor: Colors.transparent,
        maxLength: 8,
        customInputFormatter: FilteringTextInputFormatter.deny(RegExp(
          // This regex match any character that is not a letter or digit.
          // \p{L} is all single code point letters in any language.
          // \p{M} is all character intended to be combined with another character such as some vowel in Thai.
          r'[^\p{L}\p{M}0-9]',
          unicode: true,
        )),
        errorMsg: errorMsg,
        onChanged: onChanged,
      ),
    );
  }
}
