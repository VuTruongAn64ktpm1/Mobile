import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:call_log/call_log.dart'; // Thư viện lấy lịch sử
import 'package:intl/intl.dart'; // Thư viện định dạng ngày giờ
import '../../../../core/app_colors.dart';
import '../../../../data/local/database_helper.dart';
import 'edit_contact_screen.dart';

class ContactDetailScreen extends StatefulWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  // Biến chứa danh sách lịch sử cuộc gọi riêng của số này
  late Future<List<CallLogEntry>> _historyFuture;

  @override
  void initState() {
    super.initState();
    _historyFuture = _getContactLogs(); // Tải lịch sử khi mở màn hình
  }

  // --- LOGIC LẤY LỊCH SỬ THẬT ---
  Future<List<CallLogEntry>> _getContactLogs() async {
    // 1. Lấy tất cả lịch sử trong máy (Lấy 100 cái gần nhất cho nhanh)
    // Lưu ý: CallLog.query không hỗ trợ lọc nhiều số 1 lúc tốt, nên ta lấy về rồi tự lọc
    Iterable<CallLogEntry> allLogs = await CallLog.get();
    
    // 2. Lấy danh sách các số điện thoại của liên hệ này
    List<String> contactNumbers = widget.contact.phones.map((e) => _cleanPhone(e.number)).toList();

    if (contactNumbers.isEmpty) return [];

    // 3. Lọc ra những cuộc gọi trùng khớp số
    return allLogs.where((log) {
      String logNumber = _cleanPhone(log.number ?? "");
      // So sánh: Nếu số log chứa số contact hoặc ngược lại (để xử lý vụ +84 và 09)
      return contactNumbers.any((cNum) => logNumber.endsWith(cNum) || cNum.endsWith(logNumber));
    }).take(10).toList(); // Chỉ lấy 10 cuộc gọi gần nhất
  }

  // Hàm làm sạch số điện thoại (bỏ khoảng trắng, dấu -) để so sánh
  String _cleanPhone(String phone) {
    return phone.replaceAll(RegExp(r'\D'), ''); // Chỉ giữ lại số
  }

  // Các hàm chức năng cũ
  void _makeCall() async {
    if (widget.contact.phones.isNotEmpty) {
      final Uri launchUri = Uri(scheme: 'tel', path: widget.contact.phones.first.number);
      await launchUrl(launchUri);
    }
  }

  void _sendSms() async {
    if (widget.contact.phones.isNotEmpty) {
      final Uri launchUri = Uri(scheme: 'sms', path: widget.contact.phones.first.number);
      await launchUrl(launchUri);
    }
  }

  void _blockContact() async {
    if (widget.contact.phones.isNotEmpty) {
      String phone = widget.contact.phones.first.number;
      await DatabaseHelper.instance.insertBlacklist({
        'phone_number': phone,
        'user_id': 'USER_DEVICE',
        'label': widget.contact.displayName,
        'source': 'MANUAL',
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã chặn số này!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = widget.contact.phones.isNotEmpty ? widget.contact.phones.first.number : "Không có số";

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text("TRONG DANH BẠ CỦA BẠN", style: TextStyle(fontSize: 12, color: Colors.white70)),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert, color: Colors.white), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(height: 60, color: Colors.blue),
                Positioned(
                  top: 10,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue.shade100,
                        child: Text(
                          widget.contact.displayName.isNotEmpty ? widget.contact.displayName[0] : "?",
                          style: const TextStyle(fontSize: 30, color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(widget.contact.displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),

            // Nút chức năng
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildActionButton(Icons.call, "Gọi", _makeCall),
                  _buildActionButton(Icons.message, "Tin nhắn", _sendSms),
                  _buildActionButton(Icons.edit, "Chỉnh sửa", () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditContactScreen(contact: widget.contact)),
                    );
                    setState(() {});
                  }),
                  _buildActionButton(Icons.block, "Chặn", _blockContact),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Thông tin số
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  const Icon(Icons.phone_in_talk, color: Colors.grey),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(phoneNumber, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const Text("Vietnam • Viettel", style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Icon(Icons.video_call, color: Colors.grey),
                  const SizedBox(width: 16),
                  const Icon(Icons.message, color: Colors.grey),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // --- PHẦN HIỂN THỊ LỊCH SỬ CUỘC GỌI THẬT ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Lịch sử cuộc gọi", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 10),
                  
                  // FutureBuilder để tải dữ liệu
                  FutureBuilder<List<CallLogEntry>>(
                    future: _historyFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: Padding(padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()));
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Chưa có lịch sử cuộc gọi nào với người này.", style: TextStyle(fontStyle: FontStyle.italic)),
                        );
                      }

                      final logs = snapshot.data!;
                      return ListView.separated(
                        shrinkWrap: true, // Quan trọng: để list nằm gọn trong Column
                        physics: const NeverScrollableScrollPhysics(), // Không cho cuộn riêng
                        itemCount: logs.length,
                        separatorBuilder: (context, index) => const Divider(height: 20),
                        itemBuilder: (context, index) {
                          final log = logs[index];
                          // Xử lý icon và loại cuộc gọi
                          IconData icon = Icons.call_received;
                          Color color = Colors.grey;
                          String typeText = "Cuộc gọi đến";

                          if (log.callType == CallType.outgoing) {
                            icon = Icons.call_made;
                            typeText = "Cuộc gọi đi";
                          } else if (log.callType == CallType.missed) {
                            icon = Icons.call_missed;
                            color = Colors.red;
                            typeText = "Cuộc gọi nhỡ";
                          } else if (log.callType == CallType.blocked) {
                            icon = Icons.block;
                            color = Colors.red;
                            typeText = "Đã chặn";
                          }

                          // Xử lý thời gian
                          String timeStr = DateFormat('dd thg MM • HH:mm').format(DateTime.fromMillisecondsSinceEpoch(log.timestamp ?? 0));

                          return Row(
                            children: [
                              Icon(icon, color: color, size: 20),
                              const SizedBox(width: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(timeStr, style: const TextStyle(fontSize: 16)),
                                  Text(typeText, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                              const Spacer(),
                              Text("${log.duration}s", style: const TextStyle(color: Colors.grey)),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  
                  const SizedBox(height: 10),
                  const Divider(),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text("XEM TẤT CẢ", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
            ),
            child: Icon(icon, color: Colors.blue),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}