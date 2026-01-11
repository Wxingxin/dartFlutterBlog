好，我给你一套**“按步骤 + 每一步都有可运行案例”**的 Riverpod 学习路线。
目标不是背 API，而是**每一步都解决一个真实问题**，最后你能自然写进项目。

---

# Riverpod 学习步骤（案例驱动版）

> **总原则**：
> **先 StateProvider → 再 StateNotifier/Notifier → 再 Async → 再 项目分层**
> 不要一上来就 AsyncNotifier，不然你只会“抄代码”。

---

## Step 0：建立心智模型（先想清楚这 5 句话）

在写代码前，你必须先理解：

1. **Provider 是状态的声明，不是状态本身**
2. **UI 永远不直接保存状态**
3. **ref 是唯一操作状态的入口**
4. **watch = 会重建 UI**
5. **read = 只在事件里用**

> 👉 如果你这 5 句话能背下来，后面 80% 的坑你都能避开

---

## Step 1：StateProvider —— 最小可变状态（入门必做）

### 学什么

* `ProviderScope`
* `StateProvider`
* `ref.watch / ref.read`

### 解决什么问题

👉 **“页面里有一个会变的值”**

### 案例：计数器

```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

```dart
final count = ref.watch(counterProvider);
ref.read(counterProvider.notifier).state++;
```

### 这一阶段你要掌握的能力

✅ 用 Riverpod 替代 `setState`
✅ 明确：**UI 不保存状态**

> ⚠️ 注意：
> StateProvider **只适合 demo / 极简单状态**
> 一旦是列表、对象、业务逻辑 → 马上升级

---

## Step 2：StateNotifierProvider —— 管理“一组业务状态”

### 学什么

* `StateNotifier`
* `StateNotifierProvider`
* 不可变数据（`copyWith`）

### 解决什么问题

👉 **“一组数据 + 多个操作方法”**

### 案例：Todo List（增 / 删 / 改）

```dart
class TodoNotifier extends StateNotifier<List<String>> {
  TodoNotifier() : super([]);

  void add(String text) {
    state = [...state, text];
  }

  void remove(int index) {
    state = [...state]..removeAt(index);
  }
}
```

```dart
final todoProvider =
  StateNotifierProvider<TodoNotifier, List<String>>(
    (ref) => TodoNotifier(),
  );
```

UI：

```dart
final todos = ref.watch(todoProvider);
ref.read(todoProvider.notifier).add("new todo");
```

### 这一阶段你要掌握

✅ **业务逻辑从 UI 中消失**
✅ UI 只调用方法，不关心怎么改
✅ 理解「不可变更新」

---

## Step 3：拆组件 + 回调（你之前明确要练的）

### 学什么

* ListItem 组件拆分
* 子组件不直接操作 provider
* 回调由父组件传入

### 案例：TodoItem

```dart
class TodoItem extends StatelessWidget {
  final String text;
  final VoidCallback onDelete;

  const TodoItem({required this.text, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
```

父组件：

```dart
TodoItem(
  text: todos[i],
  onDelete: () {
    ref.read(todoProvider.notifier).remove(i);
  },
);
```

### 你应该意识到

👉 **Riverpod 管的是“状态”，不是组件通信**
👉 组件通信依然用 Flutter 的回调模型

---

## Step 4：FutureProvider —— 异步入门（必学）

### 学什么

* `FutureProvider`
* `AsyncValue`
* `when / loading / error`

### 解决什么问题

👉 **“页面加载数据 + loading + error”**

### 案例：模拟网络请求

```dart
final userListProvider = FutureProvider<List<String>>((ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return ['Tom', 'Jack', 'Lucy'];
});
```

UI：

```dart
final users = ref.watch(userListProvider);

return users.when(
  loading: () => const CircularProgressIndicator(),
  error: (e, _) => Text('error: $e'),
  data: (list) => ListView(
    children: list.map(Text.new).toList(),
  ),
);
```

### 这一阶段你要掌握

✅ AsyncValue 是 **状态机**
✅ UI 不需要 if/else
✅ loading / error 是“第一等公民”

---

## Step 5：Notifier / AsyncNotifier（项目推荐路线）

> 如果你用的是 Riverpod 2.x，这是**官方推荐**

### 同步业务

```dart
class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
}
```

```dart
final counterProvider =
  NotifierProvider<CounterNotifier, int>(() => CounterNotifier());
```

### 异步业务

```dart
class UserNotifier extends AsyncNotifier<List<String>> {
  @override
  Future<List<String>> build() async {
    return fetchUsers();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(fetchUsers);
  }
}
```

### 你在这里要转变的思维

👉 provider ≈ ViewModel
👉 UI ≈ 只负责展示
👉 状态生命周期由 Riverpod 管

---

## Step 6：副作用管理（listen）

### 学什么

* `ref.listen`
* 不在 `build` 里做副作用

### 案例：成功后弹 Toast

```dart
ref.listen(counterProvider, (prev, next) {
  if (next == 10) {
    showSnackBar();
  }
});
```

### 原则

❌ 不在 build 里 `Navigator.push`
❌ 不在 build 里弹 Toast
✅ 用 listen

---

## Step 7：项目级结构（你做毕业设计必须到这）

```txt
lib/
 ├─ data/
 │   ├─ api/
 │   ├─ repository/
 ├─ state/
 │   ├─ user_notifier.dart
 ├─ ui/
 │   ├─ pages/
 │   ├─ widgets/
```

依赖注入：

```dart
final apiProvider = Provider<Api>((ref) => Api());
final repoProvider =
  Provider<UserRepo>((ref) => UserRepo(ref.watch(apiProvider)));
```

---

## 推荐你现在的**实战顺序（7 天）**

* Day 1：StateProvider（计数器）
* Day 2：StateNotifier（Todo）
* Day 3：ListItem 拆组件
* Day 4：FutureProvider（loading / error）
* Day 5：Notifier / AsyncNotifier
* Day 6：listen + 副作用
* Day 7：按项目结构重写一遍

---

## 最重要的一句话（别跳步骤）

> **Riverpod 学不会，90% 是因为直接抄 AsyncNotifier，没走 StateProvider → StateNotifier 这条路**

如果你愿意，下一步我可以直接 **按你“AI 私人助手 APP”给你设计一套 Riverpod 页面状态模板（loading / success / error）+ 一个真实页面完整代码**，直接能写进论文和项目。
