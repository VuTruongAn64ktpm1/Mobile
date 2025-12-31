import 'package:flutter/material.dart';

class AppInfoScreen extends StatelessWidget {
  const AppInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Thông tin ứng dụng"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thông tin ứng dụng", style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text("Phiên bản", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("v1.0.0 (Beta)", style: TextStyle(fontSize: 14)),
            
            Spacer(),
            Center(child: Text("Bản quyền thuộc nhóm Dev", style: TextStyle(color: Colors.grey, fontSize: 12))),
          ],
        ),
      ),
    );
  }
}