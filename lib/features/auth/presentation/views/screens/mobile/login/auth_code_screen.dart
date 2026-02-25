import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/login/auth_code_controller.dart';
import 'package:uchat/features/auth/presentation/views/widgets/qr_login_bottom_sheet.dart';

class AuthCodeScreen extends GetView<AuthCodeController> {
  const AuthCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: QrLoginBottomSheetWidget(
        loginFrom: 'UChat Desktop',
        loginForUsing: 'UChat Desktop',
        onLogin: controller.handleLogin,
        onCancel: controller.handleCancel,
      ),
    );
  }
}
