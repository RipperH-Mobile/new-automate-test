import 'package:uchat/core/domain/repositories/user_local_repository.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/accounts_center/domain/events/hidden_account_update_event.dart';
import 'package:uchat/use_cases/use_case.dart';

class ToggleHiddenAccountParams {
  final String accountId;
  final bool isHidden;

  ToggleHiddenAccountParams({
    required this.accountId,
    required this.isHidden,
  });
}

class ToggleHiddenAccountUseCase extends SimpleUseCase<void, ToggleHiddenAccountParams> {
  final UserLocalRepository userLocalRepository;
  final EventBus eventBus;

  ToggleHiddenAccountUseCase({
    required this.userLocalRepository,
    required this.eventBus,
  });

  @override
  Future<void> call(ToggleHiddenAccountParams params) async {
    final localUser = await userLocalRepository.getUser(params.accountId);
    if (localUser != null) {
      final updatedUser = localUser.copyWith(isMAHidden: params.isHidden);

      await userLocalRepository.putUser(updatedUser);

      eventBus.fire(HiddenAccountUpdateEvent(
        accountId: params.accountId,
        isHidden: params.isHidden,
      ));
    }
  }
}
