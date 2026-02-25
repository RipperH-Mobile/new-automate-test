import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';

import '../../data/model/invited_list_request.dart';
import '../entities/add_contact_invited_entity.dart';
import '../repositories/add_contact_server_repository.dart';

class GetGroupInvitedListUseCase {
  AddContactServerRepository get addContactServerRepository {
    return GetIt.I.get<AddContactServerRepository>();
  }

  Future<PaginationPayload<AddContactInvitedEntity>?> call(InvitedListRequest request) async {
    final res = await addContactServerRepository.getGroupInvitedList(request);

    return res?.toEntity(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }
}
