import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/features/contact/domain/use_cases/get_contact_use_case.dart';
import 'package:uchat/features/contact/domain/use_cases/update_nickname_use_case.dart';

import '../controllers/profile_nickname_controller.dart';

class ProfileNicknameBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileNicknameController>(
      ProfileNicknameController(
        accountId: Get.parameters['id'] ?? '',
        getContactUseCase: GetIt.I<GetContactUseCase>(),
        updateNicknameUseCase: GetIt.I<UpdateNicknameUseCase>(),
        taxonomyService: GetIt.I<TaxonomyService>(),
      ),
    );
  }
}
