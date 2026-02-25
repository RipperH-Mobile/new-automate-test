import 'package:uchat/features/contact/data/models/requests/add_friend_in_group_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class AddFriendInGroupUseCase extends SimpleUseCase<ContactEntity, AddFriendInGroupRequest> {
  final ContactServerRepository contactServerRepository;

  AddFriendInGroupUseCase({
    required this.contactServerRepository,
  });

  @override
  Future<ContactEntity> call(AddFriendInGroupRequest params) async {
    return await contactServerRepository.addFriendInGroup(params);
  }
}
