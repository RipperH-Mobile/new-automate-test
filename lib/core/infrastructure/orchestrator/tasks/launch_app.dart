import 'package:get_it/get_it.dart';
import 'package:uchat/controllers/user_controller.dart';
import 'package:uchat/core/domain/use_cases/get_user_count_use_case.dart';
import 'package:uchat/features/accounts_center/domain/services/accounts_center_service.dart';

import '../common/task_result.dart';

Future<TaskResult> launchAppBegin() async {
  // Step 1 - Check user and load user data to memory.
  final userCtl = UserController.instance;
  await userCtl.checkCurrentUser();

  // Step 2 - Update AccountsCenterService.haveAccount
  final userCount = await GetIt.I<GetUserCountUseCase>().call(GetUserCountParams());
  GetIt.I<AccountsCenterService>().updateHaveAccount(userCount >= 1);

  return TaskResult.next;
}
