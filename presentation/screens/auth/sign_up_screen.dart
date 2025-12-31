import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text("Đăng kí", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),

            _buildInput("Họ tên"),
            const SizedBox(height: 16),
            _buildInput("Email"),
            const SizedBox(height: 16),
            _buildPassInput("Mật khẩu", _obscurePass, () => setState(() => _obscurePass = !_obscurePass)),
            const SizedBox(height: 16),
            _buildPassInput("Xác nhận mật khẩu", _obscureConfirm, () => setState(() => _obscureConfirm = !_obscureConfirm)),
            
            const SizedBox(height: 30),
             SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007AFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                onPressed: () {}, // Logic đăng ký
                child: const Text("Đăng kí", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 24),
            _buildOrDivider(),
            const SizedBox(height: 24),
            _buildSocialButton("Tiếp tục với Google", Icons.g_mobiledata),
            const SizedBox(height: 16),
            _buildSocialButton("Tiếp tục với Facebook", Icons.facebook, iconColor: Colors.blue),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildPassInput(String hint, bool obscure, VoidCallback onToggle) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey), onPressed: onToggle),
      ),
    );
  }
  
  Widget _buildOrDivider() {
    return Row(children: const [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text("OR", style: TextStyle(color: Colors.grey, fontSize: 12))), Expanded(child: Divider())]);
  }

  Widget _buildSocialButton(String text, IconData icon, {Color iconColor = Colors.black}) {
    return Container(
      width: double.infinity, height: 50,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(25)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: iconColor, size: 28), const SizedBox(width: 12), Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))]),
    );
  }
}