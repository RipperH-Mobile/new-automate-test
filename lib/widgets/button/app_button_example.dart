import 'package:flutter/material.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/entities/enum/app_button_size.dart';
import 'package:uchat/widgets/button/app_filled_button.dart';
import 'package:uchat/widgets/button/app_outlined_button.dart';
import 'package:uchat/widgets/button/app_secondary_button.dart';

class AppButtonExample extends StatelessWidget {
  const AppButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppFilledButton.defaultButton(
          context: context,
          label: 'labela ฟฟ์ูนี่่่',
          icon: const Icon(Icons.add),
          iconAlignment: IconAlignment.end,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppFilledButton.primary(
          context: context,
          label: 'labela ฟฟ์ูนี่่่',
          icon: const Icon(Icons.add),
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppFilledButton.warning(
          context: context,
          label: 'labela ฟฟ์ูนี่่่',
          icon: const Icon(Icons.add),
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppFilledButton.success(
          context: context,
          label: 'label',
          icon: const Icon(Icons.add),
          size: AppButtonSize.medium,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppFilledButton.error(
          context: context,
          label: 'label',
          // isRounded: false,
          icon: const Icon(Icons.add),
          size: AppButtonSize.small,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppFilledButton.primary(
          context: context,
          label: 'disable',
          icon: const Icon(Icons.add),
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppOutlinedButton.defaultButton(
          context: context,
          icon: const Icon(Icons.add),
          label: 'Outlined Default',
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppOutlinedButton.primary(
          context: context,
          icon: const Icon(Icons.add),
          label: 'Outlined Primary',
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppOutlinedButton.warning(
          context: context,
          icon: const Icon(Icons.add),
          label: 'Outlined Warning',
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppOutlinedButton.success(
          context: context,
          icon: const Icon(Icons.add),
          label: 'Outlined Success',
          size: AppButtonSize.medium,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppOutlinedButton.error(
          context: context,
          icon: const Icon(Icons.add),
          label: 'Outlined Error',
          size: AppButtonSize.small,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppOutlinedButton.primary(
          context: context,
          label: 'disable',
          icon: const Icon(Icons.add),
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppSecondaryButton.defaultButton(
          context: context,
          label: 'Secondary Default',
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppSecondaryButton.primary(
          context: context,
          label: 'Secondary Primary',
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppSecondaryButton.warning(
          context: context,
          label: 'Secondary Warning',
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppSecondaryButton.success(
          context: context,
          label: 'Secondary Success',
          size: AppButtonSize.medium,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppSecondaryButton.error(
          context: context,
          label: 'Secondary Error',
          size: AppButtonSize.small,
          onTap: () {},
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppSecondaryButton.primary(
          context: context,
          label: 'disable',
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
