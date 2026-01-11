这一节**非常关键**，也是很多人 Flutter 用着用着就“莫名其妙报错 / 内存泄漏 / setState 崩溃”的根源。
我用**一条清晰的主线 + 一个完整例子**，把你列的 3 点一次讲透。

---

## 一、先给你一条“总纲”（一定要记住）

> **Flutter 状态生命周期 = Widget 被创建 → 使用 → 销毁 的全过程**

在这个过程中，你**只能在对的时间做对的事**。

---

## 二、State 的生命周期（先有整体感觉）

![Image](https://mobikul.com/wp-content/uploads/2020/12/000129.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2AnfzJmPSDBA-aasw3gwTiAw.png)

简化后你现在**必须掌握的只有 3 个点**：

```text
initState  →  build  →  dispose
```

| 阶段          | 你该做什么          |
| ----------- | -------------- |
| `initState` | 初始化、发请求、监听     |
| `build`     | 读状态、画 UI（不写逻辑） |
| `dispose`   | 释放资源、防内存泄漏     |

---

## 三、`initState`：初始化 / 发请求（只能在这里）

### 规则（很重要）

* `initState` **只调用一次**
* 这里适合：

  * 初始化变量
  * 发网络请求
  * 初始化 Controller / Stream
* **不能 `async`，但可以调用 async 方法**

---

### ✅ 正确示例：初始化 + 模拟请求

```dart
class LifeCyclePage extends StatefulWidget {
  const LifeCyclePage({super.key});

  @override
  State<LifeCyclePage> createState() => _LifeCyclePageState();
}

class _LifeCyclePageState extends State<LifeCyclePage> {
  String text = '加载中...';

  @override
  void initState() {
    super.initState();

    // 在 initState 中启动异步任务
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));

    // ⚠️ 异步回来时，先判断 mounted
    if (!mounted) return;

    setState(() {
      text = '数据加载完成';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('生命周期')),
      body: Center(child: Text(text)),
    );
  }
}
```

---

### ❌ 新手常犯错误

```dart
@override
Widget build(BuildContext context) {
  _loadData(); // ❌ 每次 build 都会调用
  return ...
}
```

👉 **build 可能被调用很多次，initState 只会一次**

---

## 四、`dispose`：释放资源（非常重要）

### 什么时候一定要写 `dispose`？

> **你创建了“需要手动释放的东西”**

常见的有：

* `TextEditingController`
* `AnimationController`
* `StreamSubscription`
* `Timer`

---

### ✅ 正确示例：TextEditingController

```dart
class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose(); // ✅ 必须释放
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(controller: controller);
  }
}
```

---

### ❌ 不 dispose 的后果

* 内存泄漏
* 控制台警告
* 页面多进多出后 App 变卡

📌 **一句判断口诀**

> **new 了什么，就在 dispose 里干掉什么**

---

## 五、`setState` 不能乱用（异步 + mounted）

### 经典崩溃场景（你以后一定会遇到）

```text
进入页面
→ 发请求
→ 还没回来
→ 页面被 pop
→ 请求回来
→ setState
→ ❌ 崩溃
```

报错类似：

```text
setState() called after dispose()
```

---

### 为什么会这样？

* 页面已经销毁（`dispose` 已执行）
* 但异步任务还活着
* 它回来后还想改 UI

---

### ✅ 正确做法：判断 `mounted`

```dart
Future<void> fetchData() async {
  await Future.delayed(const Duration(seconds: 2));

  if (!mounted) return; // 👈 核心

  setState(() {
    text = '更新成功';
  });
}
```

---

### `mounted` 是什么？（人话）

```text
mounted == true  → 页面还活着
mounted == false → 页面已经死了
```

---

## 六、`setState` 的 3 条铁律（背下来）

### ❌ 不要在这些地方乱用

* `build` 里
* 页面已经 `dispose` 后
* 无意义的小改动频繁调用

---

### ✅ 正确用法

* 事件回调（点击、输入）
* 请求完成后（判断 mounted）
* 一次 setState 改完相关状态

---

## 七、一个“生命周期完整模板”（收藏级）

```dart
class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  late final TextEditingController controller;
  String data = 'loading';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      data = 'done';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(data);
  }
}
```

---

## 八、你现在要形成的“条件反射”

* 一写 `StatefulWidget`
  👉 **先想：我需要 initState 吗？需要 dispose 吗？**

* 一写异步
  👉 **setState 前先想：mounted 吗？**

* 一写 controller / stream
  👉 **马上想到 dispose**

---

## 下一步（非常自然的一步）

学完生命周期，**状态管理就该进入“异步状态”阶段了**：

* loading / success / error
* 请求失败重试
* 下拉刷新

如果你愿意，我可以下一步带你写一个：

👉 **「带 loading / error / retry 的列表页面」**

你只要回我一句：
**“继续学异步状态”** 或 **“我想先练生命周期”**
