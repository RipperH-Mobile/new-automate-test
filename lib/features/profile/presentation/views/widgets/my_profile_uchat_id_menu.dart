import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/toast/app_toast.dart';
import 'package:uchat/features/profile/presentation/views/widgets/corner_box_menu.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/qr_code/qr_code_bottom_sheet.dart';

class MyProfileUchatIdMenu extends StatelessWidget {
  final String? uchatId;

  const MyProfileUchatIdMenu({super.key, required this.uchatId});

  void _handleShowMyQR() {
    final user = UserController.instance.currentUser();
    if (user != null) {
      QrCodeBottomSheet.showFromUserEntity(user);
    }
  }

  void _handleCopyUchatId(String? uchatId) {
    if (uchatId == null || uchatId.isEmpty) {
      return;
    }

    // haptic feedback for better UX
    HapticFeedback.lightImpact();

    Clipboard.setData(ClipboardData(text: uchatId));

    final context = Get.context;
    if (context != null) {
      // Show success toast
      AppToast.showToast(
        context: context,
        message: 'copied UChat ID'.tr,
        icon: Assets.vectors.contentCopy.svg(
          colorFilter: ColorFilter.mode(
            context.theme.appColors.iconPrimaryInverse,
            BlendMode.srcIn,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CornerBoxMenuItem(
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  _handleCopyUchatId(uchatId);
                },
                behavior: HitTestBehavior.translucent,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppSpace.space3,
                    horizontal: AppSpace.space4,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText.body3(
                        'UChat ID'.tr,
                        context: context,
                      ),
                      AppText.body1(
                        uchatId ?? 'Not set up'.tr,
                        context: context,
                        color: uchatId != null && uchatId!.isNotEmpty
                            ? context.theme.appColors.textPrimary
                            : context.theme.appColors.textLight,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _handleShowMyQR();
              },
              behavior: HitTestBehavior.translucent,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpace.space4,
                ),
                child: Assets.vectors.qrCode.svg(
                  colorFilter: ColorFilter.mode(
                    context.theme.appColors.iconPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
