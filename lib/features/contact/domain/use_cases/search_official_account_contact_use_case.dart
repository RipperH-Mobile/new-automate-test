import 'package:uchat/features/contact/data/models/requests/search_official_account_contact_request.dart';
import 'package:uchat/features/contact/domain/entities/contact_entity.dart';
import 'package:uchat/features/contact/domain/params/search_official_account_contact_params.dart';
import 'package:uchat/features/contact/domain/repositories/contact_local_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SearchOfficialAccountContactUseCase extends SimpleUseCase<List<ContactEntity>, SearchOfficialAccountContactParams> {
  final ContactLocalRepository contactLocalRepository;
  
  SearchOfficialAccountContactUseCase({
    required this.contactLocalRepository,
  });
  
  @override
  Future<List<ContactEntity>> call(SearchOfficialAccountContactParams params) async {
    return await contactLocalRepository.searchOfficialAccountContact(
      SearchOfficialAccountContactRequest(keyword: params.keyword, limit: params.limit),
    );
  }
}
