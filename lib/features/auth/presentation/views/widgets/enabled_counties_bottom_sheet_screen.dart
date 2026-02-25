// TODO: must be refactored to use design system and other best practices

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/app_text.dart';

class EnabledCountriesBottomSheetScreen extends StatelessWidget {
  final List<CountryWithPhoneCode> countryList;
  final String selectedCountryCode;
  final void Function(CountryWithPhoneCode country) onSelectItem;

  const EnabledCountriesBottomSheetScreen({
    super.key,
    required this.countryList,
    required this.selectedCountryCode,
    required this.onSelectItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select country'.tr,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        leading: Container(),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.spMin),
            child: TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel'.tr,
                style: const TextStyle(
                  color: Color(0xFF0056fd),
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: countryList.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppText.subtitle1(
                      'No item'.tr,
                      color: context.theme.appColors.textDark,
                      context: context,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: countryList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => onSelectItem.call(countryList[index]),
                    child: _buildListItem(
                      countryName: countryList[index].countryName ?? 'TH',
                      phoneCode: countryList[index].phoneCode,
                      countryCode: countryList[index].countryCode,
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildListItem({
    required String countryName,
    required String phoneCode,
    required String countryCode,
  }) {
    return SizedBox(
      height: 68.spMin,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.spMin),
            child: CountryFlag.fromCountryCode(
              countryCode,
              height: 20.spMin,
              width: 25.spMin,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 16.spMin),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    countryName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: selectedCountryCode == countryCode ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                  Text(
                    '(+$phoneCode)',
                    style: const TextStyle(
                      color: Color(0xFFc7c7c7),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (selectedCountryCode == countryCode)
            Container(
              height: 68.spMin,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                ),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.spMin),
              child: const Icon(Icons.check, color: Color(0xFF0056fd)),
            ),
        ],
      ),
    );
  }
}
