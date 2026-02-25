import 'dart:async';

import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/event_bus/event_bus.dart';
import 'package:uchat/features/chat_room/data/models/models/rich_menu_model.dart';

final _log = useLogger();

class OfficialAccountService with ServiceMixin {
  /// Singleton pattern
  static final instance = OfficialAccountService._internal();

  factory OfficialAccountService() => instance;

  OfficialAccountService._internal();

  ///
  /// Variable
  ///
  final socket = SocketCaller().socket;

  ///
  /// Get official menu request
  ///
  Future<GetMenuResponse?> getMenu(GetMenuRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getMenu.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse<GetMenuResponse>(
          (data) => GetMenuResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('getMenu with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(
      BackendPath.getMenu.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<GetMenuResponse>(
      (data) => GetMenuResponse.fromMap(data),
    );
  }

  ///
  /// Subscribe Official Account Event
  ///
  Future<void> subscribe(
    String oaAccountId,
  ) async {
    _log.d('officialAccount.subscribe');
    await socketCaller.emitCallV3(
      BackendPath.subscribeOA.socket,
      SubscribeRequest(officialAccountId: oaAccountId),
    );

    if (!socket.hasListeners('oa_menu_publish')) {
      socket.on('oa_menu_publish', onMenuPublishedEvent);
    }

    if (!socket.hasListeners('oa_menu_unpublish')) {
      socket.on('oa_menu_unpublish', onMenuUnpublishedEvent);
    }
  }

  ///
  /// Unsubscribe Official Account Event
  ///
  Future<void> unsubscribe(
    String oaAccountId,
  ) async {
    await socketCaller.emitCallV3(
      BackendPath.unsubscribeOA.socket,
      SubscribeRequest(officialAccountId: oaAccountId),
    );

    if (socket.hasListeners('oa_menu_publish')) {
      socket.off('oa_menu_publish', onMenuPublishedEvent);
    }

    if (socket.hasListeners('oa_menu_unpublish')) {
      socket.off('oa_menu_unpublish', onMenuUnpublishedEvent);
    }
  }

  ///
  /// Broadcast event when receive menu published.
  ///
  Future<void> onMenuPublish(data) async {
    try {
      _log.d('Menu publish');
      final menuResp = PublishMenuSubscribe.fromMap(data);

      if (menuResp.menu != null && menuResp.id != null) {
        eventBus.fire(OaMenuPublishEvent(
          id: menuResp.id!,
          menu: menuResp.menu!,
          lastUpdatedAt: menuResp.lastUpdatedAt!,
        ));
      }

      return;
    } catch (e, stackTrace) {
      _log.e('onMenuPublish error.', e, stackTrace);
    }
  }

  ///
  /// Broadcast event when receive menu unpublished.
  ///
  Future<void> onMenuUnpublish(data) async {
    try {
      final menuResp = UnpublishMenuSubscribe.fromMap(data);

      if (menuResp.lastUpdatedAt != null && menuResp.id != null) {
        eventBus.fire(OaMenuUnpublishEvent(
          id: menuResp.id!,
          lastUpdatedAt: menuResp.lastUpdatedAt!,
        ));
      }

      return;
    } catch (e, stackTrace) {
      _log.e('onMenuUnpublish error.', e, stackTrace);
    }
  }

  Future<void> onMenuPublishedEvent(data) async {
    if (data == null) return;
    try {
      final Map<String, dynamic> menuData = data as Map<String, dynamic>;

      final RichMenuModel richMenu = RichMenuModel.fromJson(menuData);
      final String? accountId = richMenu.officialAccountId;
      if (accountId == null) {
        _log.w('onMenuPublishedEvent accountId is null.');
        return;
      }

      eventBus.fire(RichMenuUpdateEvent(richMenu: richMenu, accountId: accountId));
    } catch (e, stackTrace) {
      _log.w('Call onMenuPublishedEvent error.', e, stackTrace);
    }
  }

  Future<void> onMenuUnpublishedEvent(data) async {
    if (data == null) return;
    try {
      final menuData = data as Map<String, dynamic>?;
      final String? accountId = menuData?['officialAccountId'] as String?;
      if (accountId == null) {
        _log.w('onMenuUnpublishedEvent accountId is null.');
        return;
      }

      eventBus.fire(RichMenuUpdateEvent(richMenu: null, accountId: accountId));
    } catch (e, stackTrace) {
      _log.w('Call onMenuUnpublishedEvent error.', e, stackTrace);
    }
  }
}
