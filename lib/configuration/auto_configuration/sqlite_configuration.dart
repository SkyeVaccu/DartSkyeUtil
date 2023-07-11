import 'package:yaml/yaml.dart';

import '../../system/resource/yaml/yaml_configuration.dart';
import '../../system/sqlite/database_table.dart';
import '../../system/sqlite/sqlite_data_type.dart';
import '../../system/sqlite/sqlite_util.dart';
import '../../util/cache_util.dart';

///it's the configuration to identity the sqlite
class SqliteConfiguration {
  // the database name
  late String dataBaseName;

  //the sign which assign to the login user
  late String identitySign;

  //the database table list
  late List<DatabaseTable> databaseTableList;

  // the static instance
  static late SqliteConfiguration instance;

  // the constructor method
  static SqliteConfiguration getInstance() {
    instance = SqliteConfiguration._();
    return instance;
  }

  SqliteConfiguration._() {
    // get the global yaml configuration
    YamlConfiguration configuration = CacheUtil.get("_GlobalConfiguration");
    // get the database name
    dataBaseName = configuration["sqlite.dataBaseName"] ?? "sqlite3";
    // get the identity sign
    identitySign = configuration["sqlite.identitySign"] ?? "loginUserId";
    // get the identity sign type
    SqliteDataType identitySignType =
        SqliteUtil.mate(configuration["sqlite.identitySignType"] ?? "TEXT");
    // get the sqlite table configuration
    YamlConfiguration sqliteConfiguration = CacheUtil.get("_SqliteTableConfiguration");
    // get the sqlite table configuration list
    YamlList databaseTableConfiguration = sqliteConfiguration["sqlite"];
    // parse the every table
    for (YamlMap table in databaseTableConfiguration) {
      // get the table name
      String? tableName = table["tableName"];
      // get the primary column
      String? primaryColumn = table["primaryColumn"];

      // check the information
      if (tableName == null || primaryColumn == null) {
        throw "table lack the necessary information";
      }
      // which store the column information
      Map<String, SqliteDataType> dataColumns = {};
      // parse the every column
      YamlList columnConfigurations = table["columns"];
      for (YamlMap column in columnConfigurations) {
        // decide the column type
        dataColumns[column["name"]] = SqliteUtil.mate(column["type"]);
      }
      // if we need different the login user, we will add a new column
      if (table["loginDifference"] ?? true) {
        dataColumns[identitySign] = identitySignType;
      }
      databaseTableList.add(DatabaseTable(tableName, primaryColumn, dataColumns));
    }
  }
}
