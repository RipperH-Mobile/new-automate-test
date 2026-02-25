import 'dart:io';
import 'package:path/path.dart' as p;

final sourceDir = Directory('integration_test/test_data');
final targetDir = Directory('assets/temp_test_data');

void main(List<String> args) {
  if (args.isEmpty) {
    stdout.writeln('Usage: dart run scripts/prepare_test_assets.dart [setup|teardown]');
    exit(1);
  }

  final command = args[0];
  final env = args[1];
  final featureFolder = args[2];

  if (command == 'setup') {
    setupAssets(env, featureFolder);
  } else if (command == 'teardown') {
    teardownAssets();
  } else {
    stdout.writeln('Unknown command: $command');
    exit(1);
  }
}

void setupAssets(String env, String featureFolder) {
  final sourceDirPath = p.join('integration_test', 'test_data', env, featureFolder);
  final sourceDir = Directory(sourceDirPath);
  final targetDir = Directory(p.join('assets', 'temp_test_data'));
  if (!sourceDir.existsSync()) {
    stdout.writeln('❌ Source directory not found: ${sourceDir.path}');
    return;
  }
  if (targetDir.existsSync()) {
    try {
      targetDir.deleteSync(recursive: true);
    } catch (e) {
      stdout.writeln('⚠️ Warning: Could not delete existing target dir: $e');
    }
  }
  targetDir.createSync(recursive: true);
  sourceDir.listSync(recursive: true).forEach((sourceEntity) {
    if (sourceEntity is File) {
      final relativePath = p.relative(sourceEntity.path, from: sourceDir.path);
      final targetFilePath = p.join(targetDir.path, relativePath);
      File(targetFilePath).parent.createSync(recursive: true);
      sourceEntity.copySync(targetFilePath);
      stdout.writeln('   📄 Copied: $relativePath');
    }
  });

  stdout.writeln('✅ Successfully prepared assets for "$featureFolder" ($env)');
  stdout.writeln('   From: ${sourceDir.path}');
  stdout.writeln('   To:   ${targetDir.path}');
}

void teardownAssets() {
  if (targetDir.existsSync()) {
    targetDir.deleteSync(recursive: true);
    stdout.writeln('🗑️ Test assets cleaned up from ${targetDir.path}');
  } else {
    stdout.writeln('No temporary assets to clean up.');
  }
}