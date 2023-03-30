### 介绍

一个简单的工具类，参照本人的**JavaSkyeUtil**的库，使用dart进行编写,这个工具类包含有一些常规的字符串处理功能等，提供Http等一系列功能，主要完成了对于基本功能的封装，从而能够更加方便地使用

#### 日志工具  
提供默认的日志对象，可以自定义默认的日志前缀名  
```dart
Logger logger = Log.getInstance(author="alien");
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
String dateStr = DatetimeUtil.convertDateToString(dateTime,"yyyy-mm-dd");
```
#### HTTP工具  
拼接对应的参数，形成请求路径  
```dart
// isAnonymous 将会决定前缀（在HttpConfiguration中配置）
String requestPath = HttpUtil.join("user","login",isAnonymous=false);
```
获得响应体内容  
```dart
String responseBody = await HttpUtil.getBodyString(response);
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
dynamic result = await IsolateUtil.builder(function).setParameter(1).setParameter(2).run();
```
#### 数字工具  
创建随机数字  
```dart
// 将会获得一个 0-100 的随机数字
int number = NumberUtil.createRandomNumber(ceil=100,floor=0);
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
String value = table.get("x","y");
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
Map<String,value>? row = table.getRow("x");
// 获得整列
Map<String,value>? column = table.getColumn("y");
```
#### Sliver工具  
删除List自带的上方Padding  
```dart
MediaQuery mediaQuery = SliverUtil.removeTop(listView,context);
```
#### 字符串工具  
生成一个UUID  
```dart
String uuid = StringUtil.getUUID();
```  
分割字符串同时保留连接符在数组中  
```dart
// 返回["www",".","google",".","com"]
List<String> list=StringUtil.splitAndJoin("www.google.com",".");
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
SystemUiUtil.showToast("this is an error message");
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
TimerUtil.periodExecuteTask(
  intervalSeconds = 1000,
  function = myFunction,
  count = 3,
  delaySeconds = 500
);
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
ThemeData themeData = ColorUtil.getThemeData(isDark=true);
```
获得适配当前主题的指定色  
```dart
Color color = ColorUitl.getAdaptColor(AdaptColorType.ThemeColor,reverse=false)
```
#### 总线工具  
发送一个总线事件  
```dart
EventBusUtil.send(busEvent);
```
监听总线事件  
```dart
EventBusUtil.listen(
  BusEventType.Default
  onData=onDataFunction,
  onError=onErrorFunction,
  onDone=onDoneFuntion,
  cancelOnError=false
);
```
 




