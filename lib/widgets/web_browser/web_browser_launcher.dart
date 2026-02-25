import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:uchat/controllers.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/infrastructure/orchestrator/navigation/deep_link_handler.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/responsive/responsive_screen_util.dart';

import 'web_browser_page.dart';

class WebBrowserLauncher {
  /// Instance
  static final WebBrowserLauncher instance = WebBrowserLauncher.internal();

  WebBrowserLauncher.internal();

  factory WebBrowserLauncher() => instance;

  AppController get appController => Get.find<AppController>();

  bool isUChatUrlDeepLink(String url) {
    if ([AppEnv.getPolicyUrl(), AppEnv.getTermAndConditionsUrlWith()].contains(url)) {
      return false;
    }

    if (url.startsWith(Uri.parse(AppEnv.addFriendPrefix).toString())) {
      return true;
    }

    if (url.startsWith(Uri.parse(AppEnv.roomInviteLinkPrefix).toString())) {
      return true;
    }

    if (url.startsWith(Uri.parse(AppEnv.stickerSharingPrefix).toString())) {
      return true;
    }

    return false;
  }

  Future<void> open(String url) async {
    if (isUChatUrlDeepLink(url)) {
      GetIt.I<DeepLinkHandler>().processLink(Uri.parse(url));
      return;
    }

    if (UChatScreenUtil.instance.isMobilePlatform) {
      showCustomModalBottomSheet(
        context: Get.context!,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        builder: (context) => WebBrowserPage(url: url),
        containerWidget: (
          BuildContext context,
          Animation<double> animation,
          Widget child,
        ) {
          return Container(child: child);
        },
      );
    } else {
      if (Platform.isWindows) {
        await GetIt.I<UrlService>().open(url);
      } else {
        final browser = InAppBrowser();
        final inAppBrowserSettings = InAppBrowserClassSettings(
          browserSettings: InAppBrowserSettings(hideUrlBar: true),
          webViewSettings: InAppWebViewSettings(javaScriptEnabled: true),
        );

        browser.openUrlRequest(
          urlRequest: URLRequest(url: WebUri(url)),
          settings: inAppBrowserSettings,
        );
      }
    }
  }
}
