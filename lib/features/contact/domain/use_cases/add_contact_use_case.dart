import 'package:uchat/features/contact/data/models/requests/add_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AddContactUseCase extends SimpleUseCase<AddContactResponse, AddContactRequest> {
  final ContactServerRepository contactServerRepository;

  AddContactUseCase({
    required this.contactServerRepository,
  });

  @override
  Future<AddContactResponse> call(AddContactRequest params) async {
    final response = await contactServerRepository.addContact(params);
    return response;
  }
}
