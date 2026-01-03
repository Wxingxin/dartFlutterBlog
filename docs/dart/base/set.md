下面给你一份**📘 Dart 语言 Set（集合）知识点大全**，我按**基础 → 常用 API → 高阶用法 → Flutter / 面试坑**的顺序系统整理，和你前面的 **List / Map** 是同一知识体系，学完三者你对 Dart 集合就非常扎实了。

---

# 一、Set 是什么（核心概念）

在 Dart 中，**Set 是一个“元素唯一”的集合**：

```dart
Set<int> set = {1, 2, 3};
```

👉 特点：

* **元素唯一（自动去重）**
* 无索引（不能用 `[]`）
* 无序（不要依赖顺序）
* 强泛型

---

# 二、Set 的声明方式（必会）

## 1️⃣ 字面量声明（最常用）

```dart
var set = {1, 2, 3};
Set<String> names = {'Tom', 'Jack'};
```

⚠️ 注意：

```dart
var x = {};   // 这是 Map，不是 Set
```

---

## 2️⃣ 空 Set 的正确写法（⚠️ 高危坑）

```dart
Set<int> set = {};
var set = <int>{};
```

❌ 错误写法：

```dart
var set = {}; // Map<dynamic, dynamic>
```

---

## 3️⃣ 构造函数方式

```dart
var set = Set<int>();
```

---

## 4️⃣ final / const Set

```dart
final set = {1, 2};
set.add(3); // ✅

const set = {1, 2};
set.add(3); // ❌
```

---

# 三、Set 常用属性（基础）

```dart
set.length
set.isEmpty
set.isNotEmpty
```

---

# 四、Set 的增删查（核心）

## ➕ 增

```dart
set.add(4);
set.addAll([5, 6]);
```

👉 自动去重：

```dart
set.add(1); // 不会报错，但无效果
```

---

## ➖ 删

```dart
set.remove(3);
set.clear();
```

---

## 🔍 查

```dart
set.contains(2);
```

---

# 五、Set 遍历方式（必会）

## 1️⃣ for-in（最常用）

```dart
for (var item in set) {
  print(item);
}
```

---

## 2️⃣ forEach

```dart
set.forEach((e) => print(e));
```

---

## 3️⃣ 转 List 遍历（需要索引）

```dart
var list = set.toList();
```

---

# 六、Set 的核心价值：集合运算（🔥 必考）

假设：

```dart
var a = {1, 2, 3};
var b = {3, 4, 5};
```

---

## 1️⃣ 并集 union

```dart
var c = a.union(b); // {1,2,3,4,5}
```

---

## 2️⃣ 交集 intersection

```dart
var c = a.intersection(b); // {3}
```

---

## 3️⃣ 差集 difference

```dart
var c = a.difference(b); // {1,2}
```

---

## 4️⃣ 子集判断

```dart
a.containsAll({1, 2}); // true
```

---

# 七、Set 高阶方法（函数式）

## 1️⃣ map

```dart
var newSet = set.map((e) => e * 2).toSet();
```

---

## 2️⃣ where

```dart
var evens = set.where((e) => e.isEven).toSet();
```

---

## 3️⃣ any / every

```dart
set.any((e) => e > 3);
set.every((e) => e > 0);
```

---

# 八、Set 拷贝（⚠️ 引用陷阱）

❌ 错误：

```dart
var a = {1, 2};
var b = a;
b.add(3);
print(a); // {1,2,3}
```

---

## ✅ 正确拷贝

```dart
var b = Set.from(a);
var b = {...a}; // 推荐
```

---

# 九、Set 与 List 的互转（非常常见）

## List → Set（去重）

```dart
var list = [1, 2, 2, 3];
var set = list.toSet();
```

---

## Set → List

```dart
var list = set.toList();
```

---

# 十、Set 与 null safety（必考）

```dart
Set<int>? set;        // Set 可为 null
Set<int?> set;        // 元素可为 null
Set<int?>? set;       // 都可为 null
```

---

# 十一、Flutter 中 Set 的典型场景

## 1️⃣ 去重数据

```dart
var uniqueIds = <int>{};
```

---

## 2️⃣ 多选状态（Checkbox）

```dart
Set<int> selectedIds = {};
```

```dart
onChanged: (value) {
  setState(() {
    value ? selectedIds.add(id) : selectedIds.remove(id);
  });
}
```

---

## 3️⃣ 权限 / 标签系统

```dart
Set<String> permissions = {'read', 'write'};
```

---

# 十二、Set vs List vs Map（终极对比）

| 类型   | 有序 | 唯一性    | 访问方式     |
| ---- | -- | ------ | -------- |
| List | ✅  | ❌      | index    |
| Set  | ❌  | ✅      | contains |
| Map  | ❌  | key 唯一 | key      |

---

# 十三、Set 常见错误总结（面试必考）

❌ `var set = {};`
❌ 以为 Set 有索引
❌ 依赖 Set 顺序
❌ 引用拷贝导致数据污染
❌ map / where 忘记 `.toSet()`

---

# 十四、一句话总结（记忆版）

> **Set = 天然去重 + 集合运算 + 高效 contains**

---

## 下一步我可以继续帮你👇

* ✅ **List / Set / Map 选型思维**
* ✅ **集合 + JSON / Model 实战**
* ✅ **Flutter 表单 & 多选完整案例**
* ✅ **Dart 集合常见面试题**

你只要说：**“集合选型”** 或 **“Flutter 实战”** 我就继续 👍
