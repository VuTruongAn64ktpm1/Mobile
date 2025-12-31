import 'package:flutter/material.dart';

class CallSettingsScreen extends StatefulWidget {
  const CallSettingsScreen({super.key});

  @override
  State<CallSettingsScreen> createState() => _CallSettingsScreenState();
}

class _CallSettingsScreenState extends State<CallSettingsScreen> {
  bool isPostCallDetailEnabled = true;
  bool isInCallAlertEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text("Cuộc gọi"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSettingCard(
            title: "Chi tiết sau cuộc gọi",
            description: "Màn hình tổng kết sau cuộc gọi, bao gồm các hành động nhanh: Chặn, gọi lại, thời lượng, báo cáo spam",
            value: isPostCallDetailEnabled,
            onChanged: (val) => setState(() => isPostCallDetailEnabled = val),
          ),
          const SizedBox(height: 16),
          _buildSettingCard(
            title: "Cảnh báo trong cuộc gọi",
            description: "Khi sử dụng trình gọi điện mặc định, sẽ có thông báo cảnh báo của ứng dụng về các cuộc gọi spam, lừa đảo",
            value: isInCallAlertEnabled,
            onChanged: (val) => setState(() => isInCallAlertEnabled = val),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingCard({required String title, required String description, required bool value, required Function(bool) onChanged}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value ? "Hiện" : "Ẩn", style: const TextStyle(fontWeight: FontWeight.w500)),
                Switch(
                  value: value,
                  onChanged: onChanged,
                  activeColor: Colors.blue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}