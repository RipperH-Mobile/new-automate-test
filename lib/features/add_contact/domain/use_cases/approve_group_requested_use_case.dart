import 'package:get_it/get_it.dart';
import 'package:uchat/features/add_contact/domain/repositories/add_contact_server_repository.dart';
import 'package:uchat/features/contact/data/models/requests/approve_group_requested_request.dart';

class ApproveGroupRequestedUseCase {
  AddContactServerRepository get addContactServerRepository {
    return GetIt.I.get<AddContactServerRepository>();
  }

  Future<ApproveGroupRequestedResponse?> call(ApproveGroupRequestedRequest request) async {
    return await addContactServerRepository.approveGroupRequest(request);
  }
}
