import 'package:permission_handler/permission_handler.dart';

class ContactsPermissionService {
  /// Kiểm tra + xin quyền danh bạ
  static Future<bool> ensurePermission() async {
    final status = await Permission.contacts.status;

    if (status.isGranted) {
      return true;
    }

    final result = await Permission.contacts.request();
    return result.isGranted;
  }

  /// Mở cài đặt nếu bị từ chối vĩnh viễn
  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
