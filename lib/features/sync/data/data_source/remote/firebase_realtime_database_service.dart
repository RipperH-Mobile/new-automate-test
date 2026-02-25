import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:uchat/controllers.dart';

import 'package:uchat/core/infrastructure/analytics/logger_service.dart';
import 'package:uchat/core/infrastructure/analytics/taxonomy_service.dart';
import 'package:uchat/entities/services/config_db.dart';
import 'package:uchat/features/auth/domain/params/sign_in_to_firebase_params.dart';
import 'package:uchat/features/auth/domain/use_cases/sign_in_to_firebase_use_case.dart';
import 'package:uchat/features/sync/data/models/entities/update_state_model.dart';
import 'package:uchat/features/sync/domain/repositories/sync_server_repository.dart';
import 'package:uchat/features/sync/domain/services/sync_service.dart';
import 'package:uchat/utils/app_env.dart';
import 'package:uchat/utils/datetime.dart';

final _log = useLogger();

class FirebaseRealtimeDatabaseService {
  StreamSubscription? _firebaseStateListener;

  FirebaseDatabase get database {
    return FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: AppEnv.firebaseStateDbUrl,
    );
  }

  ConfigDb get configDb {
    return GetIt.I<ConfigDb>();
  }

  void initListener() async {
    _log.d('Initializing Firebase Realtime Database state update listener...');
    final accountId = UserController.instance.currentUser()?.id;
    if (accountId == null) {
      _log.e('Initialize Firebase Realtime Database state update listener failed. accountId is null');
      return;
    }

    final dbRef = 'state/$accountId';
    String? lastCreatedAt = await configDb.authenticated.getString(key: ConfigDb.getLastFirebaseStateCreatedAtKey());
    if (lastCreatedAt != null) {
      // Check whether the last state that this device received is still in firebase.
      // If not, That means this device hasn't received new state for a long time and should re-initialize the state.
      final result = await database.ref(dbRef).orderByChild('createdAt').equalTo(lastCreatedAt).once();
      if (result.snapshot.value == null) {
        _log.d('State data is not found in firebase. Re-initializing the state data...');
        GetIt.I<SyncService>().addInitQueue();
      }
    }

    try {
      Query stateRef;
      // Only get newer states if this devices has already received some states to reduce data usage.
      if (lastCreatedAt != null) {
        stateRef = database.ref(dbRef).orderByChild('createdAt').startAfter(lastCreatedAt);
      } else {
        stateRef = database.ref(dbRef).orderByChild('createdAt');
      }
      _firebaseStateListener = stateRef.onChildAdded.listen((DatabaseEvent event) {
        if (!UserController.instance.useFirebaseState) return;
        try {
          // Because data from firebase is Map<Object?, Object?>, we need to convert it to Map<String, dynamic>.
          // Convert Map<Object?, Object?> to Map<String, dynamic>.
          final stateMap = convertToMapStringDynamic(event.snapshot.value as Map);

          // Convert Map<String, dynamic> to UpdateStateModel.
          final state = UpdateStateModel.fromMap(stateMap);

          GetIt.I<TaxonomyService>().sendEvent(
            EventName.receiveStateFromFirebase,
            eventProperties: EventProperty.stateReceived(state),
          );

          if (stateMap['createdAt'] != null) {
            updateLastFirebaseStateCreatedAt(stateMap['createdAt']);
          }

          // Add state to the process queue.
          GetIt.I<SyncService>().addState(state);
        } catch (e, stackTrace) {
          _log.e('State data conversion error', e, stackTrace);
        }
      });
    } catch (e, stackTrace) {
      _log.e('Initial Firebase Realtime Database state update listener error', e, stackTrace);
    }
  }

  void onClearListener() {
    _firebaseStateListener?.cancel();
    _firebaseStateListener = null;
  }

  Map<String, dynamic> convertToMapStringDynamic(Map input) {
    return input.map((key, value) {
      final newKey = key.toString();
      if (value is Map && value is! Map<String, dynamic>) {
        // If value is a Map (If there is a map within a map), convert it to Map<String, dynamic>.
        return MapEntry(newKey, convertToMapStringDynamic(value));
      } else if (value is List<Object?>) {
        if (value.firstOrNull is Map) {
          // If value is a List of object, convert each element to Map<String, dynamic>.
          return MapEntry(newKey, value.whereType<Map>().map((e) => convertToMapStringDynamic(e)).toList());
        } else if (value.firstOrNull is String) {
          return MapEntry(newKey, value.cast<String>());
        } else {
          _log.w(
              'Firebase state data is not in the expected format. key is $key value is $value type is ${value.runtimeType}');
          return MapEntry(newKey, value);
        }
      } else {
        return MapEntry(newKey, value);
      }
    });
  }

  void updateLastFirebaseStateCreatedAt(String createdAtStr) async {
    final createdAt = strToDateTime(createdAtStr);
    if (createdAt == null) return;
    final oldCreatedAtStr = await configDb.authenticated.getString(key: ConfigDb.getLastFirebaseStateCreatedAtKey());
    if (oldCreatedAtStr != null) {
      final oldCreatedAt = strToDateTime(oldCreatedAtStr);
      // If data in local db is newer than the data from Firebase, do not update.
      if (oldCreatedAt != null && oldCreatedAt.isAfter(createdAt)) return;
    }
    // Save createdAt as string in local db because we want date time format to not change and used as is for firebase query.
    await configDb.authenticated.saveConfig(
      key: ConfigDb.getLastFirebaseStateCreatedAtKey(),
      value: createdAtStr,
    );
  }

  Future<List<UpdateStateModel>> fetchSpecificFirebaseState(int start, int end, String group) async {
    final accountId = UserController.instance.currentUser()?.id;
    if (accountId == null) {
      _log.e('fetchSpecificFirebaseState failed. accountId is null');
      return [];
    }
    final dbRef = 'state/$accountId';
    final startAt = '$group-$start';
    final endAt = '$group-$end';
    final data = await database.ref(dbRef).orderByChild('firebaseSeq').startAt(startAt).endAt(endAt).once();
    // Convert list of Map<Object?, Object?> to Map<String, dynamic>.
    final stateList = convertToMapStringDynamic(data.snapshot.value as Map);
    final result = stateList.mapTo((key, value) {
      // Convert Map<String, dynamic> to UpdateStateModel.
      return UpdateStateModel.fromMap(value);
    }).toList();

    return result;
  }

  /// Check if the user is logged in to Firebase and sign in if not.
  Future<void> checkIsLoggedInToFirebase() async {
    if (FirebaseAuth.instance.currentUser != null) return;
    try {
      final userId = UserController.instance.currentUser()?.id;
      if (userId == null) {
        _log.e('checkIsLoggedInToFirebase failed. userId is null');
        return;
      }
      String firebaseToken = await GetIt.I<SyncServerRepository>().getFirebaseToken();
      await GetIt.I<SignInToFirebaseUseCase>().call(SignInToFirebaseParams(
        signInUserId: userId,
        token: firebaseToken,
      ));
    } catch (e, stackTrace) {
      _log.e('sign in to firebase error.', e, stackTrace);
    }
  }
}
