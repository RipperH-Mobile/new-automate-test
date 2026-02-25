import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/chat_room/data/models/collections/message_collection.dart';

class MessageTypeRemoveOthers extends StatelessWidget {
  final MessageCollection message;

  const MessageTypeRemoveOthers({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final style = context.theme.appTexts.caption2.copyWith(
      color: context.theme.appColors.textDark,
      fontSize: 11.spMin,
    );

    return Center(
      child: Container(
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
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Admin'.tr, style: style.copyWith(fontWeight: FontWeight.bold)),
                  Text(' delete a message'.tr, style: style),
                ],
              ),
              AppSpace.space05.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
