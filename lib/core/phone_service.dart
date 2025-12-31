import 'package:call_log/call_log.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneService {
  // 1. Lấy lịch sử cuộc gọi
  static Future<List<CallLogEntry>> getCallHistory() async {
    // Xin quyền
    if (await Permission.phone.request().isGranted) {
      // Lấy danh sách
      Iterable<CallLogEntry> entries = await CallLog.get();
      return entries.toList();
    }
    return [];
  }

  // 2. Lấy danh bạ
  static Future<List<Contact>> getContacts() async {
    // Xin quyền
    if (await Permission.contacts.request().isGranted) {
      // Lấy danh sách (kèm ảnh avatar nếu có)
      return await FlutterContacts.getContacts(withProperties: true, withPhoto: true);
    }
    return [];
  }
}