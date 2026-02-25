import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:uchat/api/api.dart';
import 'package:uchat/api/mixins/service_mixin.dart';
import 'package:uchat/core/domain/services/meta_service.dart';
import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/entities/collections.dart';
import 'package:uchat/entities/models/devices_manager_model.dart';
import 'package:uchat/entities/services.dart';
import 'package:uchat/features/auth/data/models/responses/auth_login_response.dart';
import 'package:uchat/features/chat_room_detail/data/models/collections/room_file_collection.dart';
import 'package:uchat/utils/app_env.dart';

final _log = useLogger();
const allFriendLastSyncAtKey = 'ALL_FRIEND_LAST_SEEN_LAST_SYNC_AT';

class AccountService with ServiceMixin {
  /// Singleton pattern
  static final AccountService instance = AccountService._internal();

  factory AccountService() => instance;

  AccountService._internal();

  final configAuthenticated = ConfigDb().authenticated;

  /// Util getter
  String getRoomPublicAvatar(String roomId) {
    return '${AppEnv.apiUrl}v2/chat-rooms/$roomId/public-avatar';
  }

  String getUserPublicAvatar(String accountId) {
    return '${AppEnv.apiUrl}v2/users/$accountId/public-avatar';
  }

  /// ServiceMethod: upload profile image
  Future<UserResponse?> getProfile() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getProfile.socket,
          GetIt.I<MetaService>().toMap(),
        );

        return socketResp.mapToResponse<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w(
          'getProfile with socket error. fallback to http request...',
          e,
          stackTrace,
        );
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.get(
      BackendPath.getProfile.http,
    );

    return httpResp.mapToResponse<UserResponse>(
      (data) => UserResponse.fromMap(data),
    );
  }

  Future<UserResponse?> getProfileWithCustomToken(String customToken) async {
    final httpResp = await httpCaller.get(
      BackendPath.getProfile.http,
      customAccessToken: customToken,
    );

    return httpResp.mapToResponse<UserResponse>(
      (data) => UserResponse.fromMap(data),
    );
  }

  /// Get profile of other user
  ///
  /// This response should not equal to [getProfile] response, should be map to [ContactResponse] or something else
  /// TODO: change to use ContactResponse or something else
  /// Example response:
  /// ```json
  /// {
  ///  "data": {
  ///      "_id": "681c30a74adacca8dd1a9d3f",
  ///      "username": "pongsakorner",
  ///      "displayName": "pong",
  ///      "avatarId": "681c30a74adacca8dd1a9d3f_055046f2-2162-4c44-b3ff-86aa58cf17df.png",
  ///      "avatarBlurhash": "UsJayCWX%Mt7~qt6j]s:%MbIRjWBt7ozNGWC",
  ///      "deleted": false,
  ///      "currentSessionKeyId": "681c31170d0af1bf26c72e20"
  ///  },
  ///  "code": 200,
  ///  "type": "SUCCESS",
  ///  "metadata": {
  ///      "requestId": "755c498d-7ba8-4a09-a0f2-c6944bebb756",
  ///      "timestamp": "2025-05-15T04:05:30.059Z"
  ///   }
  /// }
  /// ```
  Future<UserResponse?> getProfileById(String id) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getProfileById.socket,
          {
            'accountId': id,
          },
        );

        return socketResp.mapToResponse<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('getProfileById with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(
      BackendPath.getProfileById.http.replaceAll(':accountId', id),
    );

    return httpResp.mapToResponse<UserResponse>(
      (data) => UserResponse.fromMap(data),
    );
  }

  Future<bool> checkIsUsernameValid(String username) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.verifyUsername.socket,
          {'username': username},
        );

        return socketResp.data == true;
      } catch (e, stackTrace) {
        _log.w('checkIsUsernameValid with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.verifyUsername.http,
      data: {'username': username},
    );

    return httpResp.data == true;
  }

  Future<UserResponse?> updateProfileUsername(
    UpdateUsernameRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.updateUsername.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('updateProfileUsername with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(BackendPath.updateUsername.http, data: request.toMap());
    return httpResp.mapToResponse<UserResponse>((data) => UserResponse.fromMap(data));
  }

  Future<UserResponse?> updateProfileDisplayName(
    UpdateDisplayNameRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.updateProfile.socket,
          request.toMap(),
        );

        return socketResp.mapToResponseV3<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('updateProfileDisplayName with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(BackendPath.updateProfile.http, data: request.toMap());
    return httpResp.mapToResponseV3<UserResponse>((data) => UserResponse.fromMap(data));
  }

  Future<UserResponse?> updateProfileStatusMessage(
    UpdateStatusMessageRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.updateProfile.socket,
          request.toMap(),
        );

        return socketResp.mapToResponseV3<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('updateProfileStatusMessage with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(BackendPath.updateProfile.http, data: request.toMap());
    return httpResp.mapToResponseV3<UserResponse>((data) => UserResponse.fromMap(data));
  }

  Future<UserResponse?> updateProfileBirthdate(
    UpdateBirthdateRequest request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.updateProfile.socket,
          request.toMap(),
        );

        return socketResp.mapToResponseV3<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('updateProfileBirthdate with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(BackendPath.updateProfile.http, data: request.toMap());
    return httpResp.mapToResponseV3<UserResponse>((data) => UserResponse.fromMap(data));
  }

  /// Use this to update (almost) all account setting.
  /// Use [UpdateAccountSettingRequest.create()] to send new value to server.
  Future<UserResponse?> updateAccountSetting(UpdateAccountSettingRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.updateAccountSetting.socket,
          request.toMap(),
        );

        return socketResp.mapToResponseV3<UserResponse>(
          (data) => UserResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('updateAccountSetting with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(BackendPath.updateAccountSetting.http);

    return httpResp.mapToResponseV3<UserResponse>(
      (data) => UserResponse.fromMap(data),
    );
  }

  /// ServiceMethod: upload profile image
  Future<UpdateProfileImageResponse?> uploadProfileImage(
    UpdateProfileImageRequest request,
  ) async {
    // TODO (improve) uploadProfile with FormData with socket return error : Converting object to an encodable object failed: Instance of 'FormData'
    // if (socketCaller.isConnected) {
    //   try {
    //     final socketResp = await socketCaller.emitCall(
    //       BackendPath.uploadProfile.socket,
    //       await request.toFormData(),
    //     );
    //
    //     return socketResp.mapToResponse(
    //       (data) => UpdateProfileImageResponse.fromMap(data),
    //     );
    //   } catch (e, stackTrace) {
    //     _log.w('uploadProfileImage with socket error. fallback to http request...', e, stackTrace);
    //   }
    // }

    final formData = await request.toFormData();
    final httpResp = await httpCaller.post(
      BackendPath.uploadProfileImage.http,
      data: formData,
      // onSendProgress: (count, total) {
      //   if (count != total) {
      //     UChatLoading.showProgress(count / total);
      //   } else {
      //     UChatLoading.show(status: 'Processing...'.tr);
      //   }
      // },
    );

    return httpResp.mapToResponse(
      (data) => UpdateProfileImageResponse.fromMap(data),
    );
  }

  Future<void> uploadBackgroundImage(
    UpdateBackgroundImageRequest request,
  ) async {
    // TODO (improve) uploadBackgroundImage with FormData with socket return error : Converting object to an encodable object failed: Instance of 'FormData'
    // if (socketCaller.isConnected) {
    //   try {
    //     await socketCaller.emitCall(
    //       BackendPath.uploadBackground.socket,
    //       await request.toFormData(),
    //     );
    //
    //     return;
    //   } catch (e, stackTrace) {
    //     _log.w('uploadBackgroundImage with socket error. fallback to http request...', e, stackTrace);
    //   }
    // }

    final data = await request.toFormData();
    await httpCaller.post(
      BackendPath.uploadBackground.http,
      data: data,
    );
  }

  Future<bool> deleteAccount(DeleteAccountRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.deleteAccount.socket,
          request.toMap(),
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('deleteAccount with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.deleteAccount.http,
      data: request.toMap(),
    );

    return httpResp.data;
  }

  Future<List<GetAllFriendLastSeenResponse>?> getAllFriendLastSeen() async {
    final lastSyncAt = await configAuthenticated.getDateTime(
      key: allFriendLastSyncAtKey,
    );

    final request = GetAllFriendLastSeenRequest(lastSyncAt: lastSyncAt);
    await configAuthenticated.saveConfig(
      key: allFriendLastSyncAtKey,
      value: DateTime.now(),
    );
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getAllFriendLastSeen.socket,
          request.toMap(),
        );

        return socketResp.listToResponse((e) => GetAllFriendLastSeenResponse.fromMap(e))?.toList();
      } catch (e, stackTrace) {
        _log.w('getAllFriendLastSeen with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(BackendPath.getAllFriendLastSeen.http);

    return httpResp.listToResponse((e) => GetAllFriendLastSeenResponse.fromMap(e))?.toList();
  }

  Future<UpdateOnlineStatusResponse?> updateOnlineStatus(UpdateOnlineStatusRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.updateOnlineStatus.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse(
          (data) => UpdateOnlineStatusResponse.fromMap(data['data']),
        );
      } catch (e, stackTrace) {
        _log.w('updateOnlineStatus with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.updateOnlineStatus.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse(
      (data) => UpdateOnlineStatusResponse.fromMap(data['data']),
    );
  }

  /// [Hybrid]
  /// Get public key and private key of the current user.
  Future<GetSelfEncryptionKeyResponse?> getSelfEncryptionKey() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getSelfEncryptionKey.socket,
          null,
        );

        return socketResp.mapToResponse(
          (data) => GetSelfEncryptionKeyResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('getSelfEncryptionKey with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(BackendPath.getSelfEncryptionKey.http);

    return httpResp.mapToResponse<GetSelfEncryptionKeyResponse>(
      (data) => GetSelfEncryptionKeyResponse.fromMap(data),
    );
  }

  Future<PaginationPayload<RoomFileCollection>?> requestFetchMedia(
    FetchMyProfileMedia request,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCallV3(
          BackendPath.getMyProfileMedia.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse(
          (data) => PaginationPayload<RoomFileCollection>.fromMapV3(
            data,
            listMapper: (files) {
              return files.map(
                (item) => RoomFileCollection.fromMap(item),
              );
            },
          ),
        );
      } catch (e, stackTrace) {
        _log.w('requestFetchMedia with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.get(
      BackendPath.getMyProfileMedia.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse(
      (data) => PaginationPayload<RoomFileCollection>.fromMapV3(
        data,
        listMapper: (files) {
          return files.map(
            (item) => RoomFileCollection.fromMap(item),
          );
        },
      ),
    );
  }

  /// ServiceMethod: Send Message
  Future<bool> checkEmailValid(String email) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.checkEmailValid.socket,
          {'email': email},
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('checkEmailValid with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.checkEmailValid.http,
      data: {'email': email},
    );

    return httpResp.data;
  }

  /// [Hybrid]
  Future<RequestOTPResponse?> updateEmailRequestOTP(UpdateEmailOtpRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.updateEmailOtpRequest.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse((data) => RequestOTPResponse.fromMap(data));
      } catch (e, stackTrace) {
        _log.w('updateEmailRequestOTP with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.post(
      BackendPath.updateEmailOtpRequest.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse((data) => RequestOTPResponse.fromMap(data));
  }

  /// [Hybrid]
  Future<UserCollection?> updateEmail(SettingEmailOTPRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.updateEmail.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('updateEmail with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.put(
      BackendPath.updateEmail.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  /// [Hybrid]
  Future<UserCollection?> removeEmail(String actionToken) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.deleteEmail.socket,
          {
            'actionToken': actionToken,
          },
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('removeEmail with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.put(
      BackendPath.deleteEmail.http,
      data: {
        'actionToken': actionToken,
      },
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  /// [Hybrid]
  Future<bool> checkUpdatePhoneNumberPermission() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getCanChangePhoneNumber.socket,
          {},
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('checkUpdatePhoneNumberPermission with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.post(BackendPath.getCanChangePhoneNumber.http);

    return httpResp.data;
  }

  /// [Hybrid]
  Future<bool> checkDuplicatePhoneNumber(
    String phoneNumber,
    String isoCode,
  ) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.checkDuplicatePhoneNumber.socket,
          {
            'phoneNumber': phoneNumber,
            'countryCode': isoCode,
          },
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('checkDuplicatePhoneNumber with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.post(
      BackendPath.checkDuplicatePhoneNumber.http,
      data: {
        'phoneNumber': phoneNumber,
        'countryCode': isoCode,
      },
    );

    return httpResp.data;
  }

  /// [Hybrid]
  Future<RequestOTPResponse?> updatePhoneNumberRequestOTP(UpdatePhoneNumberOtpRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.updatePhoneNumberOtpRequest.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse((data) => RequestOTPResponse.fromMap(data));
      } catch (e, stackTrace) {
        _log.w('updatePhoneNumberRequestOtp with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.post(
      BackendPath.updatePhoneNumberOtpRequest.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse((data) => RequestOTPResponse.fromMap(data));
  }

  /// [Hybrid]
  Future<UserCollection?> updatePhoneNumber(SettingPhoneNumberOTPRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.updatePhoneNumber.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('updatePhoneNumber with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.put(
      BackendPath.updatePhoneNumber.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<bool?> changePassword(ChangePasswordRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.changePassword.socket,
          request.toMap(),
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('changePassword with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.post(
      BackendPath.changePassword.http,
      data: request.toMap(),
    );

    return httpResp.data;
  }

  Future<bool?> enableMultiFactor(EnableMultiFactorRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.enableMultiFactor.socket,
          request.toMap(),
        );

        return socketResp.data;
      } catch (e, stackTrace) {
        _log.w('enableMultiFactor with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.post(
      BackendPath.enableMultiFactor.http,
      data: request.toMap(),
    );

    return httpResp.data;
  }

  Future<RequestOTPResponse?> checkUserPhoneOrEmail(CheckUserPhoneOrEmailRequest request) async {
    final httpResp = await httpCaller.post(
      BackendPath.authUserCheck.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponseV3((data) => RequestOTPResponse.fromMap(data));
  }

  Future<bool?> forgotPassword(ForgotPasswordRequest request) async {
    final httpResp = await httpCaller.put(
      BackendPath.forgotPassword.http,
      data: request.toMap(),
    );

    return httpResp.data != null;
  }

  Future<RequestOTPResponse?> requestAuthentication(AuthenticationRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.requestAuthentication.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse(
          (data) => RequestOTPResponse.fromMap(data),
        );
      } on ApiException catch (e, stackTrace) {
        if (e.type == 'ERR_ACCOUNT_INVALID_PASSWORD') {
          _log.w('requestAuthentication error : Incorrect password.', e, stackTrace);
          rethrow;
        } else {
          _log.w('requestAuthentication with socket error. fallback to http request...', e, stackTrace);
        }
      } catch (e, stackTrace) {
        _log.w('requestAuthentication with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.requestAuthentication.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  Future<RequestOTPResponse?> selectOtpType(SelectOtpTypeRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.selectOtpType.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse(
          (data) => RequestOTPResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('selectOtpType with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.selectOtpType.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  Future<RequestOTPResponse?> verifyOtp(VerifyOtpRequest request) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.verifyOtp.socket,
          request.toMap(),
        );

        return socketResp.mapToResponse(
          (data) => RequestOTPResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('verifyOtp with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.post(
      BackendPath.verifyOtp.http,
      data: request.toMap(),
    );

    return httpResp.mapToResponse<RequestOTPResponse>(
      (data) => RequestOTPResponse.fromMap(data),
    );
  }

  /// [Hybrid]
  Future<List<DevicesManagerModel>?> getAllLoggedInDevicesList() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.getAllSessions.socket,
          {},
        );

        return socketResp.listToResponse((e) => DevicesManagerModel.fromMap(e))?.toList();
      } catch (e, stackTrace) {
        _log.w('getAllLoggedInDevicesList with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    final httpResp = await httpCaller.get(BackendPath.getAllSessions.http);

    return httpResp.listToResponse((e) => DevicesManagerModel.fromMap(e))?.toList();
  }

  /// [Hybrid]
  Future<void> logoutFromDevice({String? sessionId, bool isRemoveAll = false}) async {
    if (socketCaller.isReadyForCall) {
      try {
        await socketCaller.emitCall(
          BackendPath.deleteSessions.socket,
          {
            'sessionId': isRemoveAll ? null : sessionId,
            'isRejectAll': isRemoveAll,
          },
        );

        return;
      } catch (e, stackTrace) {
        _log.w('logoutFromDevice with socket error. fallback to http request...', e, stackTrace);
      }
    }

    // Fallback to http caller
    await httpCaller.delete(
      BackendPath.deleteSessions.http,
      data: {
        'sessionId': isRemoveAll ? null : sessionId,
        'isRejectAll': isRemoveAll,
      },
    );
  }

  /// Get public key and private key of the current user.
  Future<AuthLoginResponse?> linkAccountWithGoogleAccount(String token) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithGoogleAccount.socket,
          {'token': token},
        );

        return socketResp.mapToResponse<AuthLoginResponse>(
          (data) => AuthLoginResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('linkAccountWithGoogle with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.linkAccountWithGoogleAccount.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  /// [Hybrid]
  Future<UserCollection?> unlinkAccountWithGoogleAccount() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.unlinkAccountWithGoogleAccount.socket,
          {},
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('unlinkAccountWithGoogle with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(BackendPath.unlinkAccountWithGoogleAccount.http);

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<AuthLoginResponse?> signInByGoogleAccount(String token) async {
    final httpResp = await httpCaller.post(
      BackendPath.signInByGoogleAccount.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  Future<AuthLoginResponse?> linkAccountWithAppleId(String token) async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithAppleId.socket,
          {'token': token},
        );

        return socketResp.mapToResponse<AuthLoginResponse>(
          (data) => AuthLoginResponse.fromMap(data),
        );
      } catch (e, stackTrace) {
        _log.w('linkAccountWithAppleId with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.put(
      BackendPath.linkAccountWithAppleId.http,
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }

  Future<UserCollection?> unlinkAccountWithAppleId() async {
    if (socketCaller.isReadyForCall) {
      try {
        final socketResp = await socketCaller.emitCall(
          BackendPath.linkAccountWithAppleId.socket,
          {},
        );

        return socketResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
      } catch (e, stackTrace) {
        _log.w('unlinkAccountWithAppleId with socket error. fallback to http request...', e, stackTrace);
      }
    }

    final httpResp = await httpCaller.delete(
      BackendPath.unlinkAccountWithAppleId.http,
    );

    return httpResp.mapToResponse((data) => UserCollection.fromMap(data['account']));
  }

  Future<AuthLoginResponse?> signInByAppleId(String token) async {
    final httpResp = await httpCaller.post(
      'v2/auth/sign-in/apple',
      data: {'token': token},
    );

    return httpResp.mapToResponse<AuthLoginResponse>(
      (data) => AuthLoginResponse.fromMap(data),
    );
  }
}
