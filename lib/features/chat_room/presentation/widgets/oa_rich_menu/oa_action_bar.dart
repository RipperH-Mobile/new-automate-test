import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';
import 'package:uchat/features/chat_room/presentation/widgets/oa_rich_menu/rich_menu_panel.dart';
import 'package:uchat/gen/assets.gen.dart';

class OaActionBar extends StatelessWidget {
  const OaActionBar({
    super.key,
    this.isLoading = false,
    this.onPressSwitchMode,
    this.onMenuToggle,
    required this.isShowRichMenu,
    this.richMenu,
    this.onSendMessage,
  });
  final bool isLoading;
  final VoidCallback? onPressSwitchMode;
  final Function(bool)? onMenuToggle;
  final bool isShowRichMenu;
  final RichMenuModel? richMenu;
  final void Function(String message)? onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.appColors.elevationSurfaceChat,
      child: Column(
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: isShowRichMenu
                ? RichMenuPanel(
                    richMenu: richMenu,
                    isLoading: isLoading,
                    onSendMessage: onSendMessage,
                  )
                : const SizedBox.shrink(),
          ),
          Container(
            color: context.theme.appColors.backgroundNeutralLightest,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpace.space4),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: onPressSwitchMode,
                              child: Assets.vectors.keyboard03.svg(
                                  colorFilter: ColorFilter.mode(context.theme.appColors.buttonBlack, BlendMode.srcIn))),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            onMenuToggle?.call(!isShowRichMenu);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Menu'.tr, style: context.theme.textTheme.bodyMedium),
                              const SizedBox(width: AppSpace.space1),
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                turns: isShowRichMenu ? 0.5 : 0.0,
                                child: Icon(
                                  Icons.keyboard_arrow_up_rounded,
                                  size: 20,
                                  color: context.theme.appColors.buttonBlack,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Expanded(flex: 1, child: SizedBox.shrink()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
