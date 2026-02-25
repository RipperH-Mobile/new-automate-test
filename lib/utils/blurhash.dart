const defaultBlurHash = 'LEHV6nWB2yk8pyo0adR*.7kCMdnj';

// For quick solution to check if blurhash is valid
String blurhashDefault(String? blurhash) {
  if (blurhash == null) {
    return defaultBlurHash;
  }
  if (blurhash.isEmpty || blurhash.length < 6) {
    return defaultBlurHash;
  }

  return blurhash;
}
