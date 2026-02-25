import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_set_password_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_set_password_arguments.dart';

class CreateAccountSetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as CreateAccountSetPasswordArguments;
    Get.put(CreateAccountSetPasswordController(args: args));
  }
}
