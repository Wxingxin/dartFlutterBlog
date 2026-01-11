这一节我们**只讲一件事：副作用（Side Effects）怎么用 `ref.listen` 正确做**。
你把这节吃透，Riverpod 的“坑位”基本避开 80%。

---

# 副作用管理（listen）—— 必学

## 一、什么是「副作用」？

**副作用 = 不属于 UI 渲染的行为**

常见副作用包括：

* ❗️弹 Toast / SnackBar
* ❗️页面跳转 `Navigator.push`
* ❗️弹 Dialog
* ❗️调用一次性 API（打点、日志）
* ❗️播放动画 / 声音

👉 这些 **都不应该写在 `build()` 里**

---

## 二、为什么不能在 build 里做副作用？

### ❌ 错误示例（新手最常犯）

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(loginProvider);

  if (state.isSuccess) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('登录成功')),
    );
  }

  return ...
}
```

### 会发生什么？

* `build()` 会被 **多次调用**
* SnackBar 会 **反复弹**
* 页面重建就触发副作用 → **Bug**

---

## 三、正确做法：`ref.listen`

> **listen = 监听状态变化，执行一次性副作用**

---

## 四、最小可运行案例：成功后弹 Toast

### 场景

* 有一个操作（模拟请求）
* 成功后 → 弹 SnackBar
* UI 本身不因为弹 SnackBar 重建

---

### 1️⃣ 定义状态 Provider（用 StateProvider 演示）

```dart
final submitProvider = StateProvider<AsyncValue<void>>(
  (ref) => const AsyncData(null),
);
```

---

### 2️⃣ 模拟提交方法（成功 / 失败）

```dart
Future<void> submit(WidgetRef ref) async {
  ref.read(submitProvider.notifier).state = const AsyncLoading();

  await Future.delayed(const Duration(seconds: 1));

  final ok = DateTime.now().second % 2 == 0;

  if (ok) {
    ref.read(submitProvider.notifier).state =
        const AsyncData(null);
  } else {
    ref.read(submitProvider.notifier).state =
        AsyncError('提交失败', StackTrace.current);
  }
}
```

---

### 3️⃣ 页面中使用 `ref.listen`（重点）

```dart
class SubmitPage extends ConsumerWidget {
  const SubmitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(submitProvider);

    /// ⭐ 正确：监听状态变化，执行副作用
    ref.listen<AsyncValue<void>>(submitProvider, (prev, next) {
      // 从 loading → data，视为成功
      if (prev is AsyncLoading && next is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('提交成功 🎉')),
        );
      }

      // 从 loading → error，视为失败
      if (prev is AsyncLoading && next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error.toString())),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('ref.listen 示例')),
      body: Center(
        child: state.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => submit(ref),
                child: const Text('提交'),
              ),
      ),
    );
  }
}
```

---

### 4️⃣ main 函数

```dart
void main() {
  runApp(const ProviderScope(child: MaterialApp(home: SubmitPage())));
}
```

---

## 五、listen 的核心规则（一定要记）

### ✅ 什么时候用 `listen`

* Toast / SnackBar
* 页面跳转
* Dialog
* 一次性提示

### ❌ 不要用 `listen` 的情况

* 渲染 UI
* 展示列表 / 文本
* 控制 widget 样式

---

## 六、listen vs watch（一句话分清）

| 用途    | 用哪个      |
| ----- | -------- |
| UI 显示 | `watch`  |
| 副作用   | `listen` |
| 事件触发  | `read`   |

---

## 七、常见坑（你一定会踩）

❌ 在 `listen` 里改 state → 死循环
❌ 用 `watch` 弹 Toast
❌ 在 `build` 里 `Navigator.push`
❌ 忘记判断 `prev → next` 的变化

---

## 八、进阶写法（项目中常用）

### 只在“第一次成功”时触发

```dart
ref.listen(provider, (prev, next) {
  if (prev != next && next.isSuccess) {
    ...
  }
});
```

### 监听 AsyncValue 的语义

```dart
next.whenOrNull(
  data: (_) => showSuccess(),
  error: (e, _) => showError(e),
);
```

---

## 九、这一节你应该达到的水平

你现在应该能 **下意识做到**：

* ❗️Toast / 跳转 → 用 `ref.listen`
* ❗️UI 展示 → 用 `ref.watch`
* ❗️事件 → 用 `ref.read`

---

## 下一步（强烈推荐）

👉 **把 listen 用进真实页面**

比如：

* 登录成功 → 跳首页
* 表单提交成功 → 关闭页面
* Todo 新增成功 → Toast 提示

如果你愿意，我可以**用你刚才的 Todo / FutureProvider 案例，现场加上 `ref.listen` 的真实用法**，让你看到它在项目里到底长什么样。
