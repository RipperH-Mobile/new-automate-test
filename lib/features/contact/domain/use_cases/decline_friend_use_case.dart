import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class DeclineFriendUseCase extends SimpleUseCase<void, DeclineFriendRequest> {
  ContactServerRepository get contactServerRepository {
    return GetIt.I<ContactServerRepository>();
  }

  @override
  Future<void> call(DeclineFriendRequest params) async {
    return await contactServerRepository.declineFriendRequest(params);
  }
}
