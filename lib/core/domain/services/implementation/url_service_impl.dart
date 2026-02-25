import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlServiceImpl implements UrlService {
  @override
  Future<void> mailTo(String email) async {
    final mailtoLink = 'mailto:$email';
    await open(mailtoLink);
  }

  @override
  Future<void> open(String url, {LauncherMode mode = LauncherMode.platformDefault}) async {
    try {
      if (url.isEmpty) {
        throw ArgumentError('URL cannot be empty');
      }

      final uri = Uri.tryParse(url);
      if (uri == null) {
        throw FormatException('Invalid URL format: $url');
      }

      await launchUrl(uri, mode: mode.origin);
    } catch (e, stackTrace) {
      useLogger().e('Launch URL failed.', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> sms(String phoneNumber) async {
    final smsLink = 'sms:$phoneNumber';
    await open(smsLink);
  }

  @override
  Future<void> tel(String phoneNumber) async {
    final telLink = 'tel:$phoneNumber';
    await open(telLink);
  }
}
