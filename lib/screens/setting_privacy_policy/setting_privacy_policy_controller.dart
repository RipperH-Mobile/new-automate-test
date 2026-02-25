import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/services/platform_document_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets/dialog/uchat_new_dialog.dart';

class SettingPrivacyPolicyController extends GetxController {
  final LoggerService log;
  final fileUrl = ''.obs;

  SettingPrivacyPolicyController({
    required this.log,
  });

  @override
  void onReady() {
    super.onReady();
    _getPlatformDocument();
  }

  Future<void> _getPlatformDocument() async {
    try {
      final url = await GetIt.I<PlatformDocumentService>().getPrivacyPolicyUrlAndCurrentVersion();
      fileUrl(url.$1);
    } catch (e) {
      log.e('Error fetching privacy policy', e);
      UChatNewDialog.showGeneralErrorDialog(
        context: Get.context!,
      );
    }
  }
}
