import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'firebase_options.dart';

// --- IMPORTS CÁC MÀN HÌNH ---
import 'core/app_colors.dart';
import 'presentation/screens/auth/login_screen.dart';
import 'presentation/screens/auth/sign_up_screen.dart';
import 'presentation/screens/auth/forgot_password_screen.dart';
import 'presentation/main_screen.dart';
import 'presentation/screens/onboarding/welcome_screen.dart'; 
import 'presentation/screens/protection/scam_alert_screen.dart';
import 'presentation/screens/protection/block_inputs/block_phone_screen.dart';
import 'presentation/screens/protection/block_inputs/block_name_screen.dart';
import 'presentation/screens/protection/block_inputs/block_country_screen.dart';
import 'presentation/screens/protection/block_inputs/block_series_screen.dart';
import 'presentation/screens/settings/settings_screen.dart';
import 'presentation/screens/settings/help_screen.dart';
import 'presentation/screens/settings/call_settings_screen.dart';
import 'presentation/screens/settings/app_info_screen.dart';
import 'presentation/screens/settings/profile_screen.dart';
import 'presentation/overlays/caller_id_overlay.dart';

// --- MAIN CHÍNH ---
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Cấu hình thanh trạng thái trong suốt
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark, 
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    // --- THỬ KẾT NỐI ---
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Nếu chạy đến dòng này nghĩa là THÀNH CÔNG
    print("✅✅✅ CHÚC MỪNG! FIREBASE ĐÃ KẾT NỐI THÀNH CÔNG! ✅✅✅");
  } catch (e) {
    // Nếu nhảy vào đây là THẤT BẠI
    print("❌❌❌ TOANG RỒI! LỖI KẾT NỐI: $e");
  }
  runApp(const MyApp());
}

// --- MAIN OVERLAY ---
@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CallerIdOverlay()
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'An Tâm Nghe',
      
      // --- THEME ---
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3D5CFF), 
          primary: const Color(0xFF3D5CFF),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3D5CFF),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      
      // --- CỔNG SOÁT VÉ (AUTH GATE) ---
      home: const AuthGate(), 

      // --- ROUTES ---
      routes: {
        '/signup': (context) => const SignUpScreen(),
        '/forgot_password': (context) => const ForgotPasswordScreen(),
        
        // Đường dẫn quan trọng để LoginScreen chuyển hướng vào
        '/main': (context) => const MainScreen(),
        
        '/scam_alert': (context) => const IncomingScamScreen(),
        '/block_phone': (context) => const BlockPhoneScreen(),
        '/block_name': (context) => const BlockNameScreen(),
        '/block_country': (context) => const BlockCountryScreen(),
        '/block_series': (context) => const BlockSeriesScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/settings/call': (context) => const CallSettingsScreen(),
        '/settings/info': (context) => const AppInfoScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/help': (context) => const HelpScreen(),
        // Đã xóa dòng '/settings' bị thừa ở đây
      },
    );
  }
}

// --- AUTH GATE NÂNG CẤP (CHECK WELCOME + FIREBASE) ---
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool? _hasSeenWelcome; // null = chưa kiểm tra xong

  @override
  void initState() {
    super.initState();
    _checkWelcomeStatus();
  }

  // Kiểm tra xem đã từng bấm "Bắt đầu" ở màn hình Welcome chưa
  Future<void> _checkWelcomeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    // Nếu chạy trên máy ảo mới tinh, dòng này sẽ trả về false
    bool seen = prefs.getBool('hasSeenWelcome') ?? false;
    
    if (mounted) {
      setState(() {
        _hasSeenWelcome = seen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 1. Đang đọc bộ nhớ -> Hiện loading xoay xoay
    if (_hasSeenWelcome == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 2. Nếu chưa từng xem Welcome -> Hiện màn hình Chào mừng
    if (_hasSeenWelcome == false) {
      return const WelcomeScreen();
    }

    // 3. Nếu đã xem Welcome rồi -> Kiểm tra đăng nhập Firebase
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        
        // Đã đăng nhập -> Vào Main
        if (snapshot.hasData) {
          return const MainScreen();
        }

        // Chưa đăng nhập -> Vào Login
        return const LoginScreen(); 
      },
    );
  }
}