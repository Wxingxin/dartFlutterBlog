下面给你一个**标准、完整、可直接运行的 `FutureProvider` 异步入门案例**，严格围绕你列的学习目标来，不掺杂多余概念。

> 你学会这一节，就等于**掌握 Riverpod 里 80% 的异步页面写法**。

---

# FutureProvider —— 异步入门（必学）

## 一、这一节你到底在学什么？

### 学什么

* `FutureProvider`
* `AsyncValue<T>`
* `when(loading / error / data)`

### 解决什么问题

👉 **页面首次进入**

* 显示 loading
* 请求成功 → 显示数据
* 请求失败 → 显示错误 + 重试

> 这是 **列表页 / 详情页 / 首页 / 搜索页** 的通用模式

---

## 二、核心心智模型（先记住）

> **FutureProvider = 一个自带状态机的异步请求**

```txt
loading  →  data
    ↘
     error
```

Riverpod 已经帮你做了：

* loading 状态管理
* error 捕获
* 生命周期管理（页面销毁自动取消）

你只管 **声明请求**，**展示状态**

---

## 三、完整案例：模拟网络请求（推荐你直接跑）

### 1️⃣ 声明一个 FutureProvider（模拟接口）

```dart
final userListProvider = FutureProvider<List<String>>((ref) async {
  // 模拟网络延迟
  await Future.delayed(const Duration(seconds: 2));

  // 模拟失败（30% 概率）
  if (DateTime.now().second % 3 == 0) {
    throw Exception('网络错误，请稍后重试');
  }

  // 模拟成功返回数据
  return ['Tom', 'Jack', 'Lucy', 'Lily'];
});
```

👉 关键点：

* **不要 try-catch**（Riverpod 会自动捕获异常）
* 直接 `throw` 即可 → 进入 error 状态

---

### 2️⃣ 页面中使用：ref.watch + AsyncValue

```dart
class UserPage extends ConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(userListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('FutureProvider 示例')),
      body: Center(
        child: usersAsync.when(
          /// 1. 加载中
          loading: () => const CircularProgressIndicator(),

          /// 2. 出错
          error: (error, stack) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  /// 重新触发 FutureProvider
                  ref.refresh(userListProvider);
                },
                child: const Text('重试'),
              ),
            ],
          ),

          /// 3. 成功
          data: (users) => ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(users[index]),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

---

### 3️⃣ main.dart（确保能跑）

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserPage(),
    );
  }
}
```

---

## 四、你必须掌握的 4 个关键点（非常重要）

### ① AsyncValue ≠ Future

* `Future` 是一次性
* `AsyncValue` 是 **状态 + 数据**

```dart
AsyncValue<List<String>>
```

---

### ② when 是最推荐的写法

❌ 不推荐：

```dart
if (usersAsync.isLoading) ...
```

✅ 推荐：

```dart
usersAsync.when(
  loading: () => ...
  error: (e, _) => ...
  data: (d) => ...
)
```

👉 **可读性 + 强制处理所有状态**

---

### ③ refresh = 重新请求

```dart
ref.refresh(userListProvider);
```

等价于：

* 清空旧状态
* 重新执行 Future

---

### ④ UI 不要 try-catch

❌ 错误做法：

```dart
try {
  await fetch();
} catch ...
```

✅ 正确做法：

```dart
throw Exception('error');
```

👉 交给 Riverpod

---

## 五、常见错误（新手必踩）

❌ 在 UI 里写 `FutureBuilder`
❌ 在 provider 里 catch 了又 return 空数据
❌ 在 build 里调用 `ref.read(...).then(...)`
❌ 把 loading/error 写成 if else 到处飞

---

## 六、这一节你应该练到什么程度？

你可以自己写出下面这些：

* ✅ 一个页面，进入显示 loading
* ✅ 请求失败，显示错误 + 重试按钮
* ✅ 点击重试，重新 loading
* ✅ 不用 `setState`
* ✅ 不用 `FutureBuilder`

---

## 七、下一步该学什么？（非常自然）

你现在已经会：

> **“一次性的异步请求页面”**

下一步升级到：

👉 **`AsyncNotifierProvider`**

* 支持 **刷新 / 分页 / 提交 / 状态保持**
* 真正用于「项目级页面」

如果你愿意，我可以**把这个例子升级成 `AsyncNotifier` 版本**，并解释：

* 为什么 FutureProvider 不适合复杂页面
* 项目中什么时候用 FutureProvider，什么时候不用
