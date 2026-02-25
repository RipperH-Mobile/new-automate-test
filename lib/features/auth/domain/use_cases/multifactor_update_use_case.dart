import 'package:uchat/features/auth/data/models/requests/multifactor_update_setting_request.dart';
import 'package:uchat/features/auth/domain/repositories/auth_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class MultifactorUpdateUseCase extends SimpleUseCase<void, MultifactorUpdateSettingRequest> {
  final AuthServerRepository repository;

  MultifactorUpdateUseCase({required this.repository});

  @override
  Future<void> call(MultifactorUpdateSettingRequest params) async {
    return repository.multifactorUpdate(params);
  }
}
