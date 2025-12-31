import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class CallerIdOverlay extends StatelessWidget {
  const CallerIdOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy dữ liệu truyền từ Native qua (Số điện thoại, Tên, Loại spam...)
    // Ví dụ: {"phone": "0559 152 180", "type": "spam", "label": "Lừa đảo"}
    // Ở đây mình hard-code demo giống ảnh
    
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 160, // Chiều cao popup
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50), // Cách lề
        decoration: BoxDecoration(
          color: const Color(0xFF007AFF), // Màu xanh Truecaller
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          children: [
            // Header: Người gọi lần đầu
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: const [
                  Icon(Icons.star, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text("Người gọi lần đầu", style: TextStyle(color: Colors.white, fontSize: 12)),
                  Spacer(),
                  Icon(Icons.close, color: Colors.white, size: 16), // Nút tắt popup
                ],
              ),
            ),
            
            // Body: Số điện thoại & Thông tin
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    width: 50, height: 50,
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.person, color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  
                  // Thông tin
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "0559 152 180", 
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)
                      ),
                      SizedBox(height: 4),
                      Text("Vietnam", style: TextStyle(color: Colors.white70, fontSize: 14)),
                      SizedBox(height: 8),
                      // Nhãn Spam (nếu có)
                      // Container(padding: ..., child: Text("Lừa đảo", ...))
                    ],
                  )
                ],
              ),
            ),
            
            // Footer: Brand
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 12, bottom: 8),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text("An Tam Nghe Premium ♛", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }
}