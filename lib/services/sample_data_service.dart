import 'package:cloud_firestore/cloud_firestore.dart';

class SampleDataService {
  static Future<void> addSampleData() async {
    final db = FirebaseFirestore.instance;

    // Thêm user mẫu
    await db.collection('users').doc('testuid').set({
      'email': 'testuser@gmail.com',
      'name': 'Test User',
      'focusMode': false,
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Thêm call log mẫu
    await db.collection('call_logs').add({
      'userId': 'testuid',
      'phoneNumber': '0123456789',
      'decision': 'spam',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // Thêm spam number mẫu
    await db.collection('spam_numbers').doc('0123456789').set({
      'reports': 5,
      'type': 'lừa đảo',
      'lastReported': FieldValue.serverTimestamp(),
    });
  }
}
