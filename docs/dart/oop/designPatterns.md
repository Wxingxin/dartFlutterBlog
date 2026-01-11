下面给你一份 **Dart 中 class 的设计模式（Design Patterns）** 的**知识点大全 + 使用大全**，**完全站在 Dart / Flutter 实战角度**来讲，不是教条式 OO 理论。

我会重点覆盖你点名的 **Singleton / Factory / Observer**，并补充 **Flutter 中最常用、最值得学的模式**，同时告诉你 **什么时候该用、什么时候千万别用**。

---

# 一、设计模式在 Dart 中的定位（先立正确认知）

一句大实话：

> **在 Dart / Flutter 中，设计模式是“解决结构问题的工具”，不是“必须背的套路”。**

你用设计模式，通常是为了解决这 4 类问题：

1. **对象怎么创建**（Creation）
2. **对象怎么协作**（Behavior）
3. **对象怎么组合**（Structure）
4. **如何解耦、扩展、不改老代码**（架构）

---

# 二、Singleton（单例模式）✅ 必会

## 1️⃣ 单例在 Dart 中的正确打开方式

### ✅ 推荐方式：factory 构造函数（官方推荐）

```dart
class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  String env = 'prod';
}
```

使用：

```dart
final a = AppConfig();
final b = AppConfig();

print(identical(a, b)); // true
```

---

## 2️⃣ 为什么用 factory？

* `factory` **可以返回已有实例**
* 不强制每次 new 一个对象
* 天然支持单例

---

## 3️⃣ 常见使用场景

✅ 配置
✅ 日志
✅ 全局服务
✅ SDK 包装类

```dart
class Logger {
  static final Logger _instance = Logger._();
  factory Logger() => _instance;
  Logger._();

  void log(String msg) => print(msg);
}
```

---

## 4️⃣ ❌ 不推荐的单例写法

```dart
static Logger instance = Logger(); // ❌ 可被重置
```

---

## 5️⃣ 单例的注意点（面试常问）

* ❌ 滥用 = 隐式全局变量
* ❌ 不利于测试（Mock 困难）
* ✅ 适合 **无状态 / 全局唯一**

---

# 三、Factory（工厂模式）🔥 Dart 非常强

## 1️⃣ 简单工厂（最常见）

```dart
abstract class Shape {
  double area();
}
```

```dart
class Circle extends Shape {
  final double r;
  Circle(this.r);
  @override
  double area() => 3.14 * r * r;
}
```

```dart
class Square extends Shape {
  final double side;
  Square(this.side);
  @override
  double area() => side * side;
}
```

```dart
class ShapeFactory {
  static Shape create(String type) {
    switch (type) {
      case 'circle':
        return Circle(10);
      case 'square':
        return Square(5);
      default:
        throw Exception('Unknown shape');
    }
  }
}
```

📌 **创建逻辑与使用逻辑解耦**

---

## 2️⃣ factory 构造函数版（Dart 特有）

```dart
abstract class Logger {
  void log(String msg);

  factory Logger(String type) {
    if (type == 'file') return FileLogger();
    return ConsoleLogger();
  }
}
```

📌 **隐藏具体实现**

---

## 3️⃣ 工厂模式的使用信号

✅ `if / switch` 在 new 对象
✅ 调用方不关心具体类型
✅ 未来会扩展

---

## 4️⃣ ❌ 什么时候不要用工厂

* 类型固定
* 没有变化点
* 代码更绕

---

# 四、Observer（观察者模式）🔥 Flutter 核心思想

## 1️⃣ 经典 Observer 模式（手写版）

```dart
abstract class Observer {
  void update(String msg);
}
```

```dart
class Subject {
  final List<Observer> _observers = [];

  void add(Observer o) => _observers.add(o);
  void remove(Observer o) => _observers.remove(o);

  void notify(String msg) {
    for (final o in _observers) {
      o.update(msg);
    }
  }
}
```

```dart
class UserObserver implements Observer {
  @override
  void update(String msg) {
    print('收到：$msg');
  }
}
```

---

## 2️⃣ Dart / Flutter 中的真实 Observer

你天天在用：

```dart
ValueNotifier<int> counter = ValueNotifier(0);

counter.addListener(() {
  print(counter.value);
});
```

📌 Flutter **本质是 Observer + Reactive**

---

## 3️⃣ Stream = Observer 的进化版

```dart
StreamController<int> controller = StreamController();

controller.stream.listen((value) {
  print(value);
});
```

📌 实战中 **优先用 Stream / ChangeNotifier**

---

## 4️⃣ 什么时候用 Observer？

✅ 状态变化 → 多方响应
✅ UI 自动刷新
❌ 复杂业务流程（容易失控）

---

# 五、Strategy（策略模式）⭐ 超高频

```dart
abstract class PaymentStrategy {
  void pay(double amount);
}
```

```dart
class Alipay implements PaymentStrategy {
  @override
  void pay(double amount) {}
}
```

```dart
class Context {
  final PaymentStrategy strategy;
  Context(this.strategy);

  void execute(double amount) {
    strategy.pay(amount);
  }
}
```

📌 **if-else 的终结者**

---

# 六、Decorator（装饰器模式）⭐ 很适合 Dart

```dart
abstract class Coffee {
  double cost();
}
```

```dart
class SimpleCoffee implements Coffee {
  @override
  double cost() => 10;
}
```

```dart
class MilkDecorator implements Coffee {
  final Coffee coffee;
  MilkDecorator(this.coffee);

  @override
  double cost() => coffee.cost() + 2;
}
```

```dart
final coffee = MilkDecorator(SimpleCoffee());
```

📌 Dart 没有 Java 注解，但 **组合非常优雅**

---

# 七、Builder（建造者模式）⭐ 用于复杂对象

```dart
class User {
  final String name;
  final int age;
  final String? email;

  User._(this.name, this.age, this.email);

  factory User.build(void Function(UserBuilder) fn) {
    final builder = UserBuilder();
    fn(builder);
    return User._(builder.name!, builder.age!, builder.email);
  }
}
```

---

# 八、Dart / Flutter 中最实用的模式总结表

| 模式        | 是否必会 | 常见位置                 |
| --------- | ---- | -------------------- |
| Singleton | ✅    | 配置 / Logger          |
| Factory   | ✅    | Repository / Service |
| Observer  | ✅    | UI / 状态              |
| Strategy  | ✅    | 业务规则                 |
| Decorator | ⭐    | 功能增强                 |
| Builder   | ⭐    | 表单 / 配置              |

---

# 九、常见反模式（非常重要）

## ❌ 为了“用模式而用模式”

```dart
class XxxFactoryBuilderSingleton {} // ❌
```

---

## ❌ 全局 Singleton 泛滥

👉 会变成 **隐式依赖地狱**

---

## ❌ Observer 嵌套 Observer

👉 状态流向不清晰

---

# 十、面试级总结（背下来）

> **Dart 的设计模式更偏向“组合 + 接口 + factory + reactive”，而不是传统 Java 的继承体系。用模式解决变化点，而不是炫技。**

---

# 十一、下一步我可以直接带你做（强烈推荐）

你现在已经到 **OOP → 架构过渡期**，我可以直接帮你做👇

🔥 **Flutter 项目中真实的 Repository + Factory + Strategy 架构图**
🔥 **把一坨 if-else 重构成设计模式（完整实战）**
🔥 **设计模式面试题：什么时候“不要用设计模式”**

你选一个，我直接带你打到**架构级理解**。
