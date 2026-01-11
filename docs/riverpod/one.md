我给你一份**完整可运行**的 Riverpod 计数器案例：包含 `ProviderScope`、`ConsumerWidget`、`ref.watch/read`、以及一个 `ref.listen` 的副作用示例（到 10 弹提示）。你把下面代码直接放进 `lib/main.dart` 就能跑。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 1) 声明一个最简单的可变状态：StateProvider
final counterProvider = StateProvider<int>((ref) => 0);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Counter',
      theme: ThemeData(useMaterial3: true),
      home: const CounterPage(),
    );
  }
}

/// 2) ConsumerWidget：能拿到 WidgetRef（ref）
class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// watch：订阅 counterProvider，值变化会触发 build 重建
    final count = ref.watch(counterProvider);

    /// listen：监听变化做副作用（不影响 UI rebuild）
    /// 注意：listen 放在 build 里也没问题，Riverpod 会自动管理并避免重复注册
    ref.listen<int>(counterProvider, (prev, next) {
      if (next == 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('计数到 10 了！')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod 计数器')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('当前计数：', style: TextStyle(fontSize: 18)),
            Text(
              '$count',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  /// read：只取一次，不订阅，适合按钮点击等事件
                  onPressed: () =>
                      ref.read(counterProvider.notifier).state--,
                  icon: const Icon(Icons.remove),
                  label: const Text('减 1'),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.read(counterProvider.notifier).state++,
                  icon: const Icon(Icons.add),
                  label: const Text('加 1'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => ref.read(counterProvider.notifier).state = 0,
              child: const Text('重置为 0'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterProvider.notifier).state++,
        child: const Icon(Icons.plus_one),
      ),
    );
  }
}
```

你跑起来后可以顺手验证 3 个点：

* `watch`：数字变化会刷新 UI
* `read`：按钮点击更新状态
* `listen`：到 10 会弹 SnackBar（副作用不靠 setState）

如果你想要我给你再来一版**“更项目化”的计数器**（用 `NotifierProvider/Notifier` 或 `StateNotifierProvider`，带日志/持久化/步进等），我也可以直接给你完整代码。
