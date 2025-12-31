import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('antamnghe.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // 1. Bảng BLACKLIST (Chặn)
    await db.execute('''
      CREATE TABLE blacklist (
        phone_number TEXT,
        user_id TEXT, 
        label TEXT,
        source TEXT,
        created_at INTEGER,
        PRIMARY KEY (phone_number, user_id)
      )
    ''');

    // 2. Bảng WHITELIST (Ưu tiên)
    await db.execute('''
      CREATE TABLE whitelist (
        phone_number TEXT,
        user_id TEXT,
        name TEXT,
        is_temporary INTEGER DEFAULT 0,
        expiry_time INTEGER,
        created_at INTEGER,
        PRIMARY KEY (phone_number, user_id)
      )
    ''');
    
    // 3. Bảng Call Logs
    await db.execute('''
      CREATE TABLE call_logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id TEXT,
        phone_number TEXT,
        call_time INTEGER,
        action_taken TEXT,
        reason TEXT
      )
    ''');
    
    // Index cho call_logs
    await db.execute('CREATE INDEX idx_call_phone_time ON call_logs(phone_number, call_time)');

    // 4. Bảng SETTINGS
    await db.execute('''
      CREATE TABLE app_settings (
        user_id TEXT,
        key TEXT,
        value TEXT,
        PRIMARY KEY (user_id, key)
      )
    ''');
  }

  // --- CÁC HÀM NGHIỆP VỤ ---

  // 1. Thêm vào Blacklist
  Future<void> insertBlacklist(Map<String, dynamic> data) async {
    final db = await instance.database;
    await db.insert('blacklist', data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // 2. Lấy tất cả danh sách chặn (HÀM BẠN ĐANG THIẾU)
  Future<List<Map<String, dynamic>>> getAllBlacklist() async {
    final db = await instance.database;
    return await db.query('blacklist', orderBy: 'created_at DESC');
  }

  // 3. Xóa số khỏi danh sách chặn (HÀM BẠN ĐANG THIẾU)
  Future<int> removeBlacklist(String phone) async {
    final db = await instance.database;
    return await db.delete('blacklist', where: 'phone_number = ?', whereArgs: [phone]);
  }

  // 4. Kiểm tra xem số có bị chặn không
  Future<Map<String, dynamic>?> checkBlacklist(String phone, String userId) async {
    final db = await instance.database;
    final result = await db.query(
      'blacklist',
      where: 'phone_number = ? AND (user_id = ? OR user_id = ?)',
      whereArgs: [phone, userId, 'GLOBAL'],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }
}