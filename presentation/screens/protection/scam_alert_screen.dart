import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class IncomingScamScreen extends StatelessWidget {
  const IncomingScamScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF4A3B3B), Color(0xFF1F2531)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Icon(Icons.report_gmailerrorred, color: AppColors.scamRed, size: 60),
              const SizedBox(height: 16),
              const Text("Số lạ", style: TextStyle(color: Colors.white, fontSize: 28)),
              const Text("+0987654321", style: TextStyle(color: Colors.white70, fontSize: 20)),
              const Spacer(),
              Container(margin: const EdgeInsets.symmetric(horizontal: 40), padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20), decoration: BoxDecoration(color: AppColors.scamRed, borderRadius: BorderRadius.circular(30)), child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.error_outline, color: Colors.white), SizedBox(width: 8), Text("Báo cáo lừa đảo", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(children: [FloatingActionButton(backgroundColor: AppColors.scamRed, onPressed: () => Navigator.pop(context), child: const Icon(Icons.call_end)), const SizedBox(height: 8), const Text("Từ chối", style: TextStyle(color: Colors.white))]),
                  Column(children: [FloatingActionButton(backgroundColor: Colors.green, onPressed: () => Navigator.pop(context), child: const Icon(Icons.call)), const SizedBox(height: 8), const Text("Nghe máy", style: TextStyle(color: Colors.white))]),
                ]),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}