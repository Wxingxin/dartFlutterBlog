

## 一、List 是什么（基础认知）

在 Dart 中，**List 是有序集合**，可以存放多个元素，**下标从 0 开始**。

```dart
List<int> nums = [1, 2, 3];
print(nums[0]); // 1
```

👉 特点：

* 有顺序
* 可重复
* 可通过索引访问
* 可变 / 不可变（看声明方式）

---

## 二、List 的声明方式（必考）

### 1️⃣ 字面量声明（最常用）

```dart
var list = [1, 2, 3];        // 自动推断 List<int>
List<String> names = ['a', 'b'];
```

### 2️⃣ 指定泛型（强烈推荐）

```dart
List<int> numbers = [1, 2, 3];
```

❗不写泛型会变成 `List<dynamic>`

---

### 3️⃣ 空 List 的正确写法（⚠️ 易错）

```dart
List<int> list = [];        // ✅ 推荐
var list = <int>[];         // ✅ 推荐
```

❌ 错误示例（隐患）：

```dart
var list = []; // List<dynamic>
```

---

### 4️⃣ 固定长度 List（不常用）

```dart
var list = List.filled(3, 0);
```

```dart
list[0] = 1;  // ✅
list.add(4);  // ❌ UnsupportedError
```

---

## 三、可变 List vs 不可变 List

### 可变 List（默认）

```dart
var list = [1, 2, 3];
list.add(4);
```

### 不可变 List（final / const）

```dart
final list = [1, 2, 3];
list.add(4); // ✅（final 只是变量不可变）

const list = [1, 2, 3];
list.add(4); // ❌（内容不可变）
```

👉 **记忆口诀**：

* `final`：地址不变，内容可变
* `const`：地址 & 内容都不变

---

## 四、List 常用属性（必须熟）

```dart
list.length      // 长度
list.isEmpty
list.isNotEmpty
list.first
list.last
```

---

## 五、List 常用增删改查（核心）

### ➕ 增

```dart
list.add(4);
list.addAll([5, 6]);
list.insert(0, 100);
list.insertAll(1, [7, 8]);
```

---

### ➖ 删

```dart
list.remove(3);        // 删除值
list.removeAt(0);      // 删除索引
list.removeLast();
list.clear();
```

---

### ✏️ 改

```dart
list[0] = 99;
```

---

### 🔍 查

```dart
list.contains(3);
list.indexOf(3);
list.lastIndexOf(3);
```

---

## 六、List 遍历方式（重点）

### 1️⃣ for 循环（最基础）

```dart
for (int i = 0; i < list.length; i++) {
  print(list[i]);
}
```

---

### 2️⃣ for-in（推荐）

```dart
for (var item in list) {
  print(item);
}
```

---

### 3️⃣ forEach（函数式）

```dart
list.forEach((item) {
  print(item);
});
```

---

### 4️⃣ 带索引遍历

```dart
list.asMap().forEach((i, v) {
  print('$i : $v');
});
```

---

## 七、List 高阶函数（🔥 Dart 核心）

### 1️⃣ map（映射）

```dart
var newList = list.map((e) => e * 2).toList();
```

---

### 2️⃣ where（过滤）

```dart
var evens = list.where((e) => e.isEven).toList();
```

---

### 3️⃣ any / every

```dart
list.any((e) => e > 5);    // 是否存在
list.every((e) => e > 0); // 是否全部满足
```

---

### 4️⃣ reduce / fold（聚合）

```dart
list.reduce((a, b) => a + b);
list.fold(0, (sum, e) => sum + e);
```

---

## 八、List 拷贝（⚠️ Flutter 超常见坑）

### ❌ 错误：引用拷贝

```dart
var a = [1, 2];
var b = a;
b.add(3);
print(a); // [1,2,3]
```

---

### ✅ 正确：值拷贝

```dart
var b = List.from(a);
var b = [...a];          // 推荐
```

---

## 九、List 排序

```dart
list.sort(); // 默认升序
```

自定义排序：

```dart
list.sort((a, b) => b.compareTo(a)); // 降序
```

对象排序：

```dart
users.sort((a, b) => a.age.compareTo(b.age));
```

---

## 十、List 与 null safety（必懂）

```dart
List<int>? list;        // List 本身可为 null
List<int?> list;        // 元素可为 null
List<int?>? list;       // 都可为 null
```

---

## 十一、List 与 Set / Map 对比

| 类型   | 是否有序 | 是否重复   |
| ---- | ---- | ------ |
| List | ✅    | ✅      |
| Set  | ❌    | ❌      |
| Map  | ❌    | key 唯一 |

---

## 十二、Flutter 中 List 的典型使用

### 1️⃣ ListView.builder

```dart
ListView.builder(
  itemCount: list.length,
  itemBuilder: (context, index) {
    return Text(list[index]);
  },
);
```

---

### 2️⃣ setState 更新 List（重点）

```dart
setState(() {
  list.add(1);
});
```

❗不调用 `setState` → UI 不刷新

---

## 十三、常见错误总结（面试常考）

❌ `var list = [];`
❌ 忘记 `.toList()`
❌ List 拷贝引用问题
❌ `const List` 修改内容
❌ 修改 List 但没 setState

---

## 十四、一句话总结（记忆版）

> **Dart 的 List = 有序、可索引、强泛型 + 函数式操作集合**

---

如果你愿意，我可以继续帮你整理👇

* ✅ **List vs Set vs Map 深度对比**
* ✅ **List + JSON 解析实战**
* ✅ **Flutter 中 List 状态管理最佳实践**
* ✅ **List 常见面试题 & LeetCode 思路（JS/Dart 对照）**

你直接告诉我下一步学哪个 👍
