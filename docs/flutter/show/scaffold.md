下面给你一份**系统级、可直接作为文档使用的 `Scaffold` 属性与配置大全**。
我会按 **「必会 / 高频 / 进阶 / 易忽略」** 四个层级来讲，符合你现在做首页和中大型项目的实际需求。

---

# 一、Scaffold 是什么（一句话定位）

> **Scaffold 是 Material Design 页面结构的“总容器”**
> 负责页面分区、层级、浮动组件、系统 UI 协调。

典型结构：

```dart
Scaffold(
  appBar: AppBar(),
  body: ...,
  floatingActionButton: ...,
  bottomNavigationBar: ...,
)
```

---

# 二、Scaffold 构造函数（总览）

```dart
const Scaffold({
  Key? key,
  PreferredSizeWidget? appBar,
  Widget? body,
  Widget? floatingActionButton,
  FloatingActionButtonLocation? floatingActionButtonLocation,
  FloatingActionButtonAnimator? floatingActionButtonAnimator,
  List<Widget>? persistentFooterButtons,
  Widget? drawer,
  Widget? endDrawer,
  Widget? bottomNavigationBar,
  Widget? bottomSheet,
  Color? backgroundColor,
  bool? resizeToAvoidBottomInset,
  bool primary = true,
  DragStartBehavior drawerDragStartBehavior,
  bool extendBody = false,
  bool extendBodyBehindAppBar = false,
  Color? drawerScrimColor,
  double? drawerEdgeDragWidth,
  bool drawerEnableOpenDragGesture = true,
  bool endDrawerEnableOpenDragGesture = true,
  String? restorationId,
})
```

---

# 三、核心必会属性（90% 页面都会用）

## 1️⃣ appBar（顶部导航栏）

```dart
appBar: AppBar(
  title: Text('首页'),
)
```

* 类型：`PreferredSizeWidget`
* 通常使用：`AppBar`
* 作用：

  * 页面标题
  * 返回按钮
  * 菜单 / 操作按钮
  * TabBar

---

## 2️⃣ body（页面主体）

```dart
body: Center(
  child: Text('Hello'),
)
```

* 页面主要内容区域
* **不会自动滚动**
* 常见搭配：

  * `ListView`
  * `SingleChildScrollView`
  * `Column + Expanded`

---

## 3️⃣ backgroundColor（背景色）

```dart
backgroundColor: Colors.grey[100],
```

* 默认来自 `ThemeData.scaffoldBackgroundColor`
* 常用于：

  * 页面分层
  * 深色模式定制

---

# 四、高频功能区（项目中非常常见）

## 4️⃣ drawer（左侧抽屉）

```dart
drawer: Drawer(
  child: ListView(
    children: [
      DrawerHeader(child: Text('菜单')),
      ListTile(title: Text('首页')),
    ],
  ),
)
```

* 左侧滑出
* 自动带手势 & 遮罩
* 与 AppBar 左侧菜单按钮联动

---

## 5️⃣ endDrawer（右侧抽屉）

```dart
endDrawer: Drawer(
  child: Text('右侧菜单'),
)
```

* 右侧滑出
* RTL 语言场景 / 右侧筛选

---

## 6️⃣ bottomNavigationBar（底部导航）

```dart
bottomNavigationBar: BottomNavigationBar(
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ],
),
```

* 常用于：

  * 主导航
  * Tab 页面
* 与 `IndexedStack` 联用最佳

---

## 7️⃣ floatingActionButton（悬浮按钮）

```dart
floatingActionButton: FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
),
```

* 高优先级操作
* 自动悬浮在内容之上

### 位置配置

```dart
floatingActionButtonLocation:
    FloatingActionButtonLocation.endFloat,
```

---

# 五、进阶属性（中大型项目必用）

## 8️⃣ resizeToAvoidBottomInset（键盘顶起）

```dart
resizeToAvoidBottomInset: true,
```

| 值     | 效果             |
| ----- | -------------- |
| true  | 键盘弹出时 body 上移  |
| false | body 不动（聊天页常用） |

---

## 9️⃣ extendBody（内容延伸到底部）

```dart
extendBody: true,
```

* body 延伸到底部导航栏后面
* 适合：

  * 半透明 BottomNavigationBar
  * 沉浸式设计

---

## 🔟 extendBodyBehindAppBar（沉浸式）

```dart
extendBodyBehindAppBar: true,
```

* body 延伸到 AppBar 后面
* 常见场景：

  * 轮播图
  * 沉浸式首页

⚠️ 必须自己处理 `SafeArea / padding`

---

## 11️⃣ bottomSheet（底部固定面板）

```dart
bottomSheet: Container(
  height: 80,
  color: Colors.white,
)
```

* 永久显示
* ⚠️ 和 `showModalBottomSheet` 不同

---

## 12️⃣ persistentFooterButtons（底部按钮组）

```dart
persistentFooterButtons: [
  TextButton(onPressed: () {}, child: Text('取消')),
  ElevatedButton(onPressed: () {}, child: Text('确定')),
],
```

* 常用于表单页
* 始终固定在底部

---

# 六、抽屉 & 交互控制（易被忽略）

## 13️⃣ drawerScrimColor（遮罩色）

```dart
drawerScrimColor: Colors.black54,
```

---

## 14️⃣ drawerEdgeDragWidth（拖拽宽度）

```dart
drawerEdgeDragWidth: 40,
```

* 手指从屏幕边缘 40px 内滑动触发

---

## 15️⃣ drawerEnableOpenDragGesture

```dart
drawerEnableOpenDragGesture: false,
```

* 禁止手势打开抽屉

---

# 七、状态 & 恢复（高级）

## 16️⃣ primary

```dart
primary: true,
```

* 是否占用状态栏高度
* 通常不用改

---

## 17️⃣ restorationId（状态恢复）

```dart
restorationId: 'home_scaffold',
```

* App 被系统杀死后恢复状态
* 高级场景（大 App）

---

# 八、Scaffold + ScaffoldMessenger（必会）

### 显示 SnackBar

```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text('操作成功')),
);
```

⚠️ **不要再用 `Scaffold.of(context)`**

---

# 九、完整实战级配置示例（推荐收藏）

```dart
Scaffold(
  backgroundColor: Colors.grey[100],
  appBar: AppBar(
    title: Text('首页'),
  ),
  drawer: Drawer(),
  body: ListView(
    children: [
      Container(height: 200, color: Colors.blue),
    ],
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: Icon(Icons.add),
  ),
  bottomNavigationBar: BottomNavigationBar(
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
    ],
  ),
  resizeToAvoidBottomInset: true,
)
```

---

# 十、面试 / 记忆版总结

> **Scaffold = 页面结构管理器**
> **AppBar / Drawer / FAB / BottomNav 都是它的“插槽”**
> **页面行为（键盘 / 抽屉 / 底部）由它统一协调**

---

如果你愿意，我可以下一步帮你做：

* **Scaffold 属性选择决策表（什么时候该用哪个）**
* **首页沉浸式设计完整实战**
* **Scaffold vs CupertinoPageScaffold 对照表**
* **真实项目中 Scaffold 的封装方案**

你可以直接告诉我你现在在做 **首页 / 表单 / 聊天 / 管理后台** 哪一类页面。
