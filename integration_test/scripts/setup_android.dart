import 'dart:developer';
import 'dart:io';

void main() {
  copyAndroidTestPath();
  configBuildGradleFile();
  fixGradleToolchain();
}

void configBuildGradleFile() {
  log('🤖 Configuring Android Gradle (build.gradle.kts)...');
  final f = File('android/app/build.gradle.kts');
  if (!f.existsSync()) {
    log('⚠️ android/app/build.gradle.kts not found (Skipping Android setup)');
    return;
  }
  String content = f.readAsStringSync();
  bool isModified = false;
  if (!content.contains('androidx.test:orchestrator')) {
    if (content.contains('dependencies {')) {
      const orchestratorDep = '    androidTestUtil("androidx.test:orchestrator:1.5.1")';
      content = content.replaceFirst('dependencies {', 'dependencies {\n$orchestratorDep');
      log('   ✅ Added Orchestrator dependency.');
      isModified = true;
    } else {
      log('⚠️ dependencies block not found.');
    }
  } else {
    log('   ✅ Orchestrator dependency already exists.');
  }
  const patrolRunner = 'testInstrumentationRunner = "pl.leancode.patrol.PatrolJUnitRunner"';
  const patrolArgs = 'testInstrumentationRunnerArguments["clearPackageData"] = "true"';
  if (!content.contains(patrolRunner)) {
    final runnerRegExp = RegExp(r'testInstrumentationRunner\s*=\s*".*"');
    if (content.contains(runnerRegExp)) {
      content = content.replaceAll(runnerRegExp, patrolRunner);
      log('   ✅ Updated testInstrumentationRunner to Patrol.');
      isModified = true;
    } else {
      if (content.contains('defaultConfig {')) {
        content = content.replaceFirst('defaultConfig {', 'defaultConfig {\n        $patrolRunner');
        log('   ✅ Injected testInstrumentationRunner.');
        isModified = true;
      }
    }
  }
  if (!content.contains('clearPackageData')) {
    content = content.replaceFirst(patrolRunner, '$patrolRunner\n        $patrolArgs');
    log('   ✅ Added clearPackageData argument.');
    isModified = true;
  }
  // ---------------------------------------------------------
  const testOptionsBlock = '''
    testOptions {
        execution = "ANDROIDX_TEST_ORCHESTRATOR"
    }
''';
  if (!content.contains('ANDROIDX_TEST_ORCHESTRATOR')) {
    if (content.contains('testOptions {')) {
      content = content.replaceFirst(
        'testOptions {',
        'testOptions {\n        execution = "ANDROIDX_TEST_ORCHESTRATOR"',
      );
      log('   ✅ Added execution config to existing testOptions.');
    } else {
      if (content.contains('defaultConfig {')) {
        content = content.replaceFirst('android {', 'android {\n$testOptionsBlock');
        log('   ✅ Injected testOptions block.');
      }
    }
    isModified = true;
  } else {
    log('   ✅ testOptions already configured.');
  }
  if (isModified) {
    f.writeAsStringSync(content);
    log('🎉 Android build.gradle.kts updated successfully!');
  } else {
    log('   ℹ️ No changes needed.');
  }
}

void copyAndroidTestPath() {
  log('📂 Copying Android Test files...');
  final sourceFile = File('integration_test/setup/android/androidTest/java/MainActivityTest.java');
  final targetDir = Directory('android/app/src/androidTest/java');
  final targetFile = File('${targetDir.path}/MainActivityTest.java');
  if (!sourceFile.existsSync()) {
    log('❌ Source file not found: ${sourceFile.path}');
    exit(1);
  }
  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }
  sourceFile.copySync(targetFile.path);
  log('   ✅ Copied MainActivityTest.java to ${targetDir.path}');
}

void fixGradleToolchain() {
  log('☕ Configuring Gradle Java Toolchain Resolver (Kotlin DSL)...');
  File f = File('android/settings.gradle.kts');
  bool isKotlin = true;
  if (!f.existsSync()) {
    f = File('android/settings.gradle');
    isKotlin = false;
  }
  if (!f.existsSync()) {
    log('⚠️ android/settings.gradle(.kts) not found!');
    return;
  }
  String content = f.readAsStringSync();
  if (content.contains('foojay-resolver-convention')) {
    log('   ✅ Toolchain resolver already configured.');
    return;
  }
  String pluginLine;
  if (isKotlin) {
    pluginLine = '    id("org.gradle.toolchains.foojay-resolver-convention") version "0.5.0"';
  } else {
    pluginLine = '    id "org.gradle.toolchains.foojay-resolver-convention" version "0.5.0"';
  }
  if (content.contains('plugins {')) {
    content = content.replaceFirst('plugins {', 'plugins {\n$pluginLine');
    f.writeAsStringSync(content);
    log('   ✅ Injected plugin into existing plugins block.');
  } else {
    if (content.contains('pluginManagement {')) {
      String newBlock = isKotlin ? '\nplugins {\n$pluginLine\n}\n' : '\nplugins {\n$pluginLine\n}\n';

      f.writeAsStringSync(content + newBlock);
      log('   ✅ Appended new plugins block.');
    }
  }
}
