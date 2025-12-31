import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/local/database_helper.dart'; // Import Database

class BlockPhoneScreen extends StatefulWidget {
  const BlockPhoneScreen({super.key});

  @override
  State<BlockPhoneScreen> createState() => _BlockPhoneScreenState();
}

class _BlockPhoneScreenState extends State<BlockPhoneScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController(); // Thêm nhập tên gợi nhớ
  String _selectedType = 'Lừa đảo'; // Mặc định là lừa đảo

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // Hàm xử lý khi bấm nút "Chặn ngay"
  void _onBlockPressed() async {
    String phone = _phoneController.text.trim();
    String name = _nameController.text.trim();

    // 1. Kiểm tra dữ liệu đầu vào
    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập số điện thoại!')),
      );
      return;
    }

    try {
      // 2. Lưu vào SQLite (DatabaseHelper)
      await DatabaseHelper.instance.insertBlacklist({
        'phone_number': phone,
        'user_id': 'USER_DEVICE', // Đánh dấu do người dùng tự chặn
        'label': _selectedType,   // Loại: Lừa đảo/Spam/Đòi nợ...
        'source': 'MANUAL',       // Nguồn: Nhập tay
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });

      if (!mounted) return; // Kiểm tra màn hình còn tồn tại không

      // 3. Thông báo và thoát
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã thêm vào danh sách chặn!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context); // Quay về màn hình trước
      
    } catch (e) {
      print("Lỗi Database: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Lỗi: Số này có thể đã tồn tại trong danh sách.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chặn số điện thoại"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nhập số điện thoại muốn chặn:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Ô nhập số điện thoại
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Ví dụ: 0987654321",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              "Tên gợi nhớ (Tùy chọn):",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Ô nhập tên
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Ví dụ: Đòi nợ FE",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
            const SizedBox(height: 20),

            const Text("Chọn loại chặn:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // Dropdown chọn loại
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedType,
                  isExpanded: true,
                  items: <String>['Lừa đảo', 'Spam', 'Đòi nợ', 'Quấy rối']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedType = newValue!;
                    });
                  },
                ),
              ),
            ),
            const Spacer(),

            // Nút Lưu / Chặn
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _onBlockPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue, // Hoặc Colors.red nếu muốn cảnh báo mạnh
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  "CHẶN NGAY",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}