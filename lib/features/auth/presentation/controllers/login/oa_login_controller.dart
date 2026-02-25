import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/auth/domain/use_cases/official_account_qr_sign_in_verify_token_use_case.dart';
import 'package:uchat/widgets/dialog/uchat_dialog.dart';
import 'package:uchat/widgets/loading/loading.dart';

class OALoginController extends GetxController {
  static OALoginController get to => Get.find();
  late String token;

  OALoginController({
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

  Future<void> handleVerifyToken(String token) async {
    try {
      UChatLoading.show();
      final request = OAQRVerifyTokenRequest(token: token);
      await GetIt.I<OfficialAccountQRSignInVerifyTokenUseCase>().call(request);
      // authService return true if the token is valid
      // otherwise, it will throw an exception
      await UChatLoading.hide();
      Get.back();
    } on ApiException catch (e, stackTrace) {
      await UChatLoading.hide();
      Get.back();
      if (e.type == 'ERR_OA_TOKEN_EXPIRED') {
        await UChatDialog.showDialogQRCodeExpire();
      } else {
        _log.w('handleVerifyToken Scan Error.', e, stackTrace);
        await UChatDialog.showDialogQRCodeError();
      }
    } catch (e, stackTrace) {
      await UChatLoading.hide();
      Get.back();
      await UChatDialog.showDialogQRCodeError();
      _log.e('handleVerifyToken Scan Error.', e, stackTrace);
    }
  }

  void handleLogin() async {
    _log.d('handleLogin');
    await handleVerifyToken(token);
  }

  void handleCancel() {
    Get.back();
  }
}
