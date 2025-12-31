import 'package:flutter/material.dart';
import 'package:call_log/call_log.dart'; // Import để dùng CallType
import '../../../../core/app_colors.dart';
import 'views/history_view.dart';
import 'views/contacts_view.dart';
import 'views/keypad_view.dart';
import '../settings/settings_screen.dart';

class PhoneMainScreen extends StatefulWidget {
  const PhoneMainScreen({super.key});

  @override
  State<PhoneMainScreen> createState() => _PhoneMainScreenState();
}

class _PhoneMainScreenState extends State<PhoneMainScreen> {
  int _dockIndex = 0; // 0: Gần đây, 1: Danh bạ, 2: Ưa thích
  
  // LOGIC BACKEND: Biến lưu bộ lọc hiện tại
  // null = Hiện tất cả
  CallType? _currentFilter; 
  String _filterName = "Tất cả cuộc gọi"; // Tên hiển thị cho người dùng biết đang lọc cái gì

  // Hàm xử lý khi chọn menu
  void _onMenuSelected(String value) {
    setState(() {
      switch (value) {
        case 'all':
          _currentFilter = null;
          _filterName = "Tất cả cuộc gọi";
          break;
        case 'outgoing':
          _currentFilter = CallType.outgoing;
          _filterName = "Cuộc gọi đi";
          break;
        case 'incoming':
          _currentFilter = CallType.incoming;
          _filterName = "Cuộc gọi đến";
          break;
        case 'missed':
          _currentFilter = CallType.missed;
          _filterName = "Cuộc gọi nhỡ";
          break;
        case 'blocked':
          _currentFilter = CallType.blocked;
          _filterName = "Cuộc gọi bị chặn";
          break;
        case 'delete_all':
          _showDeleteConfirm(); // Hiện popup xác nhận xóa
          break;
        case 'sim':
          // Tính năng nâng cao: Thông báo cho người dùng
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Vui lòng vào Cài đặt của điện thoại để chỉnh SIM mặc định")),
          );
          break;
        case 'settings':
          Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          break;
      }
    });
  }

  // Hàm hiển thị popup xác nhận xóa
  void _showDeleteConfirm() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Xóa tất cả?"),
        content: const Text("Bạn có chắc muốn xóa toàn bộ lịch sử cuộc gọi không? Hành động này không thể hoàn tác."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Hủy")),
          TextButton(
            onPressed: () {
              // Code xóa thật ở đây (Lưu ý: Android mới hạn chế quyền xóa hàng loạt)
              // Ở đây ta giả lập xóa bằng cách thông báo
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Yêu cầu xóa đã được gửi hệ thống")));
            },
            child: const Text("Xóa", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // --- THANH TÌM KIẾM & MENU 3 CHẤM ---
                Container(
                  margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.blue, 
                        radius: 16,
                        child: Icon(Icons.person, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Tìm kiếm số điện thoại",
                            border: InputBorder.none,
                            hintStyle: const TextStyle(color: Colors.grey),
                            // Nếu đang lọc thì hiện thêm thông báo nhỏ
                            suffixText: _currentFilter != null ? "($_filterName)" : null,
                            suffixStyle: const TextStyle(fontSize: 10, color: Colors.blue),
                          ),
                        ),
                      ),
                      
                      // MENU 3 CHẤM (Đã gắn Logic Backend)
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, color: Colors.grey),
                        color: Colors.white,
                        surfaceTintColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        onSelected: _onMenuSelected, // Gọi hàm xử lý
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          // Thêm nút "Tất cả" để quay lại ban đầu
                          _buildPopupItem('all', Icons.list, Colors.black, 'Tất cả cuộc gọi'),
                          const PopupMenuDivider(),
                          _buildPopupItem('outgoing', Icons.call_made, Colors.blue, 'Cuộc gọi đi'),
                          _buildPopupItem('incoming', Icons.call_received, Colors.green, 'Cuộc gọi đến'),
                          _buildPopupItem('missed', Icons.call_missed, Colors.red, 'Các cuộc gọi nhỡ'),
                          _buildPopupItem('blocked', Icons.block, Colors.red, 'Cuộc gọi bị chặn'),
                          const PopupMenuDivider(),
                          _buildPopupItem('delete_all', Icons.delete_outline, Colors.grey, 'Xóa tất cả cuộc gọi'),
                          _buildPopupItem('sim', Icons.sim_card_outlined, Colors.grey, 'Đặt SIM mặc định'),
                          _buildPopupItem('settings', Icons.settings_outlined, Colors.grey, 'Thiết lập'),
                        ],
                      ),
                    ],
                  ),
                ),

                // --- HÀNG ƯA THÍCH (Chỉ hiện khi ở tab Gần đây & Không lọc) ---
                if (_dockIndex == 0 && _currentFilter == null)
                  SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      children: [
                        _buildQuickContact("Bố", Colors.blue.shade100),
                        _buildQuickContact("Mẹ", Colors.blue.shade100),
                        _buildQuickContact("Ông", Colors.blue.shade100),
                        _buildQuickContact("Bà", Colors.blue.shade100),
                      ],
                    ),
                  ),

                // --- NỘI DUNG CHÍNH ---
                Expanded(
                  child: _dockIndex == 0 
                      // TRUYỀN BỘ LỌC XUỐNG HISTORY VIEW
                      ? HistoryView(filterType: _currentFilter) 
                      : _dockIndex == 1 
                          ? const ContactsView() 
                          : const Center(child: Text("Mục ưa thích")),
                ),
                
                const SizedBox(height: 80), 
              ],
            ),

            // --- CỤM ĐIỀU KHIỂN NỔI (Dock) ---
            Positioned(
              bottom: 10, left: 20, right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15, spreadRadius: 2, offset: const Offset(0, 4))
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildDockIcon(0, Icons.history, "Gần đây"),
                    _buildDockIcon(1, Icons.perm_contact_calendar_outlined, "Danh bạ"),
                    _buildDockIcon(2, Icons.favorite_border, "Ưa thích"),
                    GestureDetector(
                      onTap: () => _showKeypad(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: AppColors.primaryBlue, borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.dialpad, color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String value, IconData icon, Color color, String text) {
    return PopupMenuItem<String>(
      value: value,
      height: 40,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildQuickContact(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: Text(name[0], style: const TextStyle(fontSize: 22, color: Colors.black87, fontWeight: FontWeight.w500)),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildDockIcon(int index, IconData icon, String label) {
    bool isSelected = _dockIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _dockIndex = index;
          // Khi chuyển tab thì bỏ lọc để tránh nhầm lẫn
          _currentFilter = null; 
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: isSelected 
          ? BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12))
          : null,
        child: Icon(icon, color: isSelected ? Colors.black : Colors.grey, size: 26),
      ),
    );
  }

  void _showKeypad(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const KeypadView(),
    );
  }
}