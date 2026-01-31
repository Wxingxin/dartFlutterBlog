你这个问题本质是：**Dart 里 `<>`（尖括号）里到底能写什么？**
我们一步一步说清楚。

---

## 一句话结论（先记住）

```dart
<String>  // 只能写「类型（Type）」
```

也就是：**泛型参数**。

---

## 你这行代码在干什么？

```dart
void main() {
  <String>[];
}
```

### 解析

* `[]` → List 字面量
* `<String>` → 给这个 List **显式指定泛型类型**
* 合起来等价于：

```dart
List<String>[];
```

👉 只是**创建了一个 List<String>，但没有用它**（没有变量接收）

---

## 【】里到底能写什么？

### ✅ 1️⃣ 基本类型

```dart
<int>[]
<String>[]
<double>[]
<bool>[]
```

---

### ✅ 2️⃣ 自定义类型 / 类

```dart
class User {}

<User>[]
```

---

### ✅ 3️⃣ 可空类型（Dart 空安全）

```dart
<String?>[]
<int?>[]
```

---

### ✅ 4️⃣ 泛型类型（嵌套）

```dart
<List<String>>[]
<Map<String, int>>[]
```

---

### ✅ 5️⃣ Map / Set 的写法（对比理解）

```dart
<String, int>{}     // Map<String, int>
<String>{}          // Set<String>
```

---

## ❌ 不能写什么？

### ❌ 1️⃣ 值

```dart
<1>[]        // ❌
<'a'>[]      // ❌
```

---

### ❌ 2️⃣ 表达式

```dart
<String + int>[]   // ❌
```

---

### ❌ 3️⃣ 关键字

```dart
<var>[]     // ❌
<final>[]   // ❌
```

---

## 为什么要写 `<String>[]`？

### 场景 1：空 List，类型无法推断（**非常常见**）

```dart
var list = [];      // List<dynamic> ❌
```

正确做法：

```dart
var list = <String>[];   // List<String> ✅
```

---

### 场景 2：函数返回空 List

```dart
List<String> getNames() {
  return <String>[];   // 明确返回类型
}
```

---

### 场景 3：Flutter 中强类型集合

```dart
final children = <Widget>[
  Text('A'),
  Text('B'),
];
```

---

## 和 `List<String>()` 的区别？

```dart
<String>[]        // ✅ 推荐（字面量，简洁）
List<String>()    // ❌ 已废弃写法（Dart 2 不推荐）
```

---

## 延伸：Set / Map 对应规则（一定要一起记）

| 写法                | 实际类型             |
| ----------------- | ---------------- |
| `<String>[]`      | List<String>     |
| `<String>{}`      | Set<String>      |
| `<String, int>{}` | Map<String, int> |

---

## 最终总结（记这 3 条）

1. `<>` 里 **只能写类型**
2. 用来告诉 Dart：**这个集合里装什么**
3. 空集合时 **必须写**，否则就是 `dynamic`

---

如果你愿意，我可以下一步帮你系统整理 **Dart / Flutter 泛型在真实项目中的高频写法（List / Map / Widget / Future / Stream）**，一次就能吃透。
