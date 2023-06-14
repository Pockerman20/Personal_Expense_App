import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';
import '../models/transaction.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const dbName = "expense.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
  static const id = "id";
  static const date = "date";
  static const name = "name";
  static const price = "price";

  //constructor
  static final DatabaseHelper instance = DatabaseHelper();

  // database initialization
  static Database? _database;

  Future<Database?> get database async {
    _database ??= await initDB();
    return _database;
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: dbVersion, onCreate: onCreate);
  }

  // $id INTEGER PRIMARY KEY,

  //create method
  Future onCreate(Database db, int version) async {
    db.execute(''' 
      CREATE TABLE $dbTable (
        $id STRING PRIMARY KEY,
        $date TEXT NOT NULL,
        $name TEXT,
        $price REAL
      )
      ''');
  }

  //insert method
  insertRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(dbTable, row);
  }

  // read/query method
  Future<List<Map<String, dynamic>>> queryDatabase() async {
    Database? db = await instance.database;
    return await db!.query(dbTable);
  }

  // update method
  Future<int> updateRecord(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int cid = row[id];
    return await db!.update(dbTable, row, where: '$id = ?', whereArgs: [cid]);
  }

  // delete method
  Future<int> deleteRecord(String cid) async {
    Database? db = await instance.database;
    return await db!.delete(dbTable, where: '$id = ?', whereArgs: [cid]);
  }
}
