import 'package:drink_it/core/db/scripts/cocktails_table.dart';
import 'package:drink_it/core/db/scripts/cocktails_v2_table.dart';
import 'package:drink_it/core/db/scripts/ingredients_table.dart';
import 'package:drink_it/core/db/scripts/measures_table.dart';
import 'package:sqflite/sqflite.dart';

Future initDb({required Database db}) async {
  try {
    await db.execute(ingredientsTable);
    await db.execute(cocktailsV2Table);
    await db.execute(measuresTable);
    await db.execute(cocktailsTable);
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
