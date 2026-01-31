下面我**系统、分层**给你讲一遍 **Dart 的 `enum`**，从「它是什么」→「怎么用」→「新语法」→「实战场景」，**对 Flutter / Dart 项目是直接可用的**。

---

# 一、enum 是什么（本质）

```dart
enum Status {
  pending,
  success,
  failure,
}
```

### 本质

* `enum` = **有限个离散值的集合**
* 编译期可检查
* 比 `String / int` 更安全

👉 **状态 / 类型 / 模式 / 枚举值** 的最佳工具。

---

# 二、最基础用法（必须会）

### 定义

```dart
enum Status {
  pending,
  success,
  failure,
}
```

### 使用

```dart
Status status = Status.pending;

if (status == Status.success) {
  print('成功');
}
```

---

# 三、enum 的常用属性 & 方法（重点）

## 1️⃣ `.values`（所有枚举值）

```dart
for (var s in Status.values) {
  print(s);
}
```

输出：

```
Status.pending
Status.success
Status.failure
```

---

## 2️⃣ `.name`（🔥 Dart 2.15+）

```dart
print(Status.success.name); // "success"
```

⚠️ 注意：不带 enum 名称

---

## 3️⃣ `.index`（不推荐依赖）

```dart
print(Status.success.index); // 1
```

❌ **不推荐持久化使用**

* 顺序一变 index 就变

---

# 四、switch + enum（最经典场景）

```dart
switch (status) {
  case Status.pending:
    print('处理中');
    break;
  case Status.success:
    print('成功');
    break;
  case Status.failure:
    print('失败');
    break;
}
```

### Dart 的优势

* **必须穷尽所有 enum 值**
* 少一个会直接报错（编译期）

---

# 五、enum 在 Flutter 中的真实用法（非常重要）

## 1️⃣ 控制 UI 状态

```dart
enum LoadState { loading, success, error }

Widget build(BuildContext context) {
  switch (state) {
    case LoadState.loading:
      return CircularProgressIndicator();
    case LoadState.success:
      return Text('加载完成');
    case LoadState.error:
      return Text('出错了');
  }
}
```

---

## 2️⃣ 替代魔法字符串（强烈推荐）

❌ 不要这样：

```dart
if (status == 'success') {}
```

✅ 应该这样：

```dart
if (status == Status.success) {}
```

---

# 六、带值的 enum（🔥 Dart 2.17+，核心）

## 1️⃣ enum 带字段

```dart
enum Result {
  success(200),
  notFound(404),
  serverError(500);

  final int code;
  const Result(this.code);
}
```

### 使用

```dart
print(Result.success.code); // 200
```

---

## 2️⃣ enum 带方法

```dart
enum Role {
  admin,
  user,
  guest;

  bool get canDelete {
    return this == Role.admin;
  }
}
```

```dart
if (role.canDelete) {
  // ...
}
```

---

## 3️⃣ enum 带计算属性（Flutter 常用）

```dart
enum ThemeModeX {
  light,
  dark;

  Color get color {
    return switch (this) {
      ThemeModeX.light => Colors.white,
      ThemeModeX.dark => Colors.black,
    };
  }
}
```

---

# 七、enum + switch 表达式（🔥 新写法）

```dart
String label = switch (status) {
  Status.pending => '处理中',
  Status.success => '成功',
  Status.failure => '失败',
};
```

✅ 无需 `break`
✅ 必须穷尽

---

# 八、enum + JSON / 后端数据（实战重点）

## 1️⃣ String → enum

```dart
Status parseStatus(String value) {
  return Status.values.firstWhere(
    (e) => e.name == value,
    orElse: () => Status.pending,
  );
}
```

---

## 2️⃣ enum → String

```dart
String toJson(Status status) => status.name;
```

---

## 3️⃣ 更安全写法（推荐）

```dart
Status? parseStatus(String? value) {
  return Status.values
      .where((e) => e.name == value)
      .cast<Status?>()
      .firstOrNull;
}
```

---

# 九、enum vs const / static const（理解层）

| 场景          | enum | const |
| ----------- | ---- | ----- |
| 有限状态        | ✅    | ❌     |
| switch 穷尽检查 | ✅    | ❌     |
| 语义表达        | 强    | 弱     |
| 类型安全        | 强    | 弱     |

---

# 十、常见错误 & 反模式

### ❌ 用 int / String 表示状态

```dart
int status = 1;     // ❌
String status = 'ok'; // ❌
```

### ❌ 依赖 index

```dart
save(status.index); // ❌
```

---

# 十一、你现在应该怎么用（给你一套“肌肉记忆”）

### ✅ UI 状态

```dart
enum ViewState { idle, loading, success, error }
```

### ✅ 权限 / 角色

```dart
enum UserRole { admin, editor, viewer }
```

### ✅ 网络请求

```dart
enum RequestMethod { get, post, put, delete }
```

---

## 最后一句话总结

> **只要是「固定可选项」，优先用 enum，不要用字符串。**

---

如果你愿意，我可以下一步帮你：

* 结合 **Flutter + enum + Riverpod / Bloc / Zustand 思想**
* 或写一个 **enum + JSON + UI 状态完整小案例**

你选一个方向，我直接给你代码。
