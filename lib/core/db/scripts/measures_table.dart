const measuresColumns = [
  'id',
  'measure',
  'cocktail_id',
  'ingredient_id',
];

const measuresTable = """
  CREATE TABLE measures(
    id INTEGER PRIMARY KEY,
    measure TEXT,
    cocktail_id VARCHAR(36),
    ingredient_id VARCHAR(36),
    FOREIGN KEY (cocktail_id) REFERENCES cocktails_v2(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
  );
""";
