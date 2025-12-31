import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceContactsService {
  static Future<List<Contact>> getContacts() async {
    // 1️⃣ Xin quyền danh bạ
    final status = await Permission.contacts.request();
    if (!status.isGranted) {
      return [];
    }

    // 2️⃣ Lấy danh bạ
    final contacts = await FlutterContacts.getContacts(
      withProperties: true,
      withPhoto: false,
    );

    return contacts;
  }
}
