import '../../util/sqlite/sqlite_data_type.dart';

///it's used to identify an table in the database
class DatabaseTable {
  //the table name
  String tableName;

  //the primary key column
  String primaryColumn;

  //all data columns
  Map<String, SqliteDataType> dataColumns;

  ///constructor
  DatabaseTable(this.tableName, this.primaryColumn, this.dataColumns);
}
