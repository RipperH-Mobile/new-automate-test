import 'package:get/get.dart';
import 'package:uchat/core/exceptions/failed_host_lookup_exception.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

/// Exception wrapper. Use this in catch that needed to handle offline case.
/// [e] is the exception.
/// [onFailedHostLookupException] is the function to execute when [e] is [FailedHostLookupException]
///   if null will show default offline dialog.
/// [onUnknownException] is the function to execute when [e] is not in any other cases.
///   if null will show default error dialog.
Future<void> handleException(
  dynamic e, {
  Function? onFailedHostLookupException,
  Function? onUnknownException,
}) async {
  final isOffline = e is FailedHostLookupException ||
      e.toString().contains('SocketConnectionException') ||
      e.toString().contains('Socket is disconnected');

  if (isOffline) {
    if (onFailedHostLookupException != null) {
      onFailedHostLookupException();
    } else {
      /// Call hide first because when [UChatLoading] is already shown [showCustomOfflineMode] will not work.
      await UChatLoading.hide();
      UChatNewDialog.showYouAreOfflineDialog(context: Get.context!);
    }
  } else {
    if (onUnknownException != null) {
      await onUnknownException();
    } else {
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
        e: e,
      );
    }
  }
}
