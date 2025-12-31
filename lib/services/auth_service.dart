import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'block_service.dart';
import 'focus_mode_service.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// ===== STREAM THEO DÕI LOGIN =====
  static Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  /// ===== ĐĂNG KÝ =====
  static Future<String?> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final UserCredential cred =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final String uid = cred.user!.uid;

      /// 🔥 TẠO USER DOCUMENT (LẦN ĐẦU)
      await _db.collection('users').doc(uid).set({
        'email': email,
        'name': name,
        'name_lower': name.toLowerCase(),
        'focusMode': false,
        'blocks': {
          'phones': [],
          'series': [],
          'names': [],
          'countries': [],
        },
        'createdAt': Timestamp.now(),
      });

      /// ⭐ INIT LOCAL CACHE
      await FocusModeService.init(false);
      await BlockService.syncFromFirestore(); // block list trống

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Có lỗi xảy ra, vui lòng thử lại';
    }
  }

  /// ===== ĐĂNG NHẬP =====
  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = cred.user!.uid;
      final ref = _db.collection('users').doc(uid);
      final snap = await ref.get();

      /// 🔧 ĐẢM BẢO USER DOC LUÔN TỒN TẠI
      if (!snap.exists) {
        await ref.set({
          'email': email,
          'focusMode': false,
          'blocks': {
            'phones': [],
            'series': [],
            'names': [],
            'countries': [],
          },
          'createdAt': Timestamp.now(),
        });
      }

      /// 🔄 SYNC BACKEND → LOCAL
      await FocusModeService.syncFromFirestore();
      await BlockService.syncFromFirestore();

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// ===== QUÊN MẬT KHẨU =====
  static Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  /// ===== ĐĂNG XUẤT =====
  static Future<void> logout() async {
    await _auth.signOut();
  }

  /// ===== USER HIỆN TẠI =====
  static User? currentUser() {
    return _auth.currentUser;
  }

  /// ===== CHECK LOGIN =====
  static bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
