下面给你一份 **Dart 中 Abstract Class（抽象类）** 的**系统知识点大全 + 使用大全**。我会按「是什么 → 能干什么 → 怎么用 → 什么时候用 → 常见坑」的顺序来讲，适合你现在这种**系统学 Dart / Flutter 的阶段**。

---

# 一、什么是 Abstract Class（抽象类）

**抽象类 = 不能被直接实例化的类，用来定义“规范 / 模板”**

👉 它关注的是：
**“这个类的子类必须具备哪些能力”**，而不是“这个类如何被创建”。

```dart
abstract class Animal {
  void speak();
}
```

❌ 不能这样用：

```dart
final a = Animal(); // ❌ 编译错误
```

✅ 只能被继承：

```dart
class Dog extends Animal {
  @override
  void speak() {
    print('汪汪');
  }
}
```

---

# 二、抽象类的核心特性（必背）

## 1️⃣ 不能被实例化

```dart
abstract class A {}
A a = A(); // ❌
```

---

## 2️⃣ 可以包含「抽象方法」

**抽象方法：只有声明，没有实现**

```dart
abstract class Shape {
  double area(); // 抽象方法
}
```

* 子类 **必须实现**
* 否则子类也必须是 `abstract`

---

## 3️⃣ 可以包含「普通方法（已实现）」

```dart
abstract class Animal {
  void eat() {
    print('吃东西');
  }

  void speak(); // 抽象方法
}
```

👉 抽象类 ≠ 全部抽象
👉 **抽象类 = 抽象方法 + 已实现方法**

---

## 4️⃣ 可以包含字段（属性）

```dart
abstract class Person {
  final String name;
  int age;

  Person(this.name, this.age);
}
```

* 抽象类**可以有构造函数**
* 但构造函数只能被子类调用

---

## 5️⃣ 可以有构造函数（非常重要）

```dart
abstract class Animal {
  final String type;

  Animal(this.type);
}

class Dog extends Animal {
  Dog() : super('dog');
}
```

📌 抽象类构造函数的作用：
**给子类提供通用初始化逻辑**

---

# 三、抽象类 vs 普通 class

| 对比点      | abstract class | 普通 class |
| -------- | -------------- | -------- |
| 能否实例化    | ❌ 不可以          | ✅ 可以     |
| 是否可含抽象方法 | ✅ 可以           | ❌ 不可以    |
| 是否可含普通方法 | ✅ 可以           | ✅        |
| 是否可含字段   | ✅              | ✅        |
| 是否可被继承   | ✅              | ✅        |

---

# 四、抽象类 vs interface（implements）

⚠️ Dart **没有 interface 关键字**

👉 **任何 class / abstract class 都可以当接口用**

---

## extends（继承）

```dart
abstract class Animal {
  void speak();
}

class Dog extends Animal {
  @override
  void speak() {}
}
```

特点：

* 只能 `extends` 一个类
* 可以复用父类代码

---

## implements（实现接口）

```dart
abstract class Flyable {
  void fly();
}

class Bird implements Flyable {
  @override
  void fly() {
    print('飞');
  }
}
```

特点：

* 可以 `implements` 多个
* **必须实现所有方法**
* 不继承任何实现

---

### extends vs implements（面试常考）

| 对比      | extends | implements |
| ------- | ------- | ---------- |
| 代码复用    | ✅       | ❌          |
| 多继承     | ❌       | ✅          |
| 必须实现父方法 | ❌（可选）   | ✅（全部）      |

---

# 五、抽象类的典型使用场景（重点）

## ✅ 场景 1：定义业务规范（强烈推荐）

```dart
abstract class Repository<T> {
  T getById(String id);
  void save(T item);
}
```

```dart
class UserRepository extends Repository<User> {
  @override
  User getById(String id) {}

  @override
  void save(User item) {}
}
```

📌 常见于：

* 数据层（Repository）
* 服务层（Service）
* 插件抽象

---

## ✅ 场景 2：Flutter 中的架构设计

```dart
abstract class BaseViewModel {
  void init();
  void dispose();
}
```

```dart
class HomeViewModel extends BaseViewModel {
  @override
  void init() {}

  @override
  void dispose() {}
}
```

---

## ✅ 场景 3：多态（Polymorphism）

```dart
abstract class Shape {
  double area();
}

class Circle extends Shape {
  final double r;
  Circle(this.r);

  @override
  double area() => 3.14 * r * r;
}

class Square extends Shape {
  final double side;
  Square(this.side);

  @override
  double area() => side * side;
}
```

```dart
void printArea(Shape shape) {
  print(shape.area());
}
```

📌 调用者不关心具体实现，只关心“能力”

---

## ✅ 场景 4：模板方法模式（高级）

```dart
abstract class Task {
  void execute() {
    prepare();
    run();
    finish();
  }

  void prepare();
  void run();
  void finish();
}
```

子类只管实现步骤：

```dart
class DownloadTask extends Task {
  @override
  void prepare() {}

  @override
  void run() {}

  @override
  void finish() {}
}
```

---

# 六、抽象类 + factory（高频组合）

```dart
abstract class Logger {
  void log(String msg);

  factory Logger(String type) {
    if (type == 'file') {
      return FileLogger();
    }
    return ConsoleLogger();
  }
}
```

```dart
class FileLogger implements Logger {
  @override
  void log(String msg) {}
}

class ConsoleLogger implements Logger {
  @override
  void log(String msg) {}
}
```

📌 抽象类 + factory = **隐藏实现细节**

---

# 七、常见错误 & 坑（非常重要）

## ❌ 忘记实现抽象方法

```dart
class Dog extends Animal {} // ❌
```

✅ 必须：

```dart
class Dog extends Animal {
  @override
  void speak() {}
}
```

---

## ❌ 抽象类中使用 new / 实例化

```dart
abstract class A {
  A() {
    // ❌ 不要在这里创建实例
  }
}
```

---

## ❌ 把抽象类当工具类用

👉 如果只是放 `static` 方法
👉 **请用普通 class + 私有构造函数**

---

# 八、abstract class vs mixin（顺便帮你理清）

| 对比          | abstract class | mixin |
| ----------- | -------------- | ----- |
| 是否可构造       | ✅              | ❌     |
| 是否可被实例化     | ❌              | ❌     |
| 是否可 extends | ✅              | ❌     |
| 是否可 with    | ❌              | ✅     |
| 适合场景        | 模板 / 规范        | 行为复用  |

---

# 九、一句话总结（给你背的）

> **abstract class 是 Dart 中定义“能力规范 + 部分实现”的核心工具，用于多态、架构设计和业务约束，是 Flutter 项目必会内容。**

---

如果你愿意，下一步我可以帮你直接做这几件事之一（很适合你现在）👇

* 🔥 **abstract class vs interface vs mixin 深度对比 + 项目选型**
* 🔥 **Flutter 项目中 BasePage / BaseViewModel 的真实抽象设计**
* 🔥 **一道面试级抽象类设计题（含标准答案）**

你选一个，我直接带你进阶。
