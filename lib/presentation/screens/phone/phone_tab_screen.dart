import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../../../services/sample_contacts_service.dart';

class PhoneTabContainer extends StatefulWidget {
  /// 🔔 CALLBACK GỌI THỬ
  final void Function(String phone)? onCall;

  const PhoneTabContainer({
    super.key,
    this.onCall,
  });

  @override
  State<PhoneTabContainer> createState() => _PhoneTabContainerState();
}

class _PhoneTabContainerState extends State<PhoneTabContainer> {
  final TextEditingController _searchController = TextEditingController();

  List<ContactModel> _allContacts = [];
  List<ContactModel> _filteredContacts = [];

  bool _isLoading = true;
  String? _error;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  /// ===== LOAD DATA (SAFE) =====
  Future<void> _loadContacts() async {
    try {
      final data = await SampleContactsService.getContacts();
      if (!mounted) return;
      setState(() {
        _allContacts = data;
        _filteredContacts = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Không thể tải danh bạ';
        _isLoading = false;
      });
    }
  }

  /// ===== SEARCH (DEBOUNCE) =====
  void _onSearch() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      final query = _searchController.text.toLowerCase();

      setState(() {
        if (query.isEmpty) {
          _filteredContacts = _allContacts;
        } else {
          _filteredContacts = _allContacts.where((c) {
            return c.nameLower.contains(query) ||
                c.phone.contains(query);
          }).toList();
        }
      });
    });
  }

  void _clearSearch() {
    _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // ⏳ LOADING
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // ❌ ERROR
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    return SafeArea(
      child: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm số điện thoại',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // 📞 CONTACT LIST / EMPTY STATE
          Expanded(
            child: _filteredContacts.isEmpty
                ? const Center(
                    child: Text(
                      'Không tìm thấy liên hệ',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) {
                      final contact = _filteredContacts[index];
                      final avatarChar = contact.name.isNotEmpty
                          ? contact.name[0].toUpperCase()
                          : '?';

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: AppColors.avatarBlue,
                          child: Text(
                            avatarChar,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        title: Text(
                          contact.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(contact.phone),

                        /// 🔔 ICON GỌI THỬ
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.call,
                            color: Colors.grey,
                          ),
                          onPressed: widget.onCall == null
                              ? null
                              : () => widget.onCall!(contact.phone),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
