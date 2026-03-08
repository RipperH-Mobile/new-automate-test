import 'dart:developer';
import 'dart:io';

void main() {
  addAssets();
}

void addAssets() {
  log('📝 Configuring pubspec.yaml...');
  final f = File('pubspec.yaml');
  if (!f.existsSync()) {
    log('❌ Error: pubspec.yaml not found at project root.');
    exit(1);
  }
  final lines = f.readAsLinesSync().toList();
  bool hasAssets = lines.any((l) => l.trim().startsWith('- assets/temp_test_data/'));
  if (hasAssets) {
    log('   ✅ Assets already configured.');
    return;
  }
  int flutterIndex = lines.indexWhere((l) => l.startsWith('flutter:'));
  if (flutterIndex == -1) {
    lines.addAll(['', 'flutter:', '  assets:', '    - integration_test/', '    - assets/temp_test_data/']);
  } else {
    int assetsIndex = -1;
    for (int i = flutterIndex + 1; i < lines.length; i++) {
      if (lines[i].startsWith('  assets:')) {
        assetsIndex = i;
        break;
      }
      if (lines[i].trim().isNotEmpty && !lines[i].startsWith(' ') && !lines[i].startsWith('#')) break;
    }

    if (assetsIndex != -1) {
      lines.insert(assetsIndex + 1, '    - integration_test/');
      lines.insert(assetsIndex + 1, '    - assets/temp_test_data/');
    } else {
      lines.insert(flutterIndex + 1, '  assets:');
      lines.insert(flutterIndex + 2, '    - integration_test/');
      lines.insert(flutterIndex + 3, '    - assets/temp_test_data/');
    }
  }
  f.writeAsStringSync(lines.join('\n'));
  log('   ✅ Assets injected successfully.');
}

/*
import 'dart:io';

void main() {
  updatePubspecAssets();
}

void updatePubspecAssets() {
  log('📝 Scanning and updating assets in pubspec.yaml...');

  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    log('❌ Error: pubspec.yaml not found.');
    exit(1);
  }

  // ---------------------------------------------------------
  // 1. Scan หาโฟลเดอร์ย่อยทั้งหมด (Dynamic Scan)
  // ---------------------------------------------------------
  final rootAssetDir = Directory('assets/temp_test_data');
  List<String> newAssetLines = [];

  // เพิ่มรายการคงที่ (ถ้ามี)
  newAssetLines.add('    - integration_test/');

  if (rootAssetDir.existsSync()) {
    // 1.1 เพิ่มตัว root เอง
    newAssetLines.add('    - ${rootAssetDir.path.replaceAll('\\', '/')}/');

    // 1.2 วนลูปหา sub-directories ทั้งหมด (Recursive)
    final subDirs = rootAssetDir
        .listSync(recursive: true)
        .whereType<Directory>()
        .map((d) => '    - ${d.path.replaceAll('\\', '/')}/');

    newAssetLines.addAll(subDirs);
  } else {
    log('⚠️ Warning: ${rootAssetDir.path} does not exist. Skipping scan.');
  }

  // แปลงให้เป็น Unique (กันซ้ำ)
  newAssetLines = newAssetLines.toSet().toList();
  log('🔎 Found ${newAssetLines.length} asset paths.');

  // ---------------------------------------------------------
  // 2. อ่านและแก้ไขไฟล์ pubspec.yaml
  // ---------------------------------------------------------
  var lines = pubspecFile.readAsLinesSync();

  // 2.1 ลบ Asset เก่าที่เคย generate ไว้ทิ้งก่อน (เพื่อไม่ให้มันงอกซ้ำซ้อน)
  // ลบบรรทัดที่มี path ของ temp_test_data หรือ integration_test
  lines.removeWhere((line) {
    final trimmed = line.trim();
    return trimmed.startsWith('- assets/temp_test_data') || trimmed.startsWith('- integration_test/');
  });

  // 2.2 หาตำแหน่งที่จะแทรก (flutter: -> assets:)
  int flutterIndex = lines.indexWhere((l) => l.startsWith('flutter:'));

  if (flutterIndex == -1) {
    // กรณีไม่มี flutter: เลย (ไม่น่าเกิดขึ้นแต่กันไว้)
    lines.add('flutter:');
    lines.add('  assets:');
    lines.addAll(newAssetLines);
  } else {
    // หาบรรทัด assets: ที่อยู่ใต้ flutter:
    int assetsIndex = -1;
    for (int i = flutterIndex + 1; i < lines.length; i++) {
      if (lines[i].trim().startsWith('assets:')) {
        assetsIndex = i;
        break;
      }
      // ถ้าไปเจอบรรทัดอื่นที่ไม่ใช่ลูกของ flutter ให้หยุดหา
      if (lines[i].isNotEmpty && !lines[i].startsWith(' ') && !lines[i].startsWith('#')) {
        break;
      }
    }

    if (assetsIndex != -1) {
      // เจอ 'assets:' -> แทรกรายการใหม่เข้าไปข้างใต้
      lines.insertAll(assetsIndex + 1, newAssetLines);
    } else {
      // เจอ 'flutter:' แต่ไม่เจอ 'assets:' -> สร้าง assets: ใหม่
      lines.insert(flutterIndex + 1, '  assets:');
      lines.insertAll(flutterIndex + 2, newAssetLines);
    }
  }

  // ---------------------------------------------------------
  // 3. บันทึกไฟล์
  // ---------------------------------------------------------
  pubspecFile.writeAsStringSync(lines.join('\n'));
  log('✅ Successfully updated pubspec.yaml with dynamic assets.');
}
*/
