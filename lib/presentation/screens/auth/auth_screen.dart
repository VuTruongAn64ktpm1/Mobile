import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tạo hồ sơ cá nhân", style: TextStyle(fontSize: 16))),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity, height: 48,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.g_mobiledata, color: Colors.white, size: 28),
                label: const Text("Tiếp tục với Google", style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1A73E8), shape: const StadiumBorder()),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false),
              ),
            ),
            const SizedBox(height: 24),
            const Row(children: [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text("Điền thủ công", style: TextStyle(color: Colors.grey))), Expanded(child: Divider())]),
            const SizedBox(height: 20),
            TextField(decoration: InputDecoration(hintText: "Họ", border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
            const SizedBox(height: 12),
            TextField(decoration: InputDecoration(hintText: "Tên", border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
            const Spacer(),
            SizedBox(
              width: double.infinity, height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false),
                child: const Text("Tiếp tục", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}