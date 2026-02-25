import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class InformationPdfViewer extends StatelessWidget {
  final String heading;
  final String subtitle;
  final String pdfFileUrl;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final bool isActionButtonEnable;
  final bool isShowFullScreen;

  const InformationPdfViewer({
    super.key,
    required this.heading,
    required this.subtitle,
    required this.pdfFileUrl,
    this.onAccept,
    this.onDecline,
    this.isActionButtonEnable = false,
    this.isShowFullScreen = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isShowFullScreen ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.height * 0.9,
      color: CupertinoColors.systemBackground,
      child: Padding(
        padding: const EdgeInsets.all(AppSpace.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpace.space4,
          children: [
            // Header
            AppText.heading4(
              'UChat Messenger'.tr,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
            AppText.heading1(
              heading,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),
            AppText.body1(
              subtitle,
              context: context,
              color: context.theme.appColors.textDarkest,
            ),

            // Terms and Conditions Section
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: CupertinoColors.systemGrey6,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(AppSpace.space4),
                child: SfPdfViewer.network(
                  pdfFileUrl,
                  headers: HttpCaller().apiHeader,
                  pageLayoutMode: PdfPageLayoutMode.continuous,
                  scrollDirection: PdfScrollDirection.vertical,
                ),
              ),
            ),

            // Buttons
            if (isActionButtonEnable)
              Column(
                children: [
                  AppFilledButton.primary(
                    context: context,
                    label: 'Agree and continue'.tr,
                    onTap: onAccept,
                  ),
                  const SizedBox(height: AppSpace.space3),
                  SizedBox(
                    height: 50,
                    width: Get.width,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(
                          color: context.theme.appColors.borderDarker,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.spMin),
                        ),
                      ),
                      onPressed: onDecline,
                      child: Text(
                        'Disagree'.tr,
                        style: TextStyle(
                          color: context.theme.appColors.textDarkest,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
