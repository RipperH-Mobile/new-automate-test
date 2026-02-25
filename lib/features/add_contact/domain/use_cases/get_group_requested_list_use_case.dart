import 'package:get_it/get_it.dart';
import 'package:uchat/api/payloads/pagination/pagination_payload.dart';
import 'package:uchat/features/add_contact/data/model/requested_list_request.dart';
import 'package:uchat/features/add_contact/domain/entities/add_contact_group_requested_entity.dart';
import 'package:uchat/use_cases/use_case.dart';

import '../repositories/add_contact_server_repository.dart';

class GetGroupRequestedListUseCase
    extends SimpleUseCase<PaginationPayload<AddContactGroupRequestedEntity>?, GetRequestedListRequest> {
  AddContactServerRepository get addContactServerRepository {
    return GetIt.I.get<AddContactServerRepository>();
  }

  @override
  Future<PaginationPayload<AddContactGroupRequestedEntity>?> call(GetRequestedListRequest param) async {
    final res = await addContactServerRepository.getGroupRequestedList(param);

    return res?.toEntity(
      (models) => models.map((e) => e.toEntity()).toList(),
    );
  }
}
