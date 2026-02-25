import 'package:uchat/features/contact/data/models/requests/get_friend_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/get_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class GetFriendContactUseCase extends SimpleUseCase<List<ContactEntity>, GetFriendContactParams> {
  final ContactLocalRepository contactLocalRepository;
  
  GetFriendContactUseCase({
    required this.contactLocalRepository,
  });
  
  @override
  Future<List<ContactEntity>> call(GetFriendContactParams params) async {
    return await contactLocalRepository.getFriendContact(GetFriendContactRequest(
      limit: params.limit,
      notInIds: params.notInIds,
    ));
  }
}
