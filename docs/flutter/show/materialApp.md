```dart
const MaterialApp({
  Key? key, // widget 的唯一标识

  // ================== 应用基础信息 ==================
  GlobalKey<NavigatorState>? navigatorKey, // 全局 Navigator Key，用于全局路由控制
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey, // 全局 SnackBar / MaterialBanner 控制
  Widget? home, // 应用首页（与 routes / onGenerateRoute 二选一）
  Map<String, WidgetBuilder> routes = const <String, WidgetBuilder>{}, // 命名路由表
  String? initialRoute, // 初始路由
  RouteFactory? onGenerateRoute, // 动态生成路由（常用）
  RouteFactory? onUnknownRoute, // 未匹配到路由时回退处理
  List<NavigatorObserver> navigatorObservers = const <NavigatorObserver>[], // 路由监听器（埋点/日志/分析）

  // ================== Builder & 包裹层 ==================
  TransitionBuilder? builder, // 在 Navigator 之上包一层（如全局 Toast / Dialog）

  // ================== 应用标题 & 本地化 ==================
  String title = '', // 应用标题（Android 任务管理器显示）
  GenerateAppTitle? onGenerateTitle, // 动态生成标题（支持本地化）
  Color? color, // Android 系统中应用的主色调（Task Switcher）

  // ================== 主题 ==================
  ThemeData? theme, // 亮色主题
  ThemeData? darkTheme, // 暗色主题
  ThemeMode themeMode = ThemeMode.system, // 主题模式（系统/亮色/暗色）
  ThemeData? highContrastTheme, // 高对比度亮色主题
  ThemeData? highContrastDarkTheme, // 高对比度暗色主题

  // ================== 本地化 ==================
  Locale? locale, // 指定当前语言
  Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates, // 本地化代理
  LocaleListResolutionCallback? localeListResolutionCallback, // 多语言优先级解析
  LocaleResolutionCallback? localeResolutionCallback, // 单语言解析
  Iterable<Locale> supportedLocales = const <Locale>[Locale('en', 'US')], // 支持的语言列表

  // ================== 调试 & 性能 ==================
  bool debugShowMaterialGrid = false, // 显示 Material 布局网格（调试用）
  bool showPerformanceOverlay = false, // 显示性能层（GPU / UI）
  bool checkerboardRasterCacheImages = false, // 标记 RasterCache 图像（调试性能）
  bool checkerboardOffscreenLayers = false, // 标记离屏渲染层
  bool showSemanticsDebugger = false, // 显示语义树（无障碍调试）
  bool debugShowCheckedModeBanner = true, // 右上角 DEBUG 标识

  // ================== 快捷键 & 行为 ==================
  Map<ShortcutActivator, Intent>? shortcuts, // 快捷键映射
  Map<Type, Action<Intent>>? actions, // 快捷键对应行为

  // ================== 滚动行为 ==================
  ScrollBehavior? scrollBehavior, // 自定义滚动行为（如去除水波纹）

  // ================== 恢复状态 ==================
  String? restorationScopeId, // 状态恢复作用域 ID

  // ================== 路由回调（Router API） ==================
  RouteInformationProvider? routeInformationProvider, // 路由信息提供者
  RouteInformationParser<Object>? routeInformationParser, // 路由信息解析器
  RouterDelegate<Object>? routerDelegate, // 路由代理（Router API 核心）
  BackButtonDispatcher? backButtonDispatcher, // 返回键调度器

  // ================== 动画 ==================
  bool useInheritedMediaQuery = false, // 是否继承 MediaQuery（高级用法）
}) 
```
