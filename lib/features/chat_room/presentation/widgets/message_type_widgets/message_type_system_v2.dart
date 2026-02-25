import 'package:flutter/cupertino.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/message_system_type.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';
import 'package:uchat/features/chat_room/presentation/widgets/message_type_widgets/message_type_text_parse_mention_helper.dart';
import 'package:uchat/features/media/media_viewer/domain/media_viewer_domain.dart';
import 'package:uchat/utils/image/uchat_image.dart';

class MessageTypeSystemV2 extends StatelessWidget {
  final MessageCollection message;

  const MessageTypeSystemV2({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    if (message.systemMessage?.type == MessageSystemType.unknown) {
      return const SizedBox.shrink();
    }
    return Center(
      child: Column(
        children: [
          if (message.systemMessage?.type == MessageSystemType.changeGroupPhoto)
            Container(
              margin: const EdgeInsets.only(bottom: AppSpace.space4),
              width: 160.spMin,
              height: 160.spMin,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.spMin),
                child: UChatImage.network(
                  FileService().getFileUrl(message.systemMessage?.payload?.photoId ?? ''),
                  fit: BoxFit.cover,
                  customErrorWidget: (state) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                ),
              ),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: 0.7.sw),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.roundedFull),
              color: context.theme.appColors.backgroundGrayLightest,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.space2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSpace.space05.verticalSpace,
                  Builder(builder: (context) {
                    final style = context.theme.appTexts.caption2.copyWith(
                      color: context.theme.appColors.textDark,
                      fontSize: 11.spMin,
                    );
                    return ParsedText(
                      text: message.systemText,
                      alignment: TextAlign.center,
                      style: style,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      parse: <MatchText>[
                        _buildSystemMessageDisplayNameMatchText(context, style),
                      ],
                    );
                  }),
                  AppSpace.space05.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  MatchText _buildSystemMessageDisplayNameMatchText(BuildContext context, TextStyle style) {
    final TextStyle matchStyle = style.copyWith(fontWeight: FontWeight.bold);
    return MatchText(
      onTap: (_) {},
      pattern: UChatConstant.systemMessageDisplayNameRegexPattern,
      style: matchStyle.copyWith(
        color: context.theme.appColors.textDark,
      ),
      renderText: ({
        required String pattern,
        required String str,
      }) {
        return str.markupToDisplayRegExHelper(pattern: UChatConstant.systemMessageDisplayNameRegexPattern);
      },
    );
  }
}
