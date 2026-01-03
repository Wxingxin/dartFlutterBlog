下面是一份**📘 Dart 语言 Map（映射 / 字典）知识点大全**，我会按**学习 → 实战 → Flutter / 面试常见坑**的顺序来讲，风格和你刚才的 List 一致，方便你系统记忆和对比。

---

# 一、Map 是什么（核心概念）

在 Dart 中，**Map 是键值对（key-value）集合**：

```dart
Map<String, int> scores = {
  'Tom': 90,
  'Jack': 85,
};
```

👉 特点：

* key **唯一**
* value 可重复
* 通过 key 查 value
* **无序**（不要依赖插入顺序）
* 强泛型

---

# 二、Map 的声明方式（必会）

## 1️⃣ 字面量声明（最常用）

```dart
var map = {
  'a': 1,
  'b': 2,
};
```

等价于：

```dart
Map<String, int> map = {
  'a': 1,
  'b': 2,
};
```

---

## 2️⃣ 空 Map 的正确写法（⚠️ 易错）

```dart
Map<String, int> map = {};
var map = <String, int>{};
```

❌ 错误写法：

```dart
var map = {}; // 这是 Map<dynamic, dynamic>
```

---

## 3️⃣ 构造函数方式（了解）

```dart
var map = Map<String, int>();
```

---

## 4️⃣ final / const Map

```dart
final map = {'a': 1};
map['b'] = 2; // ✅

const map = {'a': 1};
map['b'] = 2; // ❌
```

👉 规则和 List 一样：

* `final`：引用不可变
* `const`：内容不可变

---

# 三、Map 常用属性（基础）

```dart
map.length
map.isEmpty
map.isNotEmpty
map.keys      // Iterable<K>
map.values    // Iterable<V>
map.entries   // Iterable<MapEntry<K, V>>
```

---

# 四、Map 的增删改查（核心）

## ➕ 增 / 改（同一个操作）

```dart
map['a'] = 1;     // 新增
map['a'] = 100;   // 修改
```

---

## 🔍 查

```dart
map['a'];                 // 不存在返回 null
map.containsKey('a');
map.containsValue(100);
```

⚠️ null 安全注意：

```dart
int? value = map['x'];
```

---

## ➖ 删

```dart
map.remove('a');
map.clear();
```

---

# 五、Map 遍历方式（必会）

## 1️⃣ forEach（最常用）

```dart
map.forEach((key, value) {
  print('$key : $value');
});
```

---

## 2️⃣ entries（推荐）

```dart
for (var entry in map.entries) {
  print('${entry.key} : ${entry.value}');
}
```

---

## 3️⃣ 遍历 keys / values

```dart
for (var key in map.keys) {}
for (var value in map.values) {}
```

---

# 六、Map 高阶方法（🔥 Dart 核心）

## 1️⃣ map（注意⚠️ 和 List 的 map 不一样）

```dart
var newMap = map.map((key, value) {
  return MapEntry(key, value * 2);
});
```

---

## 2️⃣ where（过滤）

```dart
var filtered = map.entries
    .where((e) => e.value > 80)
    .map((e) => MapEntry(e.key, e.value));
```

---

## 3️⃣ putIfAbsent（很常用）

```dart
map.putIfAbsent('a', () => 100);
```

👉 **key 不存在才执行**

---

## 4️⃣ update（推荐）

```dart
map.update('a', (v) => v + 1);
map.update('b', (v) => 1, ifAbsent: () => 1);
```

---

# 七、Map 拷贝（⚠️ Flutter 大坑）

## ❌ 引用拷贝

```dart
var a = {'x': 1};
var b = a;
b['x'] = 2;
print(a); // {'x':2}
```

---

## ✅ 正确拷贝

```dart
var b = Map.from(a);
var b = {...a}; // 推荐
```

---

# 八、Map 与 JSON（🔥 超高频）

## 1️⃣ JSON → Map

```dart
import 'dart:convert';

var map = jsonDecode(jsonString);
```

类型安全写法：

```dart
Map<String, dynamic> map =
    jsonDecode(jsonString) as Map<String, dynamic>;
```

---

## 2️⃣ Map → JSON

```dart
var jsonStr = jsonEncode(map);
```

---

## 3️⃣ Map → Model（核心思想）

```dart
class User {
  final String name;
  final int age;

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'];
}
```

👉 **不要手写 Map 到处用**

---

# 九、Map 与 null safety（必考）

```dart
Map<String, int>? map;      // map 可为 null
Map<String, int?> map;      // value 可为 null
Map<String, int?>? map;     // 都可为 null
```

---

# 十、Map vs List vs Set（对比）

| 类型   | 有序 | key 唯一 | value 唯一 |
| ---- | -- | ------ | -------- |
| List | ✅  | ❌      | ❌        |
| Set  | ❌  | ❌      | ✅        |
| Map  | ❌  | ✅      | ❌        |

---

# 十一、Flutter 中 Map 的典型场景

## 1️⃣ 表单数据

```dart
Map<String, dynamic> formData = {
  'username': '',
  'password': '',
};
```

---

## 2️⃣ 网络请求参数

```dart
dio.post('/login', data: {
  'username': 'admin',
  'password': '123456',
});
```

---

## 3️⃣ List<Map>（非常常见）

```dart
List<Map<String, dynamic>> users = [
  {'name': 'Tom', 'age': 18},
  {'name': 'Jack', 'age': 20},
];
```

---

# 十二、Map 常见错误总结（面试必考）

❌ `var map = {};`
❌ 忘记 null 判断：`map['x']!`
❌ Map 拷贝引用问题
❌ Map.map 返回的是 Map，不是 List
❌ JSON 不做类型转换

---

# 十三、一句话记忆版

> **Dart 的 Map = 强泛型 key-value 容器 + JSON 的核心载体**

---

## 接下来我可以帮你继续👇

* ✅ **List<Map> ↔ Model 完整实战**
* ✅ **Flutter 中 Map + 表单 + 网络**
* ✅ **Map 常见面试题（附 Dart / JS 对照）**
* ✅ **json_serializable 自动生成 Map**

你直接说：**“继续 Map + JSON 实战”** 或 **“Flutter 场景”** 就行 👍
