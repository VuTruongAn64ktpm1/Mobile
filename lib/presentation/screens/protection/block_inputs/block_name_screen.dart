import 'package:flutter/material.dart';
import '../../../../services/block_service.dart';

class BlockNameScreen extends StatefulWidget {
  const BlockNameScreen({super.key});

  @override
  State<BlockNameScreen> createState() => _BlockNameScreenState();
}

class _BlockNameScreenState extends State<BlockNameScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _blockName() async {
    final value = _controller.text.trim();
    if (value.isEmpty) return;

    setState(() => _loading = true);
    await BlockService.blockName(value);
    setState(() => _loading = false);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Đã chặn theo tên người gọi'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context); // ⬅ quay lại ProtectionScreen
  }

  @override
  Widget build(BuildContext context) {
    final isEnable = _controller.text.trim().isNotEmpty && !_loading;

    return Scaffold(
      backgroundColor: Colors.white,

      /// ===== APP BAR =====
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Chặn người gọi theo tên',
          style: TextStyle(fontSize: 18),
        ),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ===== DESCRIPTION =====
            const Text(
              'Tên người gọi có chứa từ này sẽ bị chặn',
              style: TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 8),

            Row(
              children: const [
                Icon(Icons.info_outline, size: 16, color: Colors.grey),
                SizedBox(width: 6),
                Text(
                  'Cần có Internet để ổn định',
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// ===== INPUT =====
            TextField(
              controller: _controller,
              maxLength: 35,
              decoration: InputDecoration(
                hintText: 'Tên hoặc từ',
                counterText: 'Tối đa 35 kí tự',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                isDense: true,
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 20),

            /// ===== BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isEnable ? const Color(0xFF2563EB) : Colors.grey.shade400,
                  elevation: 0,
                ),
                onPressed: isEnable ? _blockName : null,
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
