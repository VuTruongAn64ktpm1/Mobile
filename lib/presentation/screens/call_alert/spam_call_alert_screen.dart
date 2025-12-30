import 'package:flutter/material.dart';

import '../../../services/spam_service.dart';

class SpamCallAlertScreen extends StatelessWidget {
  final String phoneNumber;

  const SpamCallAlertScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.block, size: 80, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'Cuộc gọi Spam',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Số điện thoại $phoneNumber đã bị chặn.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // ===== REPORT SPAM =====
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size.fromHeight(48),
                ),
                icon: const Icon(Icons.report, color: Colors.white),
                label: const Text(
                  'Báo cáo Spam',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await SpamService.reportSpam(phoneNumber);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ Đã ghi nhận báo cáo spam'),
                      ),
                    );
                  }
                },
              ),

              const SizedBox(height: 16),

              // ===== CLOSE =====
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
