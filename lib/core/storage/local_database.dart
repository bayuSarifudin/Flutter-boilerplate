import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Pengelola Database SQLite lokal perangkat untuk mendukung kemampuan Offline-First.
class LocalDatabase {
  static const String _dbName = 'super_i_mobile.db';
  static const int _dbVersion = 1;

  Database? _database;

  /// Getter untuk memastikan koneksi database sudah terbuka sebelum dipakai
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  /// Membuat tabel-tabel draft saat database pertama kali dibuat di HP
  Future<void> _onCreate(Database db, int version) async {
    // 1. Tabel draft pekerjaan Line Walker (PPL, Pembumian, Waterpass)
    await db.execute('''
      CREATE TABLE unfinish_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        date TEXT NOT NULL,
        type TEXT NOT NULL,
        data TEXT
      )
    ''');

    // 2. Tabel draft pekerjaan Gardu Induk 20kV (Beban, IL1, Manuver, Anomali)
    await db.execute('''
      CREATE TABLE unfinished_items_gi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nama TEXT NOT NULL,
        date TEXT NOT NULL,
        type TEXT NOT NULL,
        periode INTEGER NOT NULL,
        data TEXT
      )
    ''');

    // 3. Tabel draft inspeksi pemeliharaan distribusi SUTM
    await db.execute('''
      CREATE TABLE sutm_drafts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        work_order_sutm_item_id TEXT NOT NULL UNIQUE,
        data TEXT NOT NULL,
        created_at TEXT DEFAULT (datetime('now', 'localtime')),
        updated_at TEXT DEFAULT (datetime('now', 'localtime'))
      )
    ''');
  }

  /// Menutup koneksi database saat aplikasi dimatikan
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
