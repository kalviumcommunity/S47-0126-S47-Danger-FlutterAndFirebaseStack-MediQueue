import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/sync_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'offline_sync.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE sync_queue(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        action TEXT,
        data TEXT,
        timestamp TEXT
      )
    ''');
  }

  Future<int> insertSyncItem(SyncItem item) async {
    final db = await database;
    return await db.insert('sync_queue', item.toMap());
  }

  Future<List<SyncItem>> getSyncItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('sync_queue');
    return List.generate(maps.length, (i) {
      return SyncItem.fromMap(maps[i]);
    });
  }

  Future<int> deleteSyncItem(int id) async {
    final db = await database;
    return await db.delete(
      'sync_queue',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> clearSyncQueue() async {
    final db = await database;
    await db.delete('sync_queue');
  }
}
