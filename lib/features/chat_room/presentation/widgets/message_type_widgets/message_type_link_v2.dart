import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/models/message_link_model.dart';
import 'package:uchat/utils/extension/extension_url.dart';
import 'package:uchat/utils/fix_url.dart';
import 'package:uchat/utils/get_link_helper.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/utils/uchat_image.dart';
import 'package:uchat/widgets/app_text.dart';

final _log = useLogger();

class MessageTypeLinkV2 extends StatelessWidget {
  final MessageLinkModel link;
  final bool isMyMessage;

  const MessageTypeLinkV2({
    super.key,
    required this.link,
    required this.isMyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => link.url?.openInWebBrowser(),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(AppRadius.rounded2xl)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          color:
              isMyMessage ? context.theme.appColors.backgroundPrimary : context.theme.appColors.backgroundNeutralLight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (link.hasImage)
                _buildImage(
                  context,
                ),
              _buildTitle(context),
              link.description != null
                  ? _buildDescription(context)
                  : Container(
                      padding: const EdgeInsets.only(
                        bottom: AppSpace.space2,
                      ),
                      child: const SizedBox.shrink(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space3,
        AppSpace.space3,
        AppSpace.space3,
        AppSpace.space1 / 2,
      ),
      child: AppText.body3Bold(
        link.title?.isEmpty == true ? getDomain(url: ensureUrlHasScheme(link.url ?? '')) : link.title ?? '',
        textAlign: TextAlign.start,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        context: context,
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpace.space3,
        0,
        AppSpace.space3,
        AppSpace.space3,
      ),
      child: AppText.body4(
        link.description ?? '',
        textAlign: TextAlign.start,
        color: isMyMessage ? context.theme.appColors.textPrimaryInverse : context.theme.appColors.textDarkest,
        context: context,
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (link.images?.firstOrNull == null || link.images!.firstOrNull?.isEmpty == true) {
      return const SizedBox.shrink();
    }

    try {
      //NOTE.if image is .svg type
      if (link.images!.firstOrNull!.toLowerCase().endsWith('.svg')) {
        return Container(
          constraints: BoxConstraints(maxHeight: 160.spMin),
          color: context.theme.appColors.backgroundNeutralLight,
          child: SvgPicture.network(
            link.images!.first,
            placeholderBuilder: (context) => SpinKitCircle(color: context.theme.appColors.backgroundPrimary),
            width: double.infinity,
          ),
        );
      }
      return Container(
        constraints: BoxConstraints(maxHeight: 160.spMin),
        width: double.infinity,
        color: context.theme.appColors.backgroundNeutralLight,
        child: UChatImage.network(
          fixUrl(link.images!.firstOrNull!),
          fit: BoxFit.cover,
          clearMemoryCacheIfFailed: false,
          // don't clear memory cache if failed to fix message always show loading.
          customLoadingWidget: (state) {
            return SpinKitCircle(color: context.theme.appColors.backgroundPrimary);
          },
          customErrorWidget: (state) {
            return const SizedBox.shrink();
          },
        ),
      );
    } catch (e, stackTrace) {
      _log.w('Call _buildImage error.', e, stackTrace);
      return const SizedBox.shrink();
    }
  }
}
