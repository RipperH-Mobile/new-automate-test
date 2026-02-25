import 'package:flutter/material.dart';
import 'package:uchat/widgets/app_text.dart';
import 'package:uchat/widgets/bottom_sheet/app_floating_bottom_sheet.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';

class AppBottomSheetExample extends StatelessWidget {
  const AppBottomSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFilledButton.defaultButton(
          context: context,
          label: 'bottom sheet',
          icon: const Icon(Icons.add),
          iconAlignment: IconAlignment.end,
          onTap: () {
            AppFloatingBottomSheet.show(
              context: context,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText.title1(
                    'Test',
                    context: context,
                  ),
                ],
              ),
            );
          },
        ),
        AppFilledButton.defaultButton(
          context: context,
          label: 'bottom sheet scroll',
          icon: const Icon(Icons.add),
          iconAlignment: IconAlignment.end,
          onTap: () {
            AppFloatingBottomSheet.show(
              context: context,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 300,
                      color: Colors.red,
                    ),
                    Container(
                      height: 500,
                      color: Colors.green,
                    ),
                    const Text('data'),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
