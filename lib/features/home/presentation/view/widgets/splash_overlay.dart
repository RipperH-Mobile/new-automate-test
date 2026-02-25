import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/themes/util.dart';
import 'package:uchat/widgets/app_text.dart';

class SplashOverlay extends StatelessWidget {
  final bool showUpdating;
  final bool? showWelcome;
  final String? loadingStatus;
  final String? loadingPercentage;

  const SplashOverlay({
    super.key,
    required this.showUpdating,
    this.loadingStatus,
    this.loadingPercentage,
    this.showWelcome,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(top: 1),
          width: 400,
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Assets.images.uchatLogoSplash.image(width: 248, height: 248)),
              if (showWelcome == true)
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: AppText.title2(
                    'Welcome to UChat!'.tr,
                    color: UTheme.color.primary,
                    context: context,
                  ),
                ),
              if (showUpdating)
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(color: UTheme.color.primary, strokeWidth: 2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                          child: AppText.title3(
                            'The app is updating.'.tr,
                            textAlign: TextAlign.center,
                            color: UTheme.color.primary,
                            context: context,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                          child: AppText.subtitle1(
                            'Please do not close the app while it is updating.'.tr,
                            textAlign: TextAlign.center,
                            color: UTheme.color.primary,
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else if (loadingPercentage != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(
                      color: UTheme.color.primary,
                    ),
                    const SizedBox(width: 10),
                    AppText.caption2(
                      loadingPercentage!,
                      textAlign: TextAlign.center,
                      color: UTheme.color.primary,
                      context: context,
                    ),
                  ],
                ),
              if (loadingStatus != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.caption1Bold(
                      loadingStatus!,
                      textAlign: TextAlign.center,
                      color: UTheme.color.primary,
                      context: context,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
