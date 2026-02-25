import 'package:get_it/get_it.dart';
import 'package:uchat/features/add_contact/domain/repositories/add_contact_server_repository.dart';
import 'package:uchat/features/contact/data/models/requests/reject_group_requested_request.dart';

class RejectGroupRequestedUseCase {
  AddContactServerRepository get addContactServerRepository {
    return GetIt.I.get<AddContactServerRepository>();
  }

  Future<void> call(RejectGroupRequestedRequest request) async {
    return await addContactServerRepository.rejectGroupRequest(request);
  }
}
