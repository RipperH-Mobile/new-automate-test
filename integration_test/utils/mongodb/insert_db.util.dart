import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../mongodb/base/base_db.util.dart';

class InsertDbUtil {
  Future<dynamic> insert(String? collectionName, dynamic data) async {
    if (collectionName == null) {
      throw Exception('Environment variable $collectionName is not set.');
    }
    if (data == null) {
      throw Exception('Error: Data to insert cannot be null.');
    }

    if (data is List && data.isEmpty) {
      debugPrint('⚠️ Warning: Data list is empty. Nothing to insert.');
      return null;
    }

    try {
      final result = await mongoUtil.insertDocuments(collectionName, data);
      if (result is BulkWriteResult) {
        // --- กรณี Insert Many (List) ---
        if (result.isSuccess) {
          debugPrint('✅ Insert Many Success: Inserted ${result.nInserted} documents.');
          return result;
        } else {
          debugPrint('❌ Insert Many Failed/Partial Error.');
          debugPrint('Errors: ${result.writeErrors}');
          throw Exception('Bulk insert failed with errors.');
        }
      } else if (result is Map) {
        // --- กรณี Insert One (Map) ---
        if (result['ok'] == 1.0 && result['err'] == null) {
          debugPrint('✅ Insert One Success.');
          return result;
        } else {
          debugPrint('❌ Insert One Failed: ${result['err']}');
          throw Exception('Insert failed: ${result['err']}');
        }
      }
      return result;
    } catch (e) {
      debugPrint('❌ Critical Error during insert: $e');
      rethrow;
    }
  }
}
