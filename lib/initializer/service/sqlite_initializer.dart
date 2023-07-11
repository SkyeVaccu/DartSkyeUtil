import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../system/yaml_configuration/yaml_parser.dart';
import '../../system/yaml_configuration/YamlConfiguration.dart';
import '../../util/cache_util.dart';
import '../../configuration/sqlite_configuration.dart';
import '../../initializer/initializer.dart';
import '../../util/sqlite/custom_database.dart';

///it's the initializer which is used to initialize the sqlite database
class SqliteInitializer extends Initializer {
  @override
  Future<void> init(BuildContext context) async {
    // get the configuration
    YamlConfiguration configuration = CacheUtil.get("_GlobalConfiguration");
    // if we active the sqlite environment
    if (configuration["sqlite"] != null && (configuration["sqlite.status"] ?? true)) {
      //parse the sqlite table yaml
      YamlConfiguration sqliteConfiguration = await YamlParser.parse("resource/sqlite_table.yaml");
      // store the sqlite table configuration into the global cache
      CacheUtil.put("_SqliteTableConfiguration", sqliteConfiguration);
      // get the instance
      SqliteConfiguration instance = SqliteConfiguration.getInstance();
      //create the database
      CustomDatabase customDatabase = CustomDatabase.builder(
        instance.dataBaseName,
        instance.identitySign,
        instance.databaseTableList,
      );
      //init it
      customDatabase.init();
      //put it into the Get container
      Get.put(customDatabase);
    }
  }
}
