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
    final String path = p.join(databasesPath, 'pokidex_1_0_1');
    final db = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      onUpgrade: update,
      onDowngrade: update,
    );
    return db;
  }

  @override
  Future<void> update(Database db, int lastVersion, int newVersion) async {
    print('Atualizar');
    try {
      await _clear();
      await create(db, newVersion);
    } catch (e) {
      print(e);
    }
  }

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
