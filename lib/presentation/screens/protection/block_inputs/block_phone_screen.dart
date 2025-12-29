import 'package:flutter/material.dart';

class BlockPhoneScreen extends StatefulWidget {
  const BlockPhoneScreen({super.key});

  @override
  State<BlockPhoneScreen> createState() => _BlockPhoneScreenState();
}

class _BlockPhoneScreenState extends State<BlockPhoneScreen> {
  int _type = 0; // 0: Kinh doanh, 1: Người

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: const Text("Chặn một số điện thoại", style: TextStyle(fontSize: 18)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown Quốc gia
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(4)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: "VN",
                  items: const [DropdownMenuItem(value: "VN", child: Text("Vietnam (+84)"))],
                  onChanged: (val) {},
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildInput("Số điện thoại"),
            const SizedBox(height: 16),
            _buildInput("Tên"),
            const SizedBox(height: 16),
            
            // Radio Button
            Row(
              children: [
                _buildRadio(0, "Kinh doanh"),
                const SizedBox(width: 24),
                _buildRadio(1, "Người"),
              ],
            ),
            const SizedBox(height: 24),
            
            // Nút Chặn (Màu xám)
            SizedBox(
              width: double.infinity, height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD1D5DB), elevation: 0),
                onPressed: () {},
                child: const Text("CHẶN", style: TextStyle(color: Colors.white)),
              ),
            ),
            
            const SizedBox(height: 30),
            const Text("Các số bị chặn", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            
            // List item mẫu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("+84559152180", style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("0559 152 180  •  12/12/2025", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                  ],
                ),
                Icon(Icons.remove_circle_outline, color: Colors.grey[400])
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300]!)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }

  Widget _buildRadio(int val, String label) {
    return GestureDetector(
      onTap: () => setState(() => _type = val),
      child: Row(
        children: [
          Icon(_type == val ? Icons.radio_button_checked : Icons.radio_button_unchecked, color: const Color(0xFF007AFF)),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}