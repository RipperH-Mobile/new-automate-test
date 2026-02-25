import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/dimensions.dart';
import 'package:uchat/widgets.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_control_button.dart';
import 'package:uuid/uuid.dart';

import '../arguments/passcode_arguments.dart';
import '../controllers/passcode_controller.dart';
import '../widgets/button/passcode_num_pad.dart';

class PasscodeScreen extends GetView<PasscodeController> {
  static const int buttonColumnCount = 3;

  const PasscodeScreen({super.key});

  @override
  String? get tag {
    if (Get.arguments is PasscodeArguments) {
      return (Get.arguments as PasscodeArguments).controllerTag;
    }

    return const Uuid().v4();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetBuilder<PasscodeController>(
        id: PasscodeIds.main,
        tag: controller.arguments.controllerTag,
        builder: (ctl) {
          return ScaffoldBasic(
            backgroundColor: context.theme.appColors.backgroundNeutralLightest,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: context.theme.appColors.backgroundNeutralLightest,
              elevation: 0,
              automaticallyImplyLeading: false,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              title: AppText.title3(
                controller.getAppBarTitle(),
                context: context,
                color: context.theme.appColors.textDarkest,
              ),
              leadingWidth: AppSpace.space20,
              leading: Obx(
                () {
                  // Show leading back button unless hideCloseButton is true
                  if (controller.isHideCloseButton()) {
                    return const SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(
                      left: AppSpace.space4,
                    ),
                    child: AppControlButton.back(
                      context: context,
                      onTap: () {
                        Get.back();
                      },
                    ),
                  );
                },
              ),
            ),
            child: SafeArea(
              child: Container(
                color: context.theme.appColors.backgroundNeutralLightest,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildHeader(context),
                    _buildPasswordPadGroup(context),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(
      () => Expanded(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space10),
              margin: EdgeInsets.only(
                top: AppSpace.space6,
                bottom: controller.warningLabel.isEmpty ? 50.hr : 20.hr,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      if (controller.arguments.user != null) ...[
                        Avatar(
                          url: controller.arguments.user?.avatarUrl,
                          radius: AppSize.size8,
                        ),
                        const SizedBox(height: AppSpace.space4),
                      ],
                      AppText.body3Bold(
                        controller.getHeaderTitle(),
                        context: context,
                      ),
                      const SizedBox(height: AppSpace.space015),
                      AppText.body3(
                        controller.getSubLabel(),
                        context: context,
                        color: context.theme.appColors.textLighter,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpace.space1),
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.passcode.map((digit) => PasscodeBullet(digit: digit)).toList(),
                    );
                  }),
                  const SizedBox(height: AppSpace.space1),
                  Obx(() {
                    return Visibility(
                      visible: controller.warningLabel().isNotEmpty,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: AppSpace.space2),
                        child: AppText.body4(
                          controller.warningLabel(),
                          context: context,
                          color: context.theme.appColors.textError,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordPadGroup(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          LayoutBuilder(builder: (context, bc) {
            return GridView.builder(
              primary: false,
              itemCount: controller.numPads.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: buttonColumnCount,
                mainAxisExtent: bc.maxHeight / 4, // 4 is column number.
              ),
              itemBuilder: buildPasswordItem,
            );
          }),
          Obx(
            () => controller.isDisable()
                ? Container(
                    color: context.theme.appColors.textLighter.withValues(alpha: 0.3),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  Widget buildPasswordItem(BuildContext context, int index) {
    final numPad = controller.numPads.elementAt(index);

    return Obx(() {
      final isDisabled = controller.isDisable();
      bool isMiddleColumn = index % PasscodeScreen.buttonColumnCount == 1;

      switch (numPad) {
        case 'NONE':
          return Container();
        case 'BIOMETRIC':
          if (controller.isBiometricSupported()) {
            switch (controller.isBiometricSupportedType()) {
              case BiometricType.face:
                return Center(
                  child: PasscodeNumPad(
                    widget: ImageIcon(
                      Assets.images.faceId.provider(),
                      color: isDisabled ? context.theme.appColors.textLighter : context.theme.appColors.textPrimary,
                      size: AppSpace.space10,
                    ),
                    showHorizontalBorder: isMiddleColumn,
                    onPressed: isDisabled ? null : () => controller.handleBiometricAuth(),
                  ),
                );
              case BiometricType.fingerprint:
                return Center(
                  child: PasscodeNumPad(
                    widget: Icon(
                      Icons.fingerprint,
                      color: isDisabled ? context.theme.appColors.textLighter : context.theme.appColors.textPrimary,
                      size: 30.hr,
                    ),
                    showHorizontalBorder: isMiddleColumn,
                    onPressed: isDisabled ? null : () => controller.handleBiometricAuth(),
                  ),
                );
              default:
                return Container(color: context.theme.appColors.backgroundNeutralLightest);
            }
          }
          return Center(
            child: PasscodeNumPad(
              widget: AppText.body1Bold(
                'Clear'.tr,
                context: context,
                color: isDisabled ? context.theme.appColors.textLighter : null,
              ),
              showHorizontalBorder: isMiddleColumn,
              onPressed: isDisabled ? null : () => controller.handleClear(),
            ),
          );
        case 'CANCEL':
          return Center(
            child: PasscodeNumPad(
              widget: AppText.body1Bold(
                'Clear'.tr,
                context: context,
                color: isDisabled ? context.theme.appColors.textLighter : null,
              ),
              showHorizontalBorder: isMiddleColumn,
              onPressed: isDisabled ? null : () => controller.handleClear(),
            ),
          );
        case 'BACKSPACE':
          return Center(
            child: PasscodeNumPad(
              widget: ColorFiltered(
                colorFilter: isDisabled
                    ? ColorFilter.mode(context.theme.appColors.textLighter, BlendMode.srcIn)
                    : const ColorFilter.mode(Colors.transparent, BlendMode.dst),
                child: Assets.images.passcodeBackspace.image(height: 22.hr),
              ),
              showHorizontalBorder: isMiddleColumn,
              onPressed: isDisabled ? null : () => controller.handleDeletePasscodeDigit(),
            ),
          );
        default:
          return Center(
            child: PasscodeNumPad(
              label: numPad,
              textStyle: context.theme.appTexts.heading4.copyWith(
                color: isDisabled ? context.theme.appColors.textLighter : context.theme.appColors.textDarkest,
              ),
              showHorizontalBorder: isMiddleColumn,
              onPressed: isDisabled ? null : () => controller.handleInputPasscodeDigit(numPad),
            ),
          );
      }
    });
  }
}
