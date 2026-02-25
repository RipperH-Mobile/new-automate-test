import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_confirm_password_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_confirm_password_arguments.dart';

class CreateAccountConfirmPasswordBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as CreateAccountConfirmPasswordArguments;
    Get.put(CreateAccountConfirmPasswordController(args: args));
  }
}
