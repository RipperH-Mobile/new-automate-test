String fixUrl(String url) {
  // Ensure URL starts with scheme for reliable parsing
  if (!url.startsWith(RegExp(r'https?://'))) {
    url = 'https://$url';
  }

  final uri = Uri.tryParse(url);
  if (uri == null || uri.host.isEmpty) return url;

  final host = uri.host;

  final isIp = RegExp(r'^\d{1,3}(\.\d{1,3}){3}$').hasMatch(host);
  final isLocal = host == 'localhost';

  // Split host into parts (e.g., ['cdn', 'example', 'com'])
  final parts = host.split('.');

  // Root domains usually have only 2 parts (e.g. example.com)
  final isRootDomain = parts.length == 2;

  if (!host.startsWith('www.') && !isIp && !isLocal && isRootDomain) {
    final newHost = 'www.$host';
    final fixedUri = uri.replace(host: newHost);
    return fixedUri.toString();
  }

  return uri.toString(); // Normalize and return
}

String ensureUrlHasScheme(String url) {
  if (!url.startsWith(RegExp(r'https?://'))) {
    return 'https://$url';
  }
  return url;
}
