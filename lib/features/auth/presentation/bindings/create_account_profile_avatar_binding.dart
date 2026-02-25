import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/features/auth/presentation/controllers/register/create_account_profile_avatar_controller.dart';
import 'package:uchat/features/auth/presentation/arguments/create_account_profile_avatar_arguments.dart';

class CreateAccountProfileAvatarBinding extends Bindings {
  @override
  void dependencies() {
    final args = Get.arguments as CreateAccountProfileAvatarArguments;
    Get.put<CreateAccountProfileAvatarController>(
      CreateAccountProfileAvatarController(
        authServerRepository: GetIt.I<AuthServerRepository>(),
        userLocalRepository: GetIt.I<UserLocalRepository>(),
        args: args,
      ),
    );
  }
}
