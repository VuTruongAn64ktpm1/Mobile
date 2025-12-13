import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_colors.dart';
import 'presentation/screens/auth/onboarding_screen.dart';
import 'presentation/screens/auth/auth_screen.dart';
import 'presentation/main_screen.dart';
import 'presentation/screens/protection/scam_alert_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/settings/help_screen.dart';
import 'presentation/screens/settings/contact_detail_screen.dart';

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
      title: 'An Tâm Nghe 1',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.primaryBlue,
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.black), titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/auth': (context) => const AuthScreen(),
        '/main': (context) => const MainScreen(),
        '/scam_alert': (context) => const IncomingScamScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/help': (context) => const HelpScreen(),
        '/detail': (context) => const ContactDetailScreen(),
      },
    );
  }
}