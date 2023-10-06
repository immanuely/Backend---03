import 'package:path/path.dart';
import 'package:m03/pertemuan3/ShoppingList.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper {
  Database? _database;
  final String _table_name = "shopping_list";
  final String _db_name = "shoppinglist_database.db";
  final int _db_version = 2;

  DBhelper() {
    _openDB();
  }

  Future<void> _openDB() async {
    _database ??= await openDatabase(join(await getDatabasesPath(), _db_name),
        onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE $_table_name (id INTEGER PRIMARY KEY, name TEXT, sum INTEGER, hrg INTEGER)',
      );
    }, version: _db_version);
  }

  Future<void> insertShoppingList(ShoppingList tmp) async {
    await _database?.insert(
      _table_name,
      tmp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ShoppingList>> getmyShopingList() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps =
          await _database!.query(_table_name);
      print("Isi DB $maps");
      return List.generate(maps.length, (i) {
        return ShoppingList(
            maps[i]['id'], maps[i]['name'], maps[i]['sum'], maps[i]['hrg']);
      });
    }
    return [];
  }

  Future<void> deleteShoppingList(int id) async {
    await _database?.delete(
      _table_name,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> closeDB() async {
    await _database?.close();
  }
}
