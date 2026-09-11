import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/item_model.dart';

class DBHelper {
  static Database? _database;
  static const String tableName = 'items';

  Future<Database>  database() async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'restaurant_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            price REAL,
            category TEXT,
            imagePath TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertItem(ItemModel item) async {
    final db = await database();
    return await db.insert(tableName, item.toMap());
  }

  Future<List<ItemModel>> getItemsByCategory(String category) async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'category = ?',
      whereArgs: [category],
    );
    return List.generate(maps.length, (i) => ItemModel.fromMap(maps[i]));
  }

  Future<int> updateItem(ItemModel item) async {
    final db = await database();
    return await db.update(
      tableName,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteItem(int id) async {
    final db = await database();
    return await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}