import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusModeService {
  static const _localKey = 'focus_mode';

  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static String? get _uid => _auth.currentUser?.uid;

  static DocumentReference<Map<String, dynamic>> _ref(String uid) {
    return _db.collection('users').doc(uid);
  }

  /// ===== INIT (DÙNG SAU KHI ĐĂNG KÝ / LOGIN LẦN ĐẦU) =====
  static Future<void> init(bool value) async {
    final uid = _uid;
    if (uid == null) return;

    await _ref(uid).set({
      'focusMode': value,
      'updatedAt': Timestamp.now(),
    }, SetOptions(merge: true)); // ⭐ KHÔNG BAO GIỜ LỖI

    await _saveLocal(value);
  }

  /// ===== LOAD (LOCAL TRƯỚC → UI KHÔNG GIẬT) =====
  static Future<bool> loadFocusMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_localKey) ?? false;
  }

  /// ===== SET (LOCAL + FIRESTORE AN TOÀN) =====
  static Future<void> setFocusMode(bool value) async {
    final uid = _uid;

    if (uid != null) {
      await _ref(uid).set({
        'focusMode': value,
        'updatedAt': Timestamp.now(),
      }, SetOptions(merge: true)); // ⭐ SỬA Ở ĐÂY
    }

    await _saveLocal(value);
  }

  /// ===== SYNC FIRESTORE → LOCAL =====
  static Future<void> syncFromFirestore() async {
    final uid = _uid;
    if (uid == null) return;

    final snap = await _ref(uid).get();

    if (!snap.exists) {
      // 🔥 User chưa có document → tạo mặc định
      await init(false);
      return;
    }

    final data = snap.data();
    final value = data?['focusMode'] ?? false;

    await _saveLocal(value);
  }

  /// ===== SAVE LOCAL =====
  static Future<void> _saveLocal(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_localKey, value);
  }
}
