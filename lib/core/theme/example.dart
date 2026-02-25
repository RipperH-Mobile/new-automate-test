import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/extensions/theme_extensions.dart';
import 'package:uchat/core/theme/app_radius.dart';
import 'package:uchat/core/theme/app_size.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/core/theme/app_theme.dart';
import 'package:uchat/widgets/app_text.dart';

class ThemeExample extends StatefulWidget {
  const ThemeExample({super.key});

  @override
  State<ThemeExample> createState() => _ThemeExampleState();
}

class _ThemeExampleState extends State<ThemeExample> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpace.space4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.heading1(
                    'Heading1',
                    context: context,
                  ),
                  AppText.heading2(
                    'Heading2',
                    context: context,
                  ),
                  AppText.heading3(
                    'Heading3',
                    context: context,
                  ),
                  AppText.heading4(
                    'Heading4',
                    context: context,
                  ),
                  AppText.title1(
                    'Title1',
                    context: context,
                  ),
                  AppText.title2(
                    'Title2',
                    context: context,
                  ),
                  AppText.title3(
                    'Title3',
                    context: context,
                  ),
                  AppText.subtitle1(
                    'Subtitle1',
                    context: context,
                  ),
                  AppText.body1(
                    'Body1',
                    context: context,
                  ),
                  AppText.body1Bold(
                    'Body1 Bold',
                    context: context,
                  ),
                  AppText.body2(
                    'Body2',
                    context: context,
                  ),
                  AppText.body2Bold(
                    'Body2 Bold',
                    context: context,
                  ),
                  AppText.body3(
                    'Body3',
                    context: context,
                  ),
                  AppText.body3Bold(
                    'Body3 Bold',
                    context: context,
                  ),
                  AppText.body4(
                    'Body4',
                    context: context,
                  ),
                  AppText.body4Bold(
                    'Body4 Bold',
                    context: context,
                  ),
                  AppText.caption1(
                    'Caption1',
                    context: context,
                  ),
                  AppText.caption1Bold(
                    'Caption1 Bold',
                    context: context,
                  ),
                  AppText.caption2(
                    'Caption2',
                    context: context,
                  ),
                  AppText.caption2Bold(
                    'Caption2 Bold',
                    context: context,
                  ),
                  AppText.button1(
                    'Button1',
                    context: context,
                  ),
                  AppText.button1Bold(
                    'Button1 Bold',
                    context: context,
                  ),
                  AppText.button2(
                    'Button2',
                    context: context,
                  ),
                  AppText.button2Bold(
                    'Button2 Bold',
                    context: context,
                  ),
                  AppText.heading1(
                    'Heading1 Color',
                    context: context,
                    color: context.theme.appColors.backgroundPrimaryLight,
                  ),
                  Container(
                    width: AppSize.size32,
                    height: AppSize.size32,
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                    ),
                  ),
                  const SizedBox(
                    height: AppSpace.space4,
                  ),
                  // ลองเปลี่ยน Theme ดูเฉยๆ
                  Container(
                    padding: const EdgeInsets.all(AppSpace.space4),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                    ),
                    child: Theme(
                      data: AppTheme.dark().themeData,
                      child: Builder(
                        builder: (c) {
                          return Text(
                            'Container',
                            style: c.theme.appTexts.body1.copyWith(
                              color: c.theme.appColors.textDarkest,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSpace.space4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(AppSpace.space4),
                    decoration: BoxDecoration(
                      color: context.theme.appColors.backgroundPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.rounded2xl),
                    ),
                    child: AppText.body1(
                      'Container',
                      context: context,
                      color: context.theme.appColors.textSuccess,
                    ),
                  ),
                  const SizedBox(
                    height: AppSpace.space28,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: Icon(
                  isDark ? Icons.brightness_7 : Icons.brightness_4,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  setState(
                    () {
                      isDark = !isDark;
                      Get.changeThemeMode(
                        isDark ? ThemeMode.dark : ThemeMode.light,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
