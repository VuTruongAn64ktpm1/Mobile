import 'package:flutter/material.dart';
import '../../../../core/app_colors.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.all(16.0), child: Text("Mục ưa thích", style: TextStyle(fontSize: 20))),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _item("Bà", "B"), _item("Ông", "Ô"),
              Column(children: [const CircleAvatar(radius: 35, backgroundColor: AppColors.avatarBlue, child: Icon(Icons.add, color: Colors.black)), const SizedBox(height: 8), const Text("Thêm")])
            ]),
          )
        ],
      ),
    );
  }
  Widget _item(String n, String c) => Column(children: [CircleAvatar(radius: 35, backgroundColor: AppColors.avatarBlue, child: Text(c, style: const TextStyle(fontSize: 24, color: Colors.black))), const SizedBox(height: 8), Text(n)]);
}