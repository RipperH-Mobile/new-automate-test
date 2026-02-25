import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/profile/presentation/views/widgets/profile_glass_container.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/utils/sanitize_thai_text.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/shimmer_loading/shimmer_loading.dart';

class ProfileHeader extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String? nickname;
  final String? status;
  final double maxHeight;
  final double minHeight;
  final void Function()? onEdit;
  final Widget? customActionButtons;

  const ProfileHeader({
    super.key,
    required this.maxHeight,
    required this.minHeight,
    required this.avatarUrl,
    required this.name,
    this.nickname,
    this.status,
    this.onEdit,
    this.customActionButtons,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final expandRatio = _calculateExpandRatio(constraints);
        final animation = AlwaysStoppedAnimation(expandRatio);

        return Stack(
          fit: StackFit.expand,
          children: [
            _buildImage(
              context,
              avatarUrl,
              size: customActionButtons != null ? 200 : 110,
              animation: animation,
            ),
            _buildTitle(
              animation: animation,
              displayName: name,
              nickname: nickname,
              status: status,
              context: context,
            ),
            _buildTitleButtons(context),
          ],
        );
      },
    );
  }

  double _calculateExpandRatio(BoxConstraints constraints) {
    double expandRatio = (constraints.maxHeight - minHeight) / (maxHeight - minHeight);
    if (expandRatio > 1.0) expandRatio = 1.0;
    if (expandRatio < 0.0) expandRatio = 0.0;
    return expandRatio;
  }

  Widget _buildTitle({
    required BuildContext context,
    required Animation<double> animation,
    required String displayName,
    String? nickname,
    String? status,
  }) {
    final displayOriginalName = sanitizeThaiText(displayName);
    String displayNickname = '';
    String displayStatus = '';
    if (nickname != null && nickname.isNotEmpty) {
      displayNickname = sanitizeThaiText(nickname);
    }

    if (status != null && status.isNotEmpty) {
      displayStatus = sanitizeThaiText(status);
    }

    final statusFontSize = 14.0;
    final maxTitleFontSize = 20.0;
    final minTitleFontSize = 18.0.spMin;
    final backBtnSize = AppSize.size20;

    return Padding(
      padding: EdgeInsets.only(
        top: AppSpace.space4,
        left: AppSpace.space4,
        right: customActionButtons != null ? AppSpace.space4 : AppSpace.space4 + backBtnSize,
        bottom: customActionButtons != null
            ? 18
            : Tween<double>(begin: AppSpace.space4, end: AppSpace.space6).evaluate(animation),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ...[
            /// Nickname
            if (displayNickname.isNotEmpty) ...[
              Align(
                alignment: AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.bottomLeft).evaluate(animation),
                child: AutoSizeText(
                  displayNickname,
                  maxLines: 1,
                  minFontSize: 5,
                  maxFontSize: maxTitleFontSize,
                  style: Get.context?.theme.appTexts.heading3.copyWith(
                    fontSize: Tween<double>(begin: minTitleFontSize, end: maxTitleFontSize).evaluate(animation),
                    color: Get.context?.theme.appColors.textPrimaryInverse,
                  ),
                ),
              ),
              const SizedBox(height: AppSpace.space1),
            ],

            /// Display name
            Align(
              alignment: AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.bottomLeft).evaluate(animation),
              child: AutoSizeText(
                displayOriginalName,
                maxLines: 1,
                minFontSize: displayNickname.isNotEmpty ? 1 : 5,
                maxFontSize: displayNickname.isNotEmpty ? statusFontSize : maxTitleFontSize,
                style: Get.context?.theme.appTexts.heading3.copyWith(
                  fontWeight: displayNickname.isNotEmpty ? FontWeight.w400 : null,
                  fontSize: Tween<double>(begin: minTitleFontSize, end: maxTitleFontSize).evaluate(animation),
                  color: Get.context?.theme.appColors.textPrimaryInverse,
                ),
              ),
            ),
            SizedBox(
              height: Tween<double>(
                begin: (status?.isNotEmpty ?? false) ? 0 : AppSpace.space1,
                end: 0,
              ).evaluate(animation),
            )
          ],
          if (displayStatus.isNotEmpty) ...[
            const SizedBox(height: AppSpace.space1),
            Align(
              alignment: AlignmentTween(begin: Alignment.bottomCenter, end: Alignment.bottomLeft).evaluate(animation),
              child: AutoSizeText(
                displayStatus,
                maxFontSize: statusFontSize,
                maxLines: 1,
                minFontSize: 1,
                style: Get.context?.theme.appTexts.body4.copyWith(
                  color: Get.context?.theme.appColors.textPrimaryInverse,
                ),
              ),
            ),
            const SizedBox(height: AppSpace.space4),
          ],
          if (customActionButtons != null) ...[
            const SizedBox(height: AppSpace.space3),
            customActionButtons!,
          ],
        ],
      ),
    );
  }

  Widget _buildImage(
    BuildContext context,
    String avatar, {
    required double size,
    required Animation<double> animation,
  }) {
    return SoftEdgeBlur(
      edges: [
        EdgeBlur(
          type: EdgeType.bottomEdge,
          size: size,
          sigma: 30,
          controlPoints: [
            ControlPoint(
              position: 0.5,
              type: ControlPointType.visible,
            ),
            ControlPoint(
              position: 1,
              // if app bar is collapsed, using blur for the whole app bar
              // otherwise using transparent to blur linear.
              type: animation.value > 0 ? ControlPointType.transparent : ControlPointType.visible,
            )
          ],
        )
      ],
      child: Builder(
        builder: (_) {
          final defaultImage = Center(
            child: Assets.vectors.account.svg(
              height: Get.width,
              width: Get.width,
              fit: BoxFit.cover,
            ),
          );

          Widget child;

          if (avatar.isEmpty) {
            child = defaultImage;
          } else {
            child = UChatImage.network(
              avatar,
              width: Get.width,
              cacheWidth: Get.width.toInt(),
              cache: false,
              fit: BoxFit.cover,
              customLoadingWidget: (state) {
                return ShimmerLoading(
                  enable: true,
                  baseColor: context.theme.appColors.backgroundGrayLighter,
                  highlightColor: context.theme.appColors.backgroundGrayLightest,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          context.theme.appColors.backgroundGrayLighter,
                          context.theme.appColors.backgroundGrayLightest,
                        ],
                      ),
                      // borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              customErrorWidget: (state) {
                return defaultImage;
              },
            );
          }

          return Stack(
            children: [
              Positioned.fill(child: child),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: size,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.2),
                        Colors.black.withValues(alpha: 0.53),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitleButtons(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 6,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ProfileGlassContainer(
            onTap: () {
              Get.back();
            },
            borderRadius: BorderRadius.circular(
              AppRadius.roundedFull,
            ),
            child: SizedBox(
              width: AppSize.size8 + AppSize.size1,
              height: AppSize.size8 + AppSize.size1,
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: context.theme.appColors.iconInverse,
                  size: AppSize.size4,
                ),
              ),
            ),
          ),
          if (onEdit != null)
            ProfileGlassContainer(
              onTap: onEdit,
              padding: const EdgeInsets.symmetric(
                vertical: AppSpace.space2,
                horizontal: AppSpace.space4,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.rounded2xl,
              ),
              child: AppText.body3Bold(
                'Edit'.tr,
                context: context,
                color: context.theme.appColors.textPrimaryInverse,
              ),
            ),
        ],
      ),
    );
  }
}
