import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uchat/constants/uchat_constant.dart';
import 'package:uchat/core/theme/app_colors_theme.dart';
import 'package:uchat/core/theme/app_text_theme.dart';
import 'package:uchat/features/chat_room/utils/match_text_helper.dart';

void main() {
  group('MatchTextBuilder', () {
    test('buildMentionMatchText returns MatchText with correct pattern and style', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: '@[a-zA-Z0-9]+',
        styleMatch: TextStyle(color: AppColorsTheme.light().textPrimary),
      );
      final matchText = builder.buildMentionMatchText();
      expect(matchText.pattern, equals('@[a-zA-Z0-9]+'));
      expect(matchText.style?.color, equals(AppColorsTheme.light().textPrimary));
    });

    test('buildShowMoreLessMatchText applies correct style based on isMe and isSecretRoom', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: 'Show more|Show less',
        styleMatch: const TextStyle(color: Colors.black),
        isMe: true,
        isSecretRoom: true,
      );
      final matchText = builder.buildShowMoreLessMatchText();
      expect(matchText.style?.color, equals(AppColorsTheme.light().textPrimary));
    });

    test('buildUrlMatchText returns MatchText with correct URL pattern', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: UChatConstant.urlRegexPattern,
        styleMatch: const TextStyle(color: Colors.blue),
        isChatMessage: true,
      );
      final matchText = builder.buildUrlMatchText();
      expect(matchText.pattern, equals(UChatConstant.urlRegexPattern));
      expect(matchText.style?.decoration, equals(TextDecoration.underline));
    });

    test('buildEmailMatchText returns MatchText with email type and correct style', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: '',
        styleMatch: const TextStyle(color: Colors.green),
        isChatMessage: false,
      );
      final matchText = builder.buildEmailMatchText();
      expect(matchText.type, equals(ParsedType.EMAIL));
      expect(matchText.style?.color, equals(Colors.green));
    });

    test('buildPhoneMatchText returns MatchText with phone type and correct style', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: '',
        styleMatch: const TextStyle(color: Colors.red),
        isChatMessage: true,
      );
      final matchText = builder.buildPhoneMatchText();
      expect(matchText.type, equals(ParsedType.PHONE));
      expect(matchText.style?.color, equals(AppColorsTheme.light().linkText));
    });

    test('buildSearchHighlightText applies highlight style correctly', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: '',
        styleMatch: const TextStyle(),
      );
      final matchText = builder.buildSearchHighlightText('highlight');
      expect(matchText.pattern, equals('highlight'));
      expect(matchText.style?.backgroundColor, equals(const Color(0xffFAD200)));
    });

    test('buildSystemMessageDisplayNameMatchText applies correct pattern and style', () {
      final builder = MatchTextBuilder(
        appColorTheme: AppColorsTheme.light(),
        appTextTheme: AppTextTheme.roboto(),
        pattern: UChatConstant.systemMessageDisplayNameRegexPattern,
        styleMatch: const TextStyle(color: Colors.purple),
      );
      final matchText = builder.buildSystemMessageDisplayNameMatchText(
        const TextStyle(color: Colors.purple),
      );
      expect(matchText.pattern, equals(UChatConstant.systemMessageDisplayNameRegexPattern));
      expect(matchText.style?.color, equals(Colors.purple));
    });
  });

  group('_buildUrlMatchText', () {
    void testUrl(String description, String url, {bool hasMatch = true}) {
      test(description, () {
        final builder = MatchTextBuilder(
          appColorTheme: AppColorsTheme.light(),
          appTextTheme: AppTextTheme.roboto(),
          pattern: UChatConstant.urlRegexPattern,
          styleMatch: const TextStyle(color: Colors.blue),
          isChatMessage: true,
        );
        final matchText = builder.buildUrlMatchText();
        expect(matchText.pattern, equals(UChatConstant.urlRegexPattern));
        expect(RegExp(matchText.pattern!).hasMatch(url), hasMatch);
        if (hasMatch) {
          expect(RegExp(matchText.pattern!).stringMatch(url).toString(), equals(url));
        } else {
          expect(RegExp(matchText.pattern!).stringMatch(url), isNull);
        }
      });
    }

    void testUrlInText(String description, String url, {bool hasMatch = true, String? expectedMatch}) {
      test(description, () {
        final text = 'Visit our site at $url for more info.';

        final builder = MatchTextBuilder(
          appColorTheme: AppColorsTheme.light(),
          appTextTheme: AppTextTheme.roboto(),
          pattern: UChatConstant.urlRegexPattern,
          styleMatch: const TextStyle(color: Colors.blue),
          isChatMessage: true,
        );
        final matchText = builder.buildUrlMatchText();
        expect(matchText.pattern, equals(UChatConstant.urlRegexPattern));
        expect(RegExp(matchText.pattern!).hasMatch(text), hasMatch);
        if (hasMatch) {
          final actualMatch = RegExp(matchText.pattern!).stringMatch(text);
          expect(actualMatch, isNotNull);
          if (expectedMatch != null) {
            expect(actualMatch.toString(), equals(expectedMatch));
          } else {
            expect(actualMatch.toString(), equals(url));
          }
        } else {
          expect(RegExp(matchText.pattern!).stringMatch(text), isNull);
        }
      });
    }

    testUrl('Minimal HTTP URL without http #1', 'example.com');
    testUrl('Minimal HTTP URL without http #2', 'bit.ly');
    testUrl('Minimal HTTP URL (IP)', '1.1.1.1');

    testUrl('Minimal HTTP URL', 'http://example.com');
    testUrl('HTTPS URL with path', 'https://example.com/about');
    testUrl('URL with query', 'https://example.com/search?q=flutter');
    testUrl('URL with fragment', 'https://example.com/page#section1');
    testUrl('URL with port', 'http://example.com:8080');
    testUrl('URL with subdomain', 'http://blog.example.com');
    testUrl('URL with authentication', 'http://user:pass@example.com');
    testUrl('Full complex URL', 'https://user:pass@sub.example.com:443/path/to/resource?item=123#top');
    testUrl('FTP URL', 'ftp://ftp.example.com/files');
    testUrl('IP Address URL (IPv4)', 'http://192.168.1.1');
    testUrl('IPv6 URL', 'http://[2001:db8::1]');
    testUrl('Encoded URL', 'http://example.com/%E2%9C%93');
    testUrl('International domain (punycode)', 'http://xn--fsq.xn--0zwm56d');
    testUrl('URL with Unicode Thai text', 'https://th.example.com/สินค้า?หมวดหมู่=เทคโนโลยี');
    testUrl(
      'Real Amazon product URL',
      'https://www.amazon.co.uk/Logitech-Omnidirectional-Beamforming-Microphones-Cancellation-Graphite/dp/B0CX5D7TJG/ref=mp_s_a_1_3?crid=E72E9OQM5HSX&dib=eyJ2IjoiMSJ9.DRMXPnWg0McExxSns1Yqc_M2nv6XqlOffpk50OMqmA3-u6j8etGsnEhjxEf_AyXgHiQ23PA0o1otCfrHINCuu5qg1GPiJ83UWwXxBqZhrjke_wOm9wutnQCQdYnJ_6xTmGicUDzoVB91hsZtZzXWysHl7VK1QzcpjxJt7O1xboX4eV3of_TROtaiooVCQTeS.X_HNZLrpFX4RYBYFmfxAyNdbUKL7vDjWHkSZMem0ciI&dib_tag=se&keywords=logitech+rally+mic+pod&qid=1748168626&sprefix=rally+mic%2Caps%2C315&sr=8-3',
    );
    testUrl(
      'Return match correct, if url sample is Thai Unicode characters.',
      'https://www.amazon.co.uk/Logitech-Omnidirectional-Beamforming-Microphones-Cancellation-Graphite/dp/B0CX5D7TJG/ref=mp_s_a_1_3?crid=E72E9OQM5HSX&dib=eyJ2IjoiMSJ9.DRMXPnWg0McExxSns1Yqc_M2nv6XqlOffpk50OMqmA3-u6j8etGsnEhjxEf_AyXgHiQ23PA0o1otCfrHINCuu5qg1GPiJ83UWwXxBqZhrjke_wOm9wutnQCQdYnJ_6xTmGicUDzoVB91hsZtZzXWysHl7VK1QzcpjxJt7O1xboX4eV3of_TROtaiooVCQTeS.X_HNZLrpFX4RYBYFmfxAyNdbUKL7vDjWHkSZMem0ciI&dib_tag=se&keywords=logitech+rally+mic+pod&qid=1748168626&sprefix=rally+mic%2Caps%2C315&sr=8-3',
    );
    testUrl(
      'Return match correct, if url sample is Thai Unicode characters.',
      'https://uchat.co.th/TS-MEN-เสื้อเซ็ตผู้ชาย-เสื้อผู้ชาย-กางเกงขาสั้นผู้ชาย-(เสื้อ-กางเกงขาสั้น)-ดีไซน์เก๋-ขนาดมาตรฐาน（สีดำ-สีขาว-สีเทา）TZ05-i.24666115.19259313601',
    );
    testUrl('File URL', 'file:///C:/Users/Example/Documents/file.txt');
    testUrl('Data URI', 'data:text/plain;base64,SGVsbG8sIFdvcmxkIQ==');

    testUrlInText('Minimal HTTP URL', 'http://example.com');
    testUrlInText('HTTPS URL with path', 'https://example.com/about');
    testUrlInText('URL with query', 'https://example.com/search?q=flutter');
    testUrlInText('URL with fragment', 'https://example.com/page#section1');
    testUrlInText('URL with port', 'http://example.com:8080');
    testUrlInText('URL with subdomain', 'http://blog.example.com');
    testUrlInText('URL with authentication', 'http://user:pass@example.com');
    testUrlInText('Full complex URL', 'https://user:pass@sub.example.com:443/path/to/resource?item=123#top');
    testUrlInText('FTP URL', 'ftp://ftp.example.com/files');
    testUrlInText('IP Address URL (IPv4)', 'http://192.168.1.1');
    testUrlInText('IPv6 URL', 'http://[2001:db8::1]');
    testUrlInText('Encoded URL', 'http://example.com/%E2%9C%93');
    testUrlInText('International domain (punycode)', 'http://xn--fsq.xn--0zwm56d');
    testUrlInText('URL with Unicode Thai text', 'https://th.example.com/สินค้า?หมวดหมู่=เทคโนโลยี');
    testUrlInText(
      'Real Amazon product URL',
      'https://www.amazon.co.uk/Logitech-Omnidirectional-Beamforming-Microphones-Cancellation-Graphite/dp/B0CX5D7TJG/ref=mp_s_a_1_3?crid=E72E9OQM5HSX&dib=eyJ2IjoiMSJ9.DRMXPnWg0McExxSns1Yqc_M2nv6XqlOffpk50OMqmA3-u6j8etGsnEhjxEf_AyXgHiQ23PA0o1otCfrHINCuu5qg1GPiJ83UWwXxBqZhrjke_wOm9wutnQCQdYnJ_6xTmGicUDzoVB91hsZtZzXWysHl7VK1QzcpjxJt7O1xboX4eV3of_TROtaiooVCQTeS.X_HNZLrpFX4RYBYFmfxAyNdbUKL7vDjWHkSZMem0ciI&dib_tag=se&keywords=logitech+rally+mic+pod&qid=1748168626&sprefix=rally+mic%2Caps%2C315&sr=8-3',
    );
    testUrlInText(
      'Return match correct, if url sample is Thai Unicode characters.',
      'https://www.amazon.co.uk/Logitech-Omnidirectional-Beamforming-Microphones-Cancellation-Graphite/dp/B0CX5D7TJG/ref=mp_s_a_1_3?crid=E72E9OQM5HSX&dib=eyJ2IjoiMSJ9.DRMXPnWg0McExxSns1Yqc_M2nv6XqlOffpk50OMqmA3-u6j8etGsnEhjxEf_AyXgHiQ23PA0o1otCfrHINCuu5qg1GPiJ83UWwXxBqZhrjke_wOm9wutnQCQdYnJ_6xTmGicUDzoVB91hsZtZzXWysHl7VK1QzcpjxJt7O1xboX4eV3of_TROtaiooVCQTeS.X_HNZLrpFX4RYBYFmfxAyNdbUKL7vDjWHkSZMem0ciI&dib_tag=se&keywords=logitech+rally+mic+pod&qid=1748168626&sprefix=rally+mic%2Caps%2C315&sr=8-3',
    );
    testUrlInText(
      'Return match correct, if url sample is Thai Unicode characters.',
      'https://uchat.co.th/TS-MEN-เสื้อเซ็ตผู้ชาย-เสื้อผู้ชาย-กางเกงขาสั้นผู้ชาย-(เสื้อ-กางเกงขาสั้น)-ดีไซน์เก๋-ขนาดมาตรฐาน（สีดำ-สีขาว-สีเทา）TZ05-i.24666115.19259313601',
    );
    testUrlInText('Email simple', 'iKd6M@example.com', hasMatch: false);
    testUrlInText('Email with dot', 'poring.lunatic@prontera.com', hasMatch: false);
    testUrlInText('Email with numbers', 'user123@example456.com', hasMatch: false);
    testUrlInText('Email with subdomain', 'test.user@sub.domain.co.uk', hasMatch: false);
    testUrlInText('Email with special characters', 'user+tag@example-domain.org', hasMatch: false);
    testUrlInText('Email at beginning', 'admin@testserver.net is our email', hasMatch: false);
    testUrlInText('Email at ending', 'our email is admin@testserver.net', hasMatch: false);
    testUrlInText('Email with multiple dots', 'first.last@company.name.com', hasMatch: false);
    testUrlInText('Edge case1 of link', '1.Problem', hasMatch: false);
    testUrlInText('Edge case2 of link', '4.SP', hasMatch: false);
    testUrlInText('Version string (V1.2.3.4)', 'V1.2.3.4', hasMatch: false);
    testUrlInText('Tel protocol with IP', 'tel:1.1.1.1', expectedMatch: '1.1.1.1');
    testUrlInText('V protocol with IP', 'v:1.1.1.1', expectedMatch: '1.1.1.1');
    testUrlInText('V protocol with semicolon and IP', 'v;1.1.1.1', expectedMatch: '1.1.1.1');
    testUrlInText('V protocol with comma and IP', 'v,1.1.1.1', expectedMatch: '1.1.1.1');
    testUrlInText('Tel protocol with phone number1', 'tel:09987654321', expectedMatch: '09987654321');
    testUrlInText('Tel protocol with phone number2', 'x:09987654321', expectedMatch: '09987654321');
    testUrlInText('Tel protocol with phone number3', 'a:09987654321', expectedMatch: '09987654321');
    testUrlInText('Tel protocol with phone number4', 'b:09987654321', expectedMatch: '09987654321');
    testUrlInText('Tel protocol with phone number5', 'abcdef123:09987654321', expectedMatch: '09987654321');
    testUrlInText('Version string 1', 'X1.2.3.4', hasMatch: false);
    testUrlInText('Version string 2', 'a1.2.3.4', hasMatch: false);
    testUrlInText('Version string 3', 'njxoxoxox1.2.3.4', hasMatch: false);
    testUrlInText('Version string 4', '10.SP', hasMatch: false);
    testUrlInText('Version string 5', '10.co', hasMatch: true);
    testUrlInText('Version string 6', '10.co.th', hasMatch: true);
    testUrlInText('Version string 7', '12.co.th', hasMatch: true);
    testUrlInText('Version string 8', 'Good.co.th', hasMatch: true);
    testUrlInText('Version string 9', '9999.SP', hasMatch: false);
    testUrlInText('Version string 10', '10.Problem', hasMatch: false);
    testUrlInText('Version string 11', '9999.Problem', hasMatch: false);
    testUrlInText('Version string 12', 'sdlifsakdfjlksadjfklasjdfkl.asdkjflksdfklasdfjklasd', hasMatch: false);
    testUrlInText(
      'Version string 13',
      'sdlifsakdfjlksadjfklasjdfkl.asdkjflksdfklasdfjklasd.kasdjflasfjioejwoaijfoaiwjef',
      hasMatch: false,
    );
  });
}
