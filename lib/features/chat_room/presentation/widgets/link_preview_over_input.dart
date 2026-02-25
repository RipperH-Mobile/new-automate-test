import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/models/link_metadata_model.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/utils/fix_url.dart';
import 'package:uchat/utils/get_link_helper.dart';
import 'package:uchat/utils/image/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

class LinkPreviewOverInput extends StatelessWidget {
  final LinkMetadataModel metadata;
  final VoidCallback? onTapClose;

  const LinkPreviewOverInput({super.key, required this.metadata, this.onTapClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.appColors.backgroundNeutralLighter,
      padding: const EdgeInsets.only(top: AppSpace.space2, bottom: AppSpace.space1),
      child: Container(
        height: 56.spMin,
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.space4, vertical: AppSpace.space2),
        child: Row(
          children: [
            if (metadata.image != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                child: UChatImage.network(
                  metadata.image!,
                  width: 40.spMin,
                  height: 40.spMin,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                  customLoadingWidget: (_) {
                    return Container(
                      height: 40.spMin,
                      width: 40.spMin,
                      padding: const EdgeInsets.all(AppSpace.space3),
                      decoration: BoxDecoration(
                        color: context.theme.appColors.backgroundNeutralLightPressed,
                        borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.iconLight),
                        strokeCap: StrokeCap.round,
                        strokeWidth: .8,
                      ),
                    );
                  },
                  customErrorWidget: (_) {
                    if (metadata.image!.toLowerCase().endsWith('.svg')) {
                      return SizedBox(
                        width: 40.spMin,
                        height: 40.spMin,
                        child: SvgPicture.network(
                          metadata.image!,
                          placeholderBuilder: (context) =>
                              SpinKitCircle(color: context.theme.appColors.backgroundPrimary),
                        ),
                      );
                    }

                    final fixedUrl = fixUrl(metadata.image!);

                    return UChatImage.network(fixedUrl, fit: BoxFit.cover, width: 40, height: 40,
                        customLoadingWidget: (_) {
                      return Container(
                        height: 40.spMin,
                        width: 40.spMin,
                        padding: const EdgeInsets.all(AppSpace.space3),
                        decoration: BoxDecoration(
                          color: context.theme.appColors.backgroundNeutralLightPressed,
                          borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                        ),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.iconLight),
                          strokeCap: StrokeCap.round,
                          strokeWidth: .8,
                        ),
                      );
                    }, customErrorWidget: (state) {
                      return RepaintBoundary(
                        child: Container(
                          height: 40.spMin,
                          width: 40.spMin,
                          padding: const EdgeInsets.all(AppSpace.space2),
                          decoration: BoxDecoration(
                            color: context.theme.appColors.backgroundNeutralLightPressed,
                            borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                          ),
                          child: Assets.vectors.linkIcon.svg(
                            // ignore: deprecated_member_use_from_same_package
                            color: context.theme.appColors.iconLight,
                          ),
                        ),
                      );
                    });
                  },
                ),
              )
            else
              RepaintBoundary(
                child: Container(
                  height: 40.spMin,
                  width: 40.spMin,
                  padding: const EdgeInsets.all(AppSpace.space2),
                  decoration: BoxDecoration(
                    color: context.theme.appColors.backgroundNeutralLightPressed,
                    borderRadius: BorderRadius.circular(AppRadius.roundedMd),
                  ),
                  child: Assets.vectors.linkIcon.svg(
                    // ignore: deprecated_member_use_from_same_package
                    color: context.theme.appColors.iconLight,
                  ),
                ),
              ),
            AppSpace.space2.horizontalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: AppText.body3Bold(
                      metadata.title ?? getDomain(url: metadata.url),
                      context: context,
                      color: context.theme.appColors.textDarkest,
                      maxLines: 1,
                      textOverflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (metadata.description != null && metadata.description?.isNotEmpty == true)
                    Flexible(
                      child: AppText.body4(
                        metadata.description!,
                        context: context,
                        color: context.theme.appColors.textDark,
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            AppSpace.space1.horizontalSpace,
            if (onTapClose != null)
              GestureDetector(
                onTap: onTapClose,
                child: Assets.vectors.xClose.svg(),
              ),
          ],
        ),
      ),
    );
  }
}
