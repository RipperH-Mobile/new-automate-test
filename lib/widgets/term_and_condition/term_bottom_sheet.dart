import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:uchat/api/http/http_caller.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/term_and_condition/term_controller.dart';

class TermBottomSheet extends StatelessWidget {
  final String type;
  final String fileUrl;
  final Function onAccept;

  const TermBottomSheet({super.key, required this.type, required this.fileUrl, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermController>(
      init: TermController(onAccept: onAccept),
      builder: (controller) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9, // Adjust height to 90%
          color: CupertinoColors.systemBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UChat Messenger'.tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Terms & Condition'.tr,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'To ensure this, we’re asking you to commit to the following'.tr,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ],
                ),
              ),

              // Terms and Conditions Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey6,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: SfPdfViewer.network(
                      fileUrl,
                      headers: HttpCaller().apiHeader,
                      pageLayoutMode: PdfPageLayoutMode.continuous,
                      scrollDirection: PdfScrollDirection.vertical,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    AppFilledButton.primary(
                      context: context,
                      label: 'Agree and continue'.tr,
                      onTap: () {
                        controller.handleAccept();
                      },
                    ),
                    const SizedBox(height: 10),
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
                        child: Text(
                          'Disagree'.tr,
                          style: TextStyle(
                            color: context.theme.appColors.textDarkest,
                          ),
                        ),
                        onPressed: () {
                          controller.handleDecline();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
