import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

import 'block_inputs/block_phone_screen.dart';
import 'block_inputs/block_name_screen.dart';
import 'block_inputs/block_series_screen.dart';
import 'block_inputs/block_country_screen.dart';
import 'block_inputs/block_list_screen.dart';

class ProtectionScreen extends StatefulWidget {
  final bool isFocusModeOn;
  final Future<void> Function(bool) onToggleFocus;
  final Future<void> Function(String) onSimulateCall;

  const ProtectionScreen({
    super.key,
    required this.isFocusModeOn,
    required this.onToggleFocus,
    required this.onSimulateCall,
  });

  @override
  State<ProtectionScreen> createState() => _ProtectionScreenState();
}

class _ProtectionScreenState extends State<ProtectionScreen> {
  bool notifyBlockedCalls = true;
  bool notifyBlockedMessages = true;

  Future<void> _openScreen(Widget screen) async {
    final changed = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );

    if (changed == true) {
      setState(() {}); // reload UI
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ListView(
        children: [
          /// ================= HEADER =================
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F5BE0), Color(0xFF0B3FB3)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                const Icon(Icons.verified_user,
                    color: Colors.white, size: 48),
                const SizedBox(height: 8),
                const Text(
                  'Bảo vệ tôi',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Mức độ bảo vệ: Cơ bản',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => widget.onToggleFocus(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            !widget.isFocusModeOn ? Colors.white : Colors.white24,
                      ),
                      child: const Text('Tắt'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => widget.onToggleFocus(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            widget.isFocusModeOn ? Colors.white : Colors.white24,
                      ),
                      child: const Text('Bật'),
                    ),
                  ],
                )
              ],
            ),
          ),

          /// ================= WARNING =================
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'Tính năng bảo vệ khỏi spam chưa kích hoạt',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),

          /// ================= SETTINGS =================
          _section(
            title: 'Cài đặt thông báo',
            children: [
              SwitchListTile(
                value: notifyBlockedCalls,
                onChanged: (v) =>
                    setState(() => notifyBlockedCalls = v),
                title: const Text('Thông báo các cuộc gọi bị chặn'),
              ),
              SwitchListTile(
                value: notifyBlockedMessages,
                onChanged: (v) =>
                    setState(() => notifyBlockedMessages = v),
                title: const Text('Thông báo các số nhắn đã bị chặn'),
              ),
            ],
          ),

          /// ================= BLOCK LIST =================
          _section(
            title: 'Thêm vào danh sách chặn của tôi',
            children: [
              _item(Icons.call, 'Số điện thoại',
                  () => _openScreen(const BlockPhoneScreen())),
              _item(Icons.person, 'Tên người gọi',
                  () => _openScreen(const BlockNameScreen())),
              _item(Icons.tag, 'ID người gọi', () {}),
              _item(Icons.flag, 'Mã quốc gia',
                  () => _openScreen(const BlockCountryScreen())),
              _item(Icons.filter_alt, 'Chuỗi số',
                  () => _openScreen(const BlockSeriesScreen())),
              ListTile(
                title: const Text(
                  'Xem tất cả',
                  style: TextStyle(color: Colors.blue),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _openScreen(const BlockListScreen()),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _item(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
