///the data type in the sqlite
enum SqliteDataType {
  //it's the string
  TEXT,
  //it's the integer
  INTEGER,
  //it's double
  REAL,
  //it's the big text
  BLOB,
}

///it's the extension of the sqliteType assigns to the type
extension SqliteDataTypeExtension on SqliteDataType {
  String get info => [
        "TEXT",
        "INTEGER",
        "REAL",
        "BLOB",
      ][index];
}
