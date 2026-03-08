import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

import '../firebase_options_dev.dart' as dev;
import '../firebase_options_sit.dart' as sit;
import '../firebase_options_uat.dart' as uat;


FirebaseOptions getConfig() {
  final flavor = appFlavor ?? 'prd';

  switch (flavor) {
    case 'dev':
      return dev.DefaultFirebaseOptions.currentPlatform;
    case 'sit':
      return sit.DefaultFirebaseOptions.currentPlatform;
    case 'uat':
      return uat.DefaultFirebaseOptions.currentPlatform;
    // case 'prd':
    //   return prd.DefaultFirebaseOptions.currentPlatform;
    default:
      throw Exception('$flavor not supported');
  }
}
