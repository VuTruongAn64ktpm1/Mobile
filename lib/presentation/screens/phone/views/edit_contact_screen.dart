import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;

  const EditContactScreen({super.key, required this.contact});

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Điền sẵn thông tin cũ vào ô nhập
    _firstNameController = TextEditingController(text: widget.contact.name.first);
    _lastNameController = TextEditingController(text: widget.contact.name.last);
    _phoneController = TextEditingController(
      text: widget.contact.phones.isNotEmpty ? widget.contact.phones.first.number : "",
    );
  }

  // Hàm Lưu vào danh bạ thật
  Future<void> _saveContact() async {
    if (_formKey.currentState!.validate()) {
      // Cập nhật thông tin vào object contact
      widget.contact.name.first = _firstNameController.text;
      widget.contact.name.last = _lastNameController.text;
      
      if (widget.contact.phones.isNotEmpty) {
        widget.contact.phones.first.number = _phoneController.text;
      } else {
        widget.contact.phones = [Phone(_phoneController.text)];
      }

      // Gọi lệnh update của thư viện
      try {
        await widget.contact.update();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Đã lưu thay đổi!")));
          Navigator.pop(context); // Quay về
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lỗi: $e")));
        }
      }
    }
  }

  // Hàm xóa liên hệ
  Future<void> _deleteContact() async {
    try {
      await widget.contact.delete();
      if (mounted) {
        Navigator.pop(context); // Đóng màn hình sửa
        Navigator.pop(context); // Đóng màn hình chi tiết (vì đã xóa rồi)
      }
    } catch (e) {
      // Xử lý lỗi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Sửa liên lạc", style: TextStyle(color: Colors.black)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
            child: ElevatedButton(
              onPressed: _saveContact,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              child: const Text("Lưu"),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(padding: const EdgeInsets.all(10), color: Colors.grey[100], 
                child: const Text("Đã lưu vào bộ nhớ máy", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
              const SizedBox(height: 20),
              
              // Avatar giả
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
                child: const Icon(Icons.add_photo_alternate_outlined, size: 40, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text("Thêm ảnh", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),

              // Ô nhập tên
              _buildTextField(const Icon(Icons.person_outline), "Tên", _firstNameController),
              _buildTextField(null, "Họ", _lastNameController),
              
              const SizedBox(height: 20),
              // Checkbox giả
              Row(
                children: [
                  Checkbox(value: true, onChanged: (v){}, activeColor: Colors.blue),
                  const Text("Đề xuất tên này để giúp cải thiện Truecaller", style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),

              // Ô nhập số điện thoại
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone, color: Colors.grey),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: "Số điện thoại di động",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Row(
                      children: [
                        Icon(Icons.add, color: Colors.grey),
                        SizedBox(width: 16),
                        Text("Thêm số điện thoại", style: TextStyle(color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              TextButton(
                onPressed: _deleteContact,
                child: const Text("Xoá bỏ Số liên lạc", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(Icon? icon, String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: icon ?? const SizedBox(width: 24), // Giữ khoảng cách nếu không có icon
        title: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: label,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}