import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/phone_service.dart'; // Import service lấy danh bạ

class KeypadView extends StatefulWidget {
  const KeypadView({super.key});

  @override
  State<KeypadView> createState() => _KeypadViewState();
}

class _KeypadViewState extends State<KeypadView> {
  String _dialedNumber = ""; // Số đang bấm
  List<Contact> _allContacts = []; // Tất cả danh bạ (Cache)
  List<Contact> _filteredContacts = []; // Danh sách tìm được

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  // 1. Tải danh bạ lên trước để tìm cho nhanh
  Future<void> _loadContacts() async {
    final contacts = await PhoneService.getContacts();
    setState(() {
      _allContacts = contacts;
    });
  }

  // 2. Logic tìm kiếm khi bấm số
  void _onKeyPress(String value) {
    setState(() {
      _dialedNumber += value;
      _filterContacts();
    });
  }

  // 3. Logic xóa số
  void _onBackspace() {
    if (_dialedNumber.isNotEmpty) {
      setState(() {
        _dialedNumber = _dialedNumber.substring(0, _dialedNumber.length - 1);
        _filterContacts();
      });
    }
  }

  // 4. Hàm lọc danh bạ
  void _filterContacts() {
    if (_dialedNumber.isEmpty) {
      _filteredContacts = [];
      return;
    }
    
    // Tìm các liên hệ có số điện thoại chứa chuỗi đang bấm
    _filteredContacts = _allContacts.where((contact) {
      // Kiểm tra tất cả các số của liên hệ này
      return contact.phones.any((phone) {
        // Xóa các ký tự thừa (khoảng trắng, dấu gạch ngang) để so sánh chuẩn
        String cleanPhone = phone.number.replaceAll(RegExp(r'\D'), ''); 
        return cleanPhone.contains(_dialedNumber);
      });
    }).toList();
  }

  // 5. Thực hiện cuộc gọi thật
  Future<void> _makeCall() async {
    if (_dialedNumber.isEmpty) return;
    
    final Uri launchUri = Uri(scheme: 'tel', path: _dialedNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Không thể thực hiện cuộc gọi")),
      );
    }
  }

  // 6. Gọi cho số trong danh sách tìm kiếm
  Future<void> _callContact(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85, // Chiều cao modal
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          // Thanh nắm kéo xuống
          Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
          
          // --- PHẦN 1: DANH SÁCH GỢI Ý (Giống hình bạn gửi) ---
          Expanded(
            child: _dialedNumber.isEmpty 
              ? const SizedBox.shrink() // Nếu chưa bấm gì thì để trống cho thoáng
              : ListView.builder(
                  itemCount: _filteredContacts.length,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final contact = _filteredContacts[index];
                    final phone = contact.phones.isNotEmpty ? contact.phones.first.number : "";
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text(contact.displayName[0], style: TextStyle(color: Colors.blue.shade900)),
                      ),
                      title: Text(contact.displayName, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(phone),
                      trailing: const Icon(Icons.call, color: Colors.green),
                      onTap: () => _callContact(phone), // Bấm vào dòng này là gọi luôn
                    );
                  },
                ),
          ),

          // --- PHẦN 2: HIỂN THỊ SỐ ĐANG BẤM ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 40), // Cân bằng khoảng trống nút xóa
                Expanded(
                  child: Text(
                    _dialedNumber,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                // Nút xóa (Backspace)
                if (_dialedNumber.isNotEmpty)
                  GestureDetector(
                    onTap: _onBackspace,
                    onLongPress: () {
                      setState(() {
                        _dialedNumber = "";
                        _filterContacts();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.backspace_outlined, color: Colors.grey, size: 24),
                    ),
                  )
                else 
                  const SizedBox(width: 40), // Giữ chỗ
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey.shade200),

          // --- PHẦN 3: BÀN PHÍM SỐ (GRID) ---
          SizedBox(
            height: 380, // Chiều cao cố định cho bàn phím
            child: Column(
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    childAspectRatio: 1.6,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    physics: const NeverScrollableScrollPhysics(), // Không cho cuộn bàn phím
                    children: [
                      _buildKey("1", ""),
                      _buildKey("2", "ABC"),
                      _buildKey("3", "DEF"),
                      _buildKey("4", "GHI"),
                      _buildKey("5", "JKL"),
                      _buildKey("6", "MNO"),
                      _buildKey("7", "PQRS"),
                      _buildKey("8", "TUV"),
                      _buildKey("9", "WXYZ"),
                      _buildKey("*", ""),
                      _buildKey("0", "+"),
                      _buildKey("#", ""),
                    ],
                  ),
                ),
                
                // --- PHẦN 4: NÚT GỌI (1 Nút duy nhất) ---
                Padding(
                  padding: const EdgeInsets.only(bottom: 30, top: 10),
                  child: ElevatedButton(
                    onPressed: _makeCall,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                      elevation: 5,
                    ),
                    child: const Icon(Icons.call, color: Colors.white, size: 32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget hiển thị phím số (Có chữ nhỏ bên dưới như ảnh thật)
  Widget _buildKey(String number, String letters) {
    return InkWell(
      onTap: () => _onKeyPress(number),
      borderRadius: BorderRadius.circular(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(number, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w400)),
          if (letters.isNotEmpty)
            Text(letters, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}