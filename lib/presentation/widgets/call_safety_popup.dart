import 'package:flutter/material.dart';

class CallSafetyPopup extends StatelessWidget {
  final String phoneNumber;
  final bool isSpam;

  const CallSafetyPopup({
    super.key,
    required this.phoneNumber,
    required this.isSpam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AN TÂM NGHE',
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'AN TOÀN',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// STATUS
          Row(
            children: [
              Icon(
                isSpam ? Icons.error : Icons.check_circle,
                color: isSpam ? Colors.red : Colors.green,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                isSpam ? 'Có dấu hiệu Spam' : 'Không phải Spam',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// DESCRIPTION
          Text(
            isSpam
                ? 'Số này đã bị nhiều người báo xấu'
                : 'Số này có độ uy tín cao, không có báo cáo xấu gần đây.',
            style: const TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 20),

          /// ACTIONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Thêm VIP
                  },
                  icon: const Icon(Icons.star, color: Colors.amber),
                  label: const Text('Thêm VIP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white10,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    // TODO: Báo spam
                  },
                  icon: const Icon(Icons.report, color: Colors.white),
                  label: const Text('Báo Spam'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
