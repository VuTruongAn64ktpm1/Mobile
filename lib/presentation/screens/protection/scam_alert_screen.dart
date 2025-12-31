import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/local/database_helper.dart'; // Import Database

class IncomingScamScreen extends StatefulWidget {
  const IncomingScamScreen({super.key});

  @override
  State<IncomingScamScreen> createState() => _IncomingScamScreenState();
}

class _IncomingScamScreenState extends State<IncomingScamScreen> {
  // Hàm xóa số khỏi danh sách
  void _deleteNumber(String phone) async {
    await DatabaseHelper.instance.removeBlacklist(phone);
    setState(() {}); // Load lại giao diện sau khi xóa
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Đã bỏ chặn số $phone')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh Sách Chặn"),
        centerTitle: true,
        actions: [
          // Nút thêm nhanh ở góc trên
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/block_phone').then((_) {
                setState(() {}); // Khi quay lại thì reload danh sách
              });
            },
          )
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Gọi hàm lấy dữ liệu từ SQLite
        future: DatabaseHelper.instance.getAllBlacklist(), 
        builder: (context, snapshot) {
          // 1. Trạng thái đang tải
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. Nếu có lỗi
          if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          }

          final list = snapshot.data ?? [];

          // 3. Nếu danh sách trống
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_outlined, size: 80, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  const Text("An toàn! Chưa có số nào bị chặn.", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/block_phone').then((_) => setState(() {}));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
                    child: const Text("Thêm số chặn", style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            );
          }

          // 4. Hiển thị danh sách
          return ListView.builder(
            itemCount: list.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final item = list[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.red[100],
                    child: const Icon(Icons.block, color: Colors.red),
                  ),
                  title: Text(
                    item['phone_number'],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Text(
                    "${item['label'] ?? 'Chặn thủ công'} • ${item['source'] == 'CLOUD' ? 'Đồng bộ' : 'Cá nhân'}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.grey),
                    onPressed: () => _deleteNumber(item['phone_number']),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}