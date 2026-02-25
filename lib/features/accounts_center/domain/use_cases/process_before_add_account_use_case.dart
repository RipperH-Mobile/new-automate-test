import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/exceptions/multiple_account_limit_exceed_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/data/data_source/remote/auth_api_service_new.dart';
import 'package:uchat/use_cases/use_case.dart';

class ProcessBeforeAddAccountParams {
  final UserEntity user;

  ProcessBeforeAddAccountParams({
    required this.user,
  });
}

/// This use case do everything needed before adding a new account.
/// It checks if the multiple account limit is exceeded,
/// and logs out the existing account if the new account is already logged in to invalidate old access token.
/// When successful, it does not return anything.
/// Throws [MultipleAccountLimitExceedException] if the multiple account limit is exceeded.
class ProcessBeforeAddAccountUseCase extends SimpleUseCase<UserEntity, ProcessBeforeAddAccountParams> {
  final UserLocalRepository userLocalRepository;
  final AuthApiServiceNew authApiServiceNew;
  final UserController? mockUserController;

  ProcessBeforeAddAccountUseCase({
    required this.userLocalRepository,
    required this.authApiServiceNew,
    this.mockUserController,
  });

  UserController get _userController => mockUserController ?? UserController.instance;

  @override
  Future<UserEntity> call(ProcessBeforeAddAccountParams params) async {
    final userCount = await userLocalRepository.getUserCount();
    final userList = await userLocalRepository.getAllUsersIncludeHidden();
    final userId = params.user.id ?? '';
    final userIndex = userList.indexWhere((e) => e.id == userId);
    final bool newUserAlreadyLogin = userIndex >= 0;

    // If the new user is already logged in, we need to logout the old token to invalidate it. Otherwise, the old token
    // will stack up everytime and will clutter the manage devices screen.
    if (newUserAlreadyLogin) {
      try {
        final oldUserEntity = userList[userIndex];
        if (_userController.isCurrentUser(userId)) {
          authApiServiceNew.logout();
        } else {
          authApiServiceNew.logout(accessToken: userList[userIndex].token);
        }

        // Keep isMAHidden and shortcutPasscode settings of the old user to the new user.
        // This is to prevent the user from losing these settings when adding existing account.
        return params.user.copyWith(
          isMAHidden: oldUserEntity.isMAHidden,
          shortcutPasscode: oldUserEntity.shortcutPasscode,
        );
      } catch (e, stackTrace) {
        // When logout failed, just log the error for now. This will not cause any big problem only that the old token
        // remains valid and it can stack up in the manage devices screen but can be cleared by the user manually.
        useLogger().e('logout old token when adding existing account error.', e, stackTrace);
      }
    }

    if (userCount >= 4 && !newUserAlreadyLogin) {
      throw MultipleAccountLimitExceedException(
          message: 'Cannot add more accounts because you have reached the multiple account limit.');
    }

    return params.user;
  }
}
