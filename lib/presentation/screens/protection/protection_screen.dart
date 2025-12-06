import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class ProtectionScreen extends StatelessWidget {
  const ProtectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF0055D4), AppColors.protectionBlue], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              padding: const EdgeInsets.only(top: 60, bottom: 30),
              child: Column(children: [
                const Text("Bảo vệ tôi", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Container(padding: const EdgeInsets.all(16), decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.check, color: AppColors.protectionBlue, size: 40)),
                const SizedBox(height: 12),
                const Text("Mức độ bảo vệ | Cơ bản", style: TextStyle(color: Colors.white, fontSize: 16)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFFFF0F0), borderRadius: BorderRadius.circular(12)), child: const Row(children: [Expanded(child: Text("Tính năng bảo vệ khỏi spam cho tin nhắn", style: TextStyle(fontWeight: FontWeight.bold))), Icon(Icons.message, color: Colors.redAccent)])),
                const SizedBox(height: 20),
                _switch("Thông báo các cuộc gọi bị chặn", true),
                _switch("Thông báo về các tin nhắn đã bị chặn", true),
                const Divider(),
                _item(Icons.call_end, "Số điện thoại"), _item(Icons.person, "Tên người gọi"), _item(Icons.fingerprint, "ID người gửi"),
                const Divider(),
                _switch("Chặn các doanh nghiệp đã xác minh", true), _switch("Các số nước ngoài", true), _switch("Số điện thoại ẩn", true), _switch("Số không có trong danh bạ", true),
              ]),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
  Widget _switch(String t, bool v) => SwitchListTile(title: Text(t, style: const TextStyle(fontSize: 14)), value: v, onChanged: (x) {}, contentPadding: EdgeInsets.zero, activeColor: AppColors.protectionBlue);
  Widget _item(IconData i, String t) => ListTile(leading: Icon(i, color: Colors.grey), title: Text(t), trailing: const Icon(Icons.arrow_forward_ios, size: 12), contentPadding: EdgeInsets.zero);
}