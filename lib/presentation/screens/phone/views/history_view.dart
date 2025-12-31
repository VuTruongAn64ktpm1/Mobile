import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/phone_service.dart';
import 'contact_detail_screen.dart';

class HistoryView extends StatelessWidget {
  final CallType? filterType; // Biến nhận bộ lọc từ màn hình chính

  // Constructor nhận thêm filterType (có thể null = hiện tất cả)
  const HistoryView({super.key, this.filterType});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CallLogEntry>>(
      future: PhoneService.getCallHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final allLogs = snapshot.data ?? [];
        
        // --- LOGIC BACKEND: LỌC DỮ LIỆU ---
        List<CallLogEntry> displayedLogs = [];
        if (filterType == null) {
          // Nếu không lọc thì hiện hết
          displayedLogs = allLogs;
        } else {
          // Nếu có lọc, chỉ lấy đúng loại (Đi/Đến/Nhỡ/Chặn)
          displayedLogs = allLogs.where((log) => log.callType == filterType).toList();
        }

        if (displayedLogs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.history_toggle_off, size: 50, color: Colors.grey[300]),
                const SizedBox(height: 10),
                const Text("Không tìm thấy cuộc gọi nào", style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        }

        return ListView.separated(
          itemCount: displayedLogs.length,
          separatorBuilder: (ctx, i) => const Divider(height: 1, indent: 70),
          itemBuilder: (context, index) {
            final entry = displayedLogs[index];
            final displayName = entry.name ?? entry.number ?? "Không xác định";
            
            return ListTile(
              onTap: () {
                Contact tempContact = Contact();
                tempContact.displayName = displayName;
                if (entry.number != null) tempContact.phones = [Phone(entry.number!)];

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactDetailScreen(contact: tempContact)),
                );
              },
              leading: CircleAvatar(
                backgroundColor: _getColorForAvatar(entry.callType),
                child: _getIconForAvatar(entry.callType),
              ),
              title: Text(
                displayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: entry.callType == CallType.missed ? Colors.red : Colors.black,
                ),
              ),
              subtitle: Row(
                children: [
                  _getSmallIcon(entry.callType),
                  const SizedBox(width: 5),
                  Text(
                    DateFormat('dd/MM - HH:mm').format(DateTime.fromMillisecondsSinceEpoch(entry.timestamp ?? 0)),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.call, color: Colors.green),
                onPressed: () async {
                   if (entry.number != null) {
                     final Uri launchUri = Uri(scheme: 'tel', path: entry.number!);
                     if (await canLaunchUrl(launchUri)) await launchUrl(launchUri);
                   }
                },
              ),
            );
          },
        );
      },
    );
  }

  // Helper: Chọn màu nền Avatar theo loại cuộc gọi
  Color _getColorForAvatar(CallType? type) {
    if (type == CallType.missed) return Colors.red.shade50;
    if (type == CallType.blocked) return Colors.grey.shade200;
    return Colors.blue.shade50;
  }

  // Helper: Chọn icon trong Avatar
  Widget _getIconForAvatar(CallType? type) {
    if (type == CallType.missed) return const Text("!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20));
    if (type == CallType.blocked) return const Icon(Icons.block, color: Colors.grey, size: 20);
    return const Icon(Icons.person, color: Colors.blue);
  }

  // Helper: Icon nhỏ báo trạng thái
  Widget _getSmallIcon(CallType? type) {
    switch (type) {
      case CallType.outgoing: return const Icon(Icons.call_made, size: 14, color: Colors.blue);
      case CallType.incoming: return const Icon(Icons.call_received, size: 14, color: Colors.green);
      case CallType.missed: return const Icon(Icons.call_missed, size: 14, color: Colors.red);
      case CallType.blocked: return const Icon(Icons.block, size: 14, color: Colors.red);
      default: return const Icon(Icons.help_outline, size: 14, color: Colors.grey);
    }
  }
}