import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/auth/data/models/requests/get_sessions_list_request.dart';
import 'package:uchat/features/auth/data/models/responses/get_sessions_list_response.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetSessionsListUseCase
    extends SimpleUseCase<PaginationPayload<GetSessionsListResponse>?, GetSessionsListRequest> {
  final AuthServerRepository authServerRepository;

  GetSessionsListUseCase({required this.authServerRepository});

  @override
  Future<PaginationPayload<GetSessionsListResponse>?> call(GetSessionsListRequest params) async {
    return await authServerRepository.getSessionsList(params);
  }
}
