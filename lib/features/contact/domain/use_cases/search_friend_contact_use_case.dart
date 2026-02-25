import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_friend_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SearchFriendContactUseCase extends SimpleUseCase<List<ContactEntity>, SearchFriendContactParams> {
  final ContactLocalRepository contactLocalRepository;

  SearchFriendContactUseCase({
    required this.contactLocalRepository,
  });

  @override
  Future<List<ContactEntity>> call(SearchFriendContactParams params) async {
    return await contactLocalRepository.searchFriendContact(params);
  }
}
