import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/app_colors.dart';
import '../../../services/onboarding_service.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _acceptedTerms = false;

  Future<void> _handleStart() async {
    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Bạn cần chấp nhận điều khoản để tiếp tục"),
        ),
      );
      return;
    }

    // ✅ Đánh dấu đã xem onboarding
    await OnboardingService.markSeen();

    if (!mounted) return;

    // ✅ Đi đúng luồng AppEntry
    Navigator.pushReplacementNamed(context, '/login');
  }

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

              const Text(
                "An tâm",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                "Xác định ai đang gọi trước khi bạn nghe máy",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textGrey),
              ),

              const Spacer(),

              /// 🌍 ĐỔI NGÔN NGỮ (DEMO)
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () async {
                  final selected = await showDialog<String>(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text('Chọn ngôn ngữ'),
                      children: const [
                        SimpleDialogOption(
                          child: Text('🇻🇳 Tiếng Việt'),
                        ),
                        SimpleDialogOption(
                          child: Text('🇺🇸 English'),
                        ),
                        SimpleDialogOption(
                          child: Text('🇯🇵 日本語'),
                        ),
                        SimpleDialogOption(
                          child: Text('🇰🇷 한국어'),
                        ),
                        SimpleDialogOption(
                          child: Text('🇫🇷 Français'),
                        ),
                      ],
                    ),
                  );

                  if (selected != null && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã chọn ngôn ngữ')),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      FaIcon(FontAwesomeIcons.globe, size: 20),
                      SizedBox(width: 8),
                      Text("Thay đổi ngôn ngữ"),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 🚀 NÚT BẮT ĐẦU
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25A866),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _handleStart,
                  child: const Text(
                    "Bắt đầu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              /// ☑️ ĐIỀU KHOẢN
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: _acceptedTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptedTerms = value ?? false;
                      });
                    },
                  ),
                  const SizedBox(width: 4),
                  const Text("Chấp nhận điều khoản"),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
