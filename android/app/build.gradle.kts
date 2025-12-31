plugins {
    id("com.android.application")
    id("kotlin-android")
    // Plugin của Flutter phải nằm sau Android và Kotlin
    id("dev.flutter.flutter-gradle-plugin")
    // --- QUAN TRỌNG: Thêm plugin Google Services cho Firebase ---
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.antam"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // Chuyển về Java 8 để tương thích tốt nhất với thư viện Desugar
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        // Bật tính năng Desugaring (Hỗ trợ chạy code mới trên Android cũ)
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    defaultConfig {
        applicationId = "com.example.antam"
        
        // --- QUAN TRỌNG: Firebase yêu cầu tối thiểu là 21 ---
        minSdk = flutter.minSdkVersion 
        // ----------------------------------------------------
        
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // --- QUAN TRỌNG: Bật MultiDex để không bị lỗi tràn method ---
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // --- CÁC THƯ VIỆN BẮT BUỘC ---
    
    // 1. Thư viện MultiDex (Hỗ trợ App lớn)
    implementation("androidx.multidex:multidex:2.0.1")
    
    // 2. Thư viện Desugar (Để sửa lỗi Java version)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
