import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/link_account/link_account_with_facebook_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/link_account_widget.dart';
import 'package:uchat/gen/assets.gen.dart';
import 'package:uchat/widgets/scaffold/scaffold_basic.dart';

class LinkAccountWthFacebookScreen extends GetView<LinkAccountWithFacebookController> {
  const LinkAccountWthFacebookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldBasic(
      child: LinkAccountWidget(
        image: Assets.images.facebookLink.path,
        title: 'Confirm to link the account to a new Facebook account?'.tr,
        email: controller.args.linkAccountModel.email.isEmpty
            ? 'Facebook account'
            : controller.args.linkAccountModel.email,
        onContinue: controller.onContinue,
        onClose: controller.goToHome,
      ),
    );
  }
}
