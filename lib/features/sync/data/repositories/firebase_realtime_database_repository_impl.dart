import 'package:uchat/features/sync/data/data_source/remote/firebase_realtime_database_service.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/features/sync/domain/repositories/firebase_realtime_database_repository.dart';

class FirebaseRealtimeDatabaseRepositoryImpl extends FirebaseRealtimeDatabaseRepository {
  final FirebaseRealtimeDatabaseService firebaseRealtimeDatabaseService;

  FirebaseRealtimeDatabaseRepositoryImpl({
    required this.firebaseRealtimeDatabaseService,
  });

  @override
  Future<List<UpdateStateModel>> fetchSpecificFirebaseState(int start, int end, String group) async {
    return await firebaseRealtimeDatabaseService.fetchSpecificFirebaseState(start, end, group);
  }
}
