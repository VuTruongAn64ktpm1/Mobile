import 'package:flutter/material.dart';
import '../../../../services/block_service.dart';

class BlockCountryScreen extends StatefulWidget {
  const BlockCountryScreen({super.key});

  @override
  State<BlockCountryScreen> createState() => _BlockCountryScreenState();
}

class _BlockCountryScreenState extends State<BlockCountryScreen> {
  String? _selectedCode;

  final List<Map<String, String>> _countries = const [
    {'name': 'Việt Nam', 'code': '+84'},
    {'name': 'Hoa Kỳ', 'code': '+1'},
    {'name': 'Trung Quốc', 'code': '+86'},
    {'name': 'Hàn Quốc', 'code': '+82'},
    {'name': 'Nhật Bản', 'code': '+81'},
  ];

  Future<void> _blockCountry() async {
    if (_selectedCode == null) return;

    await BlockService.blockCountry(_selectedCode!);

    if (!mounted) return;
    _showSuccess(context);
  }

  void _showSuccess(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('An Tâm Nghe'),
        content: const Text('Đã chặn mã quốc gia'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chặn một mã quốc gia',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== DROPDOWN COUNTRY =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(6),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedCode,
                  hint: const Text('Chọn một quốc gia'),
                  items: _countries
                      .map(
                        (c) => DropdownMenuItem<String>(
                          value: c['code'],
                          child: Text('${c['name']} (${c['code']})'),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    setState(() => _selectedCode = val);
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ===== BLOCK BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedCode == null
                      ? const Color(0xFFD1D5DB)
                      : const Color(0xFF2563EB),
                  elevation: 0,
                ),
                onPressed: _selectedCode == null ? null : _blockCountry,
                child: const Text(
                  'CHẶN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
