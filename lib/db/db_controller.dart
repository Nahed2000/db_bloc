import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  DbController._();

  static final DbController _instance = DbController._();

  factory DbController() {
    return _instance;
  }

  late Database _database;

  Database get database => _database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE users ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name Text,'
            'email Text,'
            'password Text'
            ')');
        db.execute('CREATE TABLE notes ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title Text,'
            'details Text,'
            'user_id INTEGER,'
            'FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE CASCADE'
            ')');
      },
      onDowngrade: (db, oldVersion, newVersion) {},
      onUpgrade: (db, oldVersion, newVersion) {},
      onOpen: (db) {},
    );
  }
// late Datab
}
