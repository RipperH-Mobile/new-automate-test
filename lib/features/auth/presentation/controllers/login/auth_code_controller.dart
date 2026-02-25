import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/data/models/requests/auth_code_verify_token_request.dart';
import 'package:uchat/features/auth/domain/use_cases/auth_code_verify_token_use_case.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

class AuthCodeController extends GetxController {
  static AuthCodeController get to => Get.find();
  late String token;

  AuthCodeController({
    required this.token,
  }) {
    token = token;
  }

  final _log = useLogger();

  @override
  void onInit() {
    if (token.isNotEmpty == false) {
      _log.e('Token is null');
      Get.back();
      UChatDialog.showDialogQRCodeError();
      return;
    }

    super.onInit();
  }

  Future<void> handleLogin() async {
    try {
      UChatLoading.show();
      final request = AuthCodeVerifyTokenRequest(token: token);
      final result = await GetIt.I<AuthCodeVerifyTokenUseCase>().call(request);
      // authService return true if the token is valid
      // otherwise, it will throw an exception
      await UChatLoading.hide();
      Get.back();

      if (result?.success != true) {
        await UChatDialog.showDialogQRCodeError();
      }
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      Get.back();
      if (e.type == 'ERR_OA_TOKEN_EXPIRED') {
        _log.w('handleVerifyToken Token expired.', e, stackTrace);
        await UChatDialog.showDialogQRCodeExpire();
      } else {
        _log.w('handleVerifyToken Scan Error.', e, stackTrace);
        await UChatDialog.showDialogQRCodeError();
      }
    } catch (e, stackTrace) {
      _log.e('handleVerifyToken Scan Error.', e, stackTrace);

      await UChatLoading.hide();
      Get.back();
      await UChatDialog.showDialogQRCodeError();
    }
  }

  void handleCancel() {
    Get.back();
  }
}
