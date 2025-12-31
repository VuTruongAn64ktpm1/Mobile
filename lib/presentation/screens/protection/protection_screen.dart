import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class ProtectionScreen extends StatefulWidget {
  const ProtectionScreen({super.key});

  @override
  State<ProtectionScreen> createState() => _ProtectionScreenState();
}

class _ProtectionScreenState extends State<ProtectionScreen> {
  bool _isProtectionOn = true;
  bool _notifyBlockedCall = true;
  bool _notifyBlockedSms = true;
  bool _blockBusiness = true;
  bool _blockInternational = false;
  bool _blockHidden = true;
  bool _blockNotInContacts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HEADER MÀU XANH ---
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 20, left: 20, right: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade700, Colors.blue.shade500],
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Bảo vệ tôi",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  // Icon Khiên
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.shield_rounded,
                      size: 60,
                      color: Colors.blue.shade600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Mức độ bảo vệ | Cơ bản",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 25),
                  
                  // Nút Tắt / Bật
                  Container(
                    width: 200,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isProtectionOn = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: !_isProtectionOn ? Colors.blue.shade900 : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: const Center(
                                child: Text("Tắt", style: TextStyle(color: Colors.white70)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isProtectionOn = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _isProtectionOn ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Center(
                                child: Text(
                                  "Bật", 
                                  style: TextStyle(
                                    color: _isProtectionOn ? Colors.blue.shade700 : Colors.white70,
                                    fontWeight: FontWeight.bold
                                  ),
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

            // --- 2. BANNER HỒNG (Spam tin nhắn) ---
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.pink.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Tính năng bảo vệ khỏi spam cho tin nhắn",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.red.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.message, color: Colors.white, size: 20),
                  )
                ],
              ),
            ),

            // --- 3. CÀI ĐẶT THÔNG BÁO ---
            _buildSectionHeader("Cài đặt thông báo"),
            _buildSwitchItem("Thông báo các cuộc gọi bị chặn", _notifyBlockedCall, (v) => setState(() => _notifyBlockedCall = v)),
            Divider(height: 1, color: Colors.grey[200]),
            _buildSwitchItem("Thông báo về các tin nhắn đã bị chặn", _notifyBlockedSms, (v) => setState(() => _notifyBlockedSms = v)),
            const SizedBox(height: 20),

            // --- 4. DANH SÁCH CHẶN (ENTRY POINTS) ---
            _buildSectionHeader("Thêm vào danh sách chặn của tôi"),
            _buildNavItem(context, Icons.phone, "Số điện thoại", '/block_phone'),
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildNavItem(context, Icons.person, "Tên người gọi", '/block_name'), // Cần tạo route này sau
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildNavItem(context, Icons.fingerprint, "ID người gửi", '/block_id'),
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildNavItem(context, Icons.flag, "Mã quốc gia", '/block_country'),
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildNavItem(context, Icons.dialpad, "Chuỗi số", '/block_series'),
            
            // Nút Xem tất cả
            Center(
              child: TextButton(
                onPressed: () {
                  // Chuyển sang màn hình danh sách cũ (scam_alert_screen)
                  Navigator.pushNamed(context, '/scam_alert');
                },
                child: const Text("Xem tất cả", style: TextStyle(color: Colors.blue)),
              ),
            ),
            const SizedBox(height: 20),

            // --- 5. CHẶN NÂNG CAO ---
            _buildSectionHeader("Chức năng chặn nâng cao"),
            _buildAdvancedSwitch(
              Icons.business_center_outlined, 
              "Chặn các doanh nghiệp đã xác minh", 
              "Các doanh nghiệp đã được đánh dấu là bị chặn",
              _blockBusiness,
              (v) => setState(() => _blockBusiness = v)
            ),
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildAdvancedSwitch(
              Icons.language, 
              "Các số nước ngoài", 
              "Chỉ quốc gia của bạn",
              _blockInternational,
              (v) => setState(() => _blockInternational = v)
            ),
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildAdvancedSwitch(
              Icons.smartphone, 
              "Số điện thoại ẩn", 
              "Chặn tất số của số lạ",
              _blockHidden,
              (v) => setState(() => _blockHidden = v)
            ),
            Divider(height: 1, indent: 50, color: Colors.grey[200]),
            _buildAdvancedSwitch(
              Icons.person_off_outlined, 
              "Số không có trong danh bạ", 
              "Chỉ danh bạ mới liên hệ được",
              _blockNotInContacts,
              (v) => setState(() => _blockNotInContacts = v)
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- CÁC WIDGET CON (HELPER) ---

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13)),
    );
  }

  Widget _buildSwitchItem(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontSize: 15)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontSize: 15)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildAdvancedSwitch(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SwitchListTile(
        secondary: Icon(icon, color: Colors.grey[700]),
        title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.blue,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
    );
  }
}