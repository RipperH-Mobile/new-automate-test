import 'package:uchat/widgets/web_browser/web_browser_launcher.dart';

extension UrlExtension on String {
  Future<void> openInWebBrowser() async {
    if (isEmpty) return;

    if (startsWith('https://') || startsWith('http://')) {
      await WebBrowserLauncher().open(this);
    } else {
      await WebBrowserLauncher().open('https://$this');
    }
  }
}
