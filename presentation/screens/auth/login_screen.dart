import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text("Đăng nhập", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 40),
            
            // Input Email
            _buildTextField(hint: "Email"),
            const SizedBox(height: 16),
            
            // Input Password
            TextField(
              obscureText: _obscureText,
              decoration: InputDecoration(
                hintText: "Mật khẩu",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                suffixIcon: IconButton(
                  icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
                  onPressed: () => setState(() => _obscureText = !_obscureText),
                ),
              ),
            ),
            
            // Quên mật khẩu
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
                child: const Text("Quên mật khẩu?", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),

            // Nút Đăng nhập
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF), // Màu xanh như ảnh
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  elevation: 0,
                ),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false),
                child: const Text("Đăng nhập", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 24),
            _buildOrDivider(),
            const SizedBox(height: 24),
            
            // Social Buttons
            _buildSocialButton("Tiếp tục với Google", Icons.g_mobiledata),
            const SizedBox(height: 16),
            _buildSocialButton("Tiếp tục với Facebook", Icons.facebook, iconColor: Colors.blue),
            
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Bạn chưa có tài khoản? ", style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text("Đăng kí ngay", style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({required String hint}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey[300]!)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildOrDivider() {
    return Row(
      children: const [
        Expanded(child: Divider(color: Colors.black26)),
        Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("OR", style: TextStyle(color: Colors.grey, fontSize: 12))),
        Expanded(child: Divider(color: Colors.black26)),
      ],
    );
  }

  Widget _buildSocialButton(String text, IconData icon, {Color iconColor = Colors.black}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}