import 'sqlite_data_type.dart';

/// provide some util to operate
class SqliteUtil {
  /// which can help us to get the sqlite data type conviently
  /// @param name: the data type string
  /// @return : the sqlite data type
  static SqliteDataType mate(String name) {
    if (name == "TEXT") {
      return SqliteDataType.TEXT;
    } else if (name == "INTEGER") {
      return SqliteDataType.INTEGER;
    } else if (name == "BLOB") {
      return SqliteDataType.BLOB;
    } else if (name == "REAL") {
      return SqliteDataType.REAL;
    }
    return SqliteDataType.TEXT;
  }
}
