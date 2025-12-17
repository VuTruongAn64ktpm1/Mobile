import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_colors.dart';
import 'presentation/screens/auth/onboarding_screen.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/main_screen.dart';
import 'presentation/screens/protection/scam_alert_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/settings/help_screen.dart';
import 'presentation/screens/settings/contact_detail_screen.dart';
import 'presentation/screens/settings/call_settings_screen.dart'; 
import 'presentation/screens/settings/app_info_screen.dart'; 
import 'presentation/screens/auth/login_screen.dart'; // File mới
import 'presentation/screens/auth/sign_up_screen.dart'; // File mới
import 'presentation/screens/auth/forgot_password_screen.dart'; // File mới
import 'presentation/screens/auth/onboarding_screen.dart';
import 'presentation/screens/settings/profile_screen.dart';
void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'An Tâm Nghe 24/7',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.primaryBlue,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.black), titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/main': (context) => const MainScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/scam_alert': (context) => const IncomingScamScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/help': (context) => const HelpScreen(),
        '/detail': (context) => const ContactDetailScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/settings/call': (context) => const CallSettingsScreen(), // Thêm dòng này
        '/settings/info': (context) => const AppInfoScreen(),
        '/': (context) => const OnboardingScreen(),
        '/auth': (context) => const LoginScreen(), // Đổi AuthScreen cũ thành LoginScreen mới
        '/signup': (context) => const SignUpScreen(), // Thêm route đăng ký
        '/forgot_password': (context) => const ForgotPasswordScreen(),
      },
    );
  }
}