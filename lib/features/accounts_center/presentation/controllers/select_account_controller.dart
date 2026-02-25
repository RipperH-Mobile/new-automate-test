import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/use_cases/get_all_users_use_case.dart';
import 'package:uchat/features/accounts_center/accounts_center_barrel.dart';
import 'package:uchat/features/auth/presentation/arguments/welcome_arguments.dart';
import 'package:uchat/routes/app_pages.dart';

class SelectAccountIds {
  static const String accountsList = 'select_account_accounts_list';
}

class SelectAccountController extends GetxController {
  List<UserEntity> userList = [];

  @override
  void onInit() async {
    userList = await GetIt.I<GetAllUsersUseCase>().call(GetAllUsersParams());
    update([SelectAccountIds.accountsList]);

    super.onInit();
  }

  void onTapAccount(UserEntity user) async {
    await GetIt.I<AccountsCenterService>().setAccountAndReturnToHome(user);
  }

  void onTapAddAccount() {
    Get.toNamed(Routes.welcome, arguments: WelcomeArguments(isAddAccount: true));
  }
}
