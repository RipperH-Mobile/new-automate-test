import 'package:uchat/features/contact/data/models/requests/search_contact_request.dart';
import 'package:uchat/features/contact/domain/repositories/contact_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class SearchContactUseCase extends SimpleUseCase<SearchContactResponse, SearchContactRequest> {
  final ContactServerRepository contactServerRepository;

  SearchContactUseCase({
    required this.contactServerRepository,
  });
  
  @override
  Future<SearchContactResponse> call(SearchContactRequest params) async {
    return await contactServerRepository.searchContact(params);
  }
}
