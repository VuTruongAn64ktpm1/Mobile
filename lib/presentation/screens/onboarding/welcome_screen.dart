import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/login_screen.dart'; // Để chuyển sang Login

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isAccepted = false; // Checkbox điều khoản

  Future<void> _onStart() async {
    if (!_isAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chấp nhận điều khoản để tiếp tục")),
      );
      return;
    }

    // Lưu trạng thái "Đã xem Welcome" vào bộ nhớ
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenWelcome', true);

    // Chuyển sang màn hình Đăng nhập (Và xóa Welcome khỏi lịch sử Back)
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // LOGO / TIÊU ĐỀ
              const Text(
                "An tâm",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                "Xác định ai đang gọi trước khi bạn nghe máy",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              
              const SizedBox(height: 40),
              // 3 DẤU GẠCH TRANG TRÍ
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(width: 40, height: 4, color: Colors.grey.shade300, margin: const EdgeInsets.symmetric(horizontal: 4)),
                  Container(width: 40, height: 4, color: Colors.grey.shade300, margin: const EdgeInsets.symmetric(horizontal: 4)),
                  Container(width: 40, height: 4, color: Colors.grey.shade300, margin: const EdgeInsets.symmetric(horizontal: 4)),
                ],
              ),
              
              const Spacer(),

              // NÚT THAY ĐỔI NGÔN NGỮ
              TextButton.icon(
                onPressed: () {}, 
                icon: const Icon(Icons.language, color: Colors.black),
                label: const Text("Thay đổi ngôn ngữ", style: TextStyle(color: Colors.black)),
              ),
              const SizedBox(height: 20),

              // NÚT BẮT ĐẦU (XANH LÁ)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _onStart,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00C853), // Màu xanh lá chuẩn
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("Bắt đầu", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              
              const SizedBox(height: 20),

              // CHECKBOX ĐIỀU KHOẢN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _isAccepted, 
                    activeColor: const Color(0xFF00C853),
                    onChanged: (val) => setState(() => _isAccepted = val ?? false),
                  ),
                  const Text("Chấp nhận điều khoản", style: TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}