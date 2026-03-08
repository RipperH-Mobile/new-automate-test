import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uchat/core/infrastructure/app/app.dart';
import 'package:uchat/core/infrastructure/orchestrator/orchestrator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  await Orchestrator.run(OrchestratorTaskType.initializeApp);

  // Running the app
  // This is the main entry point of the app.
  await App.initialize();
  await App.run();

  // And check database version to migration.
  await Orchestrator.run(OrchestratorTaskType.launchApp);
}
