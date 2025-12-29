import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Thiết lập"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const CircleAvatar(radius: 25, backgroundColor: AppColors.avatarBlue),
            title: const Text("Nguyễn Văn A", style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: const Text("Quản lý hồ sơ của bạn"),
            contentPadding: EdgeInsets.zero,
            onTap: () {
            //dieu huong den profile screen
            Navigator.pushNamed(context, '/profile');
          },
          ),
          const SizedBox(height: 10),
          const Divider(),
          _item(context, Icons.settings_outlined, "Chung"),
          _item(context, Icons.call_outlined, "Cuộc gọi", routeName: '/settings/call'), // Link tới trang Call Settings
          _item(context, Icons.chat_bubble_outline, "Nhắn tin"),
          _item(context, Icons.block_outlined, "Chặn"),
          _item(context, Icons.info_outline, "Thông tin về ứng dụng", routeName: '/settings/info'), // Link tới trang App Info
          _item(context, Icons.help_outline, "Trợ giúp", routeName: '/help'),
        ],
      ),
    );
  }

  Widget _item(BuildContext context, IconData icon, String text, {String? routeName}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(text),
      contentPadding: EdgeInsets.zero,
      onTap: () {
        if (routeName != null) {
          Navigator.pushNamed(context, routeName);
        }
      },
    );
  }
}