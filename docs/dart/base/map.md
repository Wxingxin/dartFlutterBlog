## Map 属性-方法-遍历

### Map 的属性

| 属性                  | 干什么           | 返回值                   |
| --------------------- | ---------------- | ------------------------ |
| length                | 键值对数量       | int                      |
| isEmpty               | 是否为空         | bool                     |
| isNotEmpty            | 是否非空         | bool                     |
| keys                  | 所有 key         | Iterable<K>              |
| values                | 所有 value       | Iterable<V>              |
| entries               | key + value 组合 | Iterable<MapEntry<K, V>> |
| hashCode （Object）   | 哈希值           | int                      |
| runtimeType（Object） | 运行时类型       | Type                     |

#### 1️⃣ `length`

```dart
Map<String, int> map = {'a': 1, 'b': 2};
print(map.length); // 2
```

知识点

- 表示 **键值对数量**
- key 唯一，重复 key 会覆盖

使用场景

```dart
if (map.length > 0) {}
```

⚠️ 推荐用下面的 👇

#### 2️⃣ `isEmpty`

```dart
map.isEmpty;
```

知识点

- 等价于 `map.length == 0`
- 语义更清晰

推荐写法

```dart
if (map.isEmpty) {
  showEmpty();
}
```

#### 3️⃣ `isNotEmpty`

```dart
map.isNotEmpty;
```

知识点

- 等价于 `!map.isEmpty`
- Flutter / 业务代码中非常常见

```dart
if (data.isNotEmpty) {
  buildUI(data);
}
```

#### 4️⃣ `keys`

```dart
map.keys;
```

类型

```dart
Iterable<K>
```

常见误区（⚠️）

❌ 错误 1：把 keys / values 当 List 用

```dart
map.keys[0]; // ❌
```

✅ 正确：

```dart
map.keys.toList()[0];
```

知识点（⚠️ 重点）

- **不是 List**
- 是 Map 的实时视图（Map 变，它也变）

```dart
for (var k in map.keys) {
  print(k);
}
```

如需 List：

```dart
map.keys.toList();
```

❌ 错误 2：遍历 Map 用 keys + map[key]

```dart
for (var k in map.keys) {
  print(map[k]);
}
```

❌ 可读性差
✅ 推荐：

```dart
for (var e in map.entries) {
  print(e.value);
}
```

#### 5️⃣ `values`

```dart
map.values;
```

知识点

- 返回所有 value
- 顺序与 keys 对应

```dart
for (var v in map.values) {
  print(v);
}
```

#### 6️⃣ `entries`（🔥 非常重要）

```dart
map.entries;
```

类型

```dart
Iterable<MapEntry<K, V>>
```

知识点

- **同时拿 key 和 value**
- Map 遍历的最佳方式

```dart
for (var entry in map.entries) {
  print('${entry.key} -> ${entry.value}');
}
```

👉 **强烈推荐用它遍历 Map**

### Map 的方法

| 分类 | 方法                           |
| ---- | ------------------------------ |
| 增   | `putIfAbsent` `addAll`         |
| 改   | `update` `updateAll`           |
| 删   | `remove` `removeWhere` `clear` |
| 查   | `containsKey` `containsValue`  |
| 取   | `[]` `[]=`                     |
| 遍历 | `forEach`                      |
| 转换 | `map` `cast`                   |
| 安全 | `putIfAbsent` `update(orElse)` |

#### 1️⃣ `[]` 取值

```dart
var map = {'a': 1, 'b': 2};

print(map['a']); // 1
print(map['c']); // null
```

知识点

- key 不存在 → 返回 `null`
- **不会抛异常**

#### 2️⃣ `[]=` 赋值 / 覆盖

```dart
map['c'] = 3;
map['a'] = 10; // 覆盖
```

- key 存在：覆盖
- key 不存在：新增

#### 3️⃣ `putIfAbsent`（🔥 非常重要）

```dart
map.putIfAbsent('a', () => 100);
```

知识点

- **只有 key 不存在才会插入**
- 回调是 **懒执行**

使用场景（缓存 / 分组）

```dart
groups.putIfAbsent(key, () => []).add(value);
```

👉 **这是 Dart 分组的标准写法**

#### 4️⃣ `addAll`

```dart
map.addAll({'c': 3, 'd': 4});
```

- 合并 Map
- 重复 key 会被覆盖

#### 5️⃣ `update`

```dart
map.update('a', (v) => v + 1);
```

⚠️ key 不存在会抛异常

安全写法（必背）

```dart
map.update(
  'c',
  (v) => v + 1,
  ifAbsent: () => 1,
);
```

#### 6️⃣ `updateAll`

```dart
map.updateAll((key, value) => value * 2);
```

- 批量修改 value
- key 不变

#### 7️⃣ `remove`

```dart
map.remove('a');
```

- 删除指定 key
- 返回被删除的 value（或 null）

#### 8️⃣ `removeWhere`（🔥）

```dart
map.removeWhere((key, value) => value < 0);
```

- 条件删除
- **安全删除方式**

#### 9️⃣ `clear`

```dart
map.clear();
```

- 清空 Map

#### 🔟 `containsKey`

```dart
map.containsKey('a');
```

👉 **判断 key 是否存在（最常用）**

#### 1️⃣1️⃣ `containsValue`

```dart
map.containsValue(2);
```

- 判断 value
- 性能比 `containsKey` 差（要遍历）

#### 1️⃣2️⃣ `forEach`

```dart
map.forEach((key, value) {
  print('$key -> $value');
});
```

知识点

- ❌ 不能 `break / continue`
- ❌ 遍历时不能修改 Map 结构

👉 **推荐：`entries` + for-in（你之前学的）**

### Map 的遍历

| 遍历方法                   | 能拿到      | 能否 break |
| -------------------------- | ----------- | ---------- |
| for (var k in map.keys)    | key         | ✅         |
| for (var v in map.values)  | value       | ✅         |
| for (var e in map.entries) | key + value | ✅         |
| while + iterator           | key + value | ✅         |
| map.forEach((k,v))         | key + value | ❌         |
| map.entries.map(...)       | key + value | ❌         |
| map.entries.where(...)     | key + value | ❌         |


#### `entries + for-in`（强烈推荐）

```dart
for (final entry in map.entries) {
  print('${entry.key} -> ${entry.value}');
}
```

 知识点

* 同时拿 **key + value**
* 支持 `break / continue`
* 可读性最好、性能也很好

👉 **95% 的业务遍历就用它**


#### 1️⃣ 遍历 `keys`

```dart
for (final k in map.keys) {
  print(k);
}
```

* 只关心 key
* `keys` 是 `Iterable`（不是 List）



#### 2️⃣ 遍历 `values`

```dart
for (final v in map.values) {
  print(v);
}
```

* 只关心 value
* 顺序与插入顺序一致

#### `while + iterator`（了解即可）

```dart
final it = map.entries.iterator;
while (it.moveNext()) {
  final e = it.current;
  print('${e.key} -> ${e.value}');
}
```

* 最底层方式
* 几乎不用（for-in 更清晰）


#### `forEach`（⚠️ 易被滥用）

```dart
map.forEach((key, value) {
  print('$key -> $value');
});
```

 必知要点

* ❌ **不能 `break / continue`**
* ❌ 遍历时 **不能修改 Map 结构**
* 有回调闭包开销（通常不大）

 适合场景

```dart
map.forEach(print); // 纯打印
```


#### 1️⃣ `entries.map`（遍历 + 转换）

```dart
final list = map.entries.map((e) {
  return '${e.key}:${e.value}';
}).toList();
```

* 返回 `Iterable`
* **需要 `toList()` 才落地**



#### 2️⃣ `entries.where`（遍历 + 过滤）

```dart
final filtered = map.entries
    .where((e) => e.value > 10)
    .toList();
```

## Map 是什么（核心概念）

在 Dart 中，**Map 是键值对（key-value）集合**：

```dart
Map<String, int> scores = {
  'Tom': 90,
  'Jack': 85,
};
```

👉 特点：

- key **唯一**
- value 可重复
- 通过 key 查 value
- **无序**（不要依赖插入顺序）
- 强泛型

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

- `final`：引用不可变
- `const`：内容不可变


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

| 类型 | 有序 | key 唯一 | value 唯一 |
| ---- | ---- | -------- | ---------- |
| List | ✅   | ❌       | ❌         |
| Set  | ❌   | ❌       | ✅         |
| Map  | ❌   | ✅       | ❌         |
