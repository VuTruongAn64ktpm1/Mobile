import 'package:flutter/material.dart';

import '../core/app_colors.dart';

import 'screens/phone/phone_tab_screen.dart';
import 'screens/protection/protection_screen.dart';

import '../services/call_filter_service.dart';
import '../services/focus_mode_service.dart';

// ❌ KHÔNG DÙNG NỮA
// import 'screens/call_alert/normal_call_info_screen.dart';

import 'screens/call_alert/spam_call_alert_screen.dart';
import 'screens/call_alert/emergency_call_screen.dart';

// ✅ POPUP AN TOÀN
import 'widgets/call_safety_popup.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  bool isFocusModeOn = false;
  bool _isLoadingFocus = true;

  @override
  void initState() {
    super.initState();
    _loadFocusMode();
  }

  /// ===== LOAD FOCUS MODE =====
  Future<void> _loadFocusMode() async {
    final value = await FocusModeService.loadFocusMode();
    if (!mounted) return;
    setState(() {
      isFocusModeOn = value;
      _isLoadingFocus = false;
    });
  }

  /// ===== TOGGLE FOCUS MODE =====
  Future<void> toggleFocusMode(bool value) async {
    if (!mounted) return;
    setState(() => isFocusModeOn = value);
    await FocusModeService.setFocusMode(value);
  }

  /// ===== GIẢ LẬP CUỘC GỌI =====
  Future<void> simulateIncomingCall(String phone) async {
    final result = await CallFilterService.handleIncomingCall(
      phoneNumber: phone,
      isFocusModeOn: isFocusModeOn,
    );

    if (!mounted) return;

    switch (result) {
      case CallDecision.block:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SpamCallAlertScreen(phoneNumber: phone),
          ),
        );
        break;

      case CallDecision.emergency:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmergencyCallScreen(phoneNumber: phone),
          ),
        );
        break;

      /// ✅ GỌI BÌNH THƯỜNG → HIỆN POPUP AN TOÀN
      case CallDecision.ring:
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => CallSafetyPopup(
            phoneNumber: phone,
            isSpam: false, // sau này lấy từ backend
          ),
        );
        break;

      case CallDecision.silent:
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🔕 Cuộc gọi bị im lặng (Focus Mode)'),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingFocus) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final pages = [
      PhoneTabContainer(
        onCall: simulateIncomingCall,
      ),
      ProtectionScreen(
        isFocusModeOn: isFocusModeOn,
        onToggleFocus: toggleFocusMode,
        onSimulateCall: simulateIncomingCall,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _index,
            children: pages,
          ),

          /// 🔴 BANNER FOCUS MODE
          if (isFocusModeOn)
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '🔕 Focus Mode đang bật – Cuộc gọi lạ sẽ bị lọc',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),

      /// 🔽 BOTTOM BAR
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() => _index = i);
        },
        selectedItemColor: AppColors.primaryBlue,
        showUnselectedLabels: true,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Cuộc gọi',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.security),
                if (isFocusModeOn)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            label: 'Bảo vệ',
          ),
        ],
      ),
    );
  }
}
