下面我给你一份 **Dart 中 class 的 Polymorphism（多态）** 的**系统知识点大全 + 使用大全**。这部分是 **OOP 的灵魂**，也是 **Flutter / 架构 / 面试** 必考内容。我会用你熟悉的 Dart 语法，一步一步把“为什么、怎么用、什么时候用、常见坑”讲透。

---

# 一、什么是 Polymorphism（多态）

**一句话定义：**

> **多态 = 同一个父类型引用，在运行时表现出不同子类行为**

👉 **“接口统一，实现多样”**

---

## 最经典的一句话代码

```dart
Shape shape = Circle(10);
print(shape.area());
```

* `shape` 的**静态类型**：`Shape`
* 实际对象：`Circle`
* 调用的是 `Circle.area()`

👉 这就是 **运行时多态**

---

# 二、多态的三个前提（缺一不可）

### 1️⃣ 有父类型（abstract class / interface）

```dart
abstract class Shape {
  double area();
}
```

---

### 2️⃣ 有子类实现（extends / implements）

```dart
class Circle extends Shape {
  final double r;
  Circle(this.r);

  @override
  double area() => 3.14 * r * r;
}
```

---

### 3️⃣ 父类型引用指向子类对象

```dart
Shape s = Circle(5);
```

---

# 三、Dart 中多态的实现方式（全）

## ✅ 方式 1：abstract class + extends（最常见）

```dart
abstract class Animal {
  void speak();
}

class Dog extends Animal {
  @override
  void speak() => print('汪');
}

class Cat extends Animal {
  @override
  void speak() => print('喵');
}
```

```dart
void makeSound(Animal animal) {
  animal.speak(); // 多态
}
```

---

## ✅ 方式 2：implements（接口多态）

```dart
abstract class Flyable {
  void fly();
}

class Bird implements Flyable {
  @override
  void fly() => print('飞');
}
```

📌 适合 **能力型多态**

---

## ✅ 方式 3：mixin（行为多态）

```dart
mixin Logger {
  void log(String msg) {
    print('[LOG] $msg');
  }
}

class ApiService with Logger {}
class DbService with Logger {}
```

👉 多个类共享同一行为

---

# 四、方法重写（Override）是多态的核心

## 1️⃣ 正确重写

```dart
class Dog extends Animal {
  @override
  void speak() {}
}
```

---

## 2️⃣ 规则（必须记住）

| 规则    | 说明     |
| ----- | ------ |
| 方法名一致 | 必须     |
| 参数类型  | 相同或更宽  |
| 返回类型  | 相同或更具体 |
| 可见性   | 不能更私有  |

---

## 3️⃣ 调用父类方法

```dart
class Dog extends Animal {
  @override
  void speak() {
    super.speak(); // 如果父类有实现
    print('汪');
  }
}
```

---

# 五、运行时多态 vs 编译期多态（易混点）

## Dart 只有「运行时多态」

❌ Dart **没有方法重载（Overloading）**

```dart
void foo(int a) {}
void foo(String a) {} // ❌ 不允许
```

---

## 可选参数 ≠ 多态

```dart
void foo([int? a]) {}
```

这是语法特性，不是多态

---

# 六、多态 + 集合（超级常见）

```dart
List<Shape> shapes = [
  Circle(3),
  Square(4),
];

for (final s in shapes) {
  print(s.area());
}
```

📌 你写的是 **父类型**
📌 实际执行的是 **子类实现**

---

# 七、多态的典型使用场景（实战）

## ✅ 场景 1：业务规则抽象（强烈推荐）

```dart
abstract class Payment {
  void pay(double amount);
}

class Alipay extends Payment {
  @override
  void pay(double amount) {}
}

class WechatPay extends Payment {
  @override
  void pay(double amount) {}
}
```

```dart
void process(Payment payment) {
  payment.pay(100);
}
```

📌 新增支付方式 **无需改原逻辑**

---

## ✅ 场景 2：Flutter Widget / State（你每天都在用）

```dart
Widget build(BuildContext context) {
  return Text('hello');
}
```

* `Widget` 是父类型
* `Text / Column / Row` 都是子类
* Flutter 框架 **全靠多态**

---

## ✅ 场景 3：策略模式（面试高频）

```dart
abstract class SortStrategy {
  void sort(List<int> list);
}
```

```dart
class QuickSort implements SortStrategy {
  @override
  void sort(List<int> list) {}
}
```

```dart
class Context {
  final SortStrategy strategy;
  Context(this.strategy);

  void execute(List<int> list) {
    strategy.sort(list);
  }
}
```

---

## ✅ 场景 4：解耦（非常重要）

```dart
class UserService {
  final UserRepository repo;
  UserService(this.repo);
}
```

📌 依赖抽象，不依赖实现（DIP）

---

# 八、is / as / 多态（必须会）

## 1️⃣ is 判断类型

```dart
if (animal is Dog) {
  animal.bark();
}
```

---

## 2️⃣ as 强制转换（慎用）

```dart
(animal as Dog).bark();
```

⚠️ 错了直接崩

---

## 3️⃣ 正确思路

👉 **能用多态，就不要用 is / as**

---

# 九、常见误区（你一定要避开）

## ❌ 把 if-else 当多态用

```dart
if (type == 'dog') {}
else if (type == 'cat') {}
```

👉 这是反多态

---

## ❌ 父类写太多实现，子类被迫继承

👉 父类要 **稳定 + 抽象**

---

## ❌ 子类新增方法，父类引用用不到

```dart
Animal a = Dog();
a.bark(); // ❌
```

👉 父类不知道 bark 的存在

---

# 十、多态 + abstract class + mixin 的终极组合

```dart
abstract class Vehicle {
  void move();
}

mixin Fuel {
  void refuel() {}
}

class Car extends Vehicle with Fuel {
  @override
  void move() {}
}
```

📌 **身份：Vehicle**
📌 **能力：Fuel**

---

# 十一、一句话总结（帮你记住）

> **多态是通过“父类型引用 + 子类实现 + 方法重写”实现的运行时行为差异，是 Dart / Flutter 架构解耦的核心机制。**

---

如果你愿意，下一步我可以直接帮你做👇

* 🔥 **Flutter 中多态如何支撑整个 Widget 系统**
* 🔥 **一道“反 if-else”的多态重构实战**
* 🔥 **面试官最爱问的多态陷阱题 + 标准答案**

你选一个，我带你继续打进阶。
