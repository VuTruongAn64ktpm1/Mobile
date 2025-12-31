import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FocusModeService {
  static const _localKey = 'focus_mode';
  static final _db = FirebaseFirestore.instance;

  static String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  static DocumentReference<Map<String, dynamic>> get _ref {
    final uid = _uid;
    if (uid == null) {
      throw Exception('User chưa đăng nhập');
    }
    return _db.collection('users').doc(uid);
  }

  /// ===== INIT (GỌI SAU ĐĂNG KÝ) =====
  static Future<void> init(bool value) async {
    if (_uid == null) return;

    await _ref.set(
      {
        'focusMode': value,
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    await _saveLocal(value);
  }

  /// ===== LOAD LOCAL =====
  static Future<bool> loadFocusMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_localKey) ?? false;
  }

  /// ===== SET (KHÔNG BAO GIỜ DÙNG update) =====
  static Future<void> setFocusMode(bool value) async {
    if (_uid != null) {
      await _ref.set(
        {
          'focusMode': value,
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
    }

    await _saveLocal(value);
  }

  /// ===== SYNC FIRESTORE → LOCAL =====
  static Future<void> syncFromFirestore() async {
    if (_uid == null) return;

    final snap = await _ref.get();

    if (!snap.exists) {
      await init(false);
      return;
    }

    final data = snap.data();
    if (data == null || !data.containsKey('focusMode')) {
      await init(false);
      return;
    }

    await _saveLocal(data['focusMode'] as bool);
  }

  /// ===== SAVE LOCAL =====
  static Future<void> _saveLocal(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_localKey, value);
  }
}
