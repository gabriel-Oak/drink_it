// ignore_for_file: avoid_print

import 'package:drink_it/core/db/init_db.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class Db {
  Future<Database> get();
  Future<void> create(Database db, int newVersion);
  Future<void> update(Database db, int lastVersion, int newVersion);
}

class DbImpl extends Db {
  @override
  Future<void> create(Database db, int newVersion) async {
    print('Criando DB');
    await initDb(db: db);
    print('Banco criado!');
  }

  @override
  Future<Database> get() async {
    final String databasesPath = await getDatabasesPath();
    final String path = p.join(databasesPath, 'drink_it_2');
    final db = await openDatabase(
      path,
      version: 2,
      onCreate: create,
      onUpgrade: update,
      onDowngrade: update,
    );
    return db;
  }

  @override
  Future<void> update(Database db, int lastVersion, int newVersion) async {
    print('Atualizar DB');
    try {
      final tables = await db
          .rawQuery("SELECT name FROM sqlite_master WHERE type='table'");

      for (int i = 0; i < tables.length; i++) {
        final name = tables[i]['name'];
        if (name != 'android_metadata') {
          await db.execute('DROP TABLE IF EXISTS $name');
        }
      }

      create(db, newVersion);
    } catch (e) {
      print(e);
    }
  }

  // ignore: unused_element
  Future<void> _clear() async {
    final db = await get();
    final tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    for (int i = 0; i < tables.length; i++) {
      final name = tables[i]['name'];
      if (name != 'android_metadata') {
        await db.delete('$name');
      }
    }
  }
}
