import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';

void main() {
  group('EventProperty', () {
    test('openApp returns correct map', () {
      expect(EventProperty.openApp(accountType: 'premium'), {'account_type': 'premium'});
    });

    test('pageViewed returns correct map with route name', () {
      final route = MaterialPageRoute(builder: (_) => Container(), settings: const RouteSettings(name: '/home'));
      final result = EventProperty.pageViewed(route: route);
      expect(result['page_name'], '/home');
      expect(result['route_type'], contains('MaterialPageRoute'));
    });

    test('pageViewed returns widget name for MaterialPageRoute with argument', () {
      final route = MaterialPageRoute(
        builder: (_) => const SizedBox.shrink(),
        settings: const RouteSettings(arguments: Text('WidgetArg')),
      );
      final result = EventProperty.pageViewed(route: route);
      expect(result['page_name'], 'Text');
    });

    test('pageViewed returns widget name for CupertinoPageRoute with argument', () {
      final route = CupertinoPageRoute(
        builder: (_) => const SizedBox.shrink(),
        settings: const RouteSettings(arguments: Text('WidgetArg')),
      );
      final result = EventProperty.pageViewed(route: route);
      expect(result['page_name'], 'Text');
    });

    test('pageViewed returns /unknown if no name and no widget', () {
      final route = MaterialPageRoute(builder: (_) => const SizedBox.shrink());
      final result = EventProperty.pageViewed(route: route);
      expect(result['page_name'], '/unknown');
    });

    test('pageViewedBottomNavBar returns correct tab names', () {
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 0)['page_name'], 'contact_list_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 1)['page_name'], 'chat_list_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 2)['page_name'], 'call_log_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 3)['page_name'], 'central_notification_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 4)['page_name'], 'my_profile_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 5)['page_name'], 'back_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 6)['page_name'], 'setting_account_tab');
      expect(EventProperty.pageViewedBottomNavBar(paneIndex: 99)['page_name'], 'unknown_tab');
    });

    test('appErrorOccurred returns correct map', () {
      final result = EventProperty.appErrorOccurred(
        errorType: 'SomeError',
        errorMessage: 'msg',
        errorAdditionalMessage: 'addMsg',
        errorAdditionalData: {'foo': 'bar'},
      );
      expect(result['error_type'], 'SomeError');
      expect(result['error_message'], 'msg');
      expect(result['error_additional_message'], 'addMsg');
      expect(result['error_additional_data'], {'foo': 'bar'});
      expect(result.containsKey('current_route'), true);
      expect(result.containsKey('prev_route'), true);
    });

    test('qrCodeScanned returns correct map', () {
      expect(EventProperty.qrCodeScanned(isUChat: true), {'is_UChat': true});
      expect(EventProperty.qrCodeScanned(isUChat: false), {'is_UChat': false});
    });

    test('clickAcceptAddFriendPage returns correct map', () {
      expect(EventProperty.clickAcceptAddFriendPage(requestType: 'manual'), {'request_type': 'manual'});
    });

    test('clickAddFriendSearchPage returns correct map', () {
      expect(EventProperty.clickAddFriendSearchPage(friendType: 'uchat'), {'friend_type': 'uchat'});
    });

    test('inputPhoneNumberAddFriendPage returns correct map', () {
      expect(EventProperty.inputPhoneNumberAddFriendPage(countryName: 'Thailand'), {'country_name': 'Thailand'});
    });

    test('clickTabRequestAddFriendPage returns correct map', () {
      expect(EventProperty.clickTabRequestAddFriendPage(tapRequestCategory: 'pending'),
          {'tap_request_category': 'pending'});
    });

    test('searchingUChatIdAddFriendPage returns correct map', () {
      expect(EventProperty.searchingUChatIdAddFriendPage(searchInput: 'uchat123'), {'search_input': 'uchat123'});
    });

    test('clickContact returns correct map', () {
      expect(EventProperty.clickContact(contactType: 'friend'), {'contact_type': 'friend'});
    });

    test('swipeActionContactPage returns correct map', () {
      expect(EventProperty.swipeActionContactPage(swipeAction: 'delete', contactType: 'friend'),
          {'swipe_action': 'delete', 'contact_type': 'friend'});
    });

    test('clickLongPressAction returns correct map', () {
      expect(EventProperty.clickLongPressAction(longPressQuickAction: 'block', contactType: 'friend'),
          {'long_press_quick_action': 'block', 'contact_type': 'friend'});
    });

    test('clickTabContactHomepage returns correct map', () {
      expect(EventProperty.clickTabContactHomepage(tapCategory: 'all'), {'tap_category': 'all'});
    });

    test('selectCountryCodePhoneNumber returns correct map', () {
      expect(EventProperty.selectCountryCodePhoneNumber('Thailand', '66'), {'country_name': 'Thailand(+66)'});
    });

    test('clickContinueSignUp returns correct map', () {
      expect(EventProperty.clickContinueSignUp('email'), {'signup_method': 'email'});
    });
  });
}
