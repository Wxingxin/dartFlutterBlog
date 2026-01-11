下面这一步你做完，就真的从“会写 setState”进入“能写页面逻辑”了。
我给你一个**完整可跑**的练习：**三态页面（loading / success / error）+ 列表 + 重试**，同时让你体会“状态 → 模型”。

---

## 1）核心思想：用 `enum` 表示页面状态

我们先定义三态：

```dart
enum PageStatus { loading, success, error }
```

然后页面永远只看这个状态来决定显示什么：

* `loading` → 圈圈
* `success` → 列表
* `error` → 错误提示 + 重试

---

## 2）完整练习代码（直接放进 main.dart 跑）

> 这个例子“模拟请求”用 `Future.delayed`，并且故意随机失败，方便你练错误处理和重试。

```dart
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ListFetchDemoPage(),
    );
  }
}

/// ✅ 页面状态：用 enum 统一表达
enum PageStatus { loading, success, error }

/// ✅ 模型：列表里的每一项不再是 String，而是对象
class TodoItem {
  final String id;
  final String title;

  const TodoItem({required this.id, required this.title});
}

class ListFetchDemoPage extends StatefulWidget {
  const ListFetchDemoPage({super.key});

  @override
  State<ListFetchDemoPage> createState() => _ListFetchDemoPageState();
}

class _ListFetchDemoPageState extends State<ListFetchDemoPage> {
  PageStatus status = PageStatus.loading; // ✅ enum 状态
  List<TodoItem> items = []; // ✅ 列表状态（对象列表）
  String? errorMessage; // ✅ error 状态的附加信息

  final _rng = Random();

  @override
  void initState() {
    super.initState();
    _fetchList();
  }

  Future<void> _fetchList() async {
    setState(() {
      status = PageStatus.loading;
      errorMessage = null;
    });

    // 模拟请求耗时
    await Future.delayed(const Duration(seconds: 2));

    // ⚠️ 异步回来，先判断 mounted
    if (!mounted) return;

    // 模拟“有概率失败”
    final shouldFail = _rng.nextBool(); // 50% 概率失败
    if (shouldFail) {
      setState(() {
        status = PageStatus.error;
        errorMessage = '网络开小差了（模拟失败），请点击重试。';
      });
      return;
    }

    // 模拟成功数据（对象列表）
    final data = List.generate(
      15,
      (i) => TodoItem(id: 'id_$i', title: 'Todo #${i + 1}'),
    );

    setState(() {
      status = PageStatus.success;
      items = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('三态列表：loading / success / error'),
        actions: [
          IconButton(
            tooltip: '刷新',
            onPressed: _fetchList,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    switch (status) {
      case PageStatus.loading:
        return const _LoadingView(key: ValueKey('loading'));

      case PageStatus.error:
        return _ErrorView(
          key: const ValueKey('error'),
          message: errorMessage ?? '发生错误',
          onRetry: _fetchList,
        );

      case PageStatus.success:
        return _SuccessListView(
          key: const ValueKey('success'),
          items: items,
          onTapItem: (item) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('你点了：${item.title}')),
            );
          },
        );
    }
  }
}

/// ---------- 下面是三个“状态视图”，分别独立成组件（推荐做法） ----------

class _LoadingView extends StatelessWidget {
  const _LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('重试'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessListView extends StatelessWidget {
  final List<TodoItem> items;
  final ValueChanged<TodoItem> onTapItem;

  const _SuccessListView({
    super.key,
    required this.items,
    required this.onTapItem,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item.title),
          onTap: () => onTapItem(item),
        );
      },
    );
  }
}
```

---

## 3）你要“看懂”的关键点（这才是状态管理升级）

### ✅ 1. 状态从 int → 枚举

以前：`bool loading`
现在：`PageStatus status`（更清晰、更不容易写错）

### ✅ 2. 数据从 String → 模型对象

以前：`List<String>`
现在：`List<TodoItem>`（以后接 API 更自然）

### ✅ 3. UI 不再“到处 if else”

而是：

```dart
switch (status) { ... }
```

UI 结构清晰，维护成本低。

---

## 4）你做完这个练习后，下一步怎么更像“真实项目”？

我给你 3 个升级任务，你选一个，我可以继续带你写：

1. **把失败概率改成“第一次失败，第二次成功”**（方便稳定测试）
2. **加下拉刷新**：`RefreshIndicator` 包住 success 列表
3. **加空列表状态**：`success` 但 items 为空 → 显示“暂无数据”

你想先做哪个（回复 1/2/3 就行）？
