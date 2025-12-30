import 'package:flutter/material.dart';

class EmergencyCallScreen extends StatelessWidget {
  final String phoneNumber;

  const EmergencyCallScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, size: 80, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                'CUỘC GỌI KHẨN CẤP',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Số $phoneNumber đã gọi lại.\nĐược phép vượt chế độ Tập trung.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // ===== ANSWER =====
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size.fromHeight(48),
                ),
                icon: const Icon(Icons.call, color: Colors.white),
                label: const Text(
                  'Nghe máy',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Demo: chỉ đóng màn
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 16),

              // ===== REJECT =====
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Từ chối'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
