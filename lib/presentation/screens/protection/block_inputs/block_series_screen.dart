import 'package:flutter/material.dart';

class BlockSeriesScreen extends StatelessWidget {
  const BlockSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
        title: const Text("Chặn theo sêri điện thoại", style: TextStyle(fontSize: 18)),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[200]!), borderRadius: BorderRadius.circular(4)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: "start",
                  items: const [
                    DropdownMenuItem(value: "start", child: Text("Các số điện thoại bắt đầu với")),
                    DropdownMenuItem(value: "contain", child: Text("Các số điện thoại có chứa")),
                    DropdownMenuItem(value: "end", child: Text("Các số điện thoại kết thúc với")),
                  ],
                  onChanged: (val) {},
                ),
              ),
            ),
            const SizedBox(height: 16),
             TextField(
              decoration: InputDecoration(
                hintText: "Số điện thoại",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200]!)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[200]!)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFD1D5DB), elevation: 0),
                onPressed: () {},
                child: const Text("CHẶN", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}