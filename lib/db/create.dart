/*import 'dart:async';

import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

class Migration {
  final String path;
  Migration({@required this.path});

  Future<void> init() async {
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: onCreate,
    );
  }

  onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE files (id INTEGER PRIMARY KEY, name TEXT, path TEXT, state TEXT, resourceId TEXT)');
  }
}*/
