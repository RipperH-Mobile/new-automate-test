import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/data/models/requests/check_if_requesting_friend_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class CheckIfRequestingFriendUseCase
    extends SimpleUseCase<CheckIfRequestingFriendResponse?, CheckIfRequestingFriendRequest> {
  ContactServerRepository get contactServerRepository {
    return GetIt.I<ContactServerRepository>();
  }

  @override
  Future<CheckIfRequestingFriendResponse?> call(CheckIfRequestingFriendRequest params) async {
    return await contactServerRepository.checkIfRequestingFriend(params);
  }
}
