import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BlockService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  // 1. Cập nhật trạng thái các nút gạt (Switch)
  Future<void> updateSetting(String field, bool value) async {
    if (uid == null) return;
    await _db.collection('user_settings').doc(uid).set({
      field: value,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  // 2. Thêm một mục vào danh sách chặn (Số điện thoại, mã vùng...)
  Future<void> addToBlacklist(String type, String value) async {
    if (uid == null) return;
    await _db.collection('blacklists').add({
      'ownerId': uid,
      'type': type,
      'value': value,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 3. Lấy dòng dữ liệu cài đặt về để hiển thị lên UI
  Stream<DocumentSnapshot> getSettings() {
    return _db.collection('user_settings').doc(uid).snapshots();
  }
}