class CallLogService {
  /// Lưu thời điểm gọi gần nhất của từng số
  static final Map<String, DateTime> _lastCallTime = {};

  /// 🔹 Kiểm tra có phải gọi lại trong thời gian ngắn không
  ///
  /// - true  → gọi lại (khẩn cấp)
  /// - false → không phải
  static Future<bool> isRepeatedCall(String phoneNumber) async {
    final now = DateTime.now();

    if (_lastCallTime.containsKey(phoneNumber)) {
      final lastTime = _lastCallTime[phoneNumber]!;

      // ⏱️ Khoảng thời gian gọi lại (3 phút)
      final diff = now.difference(lastTime);

      // Cập nhật lại thời điểm gọi
      _lastCallTime[phoneNumber] = now;

      return diff.inMinutes <= 3;
    }

    // Lần đầu gọi → lưu lại
    _lastCallTime[phoneNumber] = now;
    return false;
  }
}
