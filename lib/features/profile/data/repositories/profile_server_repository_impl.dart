import 'package:uchat/api/socket/socket_caller.dart';
import 'package:uchat/core/exceptions/exceptions.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_http_service.dart';
import 'package:uchat/features/profile/data/data_source/remote/profile_socket_service.dart';
import 'package:uchat/features/profile/domain/entities/profile_entity.dart';
import 'package:uchat/features/profile/domain/repositories/profile_server_repository.dart';

class ProfileServerRepositoryImpl extends ProfileServerRepository {
  final ProfileHttpService profileHttpService;
  final ProfileSocketService profileSocketService;
  final SocketCaller socketCaller;
  final LoggerService log;

  ProfileServerRepositoryImpl({
    required this.profileHttpService,
    required this.profileSocketService,
    required this.socketCaller,
    required this.log,
  });

  @override
  Future<ProfileEntity> getProfile(String accountId) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await profileSocketService.getProfile(accountId);
        if (socketResp == null) {
          throw NullResponseException();
        }
        return socketResp;
      } on ApiException catch (e) {
        /// If the service is not found, fallback to http request.
        /// Otherwise, rethrow the error because when retrying with http request it's highly likely that server will
        /// throw the same error anyway.
        if (e.type != 'SERVICE_NOT_FOUND') rethrow;
      } catch (e, stackTrace) {
        if (e is NullResponseException) {
          rethrow;
        }
        log.w('multifactorValidate with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to HTTP
    final profile = await profileHttpService.getProfile(accountId);
    if (profile == null) {
      throw NullResponseException();
    }

    return profile;
  }
}
