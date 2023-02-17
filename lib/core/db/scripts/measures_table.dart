const measuresColumns = ["id", "name", "cocktail_id", "ingredient_id"];

const measuresTable = """
  CREATE TABLE measures(
    id TEXT PRIMARY KEY,
    name TEXT,
    FOREIGN KEY (cocktail_id) REFERENCES cocktails (id)
      ON DELETE NO ACTION ON UPDATE NO ACTION,
    FOREIGN KEY (ingredient_id) REFERENCES ingredients (id)
      ON DELETE NO ACTION ON UPDATE NO ACTION
  );
""";
