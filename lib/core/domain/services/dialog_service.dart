///
/// Abstract class for the dialog service.
/// This class provides methods to show different types of dialogs.
/// It is used to show dialogs in the app.
///
abstract class DialogService {
  Future<bool> showAppUpdateDialog({bool forceUpdate = false});

  Future<void> showSessionExpireDialog({Function? customOnConfirm});
}
