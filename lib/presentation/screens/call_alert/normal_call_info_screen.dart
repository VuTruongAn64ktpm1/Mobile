import 'package:flutter/material.dart';

class NormalCallInfoScreen extends StatelessWidget {
  final String phoneNumber;

  const NormalCallInfoScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.call, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              const Text(
                'Cuộc gọi đến',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Bạn có cuộc gọi từ số $phoneNumber',
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
                  // Demo
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
