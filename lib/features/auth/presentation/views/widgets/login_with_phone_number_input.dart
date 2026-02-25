import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/presentation/controllers/base_controller/enter_phone_number_base_controller.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/input/phone_number_input_uchat.dart';
import 'package:uchat/widgets/input/phone_number_input_uchat_desktop.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

// TODO: use stateless widget instead getx controller

class PhoneNumberInput<T extends EnterPhoneNumberBaseController> extends GetView<T> {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final ctl = controller;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: ctl.isFocusedInputBox.value
                        ? ctl.errorMessagePhone.value.isEmpty
                            ? context.theme.appColors.borderDarker
                            : context.theme.appColors.borderError
                        : context.theme.appColors.borderDark,
                  ),
                  borderRadius: BorderRadius.circular(AppRadius.roundedXl),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: ctl.onOpenCountryListBottomSheet,
                    behavior: HitTestBehavior.translucent,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpace.space4,
                        vertical: AppSpace.space3,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText.body2(
                                'Country/Region',
                                context: context,
                                color: context.theme.appColors.textLight,
                              ),
                              const SizedBox(height: AppSpace.space2),
                              Obx(
                                () => Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    _buildInputShimmerLoading(
                                      height: 24.spMin,
                                      width: 26.spMin,
                                      child: CountryFlag.fromCountryCode(
                                        ctl.currentCountry.value?.countryCode ?? 'TH',
                                        height: AppSize.size4,
                                        width: AppSize.size6,
                                      ),
                                      context: context,
                                    ),
                                    const SizedBox(width: AppSpace.space3),
                                    _buildInputShimmerLoading(
                                      height: 24.spMin,
                                      width: 200.spMin,
                                      child: AppText.title1(
                                        ctl.currentCountry.value?.countryName ?? 'Thailand'.tr,
                                        context: context,
                                      ),
                                      context: context,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Obx(() {
                            return ctl.currentCountry.value == null
                                ? const SizedBox.shrink()
                                : Assets.vectors.chevronDown.svg(
                                    colorFilter: ColorFilter.mode(
                                      context.theme.appColors.icon,
                                      BlendMode.srcIn,
                                    ),
                                  );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: ctl.isFocusedInputBox.value
                        ? context.theme.appColors.borderDarker
                        : context.theme.appColors.borderDark,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpace.space4,
                      vertical: AppSpace.space3,
                    ),
                    child: _buildInputShimmerLoading(
                      height: 24.spMin,
                      width: 260.spMin,
                      child: UChatScreenUtil.instance.isMobilePlatform
                          ? Obx(
                              () => PhoneNumberInputUChat.withController(
                                title: 'Phone No.'.tr,
                                controller: ctl.phoneInputCtl,
                                onInputChanged: ctl.onPhoneCtlChanged,
                                onInputValidated: ctl.onPhoneValidated,
                                onClearInputText: ctl.clearPhone,
                                selectedCountry: ctl.currentCountry.value,
                                initialValue: PhoneNumber(
                                  dialCode: ctl.currentCountry.value?.phoneCode ?? '66',
                                  isoCode: ctl.currentCountry.value?.countryCode ?? 'TH',
                                ),
                              ),
                            )
                          : Obx(
                              () => PhoneNumberInputUChatDesktop.withController(
                                title: 'Phone No.'.tr,
                                errorText: ctl.errorMessagePhone(),
                                controller: ctl.phoneInputCtl,
                                onInputChanged: ctl.onPhoneCtlChanged,
                                onInputValidated: ctl.onPhoneValidated,
                                onClearInputText: ctl.clearPhone,
                              ),
                            ),
                      shimmerChild: AppText.body2(
                        'Phone No.'.tr,
                        context: context,
                        color: context.theme.appColors.textLight,
                      ),
                      context: context,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: AppSpace.space2,
            ),
            Obx(
              () {
                if (ctl.errorMessagePhone.value.isNotEmpty) {
                  return AppText.body3(
                    ctl.errorMessagePhone.value,
                    context: context,
                    color: context.theme.appColors.textError,
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildInputShimmerLoading({
    required double height,
    required double width,
    required Widget child,
    required BuildContext context,
    Widget? shimmerChild,
  }) {
    return Obx(() {
      return controller.currentCountry.value == null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (shimmerChild != null) ...[
                  shimmerChild,
                  AppSpace.space1.verticalSpace,
                ],
                ShimmerLoading(
                  enable: true,
                  baseColor: context.theme.appColors.backgroundGrayLightest.withValues(alpha: 0.4),
                  highlightColor: context.theme.appColors.backgroundNeutralLightest.withValues(alpha: 0.2),
                  child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.spMin),
                    ),
                    child: shimmerChild,
                  ),
                ),
              ],
            )
          : child;
    });
  }
}
