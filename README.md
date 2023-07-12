## 介绍

一个简单的脚手架项目，你可以通过clone该项目，进行一个快速的Flutter项目开发，该脚手架
项目提供了常用的功能封装，包括Http、WebSocket、Sqlite、File、Camera、Permission等功能的使用，同时提供了非常多的工具库， 协助开发者进行使用  
*（部分工具库参照本人的**JavaSkyeUtil**的库进行编写，较为方便）*

### 主要目录的功能

* `lib/configuration`: 包含相关功能的配置方式及配置信息
    * `auto_configuration`: 主要为实现自动配置的类，其不需要修改，相关的配置信息在`application.yaml`中进行修改，主要包含 `sqlite`
      ,`websocket`,`http`
    * `其余文件`: 实现相关的配置信息，主要包含：国际化、`initializer`、路由
* `lib/expand`: 主要是对原有功能的拓展部分
    * `class_extension`: 对于相关原有类的拓展，实现功能的增强，主要包含`list`,`listview`,`map`,`string`,`widget`
    * `data_structure`: 一些新增的数据结构，主要包含 二维表格构
    * `widget`: 一些新增的组件，主要包含 状态保存组件、方向控制组件
* `lib/initiaializer`: 包含所有的初始化类，其控制初始化逻辑，及相关工具
    * `service`: 服务性初始化任务，主要包含`sqlite`.`http`,`websocket`初始化器
    * `ui`: 界面性初始化器，主要包含 状态栏颜色控制
* `lib/standard`: 主要包含所有的全局统一UI标准，主要为颜色，字体，组件
* `lib/store`: 编写相关存储的部分
    * `entity`: 存放相关实体类的目录
        * `bo`: business object
        * `po`: persistence object
        * `dto`: data transfer object
        * `vo`: view object
    * `http`: 向上提供Http服务
        * `api`: 向`Controller`层提供对应的Http Api服务
        * `interceptor`: 主要是存放相关的`request`拦截器和`response`拦截器
    * `sqlite`: 向上提供sqlite服务
        * `api`: 向`Controller`层提供对应的Sqlite Api服务
* `lib/system`: 提供相关与系统紧密相关的服务
    * `flie`: 提供硬盘文件读写服务
    * `hardware`: 提供相关的硬件支持，主要包含相机
    * `http`: http服务的底层封装，以及提供异步解码器等功能
    * `resource`: 提供对于resource目录下文件操作的支持
        * `yaml`: 提供对于yaml文件解析的支持
    * `sqlite`: sqlite服务的相关封装
    * `websocket`:websocket服务的相关封装
* `lib/ui`: 编写界面的目录
* `lib/util`: 提供相关的工具类
    * `service`: 提供服务性的工具
        * `event_bus`: 对于事件总线的封装
        * `serialize`: 对于序列化的支持
        * `其他文件`：包含剪切板、SharedPreference、权限、Isolate的封装
* `resoure`: 相关的资源文件
    * `data`: 需要使用到的数据文件，主要包含emoji文件
    * `image`: 静态照片
    * `application.yaml`: 全局配置文件
    * `sqlite_table.yaml`: sqlite 数据表的生成工具

### 工具类

#### 日志工具

提供默认的日志对象，可以自定义默认的日志前缀名

```dart

Logger logger = Log.getInstance(author = "alien");
```

可以直接打印对应的日志

```dart
Log.i("this is an info logger");  
Log.d("this is a debug logger");  
Log.w("this is a warning logger");  
Log.e("this is an error logger");  
```

#### 资源工具

可以将资源文件转换为字符串对象

```dart

String assetStr = await AssetUtil.readDataFile("emoji.json");
```

可以将资源文件转换为**AssetImage**对象

```dart

AssetImage assetImage = AssetUtil.readDataImage("asset_image.png"); 
```

#### 缓存工具

提供对应数据在内存中全局应用  
**存对象**

```dart
CacheUtil.put("key","value");
```

**取对象**

```dart

dynamic value = CacheUtil.get("key");
```

**删除对象**

```dart
CacheUtil.remove("key");
```

#### 剪切板工具

剪切板写入数据

```dart
ClipboardUtil.put("data");
```

剪切板获取数据,将会获得最新的数据

```dart
String data = await ClipboardUtil.get();
```

#### 时间工具

获得当前的时间

```dart
// 获得DateTime对象
DateTime nowDateTime = DatetimeUtil.now();
// 获得当前的时间戳
int nowTimeStamp = DatetimeUtil.nowTimeStamp();
```

将时间戳转换为DateTime对象

```dart

DateTime nowDateTime = DatetimeUtil.fromTimeStamp(nowTimeStamp);
```

将对应的日期字符串转换成时间

```dart

DateTime dateTime = DatetimeUtil.convertStringToDate("2022-12-10");
```

将时间转换成对应的字符串

```dart

String dateStr = DatetimeUtil.convertDateToString(dateTime, "yyyy-mm-dd");
```

#### HTTP工具

拼接对应的参数，形成请求路径

```dart
// isAnonymous 将会决定前缀（在HttpConfiguration中配置）
String requestPath = HttpUtil.join("user", "login", isAnonymous = false);
```

获得响应体内容

```dart

String responseBody = await
HttpUtil.getBodyString(response);
```

#### 多线程工具

能够帮助你方便地开启一个新的线程来运行对应的函数

1. 声明一个函数 *（该函数必须为静态函数或者为非类函数）*

```dart
static FutureOr<dynamic> function(List<dynamic> parameter) async {
  ...
}
```

2. 使用该工具将当前的函数在新线程中运行

```dart

dynamic result = await IsolateUtil.builder(function)
                                  .setParameter(1)
                                  .setParameter(2)
                                  .run();
```

#### 数字工具

创建随机数字

```dart
// 将会获得一个 0-100 的随机数字
int number = NumberUtil.createRandomNumber(ceil = 100, floor = 0);
```

#### 对象工具

单个判空操作

```dart

bool result = ObjectUtil.isEmpty(obj);
bool result = ObjectUtil.isNotEmpty(obj);
```

集合判空操作

```dart

bool result = ObjectUtil.isAllEmpty(objList);
bool result = ObjectUtil.isAnyEmpty(objList);
```

默认值判断

```dart

bool result = ObjectUtil.isDefaultValue(obj);
bool result = ObjectUtil.isAllDefaultValue(objList);
```

#### 屏幕参数工具

获得Material Design的AppBar高度

```dart

double height = ScreenUtil.getAppBarHeight();
```

获得Scaffold主体高度

```dart

double height = ScreenUtil.getScaffoldBodyHeight();
```

获得弹出的软键盘高度

```dart

double height = ScreenUtil.getSoftKeyboardHeight();
```

#### SharedPreference工具

能够方便地对SharedPreference进行操作  
放数据

```dart
SharedPreferenceUtil.put("key","value");
```

取数据

```dart

dynamic value = await SharedPreferenceUtil.get("key");
```  

#### 表格

提供一种由X，Y来操作表格数据的方式

```dart

SkyeTable table = SkyeTable();
// 放数据
table.put("x","y","value");
// 取数据
String value = table.get("x", "y");
// 删除数据
table.remove("x","y");
```

判断行列操作

```dart
// 行是否存在
bool isExist = table.rowIsExist("x");
// 列是否存在
bool isExist = table.columnIsExist("y");
```

整行或者整列操作

```dart
// 获得整行
Map<String, value>? row = table.getRow("x");
// 获得整列
Map<String, value>? column = table.getColumn("y");
```

#### Sliver工具

删除List自带的上方Padding

```dart

MediaQuery mediaQuery = SliverUtil.removeTop(listView, context);
```

#### 字符串工具

生成一个UUID

```dart

String uuid = StringUtil.getUUID();
```  

分割字符串同时保留连接符在数组中

```dart
// 返回["www",".","google",".","com"]
List<String> list = StringUtil.splitAndJoin("www.google.com", ".");
```

#### 系统ui工具

是否为竖屏状态

```dart

bool isPortrait = SystemUiUtil.isPortrait(context);
```

设置屏幕方向

```dart
SystemUiUtil.setScreenDirection(ScreenDirection.Portrait);
SystemUiUtil.setScreenDirection(ScreenDirection.Landscape);
```

设置是否隐藏状态栏

```dart
SystemUiUtil.setOperationBarState(OperationBarState.Hide);
SystemUiUtil.setOperationBarState(OperationBarState.Show);
```

判断软键盘是否打开

```dart

bool result = softKeyboardIsOpen();
```

关闭软键盘

```dart
SystemUiUtil.closeSoftKeyboard();
```

显示Toast

```dart
SystemUiUtil.showToast("this isan error message");
// 消息内容取决于状态
SystemUiUtil.showToast("error message",successMsg="success message",state=isTrue);
```

#### 计时工具

延迟执行任务

```dart
// 任务将会在1S后执行
TimerUtil.delayExecuteTask(1000,function);
```

周期执行任务

```dart
// 任务将会在0.5S后开始周期执行，中间的间隔时间为1S，总共需要执行的次数为3次
TimerUtil.periodExecuteTask(intervalSeconds = 1000,function = myFunction,count = 3,delaySeconds = 500);
```

#### 组件工具

创建一个具有高斯模糊背景的组件

```dart

Widget widget = convertToGaussBlurWidget(widget);
```

#### 颜色工具

创建一个符合material规范的颜色

```dart

MaterialColor color = ColorUtil.createMaterialColor(color);
```

获得一个随机颜色

```dart

Color color = ColorUtil.getRandomColor();
```

获得当前的主题

```dart

ThemeData themeData = ColorUtil.getThemeData(isDark = true);
```

获得适配当前主题的指定色

```dart

Color color = ColorUitl.getAdaptColor(AdaptColorType.ThemeColor, reverse = false)
```

#### 总线工具

发送一个总线事件

```dart
EventBusUtil.send(busEvent);
```

监听总线事件

```dart
EventBusUtil.listen(
    BusEventType.Default,
    onData = onDataFunction,
    onError = onErrorFunction,
    onDone = onDoneFuntion,
    cancelOnError = false
);
```

#### 文件工具

获得一个文件操作对象

```dart

Operator operator = await FileUtil.operate("aa.txt",directoryType=DirectoryType.ApplicationCacheDirectory)
```

读文件内容

```dart
// 二进制读取
List<int> content = await operator.readFileAsBytes();
// 字符串读取
String content = await operator.readFileAsString();
// 对象读取
dynamic content = await opertor.readFileAsObject(User());
```

写文件内容

```dart
// 二进制写入
operator.writeFileBytes(content,needCover=false);
// 字符串写入
operator.writeFileString(content,needConver=false);
// 对象写入
opertor.writeFileAsObject(user,needConver=false);
```

#### 序列化工具

1. 创建一个类继承`Serializable`接口
2. 使用`SerializeUtil`实现序列化和反序列化

将自定义对象转换成由 `Map`，`List`等组成的基本对象

```dart

Map map = SerializeUtil.asBasic(user)
```

将基本对象转换成自定义对象

```dart

User user = SerializeUtil.asCustomized<User>(map, User());
```

序列化为字符串

```dart

String? json = SerializeUtil.serialize(user);
```

反序列化为对象

```dart

User user = SerializeUtil.deserialize<User>(json, User())
```

类型强转

```dart

String val = SerializeUtil.asT<String>(value);
```

#### SQLite工具

1. 创建一个SQLite数据库

```dart

CustomDatabase database = CustomDatabase.builder("tempDatebase", "skye", [dataTable1, dataTable2]);
```

2. 初始化

```dart
database.init();
```

3. 基本的CRUD

```dart
// 插入一条数据
database.insert("User",user);
// 根据Id查找数据
User user = await database.findOneById<User>("User","1",user);
// 找到全部对象
List<User> userList = await database.findAll<User>("User","skye",User());
// 更新一个对象
int count = await database.updateOneById<User>("User","1",user);
// 判断对象是否存在
bool isExist = await database.isExistById<User>("User","1");
// 删除一个对象
int count = awaitdatabse.deleteOneById<User>("User", "1");
```

4. 原生SQL操作

```dart
// 原生查询
List<Map<String, dynamica>> data = database.rawQuery(sql, ["1"]);
// 原生更新
int count = database.rawUpdate(sql, ["1", "aa"]);
// 原生插入  
int count = database.rawInsert(sql, ["1", "aa"]);
// 原生删除  
int count = database.rawDelete(sql, ["1", "aa"]);
```




