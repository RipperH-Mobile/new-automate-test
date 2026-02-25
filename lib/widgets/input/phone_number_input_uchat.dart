// ignore_for_file: implementation_imports

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/providers/country_provider.dart';
import 'package:intl_phone_number_input/src/utils/phone_number/phone_number_util.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';

import 'package:uchat/widgets/input/phone_number_input_uchat_controller.dart';
import 'package:uchat/widgets/app_text.dart';

class PhoneNumberInputUChat extends StatefulWidget {
  final String title;
  final bool isEnabled;
  final List<String>? countries;
  final FocusNode? focusNode;
  final void Function(PhoneNumber)? onInputChanged;
  final void Function(bool)? onInputValidated;
  final TextEditingController? textFieldController;
  final PhoneNumber? initialValue;
  final void Function()? onClearInputText;
  final String? description;
  final String? errorText;
  final Widget? error;
  final CountryWithPhoneCode? selectedCountry;

  const PhoneNumberInputUChat({
    super.key,
    required this.title,
    this.isEnabled = true,
    this.selectedCountry,
    this.countries,
    this.focusNode,
    this.onInputChanged,
    this.onInputValidated,
    this.textFieldController,
    this.initialValue,
    this.onClearInputText,
    this.description,
    this.errorText,
    this.error,
  });

  factory PhoneNumberInputUChat.withController({
    Key? key,
    required String title,
    required PhoneNumberInputUChatController controller,
    void Function(PhoneNumber)? onInputChanged,
    void Function(bool)? onInputValidated,
    void Function()? onClearInputText,
    String? description,
    String? errorText,
    PhoneNumber? initialValue,
    Widget? error,
    CountryWithPhoneCode? selectedCountry,
  }) {
    return PhoneNumberInputUChat(
      key: key,
      title: title,
      selectedCountry: selectedCountry,
      isEnabled: controller.mobileCountryEnabled.isNotEmpty,
      countries: controller.mobileCountryEnabled,
      focusNode: controller.focusNodePhoneNumber,
      textFieldController: controller.phoneNumberController,
      initialValue: initialValue,
      onInputChanged: (number) {
        controller.onInputChanged(number);
        onInputChanged?.call(number);
      },
      onInputValidated: (isValid) {
        controller.onInputValidated(isValid);
        onInputValidated?.call(isValid);
      },
      onClearInputText: () {
        controller.onClearInputText();
        onClearInputText?.call();
      },
      description: description,
      errorText: errorText,
      error: error,
    );
  }

  @override
  State<PhoneNumberInputUChat> createState() => _PhoneNumberInputUChatState();
}

class _PhoneNumberInputUChatState extends State<PhoneNumberInputUChat> {
  /// The plugin’s internal `Country` model for the currently selected country.
  Country? _selectedCountry;

  /// Full list of countries, filtered by [widget.countries] if not null.
  late List<Country> _availableCountries;

  /// Local controller if [widget.textFieldController] is null
  late TextEditingController _localController;

  /// Whether the current phone input is considered valid.
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _localController = widget.textFieldController ?? TextEditingController();
    _loadCountries();
    _initializeValue();
  }

  @override
  void dispose() {
    if (widget.textFieldController == null) {
      _localController.dispose();
    }
    super.dispose();
  }

  /// Load countries from the plugin’s built-in provider.
  void _loadCountries() {
    _availableCountries = CountryProvider.getCountriesData(
      countries: widget.countries,
    );

    // Pick a default country based on initialValue or the first in the list.
    _selectedCountry = _findInitialCountry(widget.initialValue?.isoCode);
  }

  /// Finds the matching country from `_availableCountries` using [isoCode],
  /// or defaults to the first if none match.
  Country _findInitialCountry(String? isoCode) {
    if (isoCode != null && isoCode.isNotEmpty) {
      final found = _availableCountries.firstWhere(
        (c) => c.alpha2Code == isoCode,
        orElse: () => _availableCountries.first,
      );
      return found;
    } else {
      return _availableCountries.first;
    }
  }

  /// If we have an initial phone number, set the text field accordingly.
  void _initializeValue() async {
    final initial = widget.initialValue;
    if (initial != null && initial.phoneNumber != null) {
      // E.g. +66xxxxxxxxxx
      String raw = await PhoneNumber.getParsableNumber(initial);
      _localController.text = raw;
      _validatePhone(raw);
    }
  }

  /// Called whenever user types in the TextFormField.
  void _onChanged(String value) {
    // Remove non-digit chars so we can parse if needed.
    final rawNumber = value.replaceAll(RegExp(r'[^\d+]'), '');
    _validatePhone(rawNumber);
  }

  /// Actually run validation using the plugin’s phone util.
  Future<void> _validatePhone(String raw) async {
    if (_selectedCountry == null) return;

    // String isoCode = _selectedCountry!.alpha2Code!;
    String isoCode = widget.selectedCountry?.countryCode ?? '';
    bool? isValid = false;

    if (raw.isNotEmpty) {
      try {
        isValid = await PhoneNumberUtil.isValidNumber(
          phoneNumber: raw,
          isoCode: isoCode,
        );
      } catch (_) {
        // ignore
      }
    }

    setState(() {
      _isPhoneValid = (isValid == true);
    });

    // Combine dial code + raw for the callback
    widget.onInputChanged?.call(PhoneNumber(
      phoneNumber: raw,
      isoCode: widget.selectedCountry?.countryCode ?? '',
      dialCode: widget.selectedCountry?.phoneCode ?? '',
    ));
    widget.onInputValidated?.call(_isPhoneValid);
  }

  @override
  Widget build(BuildContext context) {
    final hasError = (widget.errorText ?? '').isNotEmpty || widget.error != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Title label
        AppText.body2(
          widget.title,
          context: context,
          color: context.theme.appColors.textLight,
        ),

        const SizedBox(
          height: AppSpace.space1,
        ),

        // Row: [SelectorButton -> Vertical Divider -> TextFormField]
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // The country code
            AppText.title1(
              '+${widget.selectedCountry?.phoneCode ?? ''}',
              context: context,
            ),

            // Vertical divider
            Container(
              width: AppSpace.spacePx,
              height: AppSpace.space6,
              color: context.theme.appColors.border,
              margin: const EdgeInsets.symmetric(
                horizontal: AppSpace.space2,
              ),
            ),

            // The phone TextFormField
            Expanded(
              child: TextFormField(
                focusNode: widget.focusNode,
                controller: _localController,
                enabled: widget.isEnabled,
                autofocus: false,
                keyboardType: TextInputType.phone,
                style: context.theme.appTexts.title1,
                cursorColor: context.theme.appColors.textPrimary,
                decoration: InputDecoration(
                  hintText: widget.selectedCountry?.phoneMaskMobileNational,
                  hintStyle: context.theme.appTexts.title1.copyWith(
                    color: context.theme.appColors.textLight,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),

                // Optional input formatters
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  if (widget.selectedCountry != null)
                    LibPhonenumberTextFormatter(
                      country: widget.selectedCountry!,
                      phoneNumberFormat: PhoneNumberFormat.national,
                      onFormatFinished: (val) {},
                    )
                ],
                onChanged: _onChanged,
              ),
            ),
          ],
        ),

        // If there's an error, show it
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
            ),
            child: widget.error ??
                AppText.body3(
                  widget.errorText!.tr,
                  context: context,
                  color: context.theme.appColors.textError,
                ),
          ),

        // If there's a description and no error, show it
        if (widget.description != null && !hasError)
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpace.space2,
            ),
            child: AppText.body3(
              widget.description!.tr,
              context: context,
              color: context.theme.appColors.textLight,
            ),
          ),
      ],
    );
  }
}
