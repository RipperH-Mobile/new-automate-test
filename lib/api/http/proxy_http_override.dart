import 'dart:io';

class ProxyHttpOverride extends HttpOverrides {
  final String ip;
  final int port;

  ProxyHttpOverride({required this.ip, required this.port});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);

    client.findProxy = (url) {
      return 'PROXY $ip:$port';
    };

    client.badCertificateCallback = (cert, host, port) => true;

    return client;
  }
}
