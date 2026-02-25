import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")

    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")

    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    id("com.google.firebase.firebase-perf")
    // END: FlutterFire Configuration
}

val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.reader(Charsets.UTF_8).use { reader ->
        localProperties.load(reader)
    }
}

val flutterVersionCode =
    localProperties.getProperty("flutter.versionCode") ?: "1"
val flutterVersionName =
    localProperties.getProperty("flutter.versionName") ?: "1.0"

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    testOptions {
        execution = "ANDROIDX_TEST_ORCHESTRATOR"
        unitTests {
            isReturnDefaultValues = true
        }
        animationsDisabled = true
    }

    namespace = "social.uchat"
    compileSdk = 36
    ndkVersion = "28.2.13676358"

    compileOptions {
        // Flag to enable support for the new language APIs
        isCoreLibraryDesugaringEnabled = true

        // Sets Java compatibility to Java 8
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    // read .env file and export as system env.
    // ../../ (android/app/)
    file("../../.env").readLines().forEach { line ->
        if (line.isNotEmpty() && !line.startsWith("#")) {
            val pos = line.indexOf("=")
            if (pos > 0) {
                val key = line.substring(0, pos)
                val value = line.substring(pos + 1)

                if (System.getenv(key) == null) {
                    System.setProperty("env.$key", value)
                }
            }
        }
    }

    defaultConfig {
        testInstrumentationRunner = "pl.leancode.patrol.PatrolJUnitRunner"
        testInstrumentationRunnerArguments["clearPackageData"] = "true"
        testInstrumentationRunnerArguments["timeout"] = "1800000"
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "social.uchat"

        minSdk = 30
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode.toInt()
        versionName = flutterVersionName
        manifestPlaceholders["API_KEY"] =
            "${System.getProperty("env.GOOGLE_API_KEY")}"
        manifestPlaceholders["schemeDeepLink"] = "uchat-social"
        manifestPlaceholders["hostName"] = "uchat.social"
        manifestPlaceholders["hostNameWww"] = "www.uchat.social"
        resValue("string", "app_name", "UChat")

        // https://developer.android.com/guide/practices/page-sizes#kotlin_1
        // This block is different from the one you use to link Gradle
        // to your CMake or ndk-build script.
        externalNativeBuild {
            // For ndk-build, instead use the ndkBuild block.
            cmake {
                // Passes optional arguments to CMake.
                arguments += listOf("-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON")
            }
        }
    }

    flavorDimensions += "environment"

    productFlavors {
        create("prd") {
            dimension = "environment"
            applicationId = "social.uchat"
            resValue("string", "app_name", "UChat")
            manifestPlaceholders["schemeDeepLink"] = "uchat"
            manifestPlaceholders["hostName"] = "uchat.social"
            manifestPlaceholders["hostNameWww"] = "www.uchat.social"
        }

        create("dev") {
            dimension = "environment"
            applicationId = "social.uchat.messenger.dev"
            resValue("string", "app_name", "UChat Dev")
            manifestPlaceholders["schemeDeepLink"] = "uchat-dev"
            manifestPlaceholders["hostName"] = "dev.uchat.social"
            manifestPlaceholders["hostNameWww"] = "dev.uchat.social"
        }

        create("uat") {
            dimension = "environment"
            applicationId = "social.uchat.messenger.uat"
            resValue("string", "app_name", "UChat Uat")
            manifestPlaceholders["schemeDeepLink"] = "uchat-uat"
            manifestPlaceholders["hostName"] = "uat.uchat.social"
            manifestPlaceholders["hostNameWww"] = "uat.uchat.social"
        }

        create("sit") {
            dimension = "environment"
            applicationId = "social.uchat.messenger.sit"
            resValue("string", "app_name", "UChat Sit")
            manifestPlaceholders["schemeDeepLink"] = "uchat-sit"
            manifestPlaceholders["hostName"] = "sit.uchat.social"
            manifestPlaceholders["hostNameWww"] = "sit.uchat.social"
        }
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
        // TODO: create one debug key for all dev to fixing debug google signin error
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isShrinkResources = false
            isMinifyEnabled = false

//             useProguard true
//
//             proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // signingConfig signingConfigs.debug
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    androidTestUtil("androidx.test:orchestrator:1.5.1")
    androidTestImplementation("androidx.test:runner:1.6.1")
    androidTestImplementation("androidx.test:rules:1.6.1")
    androidTestImplementation("androidx.test.ext:junit:1.2.1")
//    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.facebook.android:facebook-android-sdk:latest.release")

    implementation("com.google.android.gms:play-services-auth:21.3.0")

    implementation("com.github.AbedElazizShe:LightCompressor:1.3.2")

//    implementation("androidx.window:window:1.0.0")
//    implementation("androidx.window:window-java:1.0.0")

    // For Livekit
    implementation("io.livekit:livekit-android:2.7.0")

    // For OneSignal 5
    implementation("com.onesignal:OneSignal:5.1.34")

    // Firebase Performance Monitoring
    implementation("com.google.firebase:firebase-perf:20.5.2")

    // For AGP 8.6.0
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}