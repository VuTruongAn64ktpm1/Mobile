buildscript {
    // Khai báo phiên bản Kotlin (phải khớp với dự án của bạn)
    val kotlin_version by extra("1.9.0")

    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        // 1. Android Gradle Plugin (Dùng bản 8.2.1 như máy bạn đang có)
        classpath("com.android.tools.build:gradle:8.2.1")

        // 2. Kotlin Gradle Plugin
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version")

        // 3. Google Services (CÁI BẠN CẦN THÊM ĐÂY)
        classpath("com.google.gms:google-services:4.3.15")
    }
}

// --- PHẦN DƯỚI NÀY LÀ CODE CŨ CỦA BẠN (GIỮ NGUYÊN) ---

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
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