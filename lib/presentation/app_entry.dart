import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main_screen.dart';
import 'screens/auth/login_screen.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ⏳ ĐANG CHECK LOGIN
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ ĐÃ LOGIN → VÀO MAIN
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // ❌ CHƯA LOGIN → LOGIN SCREEN
        return LoginScreen();
      },
    );
  }
}
