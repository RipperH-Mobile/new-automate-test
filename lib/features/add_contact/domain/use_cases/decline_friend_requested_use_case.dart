import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/data/models/requests/decline_friend_request.dart';
import 'package:uchat/features/contact/domain/contact_domain.dart';

class DeclineFriendRequestedUseCase {
  ContactServerRepository get contactServerRepository {
    return GetIt.I.get<ContactServerRepository>();
  }

  Future<void> call(DeclineFriendRequest request) async {
    await contactServerRepository.declineFriendRequest(request);
  }
}
