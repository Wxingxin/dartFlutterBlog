## List 是什么（基础认知）

在 Dart 中，**List 是有序集合**，可以存放多个元素，属于：`Object → Iterable → List`

```dart
List<int> nums = [1, 2, 3];
print(nums[0]); // 1
```

👉 特点：

- 有顺序
- 可重复
- 可通过索引访问（下标从 0 开始）
- 分为：可变 List / 不可变 List（看声明方式）

---

## List 的声明方式（必考）

### 1️⃣ 字面量声明（最常用）

```dart
var list = [1, 2, 3];        // 自动推断 List<int>
List<String> names = ['a', 'b'];
```

### 2️⃣ 指定泛型（强烈推荐）

```dart
List<int> numbers = [1, 2, 3];
```

❗ 不写泛型会变成 `List<dynamic>`

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

- `final`：地址不变，内容可变
- `const`：地址 & 内容都不变

## List 的操作

### List 的访问和修改 下标访问

```dart
list[0];      // 读取
list[0] = 10; // 修改
```

⚠️ 越界直接抛异常

### 八、List 拷贝（⚠️ Flutter 超常见坑）

❌ 错误：引用拷贝

```dart
var a = [1, 2];
var b = a;
b.add(3);
print(a); // [1,2,3]
```

✅ 正确：值拷贝

```dart
var b = List.from(a);
var b = [...a];          // 推荐
```

### List 与 null safety（必懂）

```dart
List<int>? list;        // List 本身可为 null
List<int?> list;        // 元素可为 null
List<int?>? list;       // 都可为 null
```

## List 的属性和方法和遍历

> **List 的属性 = 状态判断工具，而不是数据处理工具。** > **判断用属性，处理用方法。**

### List 的属性

| 属性                | 干什么      | 返回值      |
| ------------------- | ----------- | ----------- |
| length              | 元素个数    | num         |
| isEmpty             | 是否为空    | bool        |
| isNotEmpty          | 是否非空    | bool        |
| first               | 第一个元素  | E           |
| last                | 最后—个元素 | E           |
| single              | 唯一元素    | E           |
| reversed            | 反转视图    | Iterable<E> |
| hashCode(Object)    | 哈希值      | int         |
| runtimeType(Object) | 运行时类型  | Type        |

#### 1️⃣ `length`

```dart
List<int> list = [1, 2, 3];
print(list.length); // 3
```

知识点

- 表示 **元素个数**
- 空 List：`length == 0`
- 固定长度 List 的 `length` **不能改变**

使用场景

```dart
if (list.length > 0) {}
```

❌ 错误 3：用 length 判断可读性差

```dart
if (list.length > 0) {} // ❌
```

✅ 推荐：

```dart
if (list.isNotEmpty) {}
```

⚠️ 不推荐这样写，推荐下面 👇

#### 2️⃣ `isEmpty`

```dart
list.isEmpty;
```

知识点

- 等价于：`list.length == 0`
- **语义更清晰**
- Dart / Flutter 强烈推荐

使用场景（推荐）

```dart
if (list.isEmpty) {
  showEmpty();
}
```

#### 3️⃣ `isNotEmpty`

```dart
list.isNotEmpty;
```

知识点

- 等价于：`!list.isEmpty`
- **比 `length > 0` 更安全、可读**

Flutter 中非常常见

```dart
if (items.isNotEmpty) {
  buildList(items);
}
```

#### 4️⃣ `first`

```dart
list.first;
```

知识点

- 返回 **第一个元素**
- ❌ 空 List 会抛异常

安全用法

```dart
if (list.isNotEmpty) {
  print(list.first);
}
```

❌ 错误 1：空 List 直接取 first / last

```dart
list.first; // ❌ 可能崩溃
```

✅ 正确：

```dart
if (list.isNotEmpty) {
  list.first;
}
```

#### 5️⃣ `last`

```dart
list.last;
```

知识点

- 返回 **最后一个元素**
- ❌ 空 List 会抛异常

使用场景

```dart
var lastMessage = messages.last;
```

#### 6️⃣ `single`（非常重要但容易误用）

```dart
list.single;
```

知识点

- **List 中必须且只能有 1 个元素**
- 否则直接抛异常

正确使用场景（接口校验）

```dart
final result = responseList.single;
```

👉 含义：

> **我期望后端只返回一条数据**

⚠️ 不确定数量时不要用

#### 7️⃣ `reversed`

```dart
list.reversed;
```

知识点（⚠️ 很关键）

- 返回的是：`Iterable<E>`
- **不是 List**
- **不会修改原 List**

```dart
var r = list.reversed;        // Iterable
var newList = r.toList();    // List
```

使用场景

```dart
for (var e in list.reversed) {
  print(e);
}
```

❌ 错误 2：把 reversed 当 List 用

```dart
list.reversed[0]; // ❌
```

✅ 正确：

```dart
list.reversed.toList()[0];
```

### List 的方法

| 分类      | 代表方法                                               |
| --------- | ------------------------------------------------------ |
| 增加      | `add` `addAll` `insert` `insertAll`                    |
| 删除      | `remove` `removeAt` `removeLast` `removeWhere` `clear` |
| 修改      | `setAll` `replaceRange`                                |
| 查找      | `contains` `indexOf` `lastIndexOf`                     |
| 条件查找  | `firstWhere` `lastWhere`                               |
| 遍历      | `forEach`                                              |
| 转换      | `map` `where` `expand`                                 |
| 截取      | `sublist` `getRange`                                   |
| 排序/打乱 | `sort` `shuffle`                                       |
| 判断      | `any` `every`                                          |
| 转换类型  | `toList` `toSet`                                       |

#### 1️⃣ `add`

```dart
list.add(4);
```

- 向 **末尾** 添加一个元素
- 修改原 List

#### 2️⃣ `addAll`

```dart
list.addAll([5, 6, 7]);
```

- 批量添加
- 常用于合并列表

#### 3️⃣ `insert`

```dart
list.insert(0, 99);
```

- 在指定索引插入
- 原元素整体后移

#### 4️⃣ `insertAll`

```dart
list.insertAll(1, [7, 8]);
```

#### 5️⃣ `remove`

```dart
list.remove(3);
```

- 按 **值** 删除
- 只删除第一个匹配项
- 返回 `bool`

#### 6️⃣ `removeAt`

```dart
list.removeAt(0);
```

- 按 **索引** 删除
- 越界直接抛异常

#### 7️⃣ `removeLast`

```dart
list.removeLast();
```

- 删除最后一个
- 空 List 会抛异常

#### 8️⃣ `removeWhere`（非常常用）

```dart
list.removeWhere((e) => e > 3);
```

- 条件删除
- **会修改原 List**

⚠️ 不能在遍历时手动删，用这个

#### 9️⃣ `clear`

```dart
list.clear();
```

- 清空 List

#### 🔟 `setAll`

```dart
list.setAll(1, [7, 8]);
```

- 从指定索引开始整体替换
- 长度必须匹配

#### 1️⃣1️⃣ `replaceRange`

```dart
list.replaceRange(0, 2, [9, 9]);
```

- 指定范围替换
- **非常灵活**

#### 1️⃣2️⃣ `contains`

```dart
list.contains(3);
```

- 是否包含某值

#### 1️⃣3️⃣ `indexOf`

```dart
list.indexOf(3);
```

- 返回索引
- 不存在返回 `-1`

#### 1️⃣4️⃣ `lastIndexOf`

```dart
list.lastIndexOf(3);
```

#### 1️⃣5️⃣ `firstWhere`

```dart
list.firstWhere((e) => e > 2);
```

⚠️ 找不到会抛异常

✅ 安全写法：

```dart
list.firstWhere(
  (e) => e > 10,
  orElse: () => -1,
);
```

#### 1️⃣6️⃣ `lastWhere`

```dart
list.lastWhere((e) => e > 2);
```

#### 1️⃣7️⃣ `forEach`

```dart
list.forEach((e) {
  print(e);
});
```

知识点

- 不能 `break / continue`
- 不适合复杂控制流

👉 **业务推荐：for-in**

#### 1️⃣8️⃣ `map`

```dart
var newList = list.map((e) => e * 2).toList();
```

- 一对一映射
- **不修改原 List**

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

#### 1️⃣9️⃣ `where`

```dart
var evens = list.where((e) => e.isEven).toList();
```

- 过滤

#### 2️⃣0️⃣ `expand`（扁平化）

```dart
var flat = [[1,2],[3,4]].expand((e) => e).toList();
```

#### 2️⃣1️⃣ `sublist`

```dart
list.sublist(1, 3);
```

- 左闭右开 `[1,3)`

#### 2️⃣2️⃣ `getRange`

```dart
list.getRange(0, 2);
```

- 返回 `Iterable`
- 不修改原 List

#### 2️⃣3️⃣ `sort`

```dart
list.sort(); // 升序
list.sort((a, b) => b.compareTo(a)); // 降序
```

⚠️ **原地排序**

#### 2️⃣4️⃣ `shuffle`

```dart
list.shuffle();
```

- 打乱顺序
- 常用于随机题目、抽奖

#### 2️⃣5️⃣ `any`

```dart
list.any((e) => e > 5);
```

- 是否 **存在** 满足条件的元素

#### 2️⃣6️⃣ `every`

```dart
list.every((e) => e > 0);
```

- 是否 **全部** 满足条件

#### 2️⃣7️⃣ `toList`

```dart
iterable.toList();
```

#### 2️⃣8️⃣ `toSet`（去重）

```dart
list.toSet().toList();
```

### List 的遍历方法

| 方法                         | 是否可 break | 是否可修改 List | 性能           |
| ---------------------------- | ------------ | --------------- | -------------- |
| for (int i = 0; i < ..)      | ✅           | ⚠️              | 最优           |
| for (var e in list)          | ✅           | ⚠️              | 很优           |
| while                        | ✅           | ⚠️              | ？             |
| where                        | ❌           | ❌              | 取决于链式长度 |
| forEach(内置方法)            | ❌           | ❌              | 稍慢           |
| map(内置方法)                | ❌           | ❌              | 取决于链式长度 |
| asMap().forEach （内置方法） | ❌           | ❌              | ？             |
| entries(Map)(内置方法)       | ❌           | ❌              | ？             |

#### 经典 for 下标遍历（最基础、最安全）

```dart
for (int i = 0; i < list.length; i++) {
  print(list[i]);
}
```

知识点

- 可以拿到 **索引 + 元素**
- 支持 `break / continue`
- 可以 **安全修改元素值**

使用场景

- 需要索引
- 算法题
- 批量修改元素

#### for-in（最推荐的日常写法）

```dart
for (var e in list) {
  print(e);
}
```

知识点

- 语义清晰
- 支持 `break / continue`
- 不能直接拿索引（除非自己计数）

使用场景（🔥 Flutter / 业务首选）

```dart
for (final item in items) {
  print(item.title);
}
```

#### while 遍历（较少用）

```dart
int i = 0;
while (i < list.length) {
  print(list[i]);
  i++;
}
```

适合场景

- 手动控制指针
- 特殊算法

#### where（遍历 + 过滤）

```dart
var evens = list.where((e) => e.isEven).toList();
```

知识点

- 返回满足条件的元素
- 不修改原 List

#### expand（遍历 + 扁平化）

```dart
var flat = [
  [1, 2],
  [3, 4]
].expand((e) => e).toList();
```

使用场景

- 多维数组转一维
- 接口嵌套数据处理

## 一句话总结（记忆版）

> **Dart 的 List = 有序、可索引、强泛型 + 函数式操作集合**
