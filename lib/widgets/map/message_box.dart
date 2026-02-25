import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';
import 'message_box_clipper.dart';

class MessageBox extends StatelessWidget {
  final String title;
  final bool isLoading;

  const MessageBox({
    super.key,
    required this.title,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Maximum width is set to 80% of the screen width.
    final double maxBubbleWidth = MediaQuery.of(context).size.width * 0.8;

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Message bubble container
          ConstrainedBox(
            constraints: BoxConstraints(
              // The bubble will expand until it reaches maxBubbleWidth.
              maxWidth: maxBubbleWidth,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15.spMin, vertical: 10.spMin),
              decoration: BoxDecoration(
                color: const Color(0xFF2C333A),
                borderRadius: BorderRadius.circular(AppRadius.roundedMd),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // loading indicator
                  if (isLoading)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpace.space2),
                      child: SizedBox(
                        width: AppSize.size4,
                        height: AppSize.size4,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(context.theme.appColors.textPrimaryInverse),
                        ),
                      ),
                    ),
                  Flexible(
                    child: AppText.body3Bold(
                      title,
                      context: context,
                      color: context.theme.appColors.textPrimaryInverse,
                      textOverflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // The tail of the message bubble using custom clipper
          ClipPath(
            clipper: MessageClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 5.spMin,
              color: const Color(0xFF2C333A),
            ),
          ),
        ],
      ),
    );
  }
}
