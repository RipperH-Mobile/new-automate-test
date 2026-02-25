// This file is /android/build.gradle.kts (the ROOT build file)
import org.gradle.api.file.Directory
import org.gradle.api.tasks.Delete

buildscript {
    // Define versions in a central place
    // You should check your project for the correct versions
    val kotlinVersion = "1.9.23"
    val agpVersion = "8.3.2" // Android Gradle Plugin version

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // Make sure these versions are compatible with your project
        classpath("com.android.tools.build:gradle:$agpVersion")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
        classpath("com.google.firebase:perf-plugin:2.0.2")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}