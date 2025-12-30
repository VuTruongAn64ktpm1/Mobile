import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/mock_data.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // THANH TÌM KIẾM & MENU 3 CHẤM
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 56, // tăng chiều cao
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Icon(Icons.account_circle, color: AppColors.primaryBlue),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Tìm kiếm số điện thoại",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        // TODO: Xử lý tìm kiếm ở đây
                      },
                    ),
                  ),
                  // --- BẮT ĐẦU: MENU 3 CHẤM ---
                  // PopupMenuButton<String>(
                  //   icon: const Icon(Icons.more_vert, color: Colors.grey),
                  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  //   onSelected: (value) {
                  //     if (value == 'settings') {
                  //       Navigator.pushNamed(context, '/settings');
                  //     }
                  //     // Các case khác bạn có thể xử lý sau
                  //   },
                  //   itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  //     _buildMenuItem('outgoing', Icons.call_made, 'Cuộc gọi đi', Colors.blue),
                  //     _buildMenuItem('incoming', Icons.call_received, 'Cuộc gọi đến', Colors.green),
                  //     _buildMenuItem('missed', Icons.call_missed, 'Các cuộc gọi nhỡ', Colors.red),
                  //     _buildMenuItem('blocked', Icons.block, 'Cuộc gọi bị chặn', Colors.red),
                  //     const PopupMenuDivider(),
                  //     _buildMenuItem('delete_all', Icons.delete_outline, 'Xóa tất cả cuộc gọi', Colors.grey),
                  //     _buildMenuItem('sim', Icons.sim_card_outlined, 'Đặt SIM mặc định', Colors.grey),
                  //     _buildMenuItem('settings', Icons.settings_outlined, 'Thiết lập', Colors.grey),
                  //   ],
                  // ),
                  // --- KẾT THÚC: MENU 3 CHẤM ---
                  const SizedBox(width: 4),
                ],
              ),
            ),
          ),
          
          // ... Phần danh sách bên dưới giữ nguyên
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              itemCount: MockData.contacts.length,
              itemBuilder: (context, index) {
                final c = MockData.contacts[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(children: [
                    CircleAvatar(radius: 28, backgroundColor: AppColors.avatarBlue, child: Text(c["char"], style: const TextStyle(fontSize: 20, color: Colors.black))),
                    const SizedBox(height: 4),
                    Text(c["name"], style: const TextStyle(fontSize: 12))
                  ]),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MockData.history.length,
              itemBuilder: (context, index) {
                final h = MockData.history[index];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.avatarBlue, child: Text(h["name"][0])),
                  title: Text(h["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(children: [const Icon(Icons.call_received, size: 14, color: Colors.green), const SizedBox(width: 4), Text(h["time"])]),
                  trailing: const Icon(Icons.call_outlined, color: Colors.grey),
                  onTap: () => Navigator.pushNamed(context, '/detail'),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Hàm tạo item cho Menu đẹp hơn
  PopupMenuItem<String> _buildMenuItem(String value, IconData icon, String text, Color iconColor) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}