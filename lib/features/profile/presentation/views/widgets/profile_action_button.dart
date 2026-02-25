import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';

/// Reusable action button for profile panels
class ProfileActionButton extends StatelessWidget {
  final String title;
  final String svgPath;
  final VoidCallback? onTap;

  const ProfileActionButton({
    super.key,
    required this.title,
    required this.svgPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppSpace.space4),
          ),
          child: Opacity(
            opacity: onTap == null ? 0.25 : 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: AppSize.size6,
                  height: AppSize.size6,
                  child: Center(
                    child: SvgPicture.asset(
                      svgPath,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).appColors.iconInverse,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSpace.space1,
                ),
                AppText.body4(
                  title,
                  context: context,
                  color: Theme.of(context).appColors.textPrimaryInverse,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
