import 'dart:async';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class MongoUtil {
  Db? _db;
  final String? _MONGODB_URI = dotenv.env['DB_MONGO_URL'];
  static final MongoUtil _instance = MongoUtil._internal();
  factory MongoUtil() {
    return _instance;
  }
  MongoUtil._internal();
  Future<void> connectDb() async {
    if (_MONGODB_URI == null || _MONGODB_URI!.isEmpty) {
      throw Exception("MONGODB_URI is not defined. Ensure it's set in your environment variables.");
    }
    if (_db != null && _db!.isConnected) {
      debugPrint('Already connected to MongoDB.');
      return;
    }
    try {
      debugPrint('Creating Db instance...');
      _db = await Db.create(_MONGODB_URI!);
      debugPrint('Opening connection to MongoDB (5s timeout)...');
      await _db!.open().timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw TimeoutException('Connection to MongoDB timed out after 5 seconds.');
        },
      );
      debugPrint('Successfully connected to MongoDB.');
    } on TimeoutException catch (e) {
      debugPrint('Connection Error: $e');
      _db = null;
      rethrow;
    } catch (e) {
      debugPrint('Failed to connect to MongoDB: $e');
      _db = null;
      rethrow;
    }
  }

  Future<void> disconnectDb() async {
    if (_db != null && _db!.isConnected) {
      await _db!.close();
      _db = null;
      debugPrint('Successfully disconnected from MongoDB.');
    }
  }

  Future<dynamic> insertDocuments(collectionName, data) async {
    final collection = _db!.collection(collectionName);
    try {
      if (data is List) {
        final List<Map<String, dynamic>> parsedData = data.map((e) => Map<String, dynamic>.from(e)).toList();
        var result = await collection.insertMany(parsedData);
        return result;
      } else if (data is Map) {
        final Map<String, dynamic> parsedData = Map<String, dynamic>.from(data);
        var result = await collection.insert(parsedData);
        return result;
      } else {
        throw Exception("Data format not supported. Must be Map or List.");
      }
    } catch (e) {
      debugPrint("Error inserting documents: $e");
      rethrow;
    }
  }

  Future<dynamic> findDocuments(collectionName, filter, {isSort = false, int? limit = 0}) async {
    final collection = _db!.collection(collectionName);
    var builder = where.raw({'\$query': filter});
    if (isSort) {
      builder = builder.sortBy('_id', descending: true);
    }
    if (limit! > 0) {
      builder = builder.limit(limit);
    }
    final results = await collection.find(builder).toList();
    return results;
  }

  Future<dynamic> updateDocuments(collectionName, filter, updateCondition) async {
    final collection = _db!.collection(collectionName);
    //var builder = where.raw({'\$query': filter});
    final results = await collection.updateMany(filter, updateCondition);
    debugPrint('---results---${results}');
    return results;
  }

  Future<dynamic> updateDocumentsBulk(String collectionName, updateList) async {
    final collection = _db!.collection(collectionName);
    List<Future> futures = [];
    for (var op in updateList) {
      futures.add(collection.updateOne(op['filter'], op['update']));
    }
    final results = await Future.wait(futures);
    return results;
  }
}

final mongoUtil = MongoUtil();
