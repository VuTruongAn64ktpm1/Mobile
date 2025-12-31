import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'screens/phone/phone_main_screen.dart'; 
import 'screens/protection/protection_screen.dart'; 

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PhoneMainScreen(),    // Tab 1: Màn hình gọi điện (Có Dock nổi)
    const ProtectionScreen(),   // Tab 2: Màn hình bảo vệ
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      // ĐÂY LÀ PHẦN DƯỚI CÙNG (CHIA 2 TAB)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          selectedItemColor: AppColors.primaryBlue,
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.phone),
              label: "Cuộc gọi",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shield_outlined),
              activeIcon: Icon(Icons.shield),
              label: "Bảo vệ",
            ),
          ],
        ),
      ),
    );
  }
}