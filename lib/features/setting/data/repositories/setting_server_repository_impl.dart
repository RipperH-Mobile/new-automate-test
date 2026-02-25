import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/exceptions/api_exception.dart';
import 'package:uchat/core/exceptions/null_response_exception.dart';
import 'package:uchat/features/setting/data/data_source/remote/setting_api_service.dart';
import 'package:uchat/features/setting/data/data_source/remote/setting_socket_service.dart';
import 'package:uchat/features/setting/data/models/request/check_new_phone_number_request.dart';
import 'package:uchat/features/setting/data/models/request/update_phone_number_request.dart';
import 'package:uchat/features/setting/domain/repositories/setting_server_repository.dart';

final _log = useLogger();

class SettingServerRepositoryImpl implements SettingServerRepository {
  final SocketCaller socketCaller;
  final SettingApiService settingApiService;
  final SettingSocketService settingSocketService;

  SettingServerRepositoryImpl({
    required this.socketCaller,
    required this.settingApiService,
    required this.settingSocketService,
  });

  @override
  Future<void> checkCanChangePhoneNumber() async {
    _log.d('checkCanChangePhoneNumber');
    if (socketCaller.isReadyForCall) {
      try {
        await settingSocketService.checkCanChangePhoneNumber();
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('checkCanChangePhoneNumber with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }

    await settingApiService.checkCanChangePhoneNumber();
  }

  @override
  Future<void> checkNewPhoneNumber(CheckNewPhoneNumberRequest request) async {
    _log.d('checkNewPhoneNumber: ${request.toJson()}');
    if (socketCaller.isReadyForCall) {
      try {
        await settingSocketService.checkNewPhoneNumber(request);
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('checkNewPhoneNumber with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }

    await settingApiService.checkNewPhoneNumber(request);
  }

  @override
  Future<UpdatePhoneNumberResponse> updatePhoneNumber(UpdatePhoneNumberRequest request) async {
    _log.d('updatePhoneNumber: ${request.toJson()}');
    if (socketCaller.isReadyForCall) {
      try {
        final res = await settingSocketService.updatePhoneNumber(request);
        if (res == null) throw NullResponseException();
        return res;
      } on ApiException catch (e) {
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        _log.w('updatePhoneNumber with socket error. Fallback to HTTP request...', e, stackTrace);
      }
    }

    final res = await settingApiService.updatePhoneNumber(request);
    if (res == null) throw NullResponseException();
    return res;
  }
}
