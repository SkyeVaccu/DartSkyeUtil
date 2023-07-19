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
        * `map_struct`: map_struct转换器，包含所有的转换对象
            * `impl`: 使用smart_struct生成的转换实体类
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
        * `smart_struct`: 对于smart_struct的支持
        * `其他文件`：包含剪切板、SharedPreference、权限、Isolate的封装
* `resoure`: 相关的资源文件
    * `data`: 需要使用到的数据文件，主要包含emoji文件
    * `image`: 静态照片
    * `application.yaml`: 全局配置文件
    * `sqlite_table.yaml`: sqlite 数据表的生成工具

### 简单工具类
#### 业务工具
##### 日志工具
可以自定义日志前缀名
> 必选参数：
> * author: 前缀名称

```dart
Logger logger = Log.getInstance(author = "alien");
```

可以直接打印对应的日志
> 必选参数：
> * <String> message: 消息内容  

> 可选参数：
> * <String> authorName: 前缀名，默认值为 Skye

> 直接调用则会使用默认前缀

```dart
Log.i("this is an info logger");  
Log.d("this is a debug logger");  
Log.w("this is a warning logger");  
Log.e("this is an error logger");  
```

##### 资源工具
读取`resource`文件夹下的字符串文件
> 必选参数：
> * <String> fileName: 文件名  

```dart
String assetStr = await AssetUtil.readDataFile("emoji.json");
```
读取`resource`文件夹下的照片文件，并转换为**AssetImage**对象
> 必选参数：
> * <String> fileName: 文件名  

```dart
AssetImage assetImage = AssetUtil.readDataImage("asset_image.png"); 
```

##### 缓存工具
存对象

> 必选参数：
> * <String> key: 键  
> * <dynamic> value: 值  

```dart
CacheUtil.put("key","value");
```
取对象
> 必选参数：
> * <String> key: 键  

```dart
dynamic value = CacheUtil.get("key");
```
删除对象
> 必选参数：
> * <String> key: 键  

```dart
CacheUtil.remove("key");
```

##### 剪切板工具

剪切板写入数据
> 必选参数：
> * <String> data: 需要写入剪切板的数据  

```dart
ClipboardUtil.put("data");
```
剪切板获取数据，只会获得最新的数据
```dart
String data = await ClipboardUtil.get();
```

##### 时间工具

获得当前的时间
```dart
// 获得DateTime对象
DateTime nowDateTime = DatetimeUtil.now();
// 获得当前的时间戳
int nowTimeStamp = DatetimeUtil.nowTimeStamp();
```
将时间戳转换为DateTime对象
> 必选参数：
> * <int> timeStamp: 时间戳  

```dart
DateTime nowDateTime = DatetimeUtil.fromTimeStamp(nowTimeStamp);
```
字符串转时间对象
> 必选参数：
> * <String> datetimeString: 时间字符串  

```dart
DateTime dateTime = DatetimeUtil.convertStringToDate("2022-12-10");
```
时间对象转字符串
> 必选参数：
> * <DateTime> dateTime: 时间对象  
> * <String> formatString: 格式化字符串  

```dart
String dateStr = DatetimeUtil.convertDateToString(dateTime, "yyyy-mm-dd");
```

##### 数字处理工具

获得指定范围内的一个随机数字
> 可选参数：
> * <int> ceil: 最大值，默认为1000  
> * <int> floor: 最小值，默认为0  

```dart
int number = NumberUtil.createRandomNumber(ceil = 100, floor = 0);
```

##### 对象工具

单个判空操作
> 必选参数：
> * <dynamic> obj: 目标对象  

```dart
// 对象是否为空
bool result = ObjectUtil.isEmpty(obj);
// 对象是否不为空
bool result = ObjectUtil.isNotEmpty(obj);
```
集合判空操作
> 必选参数：
> * <List<dynamic>> objList: 目标对象列表

```dart
// 集合是否全为空
bool result = ObjectUtil.isAllEmpty(objList);
// 集合存在空值
bool result = ObjectUtil.isAnyEmpty(objList);
```
对象默认值判断
> 必选参数：
> * <dynamic> obj: 目标对象  

```dart
// 该对象是否为默认值
bool result = ObjectUtil.isDefaultValue(obj);
```
集合默认值判断
> 必选参数：
> * <List<dynamic>> objList: 目标对象列表

```dart
// 集合中所有值是否为默认值
bool result = ObjectUtil.isAllDefaultValue(objList);
```

##### 字符串工具

生成一个UUID
```dart
String uuid = StringUtil.getUUID();
```  
分割字符串同时保留连接符在数组中
> 必选参数：
> * <String> str: 目标字符串  
> * <String> reg: 用于分割的正则表达式  

```dart
// 返回["www",".","google",".","com"]
List<String> list = StringUtil.splitAndJoin("www.google.com", ".");
```

##### 计时工具

延迟执行任务
> 必选参数：
> * <int> delaySeconds: 延迟毫秒数  
> * <Function> function: 任务方法  

```dart
// 任务将会在1s后执行
TimerUtil.delayExecuteTask(1000,function);
```
周期执行任务
> 必选参数：
> * <int> intervalSeconds: 执行间隔毫秒数  
> * <Function> function: 任务方法  

> 可选参数：
> * <int> count: 重复次数，默认值3
> * <int> delaySeconds: 延迟毫秒数，默认为0   

```dart
// 任务将会在0.5S后开始周期执行，中间的间隔时间为1S，总共需要执行的次数为3次
TimerUtil.periodExecuteTask(
    intervalSeconds: 1000,
    function: myFunction,
    count: 3,
    delaySeconds: 500);
```

##### 字节工具
将字符串转换成字节
> 必选参数：
> * <String> hexData: 字符串数据  

```dart
Uint8List uList = ByteUtil.stringToUList("Hello World!");
```

将字节转换成字符串
> 必选参数：
> * <Uint8List> uint8list: 字节数据  

```dart
String str = ByteUtil.ulistToString(uList);
```

将二进制字符串转换成字节
> 必选参数：
> * <String> binaryString: 二进制字符串  

```dart
Uint8List uList = ByteUtil.binaryStringToUList("101010");
```

将十六进制字符串转换成字节
> 必选参数：
> * <String> hexString: 十六进制字符串  

```dart
Uint8List uList = ByteUtil.hexStringToUList("7F1A0B");
```

将`int`列表转成字节列表
> 必选参数：
> * <List<int>> list: int列表

```dart
Uint8List uList = ByteUtil.listToUList([1,2,3,16]);
```

将字节列表转成`int`列表
> 必选参数：
> * <Uint8List> uint8list: 字节列表  

```dart
List<int> list = ByteUtil.ulistToList(ulist);
```

**** 
#### UI工具
##### 屏幕参数工具

获得`Material Design`的AppBar高度
```dart
double height = ScreenUtil.getAppBarHeight();
```
获得状态栏的高度
```dart
double height = ScreenUtil.getStatusBarHeight();
```
获得`Scaffold`主体高度
```dart
double height = ScreenUtil.getScaffoldBodyHeight();
```
获得弹出的软键盘高度
```dart
double height = ScreenUtil.getSoftKeyboardHeight();
```
##### Sliver工具

删除List自带的上方Padding
```dart
MediaQuery mediaQuery = SliverUtil.removeTop(listView, context);
```

##### 系统ui工具

是否为竖屏状态
> 必选参数：
> * <BuildContext> context: 上下文对象  

```dart
bool isPortrait = SystemUiUtil.isPortrait(context);
```
设置屏幕方向
> 必选参数：
> * <ScreenDirection> screenDirection: 屏幕方向  

```dart
SystemUiUtil.setScreenDirection(ScreenDirection.Portrait);
SystemUiUtil.setScreenDirection(ScreenDirection.Landscape);
```
设置是否隐藏状态栏
> 必选参数：
> * <OperationBarState> operationBarState: 操作栏状态   

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
> 必选参数：
> * <String> errorMsg: 错误信息  

> 可选参数：
> * <String?> successMsg: 成功信息，默认为""
> * <dynamic> state: 状态，默认为null  

```dart
// 根据state的值选择内容显示
SystemUiUtil.showToast("error message",successMsg="success message",state=isTrue);
```

##### 组件工具

创建一个具有高斯模糊背景的组件
> 必选参数：
> * <Widget> widget: 组件对象  

> 可选参数：
> * <int> sigmaX：X轴模糊半径，默认10  
> * <int> sigmaY：Y轴模糊半径，默认10  

```dart
Widget widget = convertToGaussBlurWidget(widget);
```

##### 颜色工具

创建一个符合`material`规范的颜色
> 必选参数：
> * <Color> color: 主题色对象  

```dart
MaterialColor color = ColorUtil.createMaterialColor(color);
```
获得一个随机颜色
```dart
Color color = ColorUtil.getRandomColor();
```
获得主题对象
> 可选参数:
> * <bool> isDark: 是否为夜间模式，false  

```dart
// 获得夜间模式主题
ThemeData themeData = ColorUtil.getThemeData(isDark = true);
```
获得适配当前主题的指定色
> 必选参数：
> * <AdaptColorType> adaptColorType: 颜色类型  

> 可选参数：
> * <bool> reverse: 是否翻转颜色模式，默认为false 

```dart
Color color = ColorUitl.getAdaptColor(AdaptColorType.ThemeColor, reverse = false)
```
****  
#### Serialize
该部分为该工具类核心部分，该包部分工具基于该包的实现，该包提供了对于对象的序列化和反序列化操作

##### 创建一个符合序列规则的类
该目标类应当继承`EmptySerializable`类，实现相关的抽象接口，如下所示：
> 考虑到每次实现较为复制，此处提供了一个**Windows**应用，帮助快速生成该文件内容，安装包为`to_dart_bean.msix`

```dart
class User extends EmptySerializable{
    String? account;
    String? password;
    
    User();
    
    User.create({
        this.account,
        this.password,
    });
    
    @override
    User fromJson(Map<String,dynamic> json) => User.create(
        account:SerializeUtil.asT<String>(json['account']),
        password:SerializeUtil.asT<String>(json['password']),
    );
    
    @override
    Map<String, dynamic> toJson() => <String, dynamic>{
        'account':account,
        'password':password,
        
    };
    
    @override
    bool mapPair(Map<String, dynamic> json) => super.simpleMapPair(json, [
	    "account",
	    "password",
	   ]);
}
```

##### SerializeUtil的使用
将对象转换为基础对象，也就是dart内置基本类型
> 必选参数：
> * <dynamic> oldObj: 待转换的对象  

```dart
List<String> basicObj = SerializeUtil.asBasic(obj);
```
将基础对象转换为自定义类对象
> 必选参数：
> * <dynamic> object: 待转换的对象  
> * <T> targetObj: 待转换目标类的示范对象  

```dart
User user = SerializeUtil.asCustomized<User>(obj, User());
```
将对象转换为json字符串
> 必选参数：
> * <dynamic> obj: 待序列化的对象  

```dart
String? json = SerializeUtil.serialize(user);
```
将json字符串反序列化成目标对象
> 必选参数：
> * <dynamic> obj: 待序列化的对象  
> * <T> targetObj: 待转换目标类的示范对象  

```dart
User user = SerializeUtil.deserialize<User>(json, User());
```
类型转换
> 必选参数：
> * <dynamic> value: 待转换的对象  

```dart
double? data = SerializeUtil.asT<double>("123.0");
```

****  
#### Shared Preference的使用
> 对于`Shared Preference`对象的初始化工作将会在第一个使用Shared Preference时完成

> 本工具基于同个包中的`SerializeUtil`实现，因此当目标为自定义类时，应当符合序列化工具要求

放数据
> 必选参数：
> * <String> key: 键  
> * <dynamic> value: 值  

```dart
SharedPreferenceUtil.put("key","value");
```
取数据
> 必选参数：
> * <String> key: 键  

> 可选参数：
> * <dynamic> targetObj: 值需要转换的类的一个范例对象  

```dart
dynamic value = await SharedPreferenceUtil.get("key");
```  
****  
#### 文件操作
本库提供了对于文件的便捷的操作方式，同时支持多个目录操作
##### 简单使用
1. 获得一个文件操作对象
> 必选参数：
> * <String> fileName: 文件名  

> 可选参数：
> * <DirectoryType> directoryType: 文件所在的目录，默认为应用的文档目录  

```dart
Operator operator = await FileUtil.operate("aa.txt");
```
2. 使用操作对象操作文件
* 二进制形式读文件内容
```dart
List<int> content = await operator.readFileAsBytes();
```
* 字符串形式读取文件内容
```dart
String content = await operator.readFileAsString();
```
* 读取文件内容并转化为目标对象
> 可选参数：
> * <dynamic> targetObject: 目标类实例对象，默认为null  
```dart
dynamic content = await opertor.readFileAsObject(User());
```
* 往文件写入二进制内容
> 必选参数：
> * <String> content: 字节内容  

> 可选参数：
> * <bool> needCover: 是否覆盖，默认为false  

```dart
operator.writeFileBytes(content);
```
* 往文件写入字符串内容
> 必选参数：
> * <String> content: 字符串内容  

> 可选参数：
> * <bool> needCover: 是否覆盖，默认为false  

```dart
operator.writeFileString(content);
```
* 往文件写入对象内容
> 必选参数：
> * <dynamic> content: 对象内容  

> 可选参数：
> * <bool> needCover: 是否覆盖，默认为false   

```dart
opertor.writeFileAsObject(user);
```
****  
#### Isolate
本类提供了一个方便工具，能够帮助你方便地开启一个新的线程来运行对应的函数
1. 声明一个函数 *（该函数必须为静态函数或者为非类函数）*

该函数的声明是被限制死的，必须为`static FutureOr<dynamic> function(List<dynamic> parameter) async`

被调用时，参数将会被打包成List传入

```dart
static FutureOr<dynamic> function(List<dynamic> parameter) async {
  // 此处为函数内容
  // ...
}
```

2. 使用该工具将当前的函数在新线程中运行

该工具类采用建造者模式搭建，可以通过`setParameter()`方法添加参数，最后都会被打包到一个`List`中传入目标函数

```dart
dynamic result = await IsolateUtil.builder(function)
                                  .setParameter(1)
                                  .setParameter(2)
                                  .run();
```
****
#### EventBus
##### 简单使用
1. 在`BusEventType.dart`文件中定义需要的总线事件类型
2. 创建一个总线事件对象
```dart
BusEvent busEvent = BusEvent(BusEventType.Default,data);
```
3. 发送总线事件
> 必选参数：
> * <BusEvent> busEvent: 总线事件对象  

```dart
EventBusUtil.send(busEvent);
```
4. 设置监听总线事件
> 必选参数：
> * <BusEventType> busEventType: 监听的总线事件类型  
> * <void Function(BusEvent event)?> onData: 处理事件的函数

> 可选参数：
> * <Function?> onError: 出现异常时的回调函数
> * <void Function()?> onDone: 发送完成时的回调函数
> * <bool?> cancelOnError: 出现异常时是否取消发送

```dart
EventBusUtil.listen(
    BusEventType.Default,
    onData = onDataFunction,
    onError = onErrorFunction,
    onDone = onDoneFuntion,
    cancelOnError = false
);
```
****  
#### 硬件操作
##### Camera工具
能够方便地进行拍摄照片或录制视频

拍摄一张照片
> 必选参数：
> * <void Function(XFile?) callback> callback: 拍摄完照片后的回调函数

> 可选参数：
> * <CameraDevice> cameraDevice: 拍摄使用的镜头，默认为 CameraDevice.rear,  
> * <int?> imageQuality: 压缩后的照片质量，默认为null

```dart
CameraUtil.takePhoto(callback);
```
录制一段视频
> 必选参数：
> * <void Function(XFile?) callback> callback: 录制后的回调函数

> 可选参数：
> * <CameraDevice> cameraDevice: 拍摄使用的镜头，默认为 CameraDevice.rear,  
> * <int?> maxDuration: 最大录制时长，默认为null

```dart
CameraUtil.takeVideo(callback);
```

选取一张照片
> 必选参数：
> * <void Function(XFile?) callback> callback: 选取照片后的回调函数

> 可选参数：
> * <int?> imageQuality: 压缩后的照片质量，默认为null

```dart
CameraUtil.selectPhoto(callback);
```

选取多张照片
> 必选参数：
> * <void Function(List<XFile>) callback> callback: 选取照片后的回调函数

> 可选参数：
> * <int?> imageQuality: 压缩后的照片质量，默认为null

```dart
CameraUtil.selectMultiPhoto(callback);
```

选取一段录像
> 必选参数：
> * <void Function(XFile>) callback> callback: 选取录像后的回调函数

> 可选参数：
> * <int?> maxDuration: 最大录像时长，默认为null

```dart
CameraUtil.selectVideo(callback);
```
****
#### HTTP的使用
该工具对Http工具进行了一定程度的封装，使其更加简洁易用

使用该包进行请求时，由于对响应做了封装操作，因此应当使得响应符合以下的格式
```json
{
    "code" : 200,
    "script" : "这是一个成功请求",
    "responseData" : {}
}
```

> 该类编写的上层Api类应当编写在`lib/store/http/api/`文件夹下

##### 使用
1. 在`resource/application.yaml`中编写相关配置信息
```yaml
http:
  # 是否开启http功能
  status: true
  # 激活的环境
  activeProfile: mock
  # 匿名请求时的请求前缀，例如：http://100.10.10.10:3004/anony/...
  anonymousPrefix: anony
  # 认证成功后的请求前缀，例如：http://100.10.10.10:3004/user/...
  identityPrefix: user
  # mock环境配置
  mock:
    protocol: https
    host: console-mock.apipost.cn
    port: /app/mock/project/8deeb012-ac45-46b5-c0f1
  # 本地环境配置
  local:
    protocol: http
    host: 10.2.2.2
    port: 10035
  # 生产环境配置
  development:
    protocol: http
    host: vaccum.ltd
    port: 10035
```
2. 编写一个类来进行请求
> `HttpClient`中提供了很多的方法来进行请求，部分方法可以实现对于返回数据的反序列化

```dart
class UserApi {
  // 这个请求的总前缀
  static const String urlPrefix = "user";

  static Future<User> login(User user) async {
    // 拼接获得当前请求的uri
    var uri = HttpClient.join(urlPrefix, "login");
    // 获得HttpClient对象
    HttpClient httpClient = Get.find<HttpClient>();
    // 使用该请求发起请求
    User resultUser = await httpClient.toPostAndDecode<User, User>(
        uri: uri,
        body: FormData({"username": user.username, "password": user.password}),
        modelObj: User());
    // 返回对象
    return resultUser;
  }
```
*3. 可以通过编写请求拦截器和响应拦截器在过程中进行操作
1. 编写拦截器
   以下为一个请求拦截器
```dart

class TokenInterceptor extends RequestInterceptor {

  @override
  FutureOr<Request> intercept(Request request) {
    // 操作请求对象
    return request;
  }
}
```
以下为一个响应拦截器
```dart
class ErrorInterceptor extends ResponseInterceptor {

  @override
  FutureOr<Response> intercept(Request request, Response response) {
    // 操作响应对象
    return response;
  }
}
```
2. 将拦截器在初始化方法中添加

在`/initializer/HttpInitializer.dart`中创建`HttpClient`对象时传入
```dart
HttpClient httpClient = HttpClient.uriBuilder(
                                uri:instance.baseUrl,
                                requestInterceptorList:[TokenInterceptor()],
                                responseInterceptorList:[ErrorInterceptor()]);
```
****
#### WebSocket使用
本仓库对Websocket进行了一定程度的封装，方便用户进行使用，本工具**代码侵入性较强**，适合新建项目进行使用，同时搭配本人仓库`SkyeJavaUtil`使用，能够减少编写压力

> 该类编写的Api类应当

由于为了更好的能够使用该包，本库对于传入的包结构做了要求，具体详见`WebSocketPackage`这个工具类，以下只做简单阐述
> <String?> id :  当前包的主键id
> <String?> responseId :  响应包的主键id
> <dynamic> content :  主要内容
> <int?> time :  发送时间
> <String?> loop :  大主题
> <String?> subject :  小主题
> <String?> webSocketPackageType :  包的类型
> <Map<String , dynamic>?> additionalInfos :  附加信息

##### 使用
1. 在`resource/application.yaml`中配置相关的信息
```yaml
websocket:
  # 是否开启websocket功能
  status: true
  # 请求的前缀
  identityPrefix: socket
  # 心跳的间隔时间，当前为15s
  heartBeatPeriod: 15
  # 激活的环境
  activeProfile: development
  # 本地环境的配置信息
  local:
    protocol: ws
    host: 10.0.2.2
    port: 10035
  # 生产环境的配置信息
  development:
    protocol: ws
    host: console-mock.apipost.cn
    port: /app/mock/project/8deeb012-ac45-46b5-c0f1-e4cab750ddf0
```
2. 编写一个`WebSocket`的发送器
```dart
class TestWebSocketClientSender extends WebSocketClientSender{
    
    String getLoop() => "TestLoop";
    
    String getSubject() => "TestSubject";
    
    lazy WebSocketClient webSocketClient;

    @override
    void bind(WebSocketClient webSocketClient){
        // 会传入已经绑定的webSocketClient，相当于初始化方法
        // 通常会用来保存WebSocketClient对象
        this.webSocketClient=webSocketClient;
    }
    
    @override
    void send(WebSocketPackage webSocketPackage){
        // 编写具体的发送方法逻辑
        // 最后需要使用绑定的WebSocketClient发送包
        webSocketClient.send(webSocketPackage);
    }
}
```
3. 编写一个`WebSocket`的接受器
```dart
class TestWebSocketClientSender extends WebSocketClientReceiver{
    
    String getLoop() => "TestLoop";
    
    String getSubject() => "TestSubject";
    
    lazy WebSocketClient webSocketClient;

    @override
    void bind(WebSocketClient webSocketClient){
        // 会传入已经绑定的webSocketClient，相当于初始化方法
        // 通常会用来保存WebSocketClient对象
        this.webSocketClient=webSocketClient;
    }
    
    @override
    void receive(WebSocketPackage webSocketPackage){
        // 编写接收到数据包的处理逻辑
    }
}
```
4. 注册上面编写的接收器和发送器
```dart
// 获得默认的WebSocketClient平台
WebSocketClient webSocketClient = Get.find<WebSocketClient>();

// 生成对应客户端  
TestWebSocketClientSender testWebSocketClientSender = TestWebSocketClientSender();
TestWebSocketClientReceiver testWebSocketClientReceiver = TestWebSocketClientReceiver();

//进行注册  
webSocketClient.register(testWebSocketClientSender);
webSocketClient.register(testWebSocketClientReceiver);

//发送数据包
testWebSocketClientSender.send(WebSocketPackage())
```
****
#### SQLite使用
本工具对`Sqlite`进行了封装，方便使用，同时考虑到存在多用户登录的情况，为了保证外键的统一，因此对于库表有部分约束

> 该类编写的上层Api类应当编写在`lib/store/sqlite/api/`文件夹下

##### 使用
1. 在`resource/application.yaml`中进行配置
```yaml
sqlite:
  # 是否开启sqlite功能
  status: true
  # 数据库名
  databaseName: test_database
  # 登录用户的标识字段
  identitySign: loginUserId
  # 标识字段的类型
  identitySignType: TEXT
```
2. 在`resource/sqlite_table.yaml`中配置所有表信息
```yaml
sqlite:
  # 第一张为User表
  - tableName: User
    # 主键列为 userId
    primaryColumn: userId
    # 所有的列信息
    columns:
      # 第一个字段为userId
      - name: userId
        # 类型为 INTEGER
        type: INTEGER
      # 第二个字段为username
      - name: username
        # 类型为 Text
        type: TEXT
  # 第二张为 book表
  - tableName: book
    primaryColumn: id
    # 是否需要插入登录用户的标识列
    loginDifference: true
    columns:
      - name: id
        type: TEXT
```
3. 获得默认注入的`Database`对象
```dart
CustomDatabase database = Get.find<CustomDatabaase>();
```
4. 基本的CRUD
   插入一条数据
> 必选参数：
> * <String> tableName: 表名  
> * <E> obj: 需要插入的对象  

> 可选参数：
> * <ConflictAlgorithm?> conflictAlgorithm: 冲突策略，默认为null

```dart
int influenceRows = await database.insert("user",user);
```

根据id查找一条数据
> 必选参数：
> * <String> tableName: 表名  
> * <String> id: 主键值
> * <E> targetObj: 目标类的示例对象

```dart
User user = await database.findOneById<User>("User","1",user);
```

查找登录用户的所有数据
> 必选参数：
> * <String> tableName: 表名  
> * <String?> loginUserId: 登录用户辨识列值
> * <E> targetObj: 目标类的示例对象

```dart
List<User> userList = await database.findAll<User>("User","skye",User());
```

更新一个用户
> 必选参数：
> * <String> tableName: 表名  
> * <String?> id: 更新记录的主键id值
> * <E> targetObj: 目标类的示例对象

```dart
int count = await database.updateOneById<User>("User","1",user);
```

判断记录是否存在
> 必选参数：
> * <String> tableName: 表名  
> * <String?> id: 记录的主键id值

```dart
bool isExist = await database.isExistById<User>("User","1");
```

删除一条记录
> 必选参数：
> * <String> tableName: 表名  
> * <String?> id: 更新记录的主键id值

```dart
int count = awaitdatabse.deleteOneById<User>("User", "1");
```

5. 原生SQL操作
   原生查询
> 必选参数：
> * <String> sql: sql语句  
> * <List<Object?>?> arguments: 参数值

```dart
List<Map<String, dynamica>> data = database.rawQuery(sql, ["1"]);
```

原生更新
> 必选参数：
> * <String> sql: sql语句  
> * <List<Object?>?> arguments: 参数值

```dart
int count = database.rawUpdate(sql, ["1", "aa"]);
```

原生插入
> 必选参数：
> * <String> sql: sql语句  
> * <List<Object?>?> arguments: 参数值

```dart
int count = database.rawInsert(sql, ["1", "aa"]);
```

原生删除
> 必选参数：
> * <String> sql: sql语句  
> * <List<Object?>?> arguments: 参数值

```dart
int count = database.rawDelete(sql, ["1", "aa"]);
```  
****  
#### Map_Struct
由于在编码过程中存在实体类分层问题，本仓库基于`smart_struct`进行修改，并且融入了其代码，帮助能够更快地生成转换类
> 此处感谢smotastic的库

具体的其他可用方法，参照[smart_struct](https://github.com/smotastic/smartstruct)

如果想要对生成位置等进行修改，需要定制化`build.yaml`文件
##### 简单使用
1. 修改`build.yaml`文件，将部分内容改成自己的包
```yaml
builders:
  mapper:
    # set the buildr file which will be called
    # 此处要改成自己的包名
    import: "package:skye_utils/util/service/smart_struct/builder.dart"
    # define the builder factories name
    builder_factories: ["smartStructBuilder"]
    # define the file extension reflection
    build_extensions: { ".dart": [".g.dart"] }
    # scope of the action
    auto_apply: all_packages
    # the created file store location
    build_to: source
    # the preceding builder
    runs_before: ["injectable_generator|injectable_builder"]
    # which file will be handle at last
    required_inputs: [".g.dart"]

# define the target rule
targets:
  # the default run rule
  $default:
    # the apply source directory
    sources:
      - lib/**
    # the rule of the builder
    builders:
      # you should use the project name here
      # 此处要改成自己的包名
      skye_utils|mapper:
        options:
          # define the file where is created
          build_extensions: { "lib/store/entity/map_struct/{{}}.dart": "lib/store/entity/map_struct/impl/{{}}.g.dart" }
```
2. 编写对应的抽象接口
```dart
import '../../../util/service/smart_struct/annotations.dart';
import '../bo/user_bo.dart';
import '../dto/user_dto.dart';

part 'impl/user_mapper.g.dart';

@Mapper()
abstract class UserMapper {

  @Mapping(source: "password", target: "password", isStraight: true)
  UserBO? dto2bo(UserDTO userDTO, String? password);

  UserDTO? bo2dto(UserBO userBO);
}

```
3. 运行对应的命令
```sh
> dart run builde_runner build
```
4. 可以发现在`lib/store/entity/map_struct/impl`下已经生成了对应的转换类
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../user_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class UserMapperImpl extends UserMapper {
  UserMapperImpl() : super();

  @override
  UserBO? dto2bo(
    UserDTO userDTO,
    String? password,
  ) {
    final userbo = UserBO.create(
      userDTO.username,
      password,
    );
    return userbo;
  }

  @override
  UserDTO? bo2dto(UserBO userBO) {
    final userdto = UserDTO.create(userBO.username);
    return userdto;
  }
}

```
****  
#### *依赖介绍
##### dart版本
2.18.5
##### flutter版本
3.3.9
##### 生产依赖
```yaml
get: ^4.6.5
flutter_screenutil: ^5.6.0
flutter_smart_dialog: ^4.7.1
responsive_builder: ^0.4.3
shared_preferences: ^2.0.15
uuid: ^3.0.7
date_format: ^2.0.7
path_provider: ^2.0.11
logger: ^1.1.0
event_bus: ^2.0.0
sqflite: ^2.2.2
permission_handler: ^10.2.0
image_picker: ^0.8.6
yaml: ^3.1.0
```
##### 开发依赖
```yaml
flutter_lints: ^2.0.1
build_runner: ^2.1.7
freezed: ^1.1.1
injectable_generator: ^1.5.3
test: ^1.20.1
source_gen_test: ^1.0.2
analyzer: ^3.2.0
build: ^2.2.1
code_builder: ^4.1.0
path: ^1.8.1
source_gen: ^1.2.1
freezed_annotation: ^1.1.0
```