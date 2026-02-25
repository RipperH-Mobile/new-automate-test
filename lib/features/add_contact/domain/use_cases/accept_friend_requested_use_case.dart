import 'package:get_it/get_it.dart';
import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/domain/contact_domain.dart';

class AcceptFriendRequestedUseCase {
  ContactServerRepository get contactServerRepository {
    return GetIt.I.get<ContactServerRepository>();
  }

  Future<AddContactResponse?> call(AddContactRequest request) async {
    return await contactServerRepository.addContact(request);
  }
}
