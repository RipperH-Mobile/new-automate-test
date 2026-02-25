import 'package:url_launcher/url_launcher.dart';

/// Enumeration of different launch modes for opening URLs.
///
/// This enum wraps the url_launcher package's [LaunchMode] enum to provide
/// a custom interface for the application while maintaining compatibility
/// with the underlying url_launcher functionality.
enum LauncherMode {
  /// Leaves the decision of how to launch the URL to the platform
  /// implementation.
  platformDefault,

  /// Loads the URL in an in-app web view (e.g., Android WebView).
  inAppWebView,

  /// Loads the URL in an in-app web view (e.g., Android Custom Tabs, SFSafariViewController).
  inAppBrowserView,

  /// Passes the URL to the OS to be handled by another application.
  externalApplication,

  /// Passes the URL to the OS to be handled by another non-browser application.
  externalNonBrowserApplication;

  /// Converts this custom [LauncherMode] to the corresponding url_launcher [LaunchMode].
  ///
  /// This getter provides a mapping between our custom enum and the url_launcher
  /// package's enum, allowing us to maintain our own interface while still
  /// leveraging the underlying functionality.
  LaunchMode get origin {
    switch (this) {
      case LauncherMode.platformDefault:
        return LaunchMode.platformDefault;
      case LauncherMode.inAppWebView:
        return LaunchMode.inAppWebView;
      case LauncherMode.inAppBrowserView:
        return LaunchMode.inAppBrowserView;
      case LauncherMode.externalApplication:
        return LaunchMode.externalApplication;
      case LauncherMode.externalNonBrowserApplication:
        return LaunchMode.externalNonBrowserApplication;
    }
  }
}

/// Abstract service interface for handling URL launching operations.
///
/// This service provides a unified interface for opening URLs, sending emails,
/// making phone calls, and sending SMS messages. All operations delegate to
/// the platform's default applications for handling these specific URL schemes.
///
/// Implementation should include proper input validation and error handling
/// to ensure robust operation across different platforms and edge cases.
abstract class UrlService {
  /// Opens a URL using the specified launch mode.
  ///
  /// Parameters:
  /// - [url]: The URL to open (must not be empty and must be valid)
  /// - [mode]: How the URL should be launched (defaults to platformDefault)
  ///
  /// Throws appropriate exceptions if the URL is invalid or cannot be launched.
  Future<void> open(String url, {LauncherMode mode = LauncherMode.platformDefault});

  /// Opens the default email client with the specified recipient.
  ///
  /// Creates a `mailto:` URL and opens it using the platform's default email client.
  /// The email client will open with the recipient field pre-populated.
  ///
  /// Parameters:
  /// - [email]: The recipient email address
  Future<void> mailTo(String email);

  /// Opens the default phone application to make a call.
  ///
  /// Creates a `tel:` URL and opens it using the platform's default phone application.
  /// On mobile devices, this typically opens the phone dialer with the number ready to call.
  ///
  /// Parameters:
  /// - [phoneNumber]: The phone number to call (can include country codes and formatting)
  Future<void> tel(String phoneNumber);

  /// Opens the default SMS application with the specified recipient.
  ///
  /// Creates an `sms:` URL and opens it using the platform's default SMS application.
  /// The SMS app will open with the recipient field pre-populated.
  ///
  /// Parameters:
  /// - [phoneNumber]: The recipient phone number for the SMS
  Future<void> sms(String phoneNumber);
}
