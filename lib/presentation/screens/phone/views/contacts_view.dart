import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/mock_data.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Liên hệ", style: TextStyle(fontSize: 24)), Row(children: [Icon(Icons.search), SizedBox(width: 16), Icon(Icons.person_add_alt)])]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MockData.contacts.length,
              itemBuilder: (context, index) {
                final c = MockData.contacts[index];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.avatarBlue, child: Text(c["char"])),
                  title: Text(c["name"]),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}