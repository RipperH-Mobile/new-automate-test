import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/entities/user_entity.dart';
import 'package:uchat/core/domain/use_cases/get_all_users_use_case.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/accounts_center/domain/events/account_removed_event.dart';
import 'package:uchat/features/accounts_center/domain/events/account_updated_event.dart';
import 'package:uchat/features/accounts_center/domain/events/current_account_changed_event.dart';
import 'package:uchat/features/accounts_center/domain/events/hidden_account_update_event.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/get_session_expired_account_use_case.dart';
import 'package:uchat/features/accounts_center/domain/use_cases/remove_account_from_local_use_case.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/account_setting_arguments.dart';
import 'package:uchat/features/accounts_center/presentation/arguments/accounts_center_arguments.dart';
import 'package:uchat/features/accounts_center/presentation/views/widgets/expired_account_bottom_sheet.dart';
import 'package:uchat/features/auth/presentation/arguments/welcome_arguments.dart';
import 'package:uchat/routes/app_pages.dart';

class AccountsCenterIds {
  static const String accountsList = 'setting_accounts_center_accounts_list';
}

class AccountsCenterController extends GetxController {
  final userList = <UserEntity>[];

  StreamSubscription? _currentAccountChangedSubscription;
  StreamSubscription? _hideAccountSubscription;
  StreamSubscription? _accountRemovedSubscription;
  StreamSubscription? _accountUpdatedSubscription;
  StreamSubscription? _userUpdateSubscription;

  @override
  void onInit() async {
    super.onInit();

    _currentAccountChangedSubscription = eventBus.on<CurrentAccountChangedEvent>().listen((event) async {
      final newUserList = await sortUserList();
      userList.assignAll(newUserList);
      update([AccountsCenterIds.accountsList]);
    });

    _hideAccountSubscription = eventBus.on<HiddenAccountUpdateEvent>().listen((event) async {
      if (event.isHidden) {
        if (UserController.instance.isCurrentUser(event.accountId)) {
          final index = userList.indexWhere((e) => e.id == event.accountId);
          userList[index] = userList[index].copyWith(isMAHidden: event.isHidden);
        } else {
          userList.removeWhere((user) => user.id == event.accountId);
        }
      } else {
        // re-fetch all users
        userList.clear();
        final localUserList = await GetIt.I<GetAllUsersUseCase>().call(GetAllUsersParams(
          sortByLoginAt: true,
        ));
        userList.addAll(localUserList);
      }
      update([AccountsCenterIds.accountsList]);
    });

    _accountRemovedSubscription = eventBus.on<AccountRemovedEvent>().listen((event) async {
      for (final userId in event.accountIds) {
        userList.removeWhere((user) => user.id == userId);
      }

      update([AccountsCenterIds.accountsList]);
    });

    _accountUpdatedSubscription = eventBus.on<AccountUpdatedEvent>().listen((event) async {
      final index = userList.indexWhere((e) => e.id == event.user.id);
      if (index != -1) {
        userList[index] = event.user;
        update([AccountsCenterIds.accountsList]);
      }
    });

    _userUpdateSubscription = eventBus.on<UserUpdateEvent>().listen((event) async {
      final index = userList.indexWhere((e) => e.id == event.user.id);
      if (index != -1) {
        userList[index] = event.user;
        update([AccountsCenterIds.accountsList]);
      }
    });

    final localUserList = await sortUserList();
    userList.addAll(localUserList);
    update([AccountsCenterIds.accountsList]);

    checkForSessionExpiredAccount();
  }

  @override
  void onClose() {
    _currentAccountChangedSubscription?.cancel();
    _hideAccountSubscription?.cancel();
    _accountRemovedSubscription?.cancel();
    _accountUpdatedSubscription?.cancel();
    _userUpdateSubscription?.cancel();

    super.onClose();
  }

  void checkForSessionExpiredAccount() async {
    try {
      final args = Get.arguments as AccountsCenterArguments?;
      GetSessionExpiredAccountResponse res;
      // Use data from arguments if available to avoid duplicate checks.
      if (args != null && args.sessionExpiredAccountResponse != null) {
        res = args.sessionExpiredAccountResponse!;
      } else {
        final allUserList = await GetIt.I<GetAllUsersUseCase>().call(GetAllUsersParams(includeHidden: true));
        res = await GetIt.I<GetSessionExpiredAccountUseCase>().call(
          GetSessionExpiredAccountParams(userList: allUserList),
        );
      }

      // Show bottom sheet listing all expired accounts.
      if (res.visibleExpiredAccounts.isNotEmpty || res.expiredHiddenAccountCount > 0) {
        Get.bottomSheet(
          ExpiredAccountBottomSheet(
            expiredAccounts: res.visibleExpiredAccounts,
            expiredHiddenAccountCount: res.expiredHiddenAccountCount,
            onRemovePressed: () async {
              // Remove user data from local db
              List<String> accountIds = [];
              for (final user in res.allExpiredAccounts) {
                final userId = user.id;
                if (userId == null) continue;
                accountIds.add(userId);
                await GetIt.I<RemoveAccountFromLocalUseCase>().call(
                  RemoveAccountFromLocalParams(accountId: user.id!),
                );
              }
              eventBus.fire(AccountRemovedEvent(accountIds: accountIds));
            },
          ),
          isScrollControlled: false,
          enableDrag: false,
          isDismissible: false,
        );
      }
    } on FailedHostLookupException catch (_) {
      // If check failed because of no internet connection, do nothing.
    } catch (e, stackTrace) {
      useLogger().e('checkForSessionExpiredAccount error', e, stackTrace);
    }
  }

  void onTapAddAccount() {
    Get.toNamed(Routes.welcome, arguments: WelcomeArguments(isAddAccount: true));
  }

  void onTapAccount(UserEntity user) {
    Get.toNamed(Routes.accountSetting, arguments: AccountSettingArguments(user: user));
  }

  Future<List<UserEntity>> sortUserList() async {
    final localUserList = await GetIt.I<GetAllUsersUseCase>().call(GetAllUsersParams(
      sortByLoginAt: true,
    ));
    final index = localUserList.indexWhere((e) => UserController.instance.isCurrentUser(e.id ?? ''));
    if (index != -1) {
      {
        final currentUser = localUserList.removeAt(index);
        localUserList.insert(0, currentUser);
      }
    }

    return localUserList;
  }
}
