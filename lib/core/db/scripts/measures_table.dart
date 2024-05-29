const measuresColumns = [
  'id',
  'measure',
];

const measuresTable = """
  CREATE TABLE measures(
    id VARCHAR(36),
    measure TEXT,
    cocktail_id VARCHAR(36),
    ingredient_id VARCHAR(36),
    CONSTRAINT id_primary_key PRIMARY KEY (id),
    FOREIGN KEY (cocktail_id) REFERENCES cocktails_v2(id),
    FOREIGN KEY (ingredient_id) REFERENCES ingredients(id)
  );
""";
