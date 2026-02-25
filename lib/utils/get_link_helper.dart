String getDomain({
  required String url,
}) {
  return Uri.parse(url).host.replaceAll(RegExp(r'^(www\.|web\.)'), '');
}
