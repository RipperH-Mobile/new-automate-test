import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/data/models/requests/reject_friend_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeleteContactUseCase extends SimpleUseCase<void, RejectFriendRequest> {
  ContactServerRepository get contactServerRepository {
    return GetIt.I<ContactServerRepository>();
  }

  @override
  Future<void> call(RejectFriendRequest params) async {
    return await contactServerRepository.deleteContact(params);
  }
}
