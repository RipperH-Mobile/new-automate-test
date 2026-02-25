import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_name_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_name_arguments.dart';

class CreateAccountNameBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as CreateAccountNameArguments;
    Get.put(CreateAccountNameController(args: args));
  }
}
