import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _focusKey = 'focus_mode';

  /// 🔹 LƯU FOCUS MODE (LOCAL)
  static Future<void> setFocusMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_focusKey, value);
  }

  /// 🔹 LẤY FOCUS MODE (CÓ THỂ NULL)
  ///
  /// - null  → chưa từng lưu (lần đầu cài app)
  /// - true/false → đã có dữ liệu
  static Future<bool?> getFocusMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_focusKey);
  }

  /// 🔹 XOÁ FOCUS MODE (khi logout nếu cần)
  static Future<void> clearFocusMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_focusKey);
  }
}
