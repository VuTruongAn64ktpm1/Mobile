import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text("Bạn quên mật khẩu?", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              "Vui lòng nhập địa chỉ Email của bạn. Chúng tôi sẽ gửi cho bạn 1 liên kết để đặt lại mật khẩu",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 40),
            
            TextField(
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 24),
            
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF007AFF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                onPressed: () {}, 
                child: const Text("Gửi liên kết", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Quay lại trang ", style: TextStyle(fontSize: 12)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Đăng nhập", style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}