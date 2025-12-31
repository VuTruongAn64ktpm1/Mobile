import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../../core/phone_service.dart';
import 'contact_detail_screen.dart'; // Import màn hình chi tiết

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Contact>>(
      future: PhoneService.getContacts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final contacts = snapshot.data ?? [];
        if (contacts.isEmpty) {
          return const Center(child: Text("Danh bạ trống hoặc chưa cấp quyền"));
        }

        return ListView.builder(
          itemCount: contacts.length,
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ContactDetailScreen(contact: contact),
                  ),
                );
              },
              leading: (contact.photo != null)
                  ? CircleAvatar(backgroundImage: MemoryImage(contact.photo!))
                  : CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        contact.displayName.isNotEmpty ? contact.displayName[0] : "A", 
                        style: TextStyle(color: Colors.blue.shade900)
                      ),
                    ),
              title: Text(contact.displayName),
              subtitle: Text(
                contact.phones.isNotEmpty ? contact.phones.first.number : "Không có số",
              ),
            );
          },
        );
      },
    );
  }
}