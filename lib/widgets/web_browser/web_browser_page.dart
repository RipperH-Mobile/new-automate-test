import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/domain/services/url_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

// const iconColor = Color(0xff8d8d8d);

final _log = useLogger();

class WebBrowserPage extends StatefulWidget {
  final String url;

  const WebBrowserPage({
    super.key,
    required this.url,
  });

  @override
  WebBrowserPageState createState() => WebBrowserPageState();
}

class WebBrowserPageState extends State<WebBrowserPage> {
  final GlobalKey webViewKey = GlobalKey();
  final Set<Factory<OneSequenceGestureRecognizer>> _gestureRecognizers = {Factory(() => EagerGestureRecognizer())};

  InAppWebViewController? _webView;

  InAppWebViewSettings settings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    useHybridComposition: true,
    allowsInlineMediaPlayback: true,
    allowsAirPlayForMediaPlayback: true,
  );

  double progress = 0;
  String url = '';
  Uri? uri;
  String title = '';

  bool canRefresh = false;
  bool canBack = false;
  bool canForward = false;

  final TextStyle _titleStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w400,
    fontSize: 16,
  );

  final Color _subTitleColor = Colors.black45;
  final TextStyle _subTitleStyle = const TextStyle(
    color: Colors.black45,
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static const allowNavigateSchema = ['http', 'https', 'file', 'chrome', 'data', 'javascript', 'about'];

  @override
  void initState() {
    super.initState();
    url = widget.url;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 1.0,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: _buildLeading(context),
        title: _buildTitle(context),
        actions: _buildActions(context),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: progress < 1.0
              ? LinearProgressIndicator(
                  minHeight: 3,
                  value: progress,
                  backgroundColor: Colors.blue.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                )
              : const SizedBox.shrink(),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            InAppWebView(
              key: webViewKey,
              initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
              gestureRecognizers: _gestureRecognizers,
              initialSettings: settings,
              onWebViewCreated: (InAppWebViewController controller) {
                _webView = controller;
              },
              onUpdateVisitedHistory: onUpdateVisitedHistory,
              shouldOverrideUrlLoading: shouldOverrideUrlLoading,
              onLoadStart: onLoadStart,
              onLoadStop: onLoadStop,
              onProgressChanged: onProgressChanged,
              onTitleChanged: onTitleChanged,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Future<void> onUpdateVisitedHistory(
    InAppWebViewController controller,
    Uri? url,
    bool? androidIsReload,
  ) async {
    const canRefresh = true;
    final canBack = await controller.canGoBack();
    final canForward = await controller.canGoForward();

    setState(() {
      this.url = url.toString();
      uri = url;

      this.canRefresh = canRefresh;
      this.canBack = canBack;
      this.canForward = canForward;
    });
  }

  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction,
  ) async {
    final uri = navigationAction.request.url!;

    if (!canNavigateSchema(uri)) {
      Uri canLaunchUri = uri;
      if (Platform.isAndroid && uri.scheme == 'intent') {
        canLaunchUri = intentToUri(uri.toString());
      }
      _log.i(
        '''
          URI scheme [${uri.scheme}] not allowed -> $uri
          URI after convert from Intent -> $canLaunchUri''',
      );

      if (canNavigateSchema(canLaunchUri)) {
        await controller.loadUrl(
          urlRequest: URLRequest(
            url: WebUri.uri(canLaunchUri),
          ),
        );
      }

      if (await canLaunchUrl(canLaunchUri)) {
        await GetIt.I<UrlService>().open(url, mode: LauncherMode.externalApplication);
        Get.back();
      }
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  Future<void> onLoadStart(
    InAppWebViewController controller,
    Uri? url,
  ) async {
    const canRefresh = false;
    final canBack = await controller.canGoBack();
    final canForward = await controller.canGoForward();

    setState(() {
      this.url = url.toString();
      uri = url;
      title = 'Loading...'.tr;

      this.canRefresh = canRefresh;
      this.canBack = canBack;
      this.canForward = canForward;
    });
  }

  Future<void> onLoadStop(
    InAppWebViewController controller,
    Uri? url,
  ) async {
    const canRefresh = true;
    final canBack = await controller.canGoBack();
    final canForward = await controller.canGoForward();

    setState(() {
      this.url = url.toString();
      uri = url;

      this.canRefresh = canRefresh;
      this.canBack = canBack;
      this.canForward = canForward;
    });
  }

  void onProgressChanged(
    InAppWebViewController controller,
    int progress,
  ) {
    setState(() {
      this.progress = progress / 100;
    });
  }

  Future<void> onTitleChanged(
    InAppWebViewController controller,
    String? title,
  ) async {
    const canRefresh = true;
    final canBack = await controller.canGoBack();
    final canForward = await controller.canGoForward();

    setState(() {
      this.title = title ?? 'UNKNOWN'.tr;
      this.canRefresh = canRefresh;
      this.canBack = canBack;
      this.canForward = canForward;
    });
  }

  Widget _buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close_outlined,
        color: Colors.black,
      ),
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xfff7f7f8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: _buildTitleContent(context),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTitleContent(BuildContext context) {
    return [
      // if (progress != 1.0)
      //   Text(
      //     'Loading...'.tr,
      //     textAlign: TextAlign.center,
      //     style: _titleStyle,
      //   ),
      // if (progress == 1.0)
      Text(
        title,
        textAlign: TextAlign.center,
        style: _titleStyle,
      ),
      _buildUrl(context),
    ];
  }

  Widget _buildUrl(BuildContext context) {
    if (uri != null) {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (uri!.isScheme('https'))
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                child: Icon(
                  Icons.lock,
                  color: _subTitleColor,
                  size: 12.0,
                ),
              ),
            Text(
              uri!.host,
              style: _subTitleStyle,
            ),
          ],
        ),
      );
    } else {
      return Center(
        child: Text(
          url,
          textAlign: TextAlign.center,
          style: _subTitleStyle,
        ),
      );
    }
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.more_vert_outlined,
          color: Colors.black,
        ),
        onPressed: () => _handleMoreOptionsAction(context),
      )
    ];
  }

  Widget _buildBottomNav(BuildContext context) {
    if (_webView == null) {
      return Container();
    }

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              //                    <--- top side
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              disabledColor: Colors.grey,
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: canBack ? () => _webView?.goBack() : null,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: canForward ? () => _webView?.goForward() : null,
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: canRefresh ? () => _webView?.reload() : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleMoreOptionsAction(BuildContext context) async {
    try {
      showUChatModalBottomSheet(
        menus: <Widget>[
          UChatBottomSheetItem(
            label: 'Open with browser'.tr,
            icon: Icons.open_in_browser_outlined,
            onPressed: () async {
              Get.back();
              await GetIt.I<UrlService>().open(url);
            },
          ),
          const UChatBottomSheetDivider(),
        ],
      );
    } catch (e) {
      _log.d(e);
    }
  }

  bool canNavigateSchema(Uri uri) {
    final schema = uri.scheme;

    if (allowNavigateSchema.contains(schema)) {
      return true;
    } else {
      return false;
    }
  }

  Uri intentToUri(String uri) {
    const String fallbackKeyword = 'browser_fallback_url';
    if (uri.contains(fallbackKeyword)) {
      final fallbackMatch = RegExp(r'(?:browser_fallback_url=(\w.*?)?;)').firstMatch(uri);
      final linkMatch = RegExp(r'(?:link=(\w.*?)?;)').firstMatch(uri);
      if (linkMatch?.group(1) != null) {
        final link = linkMatch!.group(1);
        return Uri.parse(Uri.decodeFull(link!));
      }

      if (fallbackMatch?.group(1) != null) {
        final fallbackUrl = fallbackMatch!.group(1);
        return Uri.parse(Uri.decodeFull(fallbackUrl!));
      }
    }

    final String urlString = uri.split('#Intent;').first;
    final scheme = RegExp(r'(?:scheme=(\w.*?)?;)');
    final schemeMatch = scheme.firstMatch(uri);

    if (schemeMatch?.group(1) != null) {
      final scheme = schemeMatch!.group(1);
      final uri = urlString.replaceAll('intent://', '$scheme://');
      return Uri.parse(uri);
    }

    return Uri.parse(uri);
  }
}
