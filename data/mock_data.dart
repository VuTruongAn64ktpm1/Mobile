class MockData {
  static final List<Map<String, dynamic>> contacts = [
    {"name": "Bố", "phone": "0987 654 321", "char": "B"},
    {"name": "Mẹ", "phone": "0912 345 678", "char": "M"},
    {"name": "Ông", "phone": "0909 000 111", "char": "Ô"},
    {"name": "Bà", "phone": "0909 222 333", "char": "B"},
    {"name": "Anh", "phone": "0933 444 555", "char": "A"},
  ];

  static final List<Map<String, dynamic>> history = [
    {"name": "Bố", "time": "18:07", "type": "incoming", "status": "ok"},
    {"name": "Mẹ", "time": "20:03", "type": "incoming", "status": "ok"},
    {"name": "Anh", "time": "Hôm qua", "type": "incoming", "status": "ok"},
    {"name": "Bố", "time": "18:07", "type": "incoming", "status": "ok"},
  ];
}