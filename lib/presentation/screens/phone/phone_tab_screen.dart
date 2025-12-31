import 'package:flutter/material.dart';
import 'views/history_view.dart';
import 'views/contacts_view.dart';
import '../../../../core/app_colors.dart';

class PhoneTabScreen extends StatelessWidget {
  const PhoneTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Điện thoại"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: TabBar(
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppColors.primaryBlue,
            tabs: const [
              Tab(text: "Gần đây"),
              Tab(text: "Danh bạ"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryView(),  // File bạn đã sửa lúc nãy
            ContactsView(), // File bạn đã sửa lúc nãy
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Sau này mở bàn phím số ở đây
          },
          backgroundColor: AppColors.primaryBlue,
          child: const Icon(Icons.dialpad),
        ),
      ),
    );
  }
}