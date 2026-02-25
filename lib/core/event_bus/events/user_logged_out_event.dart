
@Deprecated('Use hookUserLogoutBeforeCloseAuthenticateDb instead.')
class UserLoggedOutEvent {
  final bool isDebug;

  UserLoggedOutEvent({
    this.isDebug = false,
  });

  @override
  String toString() => 'UserLoggedOutEvent(isDebug: $isDebug)';
}
