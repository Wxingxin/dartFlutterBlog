下面给你一份**📘 Flutter 的 `AppBar` 与 `CupertinoNavigationBar` 知识点与使用大全（对比 + 实战）**。我会从**设计理念 → 常用 API → 高级用法 → 导航交互 → 常见坑 → 选型建议**完整讲清楚，学完你就知道**什么时候该用哪个、怎么用不翻车**。

> 两者都属于 **Flutter** 的**页面顶部导航栏组件**，但**设计哲学完全不同**。

---

# 一、核心定位（先建立正确认知）

| 组件                       | 设计规范                | 平台风格         |
| ------------------------ | ------------------- | ------------ |
| `AppBar`                 | Material Design     | Android / 通用 |
| `CupertinoNavigationBar` | iOS Human Interface | iOS          |

一句话记忆：

> **AppBar = 功能丰富、可定制、偏 Android**
> **CupertinoNavigationBar = 简洁、克制、偏 iOS 原生**

---

# 二、AppBar（Material 顶部栏）

## 1️⃣ AppBar 是什么

`AppBar` 是 **Material 页面顶部导航栏**，通常放在 `Scaffold.appBar` 中，负责：

* 页面标题
* 返回按钮
* 操作按钮
* TabBar
* 搜索 / 菜单

---

## 2️⃣ AppBar 基本结构（必背）

```dart
Scaffold(
  appBar: AppBar(
    title: Text('标题'),
  ),
  body: ...
);
```

---

## 3️⃣ AppBar 常用属性大全（🔥 重点）

```dart
AppBar(
  title: Text('标题'),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
  ),
  actions: [
    IconButton(
      icon: Icon(Icons.search),
      onPressed: () {},
    ),
  ],
  centerTitle: true,
  elevation: 4,
  backgroundColor: Colors.blue,
)
```

| 属性                | 作用            |
| ----------------- | ------------- |
| `title`           | 标题            |
| `leading`         | 左侧按钮（返回 / 菜单） |
| `actions`         | 右侧操作区         |
| `centerTitle`     | 标题是否居中        |
| `elevation`       | 阴影            |
| `backgroundColor` | 背景色           |

---

## 4️⃣ AppBar + TabBar（高频）

```dart
DefaultTabController(
  length: 2,
  child: Scaffold(
    appBar: AppBar(
      title: Text('标题'),
      bottom: TabBar(
        tabs: [
          Tab(text: 'Tab1'),
          Tab(text: 'Tab2'),
        ],
      ),
    ),
    body: TabBarView(
      children: [
        Center(child: Text('1')),
        Center(child: Text('2')),
      ],
    ),
  ),
);
```

👉 **AppBar 原生支持 TabBar**

---

## 5️⃣ AppBar 的典型使用场景

✅ Android / 通用页面
✅ 多操作按钮
✅ Tab 页面
✅ 搜索 / 菜单页
✅ 功能型页面

---

# 三、CupertinoNavigationBar（iOS 顶部栏）

## 1️⃣ CupertinoNavigationBar 是什么

`CupertinoNavigationBar` 是 **iOS 风格导航栏**，通常放在 `CupertinoPageScaffold.navigationBar` 中。

强调：

* 简洁
* 原生 iOS 交互
* 标题居中
* 返回按钮自动处理

---

## 2️⃣ CupertinoNavigationBar 基本结构

```dart
CupertinoPageScaffold(
  navigationBar: CupertinoNavigationBar(
    middle: Text('标题'),
  ),
  child: ...
);
```

⚠️ 注意：

* 没有 `title`
* 用 `middle`
* 页面主体是 `child`

---

## 3️⃣ CupertinoNavigationBar 常用属性大全

```dart
CupertinoNavigationBar(
  leading: CupertinoButton(
    padding: EdgeInsets.zero,
    child: Icon(CupertinoIcons.back),
    onPressed: () => Navigator.pop(context),
  ),
  middle: Text('标题'),
  trailing: CupertinoButton(
    padding: EdgeInsets.zero,
    child: Icon(CupertinoIcons.add),
    onPressed: () {},
  ),
  backgroundColor: CupertinoColors.systemGrey6,
  border: Border(bottom: BorderSide(color: CupertinoColors.separator)),
)
```

| 属性                | 作用    |
| ----------------- | ----- |
| `leading`         | 左侧内容  |
| `middle`          | 中间标题  |
| `trailing`        | 右侧按钮  |
| `backgroundColor` | 背景色   |
| `border`          | 底部分割线 |

---

## 4️⃣ 自动返回按钮（🔥 iOS 特性）

```dart
Navigator.push(
  context,
  CupertinoPageRoute(builder: (_) => Page()),
);
```

👉 上一页标题会**自动变成返回按钮文字**
👉 支持 **右滑返回**

---

## 5️⃣ CupertinoNavigationBar 的典型使用场景

✅ iOS 原生风格页面
✅ 设置页
✅ 表单页
✅ 简单操作页面

---

# 四、AppBar vs CupertinoNavigationBar（核心对比）

| 对比点    | AppBar    | CupertinoNavigationBar |
| ------ | --------- | ---------------------- |
| 标题属性   | `title`   | `middle`               |
| 左侧     | `leading` | `leading`              |
| 右侧     | `actions` | `trailing`             |
| Tab 支持 | ✅ 原生      | ❌                      |
| 阴影     | elevation | 无（分割线）                 |
| 返回按钮   | 自动 / 手动   | 自动（iOS 风格）             |
| 风格     | 功能型       | 简洁型                    |

---

# 五、导航动画 & 返回逻辑（必懂）

## AppBar（Material）

```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => Page()),
);
```

* Android 切页动画
* 无侧滑返回

---

## CupertinoNavigationBar（iOS）

```dart
Navigator.push(
  context,
  CupertinoPageRoute(builder: (_) => Page()),
);
```

* iOS 平滑动画
* 支持侧滑返回
* 返回按钮文字自动生成

---

# 六、SafeArea / 刘海屏处理（⚠️）

## AppBar

* 默认处理状态栏
* 不需要额外 SafeArea

---

## CupertinoNavigationBar

* **自动适配 iOS 刘海**
* 不要再额外包 SafeArea（会多留白）

---

# 七、混用是否可以？（结论）

### ❌ 不推荐

```dart
Scaffold(
  appBar: CupertinoNavigationBar(...),
);
```

👉 风格 + 行为不一致

---

### ✅ 推荐：平台自适应

```dart
Widget build(BuildContext context) {
  final isIOS = Theme.of(context).platform == TargetPlatform.iOS;

  return isIOS
      ? CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('标题')),
          child: body,
        )
      : Scaffold(
          appBar: AppBar(title: Text('标题')),
          body: body,
        );
}
```

---

# 八、常见坑总结（⚠️ 面试高频）

❌ 在 iOS 页面用 `AppBar`
❌ 在 `CupertinoNavigationBar` 里用 `actions`
❌ 忘记使用 `CupertinoPageRoute`
❌ SafeArea 重复包裹
❌ 标题过长导致溢出

---

# 九、选型速查表（直接背）

> ✅ 默认 / 跨平台 → **AppBar**
> ✅ Android 为主 → **AppBar**
> ✅ iOS 原生体验 → **CupertinoNavigationBar**
> ✅ Tab 页面 → **AppBar + TabBar**
> ❌ iOS 页面用 FAB

---

# 十、一句话终极总结

> **AppBar 是“功能型导航栏”，CupertinoNavigationBar 是“原生 iOS 导航栏”**

---

## 下一步我可以继续帮你👇

* ✅ **SliverAppBar 使用大全**
* ✅ **搜索型 AppBar 实战**
* ✅ **自定义 NavigationBar**
* ✅ **Material vs Cupertino 完整架构设计**

你直接说想学哪个，我继续给你系统讲 👍
