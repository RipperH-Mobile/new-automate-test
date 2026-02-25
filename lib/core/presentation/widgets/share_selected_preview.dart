import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/domain/entities/share_target_entity.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/presentation/widgets/app_share_bottom_sheet.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/avatar/avatar.dart';

/// A widget to display selected room in [AppShareBottomSheet].
class ShareSelectedPreview extends StatelessWidget {
  /// Selected room data, All data needed to display in ui should be in here.
  final ShareTargetEntity target;

  /// What to do after close icon on top of avatar is pressed.
  final Function onClosePressed;

  const ShareSelectedPreview({
    super.key,
    required this.target,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppSize.size16,
          height: AppSize.size16,
          child: Stack(
            children: [
              Avatar(
                url: target.avatarUrl,
                radius: AppSize.size8,
              ),
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    onClosePressed();
                  },
                  child: Assets.vectors.iconClose.svg(),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: AppSpace.space2),
        SizedBox(
          width: AppSize.size16,
          child: AppText.body4(
            target.name,
            context: context,
            color: context.theme.appColors.textDarkest,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
