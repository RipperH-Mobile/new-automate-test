import 'package:get/get.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_uchat_id_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_uchat_id_arguments.dart';

class CreateAccountUChatIDBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as CreateAccountUChatIDArguments;
    Get.put<CreateAccountUChatIDController>(
      CreateAccountUChatIDController(
        args: args,
      ),
    );
  }
}
