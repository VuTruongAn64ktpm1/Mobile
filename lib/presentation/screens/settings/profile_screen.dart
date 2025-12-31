import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Nền trắng
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black),
            onPressed: () {
              // Xử lý khi bấm nút cài đặt ở góc phải nếu cần
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            // Tên và SĐT
            const Text(
              "Nguyễn Văn A",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 4),
            const Text(
              "0987 654 321",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            
            const SizedBox(height: 24),
            
            // Avatar to tròn
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFAECBFA), // Màu xanh nhạt giống ảnh
                shape: BoxShape.circle,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Nút Chỉnh sửa
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit, size: 16, color: Color(0xFF1A73E8)),
                label: const Text("Chỉnh sửa", style: TextStyle(color: Color(0xFF1A73E8), fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE8F0FE), // Nền xanh rất nhạt
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Card Thống kê
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4, // Đổ bóng nhẹ
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Số liệu thống kê", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 24),
                      
                      // Hàng 1: Spam & Thời gian
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildStatItem(Icons.verified_user_outlined, "0", "Cuộc gọi spam được xác định"),
                          ),
                          Expanded(
                            child: _buildStatItem(Icons.access_time, "0", "Thời gian tiết kiệm khỏi những người spam"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Hàng 2: Số vô danh
                      _buildStatItem(Icons.search, "0", "Số điện thoại vô danh được xác định"),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String count, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 24, color: Colors.black87),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, height: 1.4)),
            ],
          ),
        )
      ],
    );
  }
}