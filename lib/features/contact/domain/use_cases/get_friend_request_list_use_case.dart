import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/contact/data/models/requests/get_friend_request_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetFriendRequestListUseCase
    extends SimpleUseCase<PaginationPayload<ContactEntity>?, GetFriendRequestRequest> {
  final ContactServerRepository contactServerRepository;
  
  GetFriendRequestListUseCase({
    required this.contactServerRepository,
  });

  @override
  Future<PaginationPayload<ContactEntity>?> call(GetFriendRequestRequest params) async {
    return await contactServerRepository.getFriendRequestList(params);
  }
}
