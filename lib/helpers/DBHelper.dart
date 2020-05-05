import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static const sql_cart_query =
      'CREATE TABLE user_cart(id TEXT PRIMARY KEY ,  name TEXT,count TEXT, price TEXT,size TEXT,image TEXT)';
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'batriq_cart.db'),
        onCreate: (db, version) {
      return db.execute(sql_cart_query);
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      'user_cart',
      data,
    );
  }

  static Future<void> clearCart() async {
    final db = await DBHelper.database();
    await db.execute("DROP Table user_cart");
    await db.execute(sql_cart_query);
  }

  static Future<int> delete(String table, String id) async {
    final db = await DBHelper.database();
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> update(String table, key, quantity) async {
    final db = await DBHelper.database();
    await db.update(
        table,
        <String, String>{
          'count': quantity,
        },
        where: 'id = ?',
        whereArgs: [key]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
