import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final _db = FirebaseFirestore.instance;

  Future<void> createUser(String uid, String email) async {
    await _db.collection('users').doc(uid).set({
      'email': email,
      'createdAt': Timestamp.now(),
      'focusMode': false,
    });
  }

  Future<void> updateFocusMode(String uid, bool value) async {
    await _db.collection('users').doc(uid).update({
      'focusMode': value,
    });
  }

  Future<bool> getFocusMode(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    return doc.data()?['focusMode'] ?? false;
  }
}
