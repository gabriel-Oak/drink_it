const cocktailsV2Columns = [
  "id",
  "name",
  "thumb",
  "alcoholic",
  "glass",
  "category",
  "instructions",
  "instructionsES",
  "instructionsDE",
  "instructionsFR",
  "instructionsIT",
];

const cocktailsV2Table = """
  CREATE TABLE cocktails_v2(
    id VARCHAR(36) PRIMARY KEY,
    name TEXT,
    thumb TEXT,
    alcoholic VARCHAR(15),
    glass TEXT,
    category TEXT,
    instructions TEXT,
    instructionsES TEXT,
    instructionsDE TEXT,
    instructionsFR TEXT,
    instructionsIT TEXT
  );
""";
