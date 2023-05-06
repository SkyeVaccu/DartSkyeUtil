import '../initializer/initializer.dart';
import '../initializer/service/http_initializer.dart';
import '../initializer/service/sqlite_initializer.dart';
import '../initializer/service/websocket_initializer.dart';
import '../initializer/ui/status_bar_initializer.dart';

///it's the configuration to configure all initializer
class InitializerConfiguration {
  // the initializer list
  static final List<Initializer> initializerList = [
    HttpInitializer(),
    WebSocketInitializer(),
    SqliteInitializer(),
    StatusBarInitializer(),
  ];
}
