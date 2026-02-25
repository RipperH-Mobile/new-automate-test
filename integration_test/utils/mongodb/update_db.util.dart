import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../mongodb/base/base_db.util.dart';
import '../common.util.dart';

class UpdateDbUtil {
  Future<dynamic> updatePasswordInAccount(
    String phoneNo,
    String password,
  ) async {
    final hashedPassword = CommonUtil.hashPassword(
      password,
      dotenv.env['ACCOUNT_SALT_PASSWORD'],
    );
    final filter = {'phoneNumber': phoneNo, 'deleted': false};
    final updateCondition = {
      '\$set': {'password': hashedPassword},
    };

    final dbResponse = await mongoUtil.updateDocuments(
      dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'],
      filter,
      updateCondition,
    );
    return dbResponse;
  }

  Future<dynamic> updateGroupPermissionInAccount(String phoneNo) async {
    final filter = {'phoneNumber': phoneNo, 'deleted': false};
    final updateCondition = {
      '\$set': {'features.groupPermission.enabled': true},
    };

    final dbResponse = await mongoUtil.updateDocuments(
      dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'],
      filter,
      updateCondition,
    );
    return dbResponse;
  }

  Future<dynamic> updateListReuseDeletedUserInAccount(List<Map<String, dynamic>> userList) async {
    var bulkOperations = userList.map((user) {
      Map<String, dynamic> updateData = {
        'username': user['username'],
        'password': user['hashedPassword'],
        'phoneNumber': user['phoneNumber'],
        'displayName': user['displayName'],
        'isUseGodMode': true,
        'deleted': user['deleted'],
        'features.groupPermission.enabled': true,
      };
      if (user.containsKey('email') && user['email'] != null) {
        updateData['email'] = user['email'];
      }
      return {
        'filter': {'_id': user['documentId']},
        'update': {'\$set': updateData}
      };
    }).toList();
    final dbResponse = await mongoUtil.updateDocumentsBulk(
      dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS']!,
      bulkOperations,
    );
    return dbResponse;
  }

  Future<dynamic> deleteEmailFieldInAccount(String phoneNo) async {
    final filter = {'phoneNumber': phoneNo, 'deleted': false};
    final updateCondition = {
      '\$unset': {'email': ''},
    };

    final dbResponse = await mongoUtil.updateDocuments(
      dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'],
      filter,
      updateCondition,
    );
    return dbResponse;
  }

  Future<dynamic> deleteUserInAccount(String phoneNo) async {
    final filter = {'phoneNumber': phoneNo, 'deleted': false};
    final updateCondition = {
      '\$unset': {
        'username': '',
        'password': '',
        'phoneNumber': '',
        'displayName': '',
        'deleted': true,
      },
    };

    final dbResponse = await mongoUtil.updateDocuments(
      dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'],
      filter,
      updateCondition,
    );
    return dbResponse;
  }
}
