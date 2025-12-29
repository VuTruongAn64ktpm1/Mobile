import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), title: const Text("Trợ giúp")),
      body: ListView(padding: const EdgeInsets.all(16), children: [Card(child: Column(children: const [ListTile(leading: Icon(Icons.help), title: Text("Câu hỏi thường gặp")), ListTile(leading: Icon(Icons.feedback), title: Text("Gửi phản hồi")), ListTile(leading: Icon(Icons.chat), title: Text("Trò chuyện với chúng tôi"))]))]),
    );
  }
}