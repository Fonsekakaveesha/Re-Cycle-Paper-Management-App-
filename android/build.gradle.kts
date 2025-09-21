// Top-level build.gradle.kts

buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // ✅ Add Google Services plugin here
        classpath("com.google.gms:google-services:4.4.3")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Fix build directory customization
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
    val newSubprojectBuildDir = newBuildDir.dir(name)
    layout.buildDirectory.set(newSubprojectBuildDir)

    evaluationDependsOn(":app")
}

// ✅ Clean task
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
