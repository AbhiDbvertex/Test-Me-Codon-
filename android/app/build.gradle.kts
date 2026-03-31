//plugins {
//    id("com.android.application")
//    // START: FlutterFire Configuration
//    id("com.google.gms.google-services")
//    // END: FlutterFire Configuration
//    id("kotlin-android")
//    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
//    id("dev.flutter.flutter-gradle-plugin")
//}
//val keystoreProperties = Properties()
//val keystorePropertiesFile = rootProject.file("key.properties")
//if (keystorePropertiesFile.exists()) {
//    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
//}
//android {
//    namespace = "com.testmee.app"
//    compileSdk = flutter.compileSdkVersion
//    ndkVersion = flutter.ndkVersion
//
//    compileOptions {
//        sourceCompatibility = JavaVersion.VERSION_11
//        targetCompatibility = JavaVersion.VERSION_11
//    }
//
//    kotlinOptions {
//        jvmTarget = JavaVersion.VERSION_11.toString()
//    }
//
//    defaultConfig {
//        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
//        applicationId = "com.testmee.app"
//        // You can update the following values to match your application needs.
//        // For more information, see: https://flutter.dev/to/review-gradle-config.
//        minSdk = flutter.minSdkVersion
//        targetSdk = flutter.targetSdkVersion
//        versionCode = flutter.versionCode
//        versionName = flutter.versionName
//    }
//    signingConfigs {
//        create("release") {
//            keyAlias = keystoreProperties["keyAlias"] as String?
//            keyPassword = keystoreProperties["keyPassword"] as String?
//            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
//            storePassword = keystoreProperties["storePassword"] as String?
//        }
//    }
////    buildTypes {
////        release {
////            // TODO: Add your own signing config for the release build.
////            // Signing with the debug keys for now, so `flutter run --release` works.
////            signingConfig = signingConfigs.getByName("debug")
////            isMinifyEnabled = false // Isse temporary false karke dekhein
////            isShrinkResources = false
////        }
////    }
//
//    buildTypes {
//        getByName("release") {
//            // Debug ki jagah release key use karein
//            signingConfig = signingConfigs.getByName("release")
//            isMinifyEnabled = false
//            isShrinkResources = false
//            proguardFiles(
//                getDefaultProguardFile("proguard-android-optimize.txt"),
//                "proguard-rules.pro"
//            )
//        }
//        getByName("debug") {
//            signingConfig = signingConfigs.getByName("debug")
//        }
//    }
//    lint {
//        checkReleaseBuilds = false
//        abortOnError = false
//        disable.add("NullSafeMutableLiveData")
//    }
//}
//
//flutter {
//    source = "../.."
//}
import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.testmee.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.testmee.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            // Fixed the storeFile logic for Kotlin
            val sFile = keystoreProperties["storeFile"] as String?
            storeFile = if (sFile != null) file(sFile) else null
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    lint {
        checkReleaseBuilds = false
        abortOnError = false
        disable.add("NullSafeMutableLiveData")
    }
}

flutter {
    source = "../.."
}