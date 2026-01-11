
# 一、什么是运算符重载（Operator Overloading）

**一句话定义：**

> **运算符重载 = 为自定义 class 定义运算符的行为**

让你写出：

```dart
final c = a + b;
```

而不是：

```dart
final c = a.add(b);
```

👉 **提升可读性 & 表达力**

---

# 二、Dart 运算符重载的基本规则（必背）

## 1️⃣ 使用 `operator` 关键字

```dart
class A {
  A operator +(A other) {
    return A();
  }
}
```

---

## 2️⃣ 只能重载 Dart 允许的运算符（不能自定义）

❌ 不允许：

```dart
operator **(); // ❌
```

---

## 3️⃣ 运算符本质是方法

```dart
a + b  ===  a.+(b)
```

---

# 三、Dart 允许重载的运算符（全集）

### 🔹 一元运算符（无参数）

| 运算符  | 方法名            |
| ---- | -------------- |
| `-a` | `operator -()` |
| `~a` | `operator ~()` |

---

### 🔹 二元运算符（1 个参数）

| 运算符                 |       |
| ------------------- | ----- |
| `+` `-` `*` `/` `%` |       |
| `&` `               | ` `^` |
| `<<` `>>`           |       |
| `<` `<=` `>` `>=`   |       |
| `==`                |       |

---

### 🔹 下标运算符

```dart
operator [](int index)
operator []=(int index, value)
```

---

# 四、最常用的运算符重载（重点）

## 1️⃣ 重载 `+`（最经典）

```dart
class Vector {
  final int x;
  final int y;

  Vector(this.x, this.y);

  Vector operator +(Vector other) {
    return Vector(x + other.x, y + other.y);
  }
}
```

```dart
final v1 = Vector(1, 2);
final v2 = Vector(3, 4);
final v3 = v1 + v2; // (4, 6)
```

---

## 2️⃣ 重载 `- * /`

```dart
Vector operator -(Vector o) => Vector(x - o.x, y - o.y);
Vector operator *(int n) => Vector(x * n, y * n);
```

---

## 3️⃣ 重载 `==`（⚠️ 必考）

```dart
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Point && x == other.x && y == other.y;
  }

  @override
  int get hashCode => Object.hash(x, y);
}
```

📌 **重写 `==` 必须同时重写 `hashCode`**

---

## 4️⃣ 重载 `< > <= >=`（用于排序）

```dart
class Score implements Comparable<Score> {
  final int value;

  Score(this.value);

  @override
  int compareTo(Score other) {
    return value.compareTo(other.value);
  }
}
```

```dart
list.sort(); // 自动使用 compareTo
```

📌 Dart 推荐用 `Comparable`，而不是单独重载 `<`

---

# 五、下标运算符（[]）—— 很实用

```dart
class MyList {
  final List<int> _data = [];

  int operator [](int index) => _data[index];
  void operator []=(int index, int value) {
    _data[index] = value;
  }
}
```

```dart
final l = MyList();
l[0] = 10;
print(l[0]);
```

---

# 六、一元运算符（了解）

```dart
class Flag {
  final int value;
  Flag(this.value);

  Flag operator ~() => Flag(~value);
}
```

---

# 七、运算符重载 + 不可变对象（最佳实践）

```dart
class Money {
  final double amount;
  const Money(this.amount);

  Money operator +(Money other) =>
      Money(amount + other.amount);
}
```

📌 推荐：

* 运算符重载 **返回新对象**
* 不要修改原对象（不可变）

---

# 八、真实项目中的使用场景

## ✅ 场景 1：数学 / 几何模型

```dart
Offset a + Offset b
```

👉 Flutter 官方大量使用

---

## ✅ 场景 2：值对象（Value Object）

```dart
Money total = price + tax - discount;
```

---

## ✅ 场景 3：集合包装类

```dart
matrix[i][j]
```

---

## ✅ 场景 4：DSL 风格 API（慎用）

```dart
query + filter - limit
```

---

# 九、运算符重载 vs 普通方法

| 对比     | 运算符重载 | 普通方法 |
| ------ | ----- | ---- |
| 可读性    | ⭐⭐⭐⭐⭐ | ⭐⭐   |
| 学习成本   | 高     | 低    |
| 滥用风险   | 高     | 低    |
| 适合数学语义 | ✅     | ❌    |

📌 **原则：语义直观才用运算符**

---

# 十、常见坑（一定要避开）

## ❌ 运算符语义不直观

```dart
a + b = 拼接字符串？发请求？ // ❌
```

---

## ❌ 忘记 hashCode

```dart
override bool operator ==(...) {}
// ❌ 没有 hashCode
```

---

## ❌ 修改自身状态

```dart
Vector operator +(Vector o) {
  x += o.x; // ❌
  return this;
}
```

---

## ❌ 重载太多运算符

👉 会严重降低可读性

---

# 十一、面试级总结（给你背）

> **Dart 的运算符重载本质是方法重写，适用于语义明确的值对象与数学模型，`==` 必须配合 `hashCode`，不可变对象是最佳实践。**

---

如果你愿意，下一步我可以继续帮你做👇

* 🔥 **设计一个 Money / Vector / Matrix 的完整运算符重载实战**
* 🔥 **Flutter 源码中运算符重载的真实案例拆解**
* 🔥 **一道“运算符重载设计是否合理”的面试判断题**

你选一个，我继续带你打到高手级。
