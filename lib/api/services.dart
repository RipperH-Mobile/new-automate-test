import 'package:uchat/core/data/data_sources/account_service.dart';

export 'giphy/giphy.dart';
export 'services/announcement_service.dart';
export 'services/auth_service.dart';
export 'services/file_downloader_service.dart';
export 'services/google_place_service.dart';
export 'services/message_service.dart';
export 'services/official_account_service.dart';
export 'services/support_ticket_service.dart';

// For using in the future.
// Use with automation test.
// This class make api service to testable.
class ServiceAdapter {
  // Singleton pattern
  static final ServiceAdapter instance = ServiceAdapter._internal();

  /// Factory of class.
  factory ServiceAdapter() => instance;

  /// Constructor
  ServiceAdapter._internal();

  AccountService accountService = AccountService.instance;

  accountServiceSetter(AccountService value) {
    accountService = value;
  }
}
