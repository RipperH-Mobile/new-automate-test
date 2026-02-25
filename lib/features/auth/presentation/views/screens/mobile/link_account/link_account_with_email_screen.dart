import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_email_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/link_account_widget.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class LinkAccountWithEmailScreen extends GetView<LinkAccountWithEmailController> {
  const LinkAccountWithEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      child: LinkAccountWidget(
        image: 'assets/images/email_link.png',
        title: 'Confirm to link the account to a new email?'.tr,
        email: '${controller.args.linkAccountModel.email}?',
        onContinue: controller.onContinue,
        onClose: controller.goToHome,
      ),
    );
  }
}
