import 'package:uchat/features/contact/data/models/requests/unhide_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UnhideContactUseCase extends SimpleUseCase<void, UnHideContactRequest> {
  final ContactServerRepository contactServerRepository;

  UnhideContactUseCase({
    required this.contactServerRepository,
  });

  @override
  Future<void> call(UnHideContactRequest params) async {
    return await contactServerRepository.unHideContact(params);
  }
}
