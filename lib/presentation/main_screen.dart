import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import 'screens/phone/phone_tab_screen.dart';
import 'screens/protection/protection_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  final List<Widget> _pages = [const PhoneTabContainer(), const ProtectionScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: AppColors.primaryBlue,
        showUnselectedLabels: true,
        items: const [BottomNavigationBarItem(icon: Icon(Icons.call), label: "Cuộc gọi"), BottomNavigationBarItem(icon: Icon(Icons.security), label: "Bảo vệ")],
      ),
    );
  }
}