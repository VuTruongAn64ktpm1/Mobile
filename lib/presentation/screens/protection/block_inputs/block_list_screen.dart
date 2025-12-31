import 'package:flutter/material.dart';

class BlockListScreen extends StatelessWidget {
  const BlockListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ===== APP BAR =====
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Danh sách chặn của tôi',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      /// ===== EMPTY STATE =====
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.shield_outlined,
              size: 64,
              color: Colors.black54,
            ),
            SizedBox(height: 16),
            Text(
              'Không có số điện thoại bị chặn',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
