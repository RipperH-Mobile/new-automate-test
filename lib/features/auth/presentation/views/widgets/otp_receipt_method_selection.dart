import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/utils/authentication/authentication_helper.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/setting/setting_frame_container.dart';

class OtpReceiptMethodSelection extends StatefulWidget {
  final String initialPhoneNumber;
  final String initialEmail;
  final Function(SelectedOtpType) onMethodSelected;

  const OtpReceiptMethodSelection({
    super.key,
    required this.initialPhoneNumber,
    required this.initialEmail,
    required this.onMethodSelected,
  });

  @override
  State<OtpReceiptMethodSelection> createState() => _OtpReceiptMethodSelectionState();
}

class _OtpReceiptMethodSelectionState extends State<OtpReceiptMethodSelection> {
  SelectedOtpType _selectedMethod = SelectedOtpType.email;

  void _selectMethod(SelectedOtpType method) {
    setState(() {
      _selectedMethod = method;
    });
    widget.onMethodSelected(_selectedMethod);
  }

  @override
  Widget build(BuildContext context) {
    bool isPhoneSelected = _selectedMethod == SelectedOtpType.phone;
    bool isEmailSelected = _selectedMethod == SelectedOtpType.email;

    return SettingFrameContainer.withChildren(
      context: context,
      dividerPadding: const EdgeInsets.only(left: AppSpace.space16),
      children: [
        _buildSelectionRow(
          method: SelectedOtpType.email,
          label: 'Email'.tr,
          value: widget.initialEmail,
          isSelected: isEmailSelected,
        ),
        _buildSelectionRow(
          method: SelectedOtpType.phone,
          label: 'Phone number'.tr,
          value: widget.initialPhoneNumber,
          isSelected: isPhoneSelected,
        ),
      ],
    );
  }

  Widget _buildSelectionRow({
    required SelectedOtpType method,
    required String label,
    required String value,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _selectMethod(method),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isSelected
                ? Icon(
                    Icons.check,
                    color: UTheme.color.primary,
                    size: 24,
                  )
                : const SizedBox(width: AppSize.size6, height: AppSize.size6),
            const SizedBox(width: AppSize.size6),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AppText.body1(
                      label,
                      context: context,
                      color: context.theme.appColors.textDarkest,
                    ),
                  ),
                  Expanded(
                    child: AppText.body1(
                      value,
                      context: context,
                      color: context.theme.appColors.textLighter,
                      textAlign: TextAlign.right,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
