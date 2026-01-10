## 一、Set 是什么（核心概念）

在 Dart 中，**Set 是一个“元素唯一”的集合**：

```dart
Set<int> set = {1, 2, 3};
```

👉 特点：

- **元素唯一（自动去重）**
- 无索引（不能用 `[]`）
- 无序（不要依赖顺序）
- 强泛型

## Set 的声明方式

### 1️⃣ 字面量声明（最常用）

```dart
var s1 = {1,2,3}

//（自动去重)
var s5 = {1, 2, 2, 3}; // {1, 2, 3}
```

⚠️ 注意：

```dart
var x = {};   // 这是 Map，不是 Set
```

### 2️⃣ 空 Set（A 不能写 {}，那是 Map)

```dart
Set<int> set = {};
var set = <int>{};
```

❌ 错误写法：

```dart
var set = {}; // Map<dynamic, dynamic>
```

---

### 3️⃣ 指定泛型

```dart
Set<String> s2 = {'a', 'b', 'c'};
```

### 4️⃣ final / const Set

```dart
final set = {1, 2};
set.add(3); // ✅

const set = {1, 2};
set.add(3); // ❌
```

## 三、Set 常用属性（基础）

| 属性       | 干什么                                     | 返回值 |
| ---------- | ------------------------------------------ | ------ |
| length     | 元素个数                                   | num    |
| isEmpty    | 是否为空                                   | bool   |
| isNotEmpty | 是否非空                                   | bool   |
| first      | 第一个元素（按插入顺序）,❌ 空集合会抛异常 | E      |
| last       | 最后一个元素                               | E      |
| single     | 只有一个元素时可用,多个或 0 个都会抛异常   | E      |

```dart
set.length
set.isEmpty
set.isNotEmpty
```

## 四、Set 的增删查（核心）

| 分类                       | 方法                           |
| -------------------------- | ------------------------------ |
| 增                         | `add(E value)` `addAll(Iterable elements)`         |
| 删                         | `remove` `removeAll` `retainAll` `removeWhere` `clear`|
| 查/判断                    | `contains` `containsAll`           |
| 4.遍历                     | `forEach` `iterator` `expand` |
| 5.转换                     | `[]` `[]=`                     |
| 6.集合运算(Set 独有，重点) | `forEach`                      |


#### 1️⃣ `add(E value)`

```dart
set.add(3);
```

* 添加一个元素
* ⚠️ 已存在 → **不会重复添加**
* 返回 `bool`

  * `true`：成功新增
  * `false`：元素已存在

```dart
var s = {1, 2};
print(s.add(2)); // false
print(s);        // {1, 2}
```



#### 2️⃣ `addAll(Iterable elements)`

```dart
set.addAll([3, 4, 5]);
```

* 批量添加
* 自动去重
* 参数是 `Iterable`（List / Set 都行）


#### 3️⃣ `remove(Object value)`

```dart
set.remove(2);
```

* 删除指定元素
* 返回 `bool`



#### 4️⃣ `removeAll(Iterable elements)`

```dart
set.removeAll([1, 3]);
```

* 批量删除



#### 5️⃣ `retainAll(Iterable elements)` ⭐

```dart
set.retainAll([2, 3]);
```

* **只保留指定元素**
* 本质：**取交集**
* 原 Set 会被修改（in-place）



#### 6️⃣ `removeWhere(bool test(E element))`

```dart
set.removeWhere((e) => e % 2 == 0);
```

* 按条件删除
* 非常常用



#### 7️⃣ `clear()`

```dart
set.clear();
```

* 清空 Set


#### 8️⃣ `contains(Object element)`

```dart
set.contains(3); // true / false
```

* O(1) 查找（核心优势）



#### 9️⃣ `containsAll(Iterable elements)`

```dart
set.containsAll([1, 2]);
```

* 是否**全部包含**







#### 🔟 `forEach(void f(E element))`

```dart
set.forEach((e) {
  print(e);
});
```



#### 1️⃣1️⃣ `iterator`

```dart
var it = set.iterator;
while (it.moveNext()) {
  print(it.current);
}
```

* 底层遍历方式
* 面试可能问



#### 1️⃣2️⃣ `expand()`（扁平化）

```dart
var s = {1, 2};
var r = s.expand((e) => [e, e * 10]);
print(r); // (1, 10, 2, 20)
```

#### 六、条件 & 函数式方法（Iterable 通用）

> **这一组方法你学会一次，List / Set / Map.values 都能用**



#### 1️⃣3️⃣ `where()`

```dart
var result = set.where((e) => e > 2);
```

* 过滤
* 返回 `Iterable`



#### 1️⃣4️⃣ `map()`

```dart
var result = set.map((e) => e * 2);
```



#### 1️⃣5️⃣ `any()`

```dart
set.any((e) => e > 5);
```

* 是否**至少一个满足**



#### 1️⃣6️⃣ `every()`

```dart
set.every((e) => e > 0);
```

* 是否**全部满足**



#### 1️⃣7️⃣ `firstWhere()`

```dart
set.firstWhere((e) => e > 2);
```

* 找第一个满足条件的
* ⚠️ 找不到会抛异常（可用 `orElse`）

```dart
set.firstWhere(
  (e) => e > 10,
  orElse: () => -1,
);
```



#### 1️⃣8️⃣ `fold()` ⭐（高级）

```dart
var sum = set.fold(0, (prev, e) => prev + e);
```

* 累加 / 聚合
* 面试加分项



#### 1️⃣9️⃣ `reduce()`

```dart
var sum = set.reduce((a, b) => a + b);
```

* 类似 `fold`
* ⚠️ Set 不能为空



#### 七、转换类方法（Convert）

#### 2️⃣0️⃣ `toList()`

```dart
var list = set.toList();
```



#### 2️⃣1️⃣ `toSet()`

```dart
var newSet = set.toSet();
```

* 一般用于复制



#### 2️⃣2️⃣ `join(String separator)`

```dart
var s = {'a', 'b', 'c'};
print(s.join('-')); // a-b-c
```



#### 八、集合运算（🔥 Set 的灵魂）

#### 2️⃣3️⃣ `union(Set other)`

```dart
set1.union(set2);
```

* 并集



#### 2️⃣4️⃣ `intersection(Set other)`

```dart
set1.intersection(set2);
```

* 交集



#### 2️⃣5️⃣ `difference(Set other)`

```dart
set1.difference(set2);
```

* 差集（在 set1 中但不在 set2）


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



# 十四、一句话总结（记忆版）

> **Set = 天然去重 + 集合运算 + 高效 contains**
