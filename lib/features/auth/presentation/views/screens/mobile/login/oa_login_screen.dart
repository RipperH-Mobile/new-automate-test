import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/login/oa_login_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/qr_login_bottom_sheet.dart';

class OALoginScreen extends GetView<OALoginController> {
  const OALoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: QrLoginBottomSheetWidget(
        loginFrom: 'UChat Business',
        loginForUsing: 'UChat Business',
        onLogin: controller.handleLogin,
        onCancel: controller.handleCancel,
      ),
    );
  }
}
