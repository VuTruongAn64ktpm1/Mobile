import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: const Text("Thiết lập")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(leading: const CircleAvatar(backgroundColor: AppColors.avatarBlue), title: const Text("Nguyễn Văn A"), subtitle: const Text("Quản lý hồ sơ của bạn"), contentPadding: EdgeInsets.zero),
          const Divider(),
          _item(Icons.settings, "Chung"), _item(Icons.call, "Cuộc gọi"), _item(Icons.message_outlined, "Nhắn tin"), _item(Icons.block, "Chặn"), _item(Icons.info_outline, "Thông tin về ứng dụng"),
          _item(Icons.help_outline, "Trợ giúp", onTap: () => Navigator.pushNamed(context, '/help')),
        ],
      ),
    );
  }
  Widget _item(IconData i, String t, {VoidCallback? onTap}) => ListTile(leading: Icon(i, color: Colors.black), title: Text(t), onTap: onTap, contentPadding: EdgeInsets.zero);
}