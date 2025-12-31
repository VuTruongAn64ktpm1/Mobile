import 'package:flutter/material.dart';
import '../../../../services/block_service.dart';

class BlockSeriesScreen extends StatefulWidget {
  const BlockSeriesScreen({super.key});

  @override
  State<BlockSeriesScreen> createState() => _BlockSeriesScreenState();
}

class _BlockSeriesScreenState extends State<BlockSeriesScreen> {
  final TextEditingController _startController = TextEditingController();

  @override
  void dispose() {
    _startController.dispose();
    super.dispose();
  }

  Future<void> _blockSeries() async {
    final value = _startController.text.trim();
    if (value.isEmpty) return;

    await BlockService.blockSeries(value);

    if (!mounted) return;

    // ✅ THÔNG BÁO THÀNH CÔNG
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('An Tâm Nghe'),
        content: Text('Đã chặn các số bắt đầu với $value'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // đóng màn
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = _startController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,

      /// ===== APP BAR =====
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chặn theo seri điện thoại',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),

      /// ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== BẮT ĐẦU VỚI (ACTIVE) =====
            TextField(
              controller: _startController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Các số điện thoại bắt đầu với',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2563EB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Color(0xFF2563EB), width: 2),
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 12),

            // ===== CÓ CHỨA (DISABLED) =====
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Các số điện thoại có chứa',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ===== KẾT THÚC VỚI (DISABLED) =====
            TextField(
              enabled: false,
              decoration: InputDecoration(
                hintText: 'Các số điện thoại kết thúc với',
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ===== BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isEnabled ? const Color(0xFF2563EB) : Colors.grey.shade300,
                  elevation: 0,
                ),
                onPressed: isEnabled ? _blockSeries : null,
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
