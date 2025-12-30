import 'package:permission_handler/permission_handler.dart';

class ContactsPermissionService {
  static Future<bool> request() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }
}