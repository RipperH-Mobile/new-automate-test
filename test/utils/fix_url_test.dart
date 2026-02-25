import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/utils/fix_url.dart';

void main() {
  group('fixUrl', () {
    test('adds www. if missing and domain is a normal hostname', () {
      final result = fixUrl('https://example.com/path');
      expect(result, 'https://www.example.com/path');
    });

    test('does not add www. if it already exists', () {
      final result = fixUrl('https://www.example.com/path');
      expect(result, 'https://www.example.com/path');
    });

    test('does not add www. if the host is localhost', () {
      final result = fixUrl('http://localhost:3000');
      expect(result, 'http://localhost:3000');
    });

    test('does not add www. if the host is an IP address', () {
      final result = fixUrl('http://192.168.1.1:8080');
      expect(result, 'http://192.168.1.1:8080');
    });

    test('adds www. while keeping port and path intact', () {
      final result = fixUrl('http://mydomain.com:8080/api');
      expect(result, 'http://www.mydomain.com:8080/api');
    });

    // url with sub domain
    test('does not add www. for subdomains', () {
      final result = fixUrl('https://sub.example.com/path');
      expect(result, 'https://sub.example.com/path');
    });

    // url is IP address
    test('does not add www. for subdomains', () {
      final result = fixUrl('1.1.1.1');
      expect(result, 'https://1.1.1.1');
    });
  });

  group('ensureUrlHasScheme', () {
    test('adds https:// if scheme missing', () {
      expect(ensureUrlHasScheme('example.com'), 'https://example.com');
      expect(ensureUrlHasScheme('www.example.com/path'), 'https://www.example.com/path');
    });

    test('does not add scheme if already present', () {
      expect(ensureUrlHasScheme('http://example.com'), 'http://example.com');
      expect(ensureUrlHasScheme('https://example.com'), 'https://example.com');
    });
  });
}
