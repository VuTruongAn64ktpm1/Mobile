import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';

class SampleContactsService {
  static Future<void> addSampleContacts() async {
    try {
      final db = FirebaseFirestore.instance;

      // 🔥 CHỈ THÊM KHI CHƯA CÓ CONTACT
      final snapshot = await db.collection('contacts').limit(1).get();
      if (snapshot.docs.isNotEmpty) return;

      final contacts = [
        {
          'name': 'Bố',
          'name_lower': 'bố',
          'phone': '0123456789',
        },
        {
          'name': 'Mẹ',
          'name_lower': 'mẹ',
          'phone': '0987654321',
        },
        {
          'name': 'Anh',
          'name_lower': 'anh',
          'phone': '0911222333',
        },
        {
          'name': 'Ông',
          'name_lower': 'ông',
          'phone': '0909090909',
        },
        {
          'name': 'Bà',
          'name_lower': 'bà',
          'phone': '0888888888',
        },
      ];

      for (final contact in contacts) {
        await db.collection('contacts').add(contact);
      }
    } catch (e) {
      // 🔥 WEB KHÔNG ĐƯỢC CRASH
      print('Không thể thêm sample contacts: $e');
    }
  }

  static Future<List<ContactModel>> getContacts() async {
    final db = FirebaseFirestore.instance;
    final snapshot = await db.collection('contacts').get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ContactModel(
        name: data['name'] ?? '',
        phone: data['phone'] ?? '',
      );
    }).toList();
  }
}

/// ===== MODEL =====
class ContactModel {
  final String name;
  final String phone;

  String get nameLower => name.toLowerCase();

  ContactModel({
    required this.name,
    required this.phone,
  });
}
