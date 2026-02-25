import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';

abstract class FirebaseRealtimeDatabaseRepository {
  Future<List<UpdateStateModel>> fetchSpecificFirebaseState(int start, int end, String group);
}
