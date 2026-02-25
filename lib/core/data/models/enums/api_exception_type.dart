enum ApiExceptionType {
  /// NOTE: Add more exception types as needed here

  /// The request was successful, but the server returned an error.
  success,

  /// The request was not successful due to a client-side error.
  clientError,

  /// The request was not successful due to a server-side error.
  serverError,

  /// The request was not successful due to a network error.
  networkError,

  /// The request was not successful due to an unknown error.
  unknownError,

  /// The request was not successful due to a timeout error.
  timeoutError,

  /// The request was not successful due to an invalid response.
  invalidResponseError,

  /// The request was not successful due to an message ref duplicate error.
  messageRefDuplicateError,

  notFound,

  permissionDenied,

  // ERR_ROOM_ACCOUNT_ALREADY_INVITE_IN_ROOM
  accountAlreadyInviteInRoom,

  //ERR_ROOM_MEMBER_EXCEED_LIMIT
  roomMemberExceedLimit,

  roomInviteLinkInvalid,
  roomNotFound,
  roomAccountAlreadyInRoom,
  roomAccountAlreadyRequestedToJoin,

  errorAccountHasBeenDeleted;

  String get value {
    switch (this) {
      case ApiExceptionType.success:
        return 'SUCCESS';
      case ApiExceptionType.clientError:
        return 'CLIENT_ERROR';
      case ApiExceptionType.serverError:
        return 'SERVER_ERROR';
      case ApiExceptionType.networkError:
        return 'NETWORK_ERROR';
      case ApiExceptionType.unknownError:
        return 'UNKNOWN_ERROR';
      case ApiExceptionType.timeoutError:
        return 'TIMEOUT_ERROR';
      case ApiExceptionType.invalidResponseError:
        return 'INVALID_RESPONSE_ERROR';
      case ApiExceptionType.messageRefDuplicateError:
        return 'ERR_MESSAGE_REF_DUPLICATE';
      case ApiExceptionType.notFound:
        return 'ERR_NOT_FOUND';
      case ApiExceptionType.permissionDenied:
        return 'ERR_PERMISSION_DENIED';
      case ApiExceptionType.accountAlreadyInviteInRoom:
        return 'ERR_ROOM_ACCOUNT_ALREADY_INVITE_IN_ROOM';
      case ApiExceptionType.roomMemberExceedLimit:
        return 'ERR_ROOM_MEMBER_EXCEED_LIMIT';
      case ApiExceptionType.roomInviteLinkInvalid:
        return 'ERR_ROOM_INVITE_LINK_INVALID';
      case ApiExceptionType.roomNotFound:
        return 'ERR_ROOM_NOT_FOUND';
      case ApiExceptionType.roomAccountAlreadyInRoom:
        return 'ERR_ROOM_ACCOUNT_ALREADY_IN_ROOM';
      case ApiExceptionType.roomAccountAlreadyRequestedToJoin:
        return 'ERR_ROOM_ACCOUNT_ALREADY_REQUESTED_TO_JOIN';
      case ApiExceptionType.errorAccountHasBeenDeleted:
        return 'ERR_ACCOUNT_HAS_BEEN_DELETED';
    }
  }

  static ApiExceptionType from(String? val) {
    switch (val) {
      case 'SUCCESS':
        return ApiExceptionType.success;
      case 'CLIENT_ERROR':
        return ApiExceptionType.clientError;
      case 'SERVER_ERROR':
        return ApiExceptionType.serverError;
      case 'NETWORK_ERROR':
        return ApiExceptionType.networkError;
      case 'UNKNOWN_ERROR':
        return ApiExceptionType.unknownError;
      case 'TIMEOUT_ERROR':
        return ApiExceptionType.timeoutError;
      case 'INVALID_RESPONSE_ERROR':
        return ApiExceptionType.invalidResponseError;
      case 'ERR_MESSAGE_REF_DUPLICATE':
        return ApiExceptionType.messageRefDuplicateError;
      case 'ERR_NOT_FOUND':
        return ApiExceptionType.notFound;
      case 'ERR_PERMISSION_DENIED':
        return ApiExceptionType.permissionDenied;
      case 'ERR_ROOM_ACCOUNT_ALREADY_INVITE_IN_ROOM':
        return ApiExceptionType.accountAlreadyInviteInRoom;
      case 'ERR_ROOM_MEMBER_EXCEED_LIMIT':
        return ApiExceptionType.roomMemberExceedLimit;
      case 'ERR_ROOM_INVITE_LINK_INVALID':
        return ApiExceptionType.roomInviteLinkInvalid;
      case 'ERR_ROOM_NOT_FOUND':
        return ApiExceptionType.roomNotFound;
      case 'ERR_ROOM_ACCOUNT_ALREADY_IN_ROOM':
        return ApiExceptionType.roomAccountAlreadyInRoom;
      case 'ERR_ROOM_ACCOUNT_ALREADY_REQUESTED_TO_JOIN':
        return ApiExceptionType.roomAccountAlreadyRequestedToJoin;
      case 'ERR_ACCOUNT_HAS_BEEN_DELETED':
        return ApiExceptionType.errorAccountHasBeenDeleted;
      default:
        return ApiExceptionType.unknownError;
    }
  }
}
