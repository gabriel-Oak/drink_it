const ingredientsColumns = [
  'id',
  'name',
];

const ingredientsTable = """
  CREATE TABLE ingredients(
    id VARCHAR(36) PRIMARY KEY NOT NULL,
    name TEXT
  );
""";
