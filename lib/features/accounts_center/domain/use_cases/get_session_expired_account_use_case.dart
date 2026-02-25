import 'package:uchat/core/data/data_sources/account_service.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/exceptions/invalid_token_exception.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetSessionExpiredAccountParams {
  final List<UserEntity> userList;

  GetSessionExpiredAccountParams({required this.userList});
}

class GetSessionExpiredAccountResponse {
  // List of all expired accounts including hidden ones. Used for removing data from local db.
  final List<UserEntity> allExpiredAccounts;

  // List of expired accounts that are not hidden. Used for displaying to the user.
  final List<UserEntity> visibleExpiredAccounts;
  final int expiredHiddenAccountCount;

  GetSessionExpiredAccountResponse({
    required this.allExpiredAccounts,
    required this.visibleExpiredAccounts,
    required this.expiredHiddenAccountCount,
  });

  @override
  String toString() {
    return 'GetSessionExpiredAccountResponse{allExpiredAccounts: $allExpiredAccounts, visibleExpiredAccounts: $visibleExpiredAccounts, expiredHiddenAccountCount: $expiredHiddenAccountCount}';
  }
}

class GetSessionExpiredAccountUseCase
    extends SimpleUseCase<GetSessionExpiredAccountResponse, GetSessionExpiredAccountParams> {
  final AccountService accountService;

  GetSessionExpiredAccountUseCase({required this.accountService});

  @override
  Future<GetSessionExpiredAccountResponse> call(GetSessionExpiredAccountParams params) async {
    List<UserEntity> visibleExpiredAccounts = [];
    List<UserEntity> allExpiredAccounts = [];
    int expiredHiddenAccountCount = 0;
    for (final user in params.userList) {
      try {
        final token = user.token;
        if (token == null) continue;
        // Try to get profile with existing token. Do nothing if successful.
        await accountService.getProfileWithCustomToken(token);
      } on InvalidTokenException catch (_) {
        allExpiredAccounts.add(user);
        // If get profile error with InvalidTokenException, mark this account as expired.
        if (user.isMAHidden == true) {
          // If the expired account is hidden, we just count it instead of showing it in the list.
          expiredHiddenAccountCount += 1;
        } else {
          visibleExpiredAccounts.add(user);
        }
      } catch (e, stackTrace) {
        useLogger().e('GetSessionExpiredAccountUseCase error', e, stackTrace);
      }
    }

    return GetSessionExpiredAccountResponse(
      allExpiredAccounts: allExpiredAccounts,
      visibleExpiredAccounts: visibleExpiredAccounts,
      expiredHiddenAccountCount: expiredHiddenAccountCount,
    );
  }
}
