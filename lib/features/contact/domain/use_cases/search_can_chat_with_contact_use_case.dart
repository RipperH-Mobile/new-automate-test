import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SearchCanChatWithContactUseCase extends SimpleUseCase<List<ContactEntity>, String> {
  final ContactLocalRepository contactLocalRepository;

  SearchCanChatWithContactUseCase({
    required this.contactLocalRepository,
  });
  
  @override
  Future<List<ContactEntity>> call(String query) async {
    return await contactLocalRepository.searchCanChatWithContact(query);
  }
}
