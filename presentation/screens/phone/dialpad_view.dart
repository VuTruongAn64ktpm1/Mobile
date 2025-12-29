import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';

class DialpadView extends StatelessWidget {
  const DialpadView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(alignment: Alignment.topLeft, child: IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context))),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(children: [CircleAvatar(backgroundColor: AppColors.avatarBlue, child: Text("B")), SizedBox(width: 12), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Bố", style: TextStyle(fontWeight: FontWeight.bold)), Text("0987 654 321")]), Spacer(), Icon(Icons.call, color: Colors.grey)]),
        ),
        const Spacer(),
        const Text("0987 654 321", style: TextStyle(fontSize: 36)),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: GridView.count(crossAxisCount: 3, shrinkWrap: true, childAspectRatio: 1.5, mainAxisSpacing: 16, crossAxisSpacing: 16, children: [for (var i = 1; i <= 9; i++) _key(i.toString()), _key("*"), _key("0"), _key("#")]),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () { Navigator.pop(context); Navigator.pushNamed(context, '/scam_alert'); },
          child: Container(margin: const EdgeInsets.only(bottom: 30), width: 120, height: 60, decoration: BoxDecoration(color: const Color(0xFF0F9D58), borderRadius: BorderRadius.circular(30)), alignment: Alignment.center, child: const Text("Gọi", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold))),
        )
      ],
    );
  }
  Widget _key(String t) => Container(decoration: BoxDecoration(color: Colors.grey[50], borderRadius: BorderRadius.circular(8), boxShadow: [const BoxShadow(color: Colors.black12, offset: Offset(0, 1))]), alignment: Alignment.center, child: Text(t, style: const TextStyle(fontSize: 24)));
}