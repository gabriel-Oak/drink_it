import 'package:drink_it/core/db/scripts/cocktails_table.dart';
import 'package:drink_it/core/db/scripts/ingredient_table.dart';
import 'package:drink_it/core/db/scripts/measures_table.dart';
import 'package:sqflite/sqflite.dart';

Future initDb({required Database db}) async {
  try {
    print('Creating Cocktails TABLE');
    await db.execute(cocktailsTable);

    print('Creating Ingredients TABLE');
    await db.execute(ingredientsTable);

    print('Creating Measures TABLE');
    await db.execute(measuresTable);
  } catch (e) {
    print(e);
  }
}
