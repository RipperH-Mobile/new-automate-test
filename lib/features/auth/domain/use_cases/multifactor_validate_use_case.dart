import 'package:uchat/features/auth/data/models/requests/multifactor_validate_setting_request.dart';
import 'package:uchat/features/auth/domain/entities/multifactor_validate_entity.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class MultifactorValidateUseCase extends SimpleUseCase<MultifactorValidateEntity, MultifactorValidateSettingRequest> {
  final AuthServerRepository repository;

  MultifactorValidateUseCase({required this.repository});

  @override
  Future<MultifactorValidateEntity> call(MultifactorValidateSettingRequest params) async {
    return repository.multifactorValidate(params);
  }
}
