// ✅ Plugin block
plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // ✅ Firebase plugin
    id("dev.flutter.flutter-gradle-plugin") // ✅ Flutter plugin (must be last)
}

android {
    namespace = "com.example.re_cycle"
    compileSdk = flutter.compileSdkVersion

    // ✅ Required for Firebase plugins
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.re_cycle"

        // ✅ Firebase Auth requires minSdk >= 23
        minSdk = 23
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// ✅ Flutter project reference
flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BoM - manages library versions
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))

    // ✅ Firebase libraries
    implementation("com.google.firebase:firebase-auth")         // Firebase Authentication
    implementation("com.google.firebase:firebase-firestore")    // Cloud Firestore
    implementation("com.google.firebase:firebase-storage")      // Firebase Storage
    implementation("com.google.firebase:firebase-messaging")    // Firebase Cloud Messaging
    implementation("com.google.firebase:firebase-analytics")    // Firebase Analytics (optional)
}
