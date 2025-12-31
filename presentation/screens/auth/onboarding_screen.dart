import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Text("An tâm", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text("Xác định ai đang gọi trước khi bạn nghe máy", textAlign: TextAlign.center, style: TextStyle(color: AppColors.textGrey)),
              const Spacer(),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.language, size: 20), SizedBox(width: 8), Text("Thay đổi ngôn ngữ")],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25A866), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                  onPressed: () => Navigator.pushNamed(context, '/auth'),
                  child: const Text("Bắt đầu", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 16),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.check_box_outline_blank), SizedBox(width: 8), Text("Chấp nhận điều khoản")]),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}