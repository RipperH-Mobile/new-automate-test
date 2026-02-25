import 'package:uchat/features/call/domain/params/ringing_call_param.dart';
import 'package:uchat/features/call/domain/repositories/calling_server_repository.dart';
import 'package:uchat/use_cases/use_case.dart';

class RingingCallUseCase extends SimpleUseCase<void, RingingCallParam> {
  RingingCallUseCase({
    required this.callingServerRepository,
  });

  final CallingServerRepository callingServerRepository;

  @override
  Future<void> call(RingingCallParam params) async {}
}
