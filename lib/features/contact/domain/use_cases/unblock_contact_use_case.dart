import 'package:uchat/features/contact/data/models/requests/unblock_contact_request.dart';
import 'package:uchat/features/contact/domain/params/unblock_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class UnblockContactUseCase extends SimpleUseCase<void, UnblockContactParams> {
  final ContactServerRepository contactServerRepository;

  UnblockContactUseCase({
    required this.contactServerRepository,
  });

  @override
  Future<void> call(UnblockContactParams params) async {
    return await contactServerRepository.unblockContact(
      UnblockContactRequest(
        friendAccountIds: params.contactIds,
      ),
    );
  }
}
