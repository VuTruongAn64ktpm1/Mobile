import 'package:flutter/material.dart';

class BlockSuccessDialog extends StatelessWidget {
  final String phone;

  const BlockSuccessDialog({
    super.key,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 28,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// ===== TITLE =====
            const Text(
              'An tâm nghe',
              style: TextStyle(
                color: Color(0xFF2563EB),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 16),

            /// ===== ICON =====
            Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFF22C55E),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 36,
              ),
            ),

            const SizedBox(height: 20),

            /// ===== TEXT =====
            const Text(
              'Cuộc gọi bị chặn',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              phone,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 20),

            /// ===== BUTTON =====
            SizedBox(
              width: double.infinity,
              height: 44,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF22C55E),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Số trong danh sách chặn',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
