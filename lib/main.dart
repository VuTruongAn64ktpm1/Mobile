import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// Core
import 'core/app_colors.dart';

// Entry
import 'presentation/app_entry.dart';

// Screens (routes)
import 'presentation/main_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/sign_up_screen.dart';
import 'presentation/screens/auth/forgot_password_screen.dart';

// Services
// ...existing code...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// ⭐ KHỞI TẠO FIREBASE
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// ⭐ DỮ LIỆU MẪU (có thể comment sau khi test)
  try {
   // await SampleContactsService.addSampleContacts();
  } catch (e, s) {
    debugPrint('Lỗi khi thêm sample contacts: $e');
    debugPrint('$s');
  }

  /// ⭐ STATUS BAR
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

/// 🔥 WIDGET TẮT BÀN PHÍM TOÀN APP
class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: MaterialApp(
        title: 'An Tâm Nghe',
        debugShowCheckedModeBanner: false,

        /// 🎨 THEME
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: AppColors.primaryBlue,
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        /// 🚪 ENTRY THÔNG MINH
        home: const AppEntry(),

        /// 🧭 ROUTES
        routes: {
          '/login': (context) => LoginScreen(),
          '/main': (context) => const MainScreen(),
          '/sign_up': (context) => const SignUpScreen(),
          '/forgot_password': (context) => const ForgotPasswordScreen(),
        },
      ),
    );
  }
}
