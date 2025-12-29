import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class ProtectionScreen extends StatefulWidget {
  const ProtectionScreen({super.key});

  @override
  State<ProtectionScreen> createState() => _ProtectionScreenState();
}

class _ProtectionScreenState extends State<ProtectionScreen> {
  // Trạng thái các công tắc (Giả lập)
  bool isProtectionOn = true;
  bool notifBlockedCall = true;
  bool notifBlockedMsg = true;
  bool blockBusiness = true;
  bool blockInternational = true;
  bool blockHidden = true;
  bool blockStranger = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- 1. HEADER XANH DƯƠNG ---
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0044CC), Color(0xFF0088FF)], // Gradient xanh đậm -> nhạt
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.only(top: 60, bottom: 20),
              child: Column(
                children: [
                  const Text(
                    "Bảo vệ tôi",
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  
                  // Icon Khiên bảo vệ
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.verified_user, color: Color(0xFF007AFF), size: 40),
                  ),
                  const SizedBox(height: 12),
                  
                  const Text(
                    "Mức độ bảo vệ | Cơ bản",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  
                  // Công tắc Tắt/Bật (Segmented Control)
                  Container(
                    width: 200,
                    height: 40,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15), // Nền mờ
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        // Nút Tắt
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isProtectionOn = false),
                            child: Container(
                              decoration: BoxDecoration(
                                color: !isProtectionOn ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Tắt",
                                style: TextStyle(
                                  color: !isProtectionOn ? const Color(0xFF007AFF) : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Nút Bật
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => isProtectionOn = true),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isProtectionOn ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "Bật",
                                style: TextStyle(
                                  color: isProtectionOn ? const Color(0xFF007AFF) : Colors.white70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // --- 2. NỘI DUNG CÀI ĐẶT ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Banner màu hồng
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEBEE), // Hồng nhạt
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: const [
                        Expanded(
                          child: Text(
                            "Tính năng bảo vệ khỏi spam cho tin nhắn",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.mark_chat_unread_rounded, color: Colors.redAccent, size: 28)
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section: Cài đặt thông báo
                  _buildSectionTitle("Cài đặt thông báo"),
                  _buildSwitchTile("Thông báo các cuộc gọi bị chặn", notifBlockedCall, (v) => setState(() => notifBlockedCall = v)),
                  const Divider(height: 1),
                  _buildSwitchTile("Thông báo về các tin nhắn đã bị chặn", notifBlockedMsg, (v) => setState(() => notifBlockedMsg = v)),
                  
                  const SizedBox(height: 24),

                  // Section: Thêm vào danh sách chặn
                  _buildActionItem(context, Icons.call, "Số điện thoại", '/block_phone'),
                  const Divider(height: 1, indent: 50),
                  _buildActionItem(context, Icons.person, "Tên người gọi", '/block_name'),
                  const Divider(height: 1, indent: 50),
                  _buildActionItem(context, Icons.fingerprint, "ID người gửi", '/block_name'), // Tạm dùng chung giao diện chặn tên
                  const Divider(height: 1, indent: 50),
                  _buildActionItem(context, Icons.flag, "Mã quốc gia", '/block_country'),
                  const Divider(height: 1, indent: 50),
                  _buildActionItem(context, Icons.dialpad, "Chuỗi số", '/block_series'),
                                    
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      "Xem tất cả",
                      style: TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.w500),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Divider(thickness: 1),
                  const SizedBox(height: 16),

                  // Section: Chức năng chặn nâng cao
                  _buildSectionTitle("Chức năng chặn nâng cao"),
                  _buildAdvancedSwitch(
                    Icons.business_center_outlined,
                    "Chặn các doanh nghiệp đã xác minh",
                    "Các doanh nghiệp đã được đánh dấu là bị chặn",
                    blockBusiness,
                    (v) => setState(() => blockBusiness = v),
                  ),
                  const Divider(height: 1, indent: 56),
                  
                  _buildAdvancedSwitch(
                    Icons.public,
                    "Các số nước ngoài",
                    "Chỉ quốc gia của bạn",
                    blockInternational,
                    (v) => setState(() => blockInternational = v),
                  ),
                  const Divider(height: 1, indent: 56),

                  _buildAdvancedSwitch(
                    Icons.mobile_off_outlined,
                    "Số điện thoại ẩn",
                    "Chặn tất số của số lạ",
                    blockHidden,
                    (v) => setState(() => blockHidden = v),
                  ),
                  const Divider(height: 1, indent: 56),

                  _buildAdvancedSwitch(
                    Icons.person_off_outlined,
                    "Số không có trang danh bạ",
                    "Chỉ danh bạ mới liên hệ được",
                    blockStranger,
                    (v) => setState(() => blockStranger = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget tiêu đề nhỏ màu xám
  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }

  // Widget công tắc thường
  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      activeColor: const Color(0xFF007AFF),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      value: value,
      onChanged: onChanged,
    );
  }

  // Widget mục danh sách có icon (ListTile)
Widget _buildActionItem(BuildContext context, IconData icon, String title, String route) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: Colors.grey[600], size: 22),
    title: Text(title, style: const TextStyle(fontSize: 15)),
    onTap: () {
      Navigator.pushNamed(context, route);
    },
  );
}

  // Widget công tắc nâng cao (có icon + subtitle)
  Widget _buildAdvancedSwitch(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.black54, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF007AFF),
          ),
        ],
      ),
    );
  }
}