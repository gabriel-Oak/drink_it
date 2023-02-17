const cocktailsColumns = [
  "id",
  "name",
  "thumb",
  "alcoholic",
  "glass",
  "category",
  "video",
  "tags",
  "instructions",
  "instructionsES",
  "instructionsDE",
  "instructionsFR",
  "instructionsIT",
  "instructionsPtBR",
  "dateModified",
  "iba",
];

const cocktailsTable = """
  CREATE TABLE cocktails(
    id TEXT PRIMARY KEY,
    name TEXT,
    thumb TEXT,
    alcoholic TEXT,
    glass TEXT,
    category TEXT,
    video TEXT,
    tags TEXT,
    instructions TEXT,
    instructionsES TEXT,
    instructionsDE TEXT,
    instructionsFR TEXT,
    instructionsIT TEXT,
    instructionsPtBR TEXT,
    dateModified TEXT,
    iba TEXT
  );
""";
