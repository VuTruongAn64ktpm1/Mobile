import 'package:flutter/material.dart';

class BlockNameScreen extends StatelessWidget {
  const BlockNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Chặn người gọi theo tên", style: TextStyle(fontSize: 18, color: Colors.black)),
            SizedBox(height: 2),
            Row(children: [Icon(Icons.workspace_premium, size: 12, color: Color(0xFF007AFF)), SizedBox(width: 4), Text("Tính năng Premium", style: TextStyle(fontSize: 12, color: Color(0xFF007AFF)))])
          ],
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text("Tên người gọi có chứa từ này sẽ bị chặn", style: TextStyle(fontSize: 16, color: Colors.grey[800])),
            const SizedBox(height: 8),
            Row(children: [const Icon(Icons.info, size: 14, color: Colors.grey), const SizedBox(width: 6), Text("Cần có Internet để hoạt động ổn định", style: TextStyle(fontSize: 12, color: Colors.grey[600]))]),
            const SizedBox(height: 30),
            
            TextField(
              decoration: InputDecoration(
                hintText: "Tên hoặc từ",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF007AFF))),
                counterText: "Tối đa 35 ký tự",
                counterStyle: const TextStyle(color: Color(0xFF007AFF)),
              ),
            ),
            const SizedBox(height: 20),
            
            SizedBox(
              width: double.infinity, height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD1D5DB), elevation: 0),
                onPressed: () {},
                child: const Text("Chặn", style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}