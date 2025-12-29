import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import 'views/history_view.dart';
import 'views/contacts_view.dart';
import 'views/favorites_view.dart';
import 'dialpad_view.dart';

class PhoneTabContainer extends StatefulWidget {
  const PhoneTabContainer({super.key});
  @override
  State<PhoneTabContainer> createState() => _PhoneTabContainerState();
}

class _PhoneTabContainerState extends State<PhoneTabContainer> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(padding: const EdgeInsets.only(bottom: 80), child: _content()),
          Positioned(
            bottom: 20, left: 20, right: 20,
            child: Row(children: [
              Expanded(child: Container(height: 60, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5))]), child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_icon(Icons.history, 0), _icon(Icons.perm_contact_calendar_outlined, 1), _icon(Icons.favorite_border, 2)]))),
              const SizedBox(width: 16),
              GestureDetector(onTap: () => showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent, builder: (_) => Container(height: MediaQuery.of(context).size.height * 0.9, decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))), child: const DialpadView())), child: Container(width: 60, height: 60, decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.apps, color: Colors.white, size: 28)))
            ]),
          )
        ],
      ),
    );
  }
  Widget _content() {
    if (_index == 0) return const HistoryView();
    if (_index == 1) return const ContactsView();
    return const FavoritesView();
  }
  Widget _icon(IconData i, int x) => IconButton(icon: Icon(i, color: _index == x ? Colors.black : Colors.grey[400]), onPressed: () => setState(() => _index = x));
}