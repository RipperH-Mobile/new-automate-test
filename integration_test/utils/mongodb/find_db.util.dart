import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../mongodb/base/base_db.util.dart';
import '../common.util.dart';

class FindDbUtil {
  Future<Map<String, dynamic>?> _findOne(
    String? collectionName,
    Map<String, dynamic> filter, {
    bool? isGetLatest,
  }) async {
    if (collectionName == null) {
      throw Exception('Environment variable $collectionName is not set.');
    }
    final output = await mongoUtil.findDocuments(
      collectionName,
      filter,
      isSort: isGetLatest,
    );
    return output.isNotEmpty ? output.first : null;
  }

  Future<List<Map<String, dynamic>>> _findMany(collectionName, Map<String, dynamic> filter,
      {bool? isGetLatest, int? limit}) async {
    if (collectionName == null) {
      throw Exception('Environment variable $collectionName is not set.');
    }
    return await mongoUtil.findDocuments(collectionName, filter, isSort: isGetLatest, limit: limit);
  }

  Future<String> getOtpByPhone(
    String phoneNo, {
    bool isGetLatest = false,
  }) async {
    final filter = {'phoneNumber': phoneNo};
    final dbOutput = await _findOne(
      dotenv.env['DB_MONGO_COLLECTION_SMS_LOGS'],
      filter,
      isGetLatest: isGetLatest,
    );
    return await CommonUtil.extractOtpTextFromDb(true, dbOutput);
  }

  Future<String> getOtpByEmail(String email, {bool isGetLatest = false}) async {
    final filter = {
      'toAddresses': email,
      'subject': 'OTP for verifying your identity',
    };
    final dbOutput = await _findOne(
      dotenv.env['DB_MONGO_COLLECTION_EMAIL_LOGS'],
      filter,
      isGetLatest: isGetLatest,
    );
    return await CommonUtil.extractOtpTextFromDb(false, dbOutput);
  }

  Future<dynamic> getDetailByPhoneInAccount(
    String phoneNo, {
    bool isGetLatest = false,
  }) async {
    final filter = {'phoneNumber': phoneNo, 'deleted': false};
    final dbOutput = await _findOne(
      dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'],
      filter,
      isGetLatest: isGetLatest,
    );
    return dbOutput;
  }

  Future<dynamic> getListDetailByPhoneInAccount(
    List<String> phoneList, {
    bool isGetLatest = false,
  }) async {
    final filter = {
      'phoneNumber': {'\$in': phoneList},
      'deleted': false
    };
    final dbOutput =
        await _findMany(dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'], filter, isGetLatest: isGetLatest, limit: 0);
    return dbOutput;
  }

  Future<dynamic> getListLatestDeletedUserInAccount(int limit) async {
    final filter = {
      'type': 'NORMAL',
      'displayName': 'Deleted User',
      'deleted': true,
      'publicKey': {
        '\$nin': [null, '']
      },
      'privateKey': {
        '\$nin': [null, '']
      }
    };
    final dbOutput =
        await _findMany(dotenv.env['DB_MONGO_COLLECTION_ACCOUNTS'], filter, isGetLatest: true, limit: limit);
    return dbOutput;
  }
}
