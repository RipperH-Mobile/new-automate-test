import 'package:patrol/patrol.dart';
import 'package:flutter/material.dart';

void main() {
  patrolTest('Mongodb test', ($) async {
    debugPrint('---patrolTest---');
    try{  
      //throw Exception('ข้อความแจ้งเตือนข้อผิดพลาด');
    }catch(e){
      debugPrint('---fail---');
      rethrow;
    }finally{
      debugPrint('---finally---');
    }
  });
}