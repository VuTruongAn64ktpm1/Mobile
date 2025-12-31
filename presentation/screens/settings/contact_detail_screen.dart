import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class ContactDetailScreen extends StatelessWidget {
  const ContactDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryBlue, iconTheme: const IconThemeData(color: Colors.white)),
      body: Column(
        children: [
          Container(color: AppColors.primaryBlue, padding: const EdgeInsets.only(bottom: 30), child: const Center(child: Column(children: [CircleAvatar(radius: 40, backgroundColor: AppColors.avatarBlue, child: Text("B", style: TextStyle(fontSize: 30))), SizedBox(height: 10), Text("Bố", style: TextStyle(color: Colors.white, fontSize: 24))]))),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [_btn(Icons.call), _btn(Icons.message), _btn(Icons.edit), _btn(Icons.block)]),
          const SizedBox(height: 20),
          const Card(margin: EdgeInsets.symmetric(horizontal: 16), child: ListTile(leading: Icon(Icons.call), title: Text("0987 654 321"), trailing: Icon(Icons.message)))
        ],
      ),
    );
  }
  Widget _btn(IconData i) => Container(margin: const EdgeInsets.symmetric(horizontal: 10), padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.avatarBlue, borderRadius: BorderRadius.circular(8)), child: Icon(i, color: AppColors.primaryBlue));
}