import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/mock_data.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 44,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey[300]!), borderRadius: BorderRadius.circular(8)),
              child: const Row(children: [SizedBox(width: 12), Icon(Icons.account_circle, color: Colors.blue), SizedBox(width: 8), Text("Tìm kiếm số điện thoại", style: TextStyle(color: Colors.grey)), Spacer(), Icon(Icons.more_vert, color: Colors.grey), SizedBox(width: 8)]),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 16),
              itemCount: MockData.contacts.length,
              itemBuilder: (context, index) {
                final c = MockData.contacts[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(children: [CircleAvatar(radius: 28, backgroundColor: AppColors.avatarBlue, child: Text(c["char"], style: const TextStyle(fontSize: 20, color: Colors.black))), const SizedBox(height: 4), Text(c["name"], style: const TextStyle(fontSize: 12))]),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: MockData.history.length,
              itemBuilder: (context, index) {
                final h = MockData.history[index];
                return ListTile(
                  leading: CircleAvatar(backgroundColor: AppColors.avatarBlue, child: Text(h["name"][0])),
                  title: Text(h["name"], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(children: [const Icon(Icons.call_received, size: 14, color: Colors.green), const SizedBox(width: 4), Text(h["time"])]),
                  trailing: const Icon(Icons.call_outlined, color: Colors.grey),
                  onTap: () => Navigator.pushNamed(context, '/detail'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}