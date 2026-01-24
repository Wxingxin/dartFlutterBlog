下面给你一份**系统级、可直接作为参考手册的 `AppBar` 属性与配置大全**。
结构上我会按 **「必会 / 高频 / 进阶 / 易踩坑」** 四个层级来讲，完全覆盖你在首页、列表页、详情页、后台类 App 中的使用场景。

---

# 一、AppBar 一句话定位

> **AppBar 是 Material 风格页面的顶部导航栏组件**
> 只能作为 `Scaffold.appBar` 使用，负责页面标题、导航、操作入口。

```dart
Scaffold(
  appBar: AppBar(),
)
```

---

# 二、AppBar 构造函数总览

```dart
const AppBar({
  Key? key, 
  // Widget 的唯一标识，一般不手动传

  Widget? leading, 
  // 左侧组件，通常是返回按钮、菜单按钮
  // 例如：Icon(Icons.arrow_back)

  bool automaticallyImplyLeading = true, 
  // 是否自动推断 leading
  // true：当有 Navigator.canPop 时自动显示返回按钮
  // false：完全不自动显示

  Widget? title, 
  // 中间标题区域
  // 一般是 Text("标题")，也可以是任意 Widget

  List<Widget>? actions, 
  // 右侧操作区按钮
  // 常见：搜索、更多按钮等

  Widget? flexibleSpace, 
  // AppBar 背后的可伸缩空间
  // 常用于渐变背景、图片背景（配合 SliverAppBar 很常见）

  PreferredSizeWidget? bottom, 
  // AppBar 底部区域
  // 常用于 TabBar

  double? elevation, 
  // 阴影高度（z 轴）
  // 0 = 扁平，无阴影

  double? scrolledUnderElevation, 
  // 滚动到 AppBar 下方时的阴影高度（Material 3 新增）

  Color? backgroundColor, 
  // AppBar 背景颜色

  Color? foregroundColor, 
  // 前景颜色（影响 title、icon 的默认颜色）

  Color? shadowColor, 
  // 阴影颜色

  Color? surfaceTintColor, 
  // Material 3 表面色调（用于滚动/层级效果）

  ShapeBorder? shape, 
  // AppBar 的形状
  // 如 RoundedRectangleBorder 可做圆角底部

  IconThemeData? iconTheme, 
  // leading 区域 icon 的主题样式

  IconThemeData? actionsIconTheme, 
  // actions 区域 icon 的主题样式

  TextTheme? toolbarTextTheme, 
  // 工具栏文本主题（旧用法，已不太推荐）

  TextTheme? titleTextTheme, 
  // title 的文本主题（比直接 TextStyle 更偏全局）

  double? titleSpacing, 
  // title 与 leading / actions 的水平间距

  double? toolbarHeight, 
  // AppBar 高度（默认 kToolbarHeight = 56）

  double? leadingWidth, 
  // leading 区域宽度

  bool primary = true, 
  // 是否占据系统状态栏高度
  // 通常 Scaffold 的 AppBar 用 true

  bool? centerTitle, 
  // 标题是否居中
  // Android 默认 false，iOS 默认 true

  bool excludeHeaderSemantics = false, 
  // 是否从语义树中排除（无障碍相关）

  double? titleTextStyle, 
  // ⚠️ 旧版字段，已废弃，不推荐使用

  SystemUiOverlayStyle? systemOverlayStyle, 
  // 状态栏样式
  // 控制状态栏文字颜色（亮/暗）
});

```

（部分参数随 Flutter 版本略有差异，但核心一致）

---

# 三、核心必会属性（每天都在用）

## 1️⃣ title（标题）

```dart
title: Text('首页'),
```

* 通常是 `Text`
* 可以是任意 Widget（Row / Column）

```dart
title: Row(
  children: [
    Icon(Icons.home),
    SizedBox(width: 8),
    Text('首页'),
  ],
)
```

---

## 2️⃣ leading（左侧区域）

```dart
leading: IconButton(
  icon: Icon(Icons.menu),
  onPressed: () {},
),
```

* 左上角区域
* 常见：

  * 返回按钮
  * 菜单按钮
  * 自定义 Icon

---

## 3️⃣ automaticallyImplyLeading（自动返回）

```dart
automaticallyImplyLeading: true,
```

| 值     | 行为       |
| ----- | -------- |
| true  | 自动显示返回按钮 |
| false | 不自动显示    |

**常见场景：**

* 首页通常设为 `false`

---

## 4️⃣ actions（右侧操作区）

```dart
actions: [
  IconButton(icon: Icon(Icons.search), onPressed: () {}),
  IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
],
```

* 右侧按钮区域
* 多用于：

  * 搜索
  * 更多
  * 设置

---

# 四、高频外观配置（UI 必调）

## 5️⃣ backgroundColor（背景色）

```dart
backgroundColor: Colors.white,
```

* 默认取自 Theme
* 与沉浸式页面高度相关

---

## 6️⃣ foregroundColor（前景色）

```dart
foregroundColor: Colors.black,
```

* 影响：

  * title
  * leading icon
  * actions icon

---

## 7️⃣ elevation（阴影）

```dart
elevation: 4,
```

| 值  | 效果  |
| -- | --- |
| 0  | 扁平化 |
| >0 | 阴影  |

---

## 8️⃣ centerTitle（标题居中）

```dart
centerTitle: true,
```

| 平台      | 默认    |
| ------- | ----- |
| Android | false |
| iOS     | true  |

---

## 9️⃣ titleSpacing（标题间距）

```dart
titleSpacing: 0,
```

* 标题距离左侧的距离
* 自定义布局常用

---

# 五、进阶布局（中大型项目）

## 🔟 flexibleSpace（背景/渐变/沉浸式）

```dart
flexibleSpace: Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.blue, Colors.purple],
    ),
  ),
),
```

* 在 AppBar 后面
* 常用于：

  * 渐变背景
  * Banner

---

## 11️⃣ bottom（TabBar / 自定义底部）

```dart
bottom: TabBar(
  tabs: [
    Tab(text: '推荐'),
    Tab(text: '关注'),
  ],
),
```

* 必须是 `PreferredSizeWidget`
* 常见：

  * TabBar
  * 搜索框

---

## 12️⃣ toolbarHeight（高度）

```dart
toolbarHeight: 80,
```

* 默认：`kToolbarHeight (56)`
* 用于大标题 / 双行标题

---

## 13️⃣ leadingWidth（左侧宽度）

```dart
leadingWidth: 56,
```

* 调整左侧区域占位

---

# 六、主题 & 样式控制（项目级）

## 14️⃣ iconTheme / actionsIconTheme

```dart
iconTheme: IconThemeData(color: Colors.black),
actionsIconTheme: IconThemeData(color: Colors.red),
```

---

## 15️⃣ titleTextTheme / toolbarTextTheme

```dart
titleTextTheme: TextTheme(
  titleLarge: TextStyle(fontSize: 18),
),
```

---

## 16️⃣ shape（形状）

```dart
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.vertical(
    bottom: Radius.circular(16),
  ),
),
```

---

# 七、系统相关（容易忽略但很重要）

## 17️⃣ systemOverlayStyle（状态栏）

```dart
systemOverlayStyle: SystemUiOverlayStyle.dark,
```

* 控制：

  * 状态栏字体颜色
  * 状态栏背景

---

## 18️⃣ primary（是否占状态栏）

```dart
primary: true,
```

* 通常不改
* 与 `SafeArea` 相关

---

## 19️⃣ scrolledUnderElevation（滚动阴影）

```dart
scrolledUnderElevation: 8,
```

* 滚动时出现阴影（Material 3）

---

## 20️⃣ surfaceTintColor（M3）

```dart
surfaceTintColor: Colors.transparent,
```

* 防止滚动时变色（Material 3 必会）

---

# 八、完整实战配置示例（推荐）

```dart
AppBar(
  title: Text('首页'),
  centerTitle: true,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
  elevation: 0,
  automaticallyImplyLeading: false,
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
  bottom: TabBar(
    tabs: [
      Tab(text: '推荐'),
      Tab(text: '关注'),
    ],
  ),
)
```

---

# 九、常见坑总结（非常重要）

### ❌ AppBar 不能单独使用

必须放在 `Scaffold.appBar`

---

### ❌ 沉浸式页面忘了处理状态栏

搭配：

```dart
extendBodyBehindAppBar: true
```

---

### ❌ Material 3 滚动变色

必须设置：

```dart
surfaceTintColor: Colors.transparent
```

---

# 十、一句话总结（记忆版）

> **AppBar = Scaffold 的顶部导航插槽**
> **title / leading / actions 决定结构**
> **background / elevation / flexibleSpace 决定视觉**

---

如果你愿意，下一步我可以帮你：

* 做一张 **AppBar 属性选择决策表**
* 讲 **AppBar + TabBar 的完整联动**
* 教你 **沉浸式首页 AppBar 实战**
* 对比 **AppBar vs CupertinoNavigationBar**

你可以直接告诉我：
👉「我现在在做哪一类页面（首页 / 列表 / 详情 / 后台）」
