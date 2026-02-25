import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/add_contact/presentation/controller/add_contact_search_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets.dart';

class AddContactSearchInput extends GetView<AddContactSearchController> {
  const AddContactSearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final searchType = controller.searchType.value;

      if (searchType == searchTypeUsername) {
        return SearchBox(
          onChanged: (String text) async {
            GetIt.I<TaxonomyService>().sendEvent(
              EventName.searchingUChatIdAddFriendPage,
              eventProperties: EventProperty.searchingUChatIdAddFriendPage(searchInput: text),
            );
          },
          height: AppSize.size10.spMin,
          padding: EdgeInsets.only(right: AppSpace.space4.spMin, left: AppSpace.space4.spMin),
          color: context.theme.appColors.backgroundNeutralLight,
          focusNode: controller.searchFocusNode,
          label: 'UChat ID'.tr,
          hintStyle: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textLight),
          style: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textDarkest),
          searchController: controller.searchController,
          onSuffixPressed: controller.onClearInput,
          showSearchBtn: true,
          autofocus: controller.searchText.value == '',
          hasSuffix: false,
          prefixIcon: Container(
            margin: EdgeInsets.only(right: 15.spMin),
            child: Assets.vectors.searchIcon.svg(
              height: AppSize.size4.spMin,
              width: AppSize.size4.spMin,
            ),
          ),
          suffixIcon: Assets.vectors.circleCloseIcon.svg(
            height: 20.spMin,
            width: 20.spMin,
          ),
        );
      } else if (searchType == searchTypePhone) {
        return SizedBox(
          height: AppSize.size10.spMin,
          child: Row(
            children: [
              GestureDetector(
                onTap: controller.onOpenCountryListBottomSheet,
                child: Container(
                  height: AppSize.size10.spMin,
                  padding: EdgeInsets.only(
                    top: AppSize.size2.spMin,
                    left: AppSize.size2.spMin,
                    bottom: AppSize.size2.spMin,
                    right: AppSize.size3.spMin,
                  ),
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundNeutralLighterPressed,
                    borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                  ),
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CountryFlag.fromCountryCode(
                          controller.currentCountry.value?.countryCode ?? 'TH',
                          height: AppSize.size4,
                          width: AppSize.size6,
                        ),
                        6.spMin.horizontalSpace,
                        Text(
                          '+${controller.currentCountry.value?.phoneCode ?? '66'}',
                          style: context.theme.appTexts.body1.copyWith(height: 1),
                        ),
                        AppSpace.space2.spMin.horizontalSpace,
                        Assets.vectors.arrowDown.svg(height: 20.spMin, width: 20.spMin),
                      ],
                    ),
                  ),
                ),
              ),
              AppSpace.space2.horizontalSpace,
              Expanded(
                child: SearchBox(
                  padding: EdgeInsets.only(right: AppSpace.space4.spMin, left: AppSpace.space4.spMin),
                  color: context.theme.appColors.backgroundNeutralLight,
                  focusNode: controller.searchFocusNode,
                  label: 'Phone Number'.tr,
                  hintStyle: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textLight, height: 1),
                  style: context.theme.appTexts.body1.copyWith(color: context.theme.appColors.textDarkest, height: 1),
                  searchController: controller.searchController,
                  isShowPrefix: false,
                  onSuffixPressed: controller.onClearInput,
                  onChanged: controller.onPhoneNumberChange,
                  autofocus: controller.searchText.value == '',
                  suffixIcon: Assets.vectors.circleCloseIcon.svg(
                    height: 20.spMin,
                    width: 20.spMin,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    if (controller.currentCountry.value != null)
                      LibPhonenumberTextFormatter(
                        country: controller.currentCountry.value!,
                        phoneNumberFormat: PhoneNumberFormat.national,
                      )
                  ],
                ),
              ),
            ],
          ),
        );
      }

      return const SizedBox.shrink();
    });
  }
}
