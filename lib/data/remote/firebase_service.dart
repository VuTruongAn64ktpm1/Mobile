import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../local/database_helper.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // HÀM 1: Đồng bộ "Delta" (Chỉ tải số Spam mới)
  Future<void> syncSpamNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    // Lấy mốc thời gian lần cuối sync (mặc định là 0)
    final lastSync = prefs.getInt('last_sync_timestamp') ?? 0;

    print("Bắt đầu đồng bộ từ mốc: $lastSync");

    // Query Firebase: Lấy các số có updated_at > lastSync
    final querySnapshot = await _firestore
        .collection('spam_numbers')
        .where('updated_at', isGreaterThan: lastSync)
        .get();

    if (querySnapshot.docs.isEmpty) {
      print("Không có dữ liệu mới.");
      return;
    }

    print("Tìm thấy ${querySnapshot.docs.length} số mới. Đang lưu vào SQLite...");

    // Lưu vào SQLite
    final batch = DatabaseHelper.instance; 
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      // Chuẩn hóa dữ liệu để khớp với bảng SQLite
      await batch.insertBlacklist({
        'phone_number': doc.id, // ID document là số điện thoại
        'user_id': 'GLOBAL',    // Đánh dấu là dữ liệu chung
        'label': data['type'] ?? 'Spam',
        'source': 'CLOUD',
        'created_at': DateTime.now().millisecondsSinceEpoch,
      });
    }

    // Cập nhật lại mốc thời gian sync mới nhất
    final now = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('last_sync_timestamp', now);
    print("Đồng bộ hoàn tất!");
  }

  // HÀM 2: Báo cáo số Spam mới lên Firebase
  Future<void> reportSpam(String phone, String type, String userId) async {
    final docRef = _firestore.collection('spam_numbers').doc(phone);

    await _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);

      if (!snapshot.exists) {
        // Nếu số chưa có -> Tạo mới
        transaction.set(docRef, {
          'type': type,
          'report_count': 1,
          'reported_by': FieldValue.arrayUnion([userId]),
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        });
      } else {
        // Nếu số đã có -> Tăng biến đếm
        transaction.update(docRef, {
          'report_count': FieldValue.increment(1),
          'reported_by': FieldValue.arrayUnion([userId]),
          'updated_at': DateTime.now().millisecondsSinceEpoch,
        });
      }
    });
    
    // Đồng thời lưu vào máy mình luôn (SQLite)
    await DatabaseHelper.instance.insertBlacklist({
      'phone_number': phone,
      'user_id': userId,
      'label': type,
      'source': 'USER',
      'created_at': DateTime.now().millisecondsSinceEpoch,
    });
  }
}