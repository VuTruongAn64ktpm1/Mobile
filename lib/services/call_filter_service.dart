import 'call_log_service.dart';
import 'spam_service.dart';
import 'block_service.dart';

/// 🔔 KẾT QUẢ CUỘC GỌI
enum CallDecision {
  block,      // Spam / Bị chặn → chặn
  silent,     // Focus mode → im lặng
  ring,       // Gọi bình thường
  emergency,  // Khẩn cấp → vượt rào
}

class CallFilterService {
  /// ===== XỬ LÝ CUỘC GỌI ĐẾN =====
  static Future<CallDecision> handleIncomingCall({
    required String phoneNumber,
    required bool isFocusModeOn,
    String? callerName,
  }) async {
    // 0️⃣ BỊ CHẶN THỦ CÔNG (BẢO VỆ)
    final isManuallyBlocked = await BlockService.isBlocked(
      phone: phoneNumber,
      name: callerName,
    );
    if (isManuallyBlocked) {
      return CallDecision.block;
    }

    // 1️⃣ SPAM → CHẶN CỨNG
    final isSpam = await SpamService.isSpam(phoneNumber);
    if (isSpam) {
      return CallDecision.block;
    }

    // 2️⃣ KHÔNG BẬT FOCUS MODE → ĐỔ CHUÔNG
    if (!isFocusModeOn) {
      return CallDecision.ring;
    }

    // 3️⃣ FOCUS MODE ĐANG BẬT
    // 3.1️⃣ GỌI LẠI TRONG THỜI GIAN NGẮN → KHẨN CẤP
    final isRepeated =
        await CallLogService.isRepeatedCall(phoneNumber);
    if (isRepeated) {
      return CallDecision.emergency;
    }

    // 3.2️⃣ CÒN LẠI → IM LẶNG
    return CallDecision.silent;
  }
}
