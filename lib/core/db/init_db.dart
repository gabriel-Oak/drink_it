import 'package:drink_it/core/db/scripts/cocktails_table.dart';
import 'package:sqflite/sqflite.dart';

Future initDb({required Database db}) async {
  try {
    await db.execute(cocktailsTable);
  } catch (e) {
    print(e);
  }
}
