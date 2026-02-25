import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/core/theme/app_space.dart';
import 'package:uchat/features/auth/domain/entities/password_condition_entity.dart';
import 'package:uchat/widgets/bullet/app_bullet_item.dart';

class PasswordConditionCheckList extends StatelessWidget {
  const PasswordConditionCheckList({
    super.key,
    required this.condition,
  });

  final PasswordConditionEntity condition;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBulletItem(
          text: 'Use 8 or more characters'.tr,
          isChecked: condition.isLengthValid,
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppBulletItem(
          text: 'Use a lowercase letter'.tr,
          isChecked: condition.isLowercaseValid,
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppBulletItem(
          text: 'Use an uppercase letter'.tr,
          isChecked: condition.isUppercaseValid,
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppBulletItem(
          text: 'Use a number'.tr,
          isChecked: condition.isNumberValid,
        ),
        const SizedBox(
          height: AppSpace.space2,
        ),
        AppBulletItem(
          text: 'Use a symbol'.tr,
          isChecked: condition.isSymbolValid,
        ),
      ],
    );
  }
}
