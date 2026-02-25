import 'dart:convert';

import 'package:dlibphonenumber/dlibphonenumber.dart' as dlib;
import 'package:dlibphonenumber/exceptions/number_parse_exception.dart';
import 'package:dlibphonenumber/phone_number_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart' as intl_phone_number_field;
import 'package:intl_phone_number_field/models/country_code_model.dart';
import 'package:intl_phone_number_field/models/dialog_config.dart';
import 'package:intl_phone_number_field/models/phone_config.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/input/phone_number_input_uchat_controller.dart';
import 'package:uchat/themes/themes.dart';
import 'package:uchat/themes/util.dart';

class PhoneNumberInputUChatDesktop extends StatefulWidget {
  const PhoneNumberInputUChatDesktop({
    super.key,
    required this.title,
    this.isEnabled = true,
    this.countries,
    this.focusNode,
    this.onInputChanged,
    this.onInputValidated,
    this.textFieldController,
    this.initCountry,
    this.onClearInputText,
    this.showClearButton = true,
    this.description,
    this.errorText,
    this.error,
  });
  final String title;
  final bool isEnabled;
  final List<CountryCodeModel>? countries;
  final FocusNode? focusNode;
  final void Function(PhoneNumber)? onInputChanged;
  final void Function(bool)? onInputValidated;
  final TextEditingController? textFieldController;
  final CountryCodeModel? initCountry;
  final void Function()? onClearInputText;
  final bool showClearButton;
  final String? description;
  final String? errorText;
  final Widget? error;

  factory PhoneNumberInputUChatDesktop.withController({
    Key? key,
    required String title,
    required PhoneNumberInputUChatController controller,
    void Function(PhoneNumber)? onInputChanged,
    void Function()? onClearInputText,
    void Function(bool)? onInputValidated,
    String? description,
    String? errorText,
    Widget? error,
  }) {
    useLogger().d(controller.phoneNumber());
    return PhoneNumberInputUChatDesktop(
      key: key,
      title: title,
      isEnabled: controller.desktopCountryEnabled.isNotEmpty,
      countries: controller.desktopCountryEnabled,
      focusNode: controller.focusNodePhoneNumber,
      onInputChanged: (number) {
        controller.onInputChanged(number);
        onInputChanged?.call(number);
      },
      textFieldController: controller.phoneNumberController,
      initCountry: controller.initialCountryCode,
      onClearInputText: () {
        controller.onClearInputText();
        onClearInputText?.call();
      },
      onInputValidated: (value) {
        controller.onInputValidated(value);
        onInputValidated?.call(value);
      },
      showClearButton: controller.phoneNumber().phoneNumber != '' &&
          controller.phoneNumber().phoneNumber != controller.phoneNumber().dialCode,
      description: description,
      errorText: errorText,
      error: error,
    );
  }

  @override
  State<PhoneNumberInputUChatDesktop> createState() => _PhoneNumberInputUChatDesktopState();
}

class _PhoneNumberInputUChatDesktopState extends State<PhoneNumberInputUChatDesktop> {
  String currentIsoCode = 'TH';

  @override
  void initState() {
    super.initState();
    if (widget.initCountry?.code != null) {
      currentIsoCode = widget.initCountry!.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isError = (widget.errorText ?? '').isNotEmpty || widget.error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: const Color(0xFF666666),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 13.spMin,
        ),
        Stack(
          children: [
            intl_phone_number_field.InternationalPhoneNumberInput(
              controller: widget.textFieldController,
              initCountry: widget.initCountry,
              dialogConfig: DialogConfig(
                backgroundColor: UTheme.color.scaffoldBackground,
                selectedItemColor: Colors.black12,
                searchBoxBackgroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
                searchBoxTextStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
                searchBoxHintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
                searchBoxIconColor: const Color(0xFF333333),
              ),
              phoneConfig: PhoneConfig(
                autoFocus: true,
                focusNode: widget.focusNode,
                showCursor: true,
                focusedColor: UTheme.color.primary,
                errorColor: Colors.red,
                borderWidth: 1,
                radius: 12.r,
                enabledColor: const Color(
                  0xffcccccc,
                ),
                backgroundColor: UTheme.color.scaffoldInput,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              height: 52.spMin,
              betweenPadding: 13.spMin,
              countryConfig: intl_phone_number_field.CountryConfig(
                decoration: BoxDecoration(
                  color: UTheme.color.scaffoldInput,
                  borderRadius: BorderRadius.circular(
                    12.r,
                  ),
                  border: Border.all(
                    color: const Color(
                      0xffcccccc,
                    ),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 10,
                      color: Colors.black.withValues(
                        alpha: 0.1,
                      ),
                    )
                  ],
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onInputChanged: (value) {
                // Remove leading zero
                final number = value.rawNumber.replaceFirst(RegExp(r'^0+'), '');
                widget.onInputChanged?.call(
                  PhoneNumber(
                    isoCode: value.code,
                    dialCode: value.dial_code,
                    phoneNumber: '${value.dial_code}$number', // Add dial code e.g. +66
                  ),
                );
                // Update currentIsoCode for inputformatter
                if (value.code != currentIsoCode) {
                  setState(() {
                    currentIsoCode = value.code;
                  });
                }
                // Validate phone number if length > 2
                if (value.rawNumber.length > 2) {
                  PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
                  try {
                    dlib.PhoneNumber phoneNumber = phoneUtil.parse(
                      value.rawNumber,
                      value.code,
                    );
                    bool isValid = phoneUtil.isValidNumber(phoneNumber);
                    widget.onInputValidated?.call(isValid);
                  } on NumberParseException catch (e) {
                    useLogger().w(e);
                    widget.onInputValidated?.call(false);
                  }
                }
              },
              loadFromJson: () {
                return Future.value(
                  const JsonEncoder().convert(widget.countries),
                );
              },
              inputFormatters: [
                TextInputFormatter.withFunction(
                  (oldValue, newValue) {
                    if (newValue.text.length < 2) {
                      return newValue;
                    }
                    final PhoneNumberUtil phoneUtil = PhoneNumberUtil.instance;
                    String result = dlib.PhoneNumberUtil.instance.format(
                      phoneUtil.parse(newValue.text, currentIsoCode),
                      dlib.PhoneNumberFormat.national,
                    );
                    return TextEditingValue(
                      text: result,
                    );
                  },
                ),
              ],
            ),
            if (widget.showClearButton)
              Positioned(
                right: 20.spMin,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () {
                    widget.onClearInputText?.call();
                  },
                  child: Container(
                    width: 20.spMin,
                    height: 20.spMin,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      size: 16.spMin,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
          ],
        ),
        if (isError)
          Padding(
            padding: EdgeInsets.only(
              top: 14.spMin,
            ),
            child: widget.error ??
                Text(
                  widget.errorText!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.red,
                  ),
                ),
          ),
        if (widget.description != null && !isError)
          Padding(
            padding: EdgeInsets.only(
              top: 14.spMin,
            ),
            child: Text(
              widget.description!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF989898),
              ),
            ),
          ),
      ],
    );
  }
}
