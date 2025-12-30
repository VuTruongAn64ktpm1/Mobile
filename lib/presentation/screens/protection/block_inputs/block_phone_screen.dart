import 'package:flutter/material.dart';
import '../../../../services/block_service.dart';

class BlockPhoneScreen extends StatefulWidget {
  const BlockPhoneScreen({super.key});

  @override
  State<BlockPhoneScreen> createState() => _BlockPhoneScreenState();
}

class _BlockPhoneScreenState extends State<BlockPhoneScreen> {
  final TextEditingController _phoneCtrl = TextEditingController();
  final TextEditingController _nameCtrl = TextEditingController();

  String _countryCode = '+84';
  bool _isBusiness = true;
  bool _loading = false;

  final List<Map<String, String>> _countries = const [
    {'name': 'Vietnam', 'code': '+84'},
    {'name': 'United States', 'code': '+1'},
    {'name': 'Japan', 'code': '+81'},
    {'name': 'Korea', 'code': '+82'},
  ];

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _blockPhone() async {
    final phone = _phoneCtrl.text.trim();
    if (phone.isEmpty) return;

    setState(() => _loading = true);

    await BlockService.blockPhone('$_countryCode$phone');

    setState(() => _loading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Đã chặn số điện thoại'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final enable = _phoneCtrl.text.trim().isNotEmpty && !_loading;

    return Scaffold(
      backgroundColor: Colors.white,

      /// ===== APP BAR =====
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chặn một số điện thoại',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ===== COUNTRY DROPDOWN =====
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(6),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _countryCode,
                  items: _countries
                      .map(
                        (c) => DropdownMenuItem<String>(
                          value: c['code'],
                          child: Text('${c['name']} (${c['code']})'),
                        ),
                      )
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _countryCode = val!),
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// ===== PHONE =====
            TextField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Số điện thoại',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16),

            /// ===== NAME =====
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                hintText: 'Tên',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            /// ===== TYPE =====
            Row(
              children: [
                Radio<bool>(
                  value: true,
                  groupValue: _isBusiness,
                  onChanged: (v) => setState(() => _isBusiness = v!),
                ),
                const Text('Kinh doanh'),
                const SizedBox(width: 24),
                Radio<bool>(
                  value: false,
                  groupValue: _isBusiness,
                  onChanged: (v) => setState(() => _isBusiness = v!),
                ),
                const Text('Người'),
              ],
            ),

            const SizedBox(height: 24),

            /// ===== BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      enable ? const Color(0xFF9CA3AF) : Colors.grey.shade300,
                  elevation: 0,
                ),
                onPressed: enable ? _blockPhone : null,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text(
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
