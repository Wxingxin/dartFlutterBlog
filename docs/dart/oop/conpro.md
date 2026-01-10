下面是一份**“Dart 中 class 构造函数大全（完整版）”**，按**从基础到进阶、从语法到设计模式**系统整理，覆盖你在 **Flutter / Dart 实战与面试**中几乎所有会遇到的构造函数写法。

---

## 一、默认 / 普通构造函数

### 1️⃣ 隐式默认构造函数

```dart
class Person {}
```

等价于：

```dart
class Person {
  Person();
}
```

---

### 2️⃣ 显式无参构造函数

```dart
class Person {
  Person();
}
```

---

### 3️⃣ 带参数构造函数

```dart
class Person {
  String name;
  int age;

  Person(String name, int age) {
    this.name = name;
    this.age = age;
  }
}
```

---

### 4️⃣ 构造函数参数简写（最常用）

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);
}
```

---

## 二、命名构造函数（Named Constructor）

### 5️⃣ 命名构造函数

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);
  Person.anonymous() : name = '匿名', age = 0;
}
```

用途：

* 多种创建方式
* 语义更清晰

---

### 6️⃣ 命名构造函数 + 参数

```dart
Person.withName(String name)
    : name = name,
      age = 0;
```

---

## 三、初始化列表（Initializer List）

### 7️⃣ 初始化列表

```dart
class Point {
  final int x;
  final int y;

  Point(int x, int y)
      : x = x,
        y = y;
}
```

适用：

* `final` 字段
* 父类初始化
* 计算属性

---

### 8️⃣ 初始化表达式

```dart
class User {
  final String id;

  User(String name) : id = name.toUpperCase();
}
```

---

## 四、构造函数重定向（Redirecting Constructor）

### 9️⃣ 构造函数重定向

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);
  Person.withName(String name) : this(name, 0);
}
```

作用：

* 避免重复逻辑

---

## 五、`const` 构造函数

### 🔟 `const` 构造函数

```dart
class Point {
  final int x;
  final int y;

  const Point(this.x, this.y);
}
```

条件：

* 所有字段 `final`
* 构造函数体为空

Flutter 中非常重要。

---

## 六、`factory` 构造函数（重点）

### 1️⃣1️⃣ 基本 `factory`

```dart
class Logger {
  factory Logger() {
    return Logger._internal();
  }

  Logger._internal();
}
```

---

### 1️⃣2️⃣ 单例模式

```dart
class Cache {
  static final Cache _instance = Cache._();
  factory Cache() => _instance;
  Cache._();
}
```

---

### 1️⃣3️⃣ 根据条件返回不同实例

```dart
factory Shape.create(String type) {
  if (type == 'circle') return Circle();
  return Square();
}
```

---

### 1️⃣4️⃣ `fromJson` 工厂构造（最常见）

```dart
class User {
  final String name;

  User(this.name);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['name']);
  }
}
```

---

## 七、私有构造函数

### 1️⃣5️⃣ 私有构造函数

```dart
class Utils {
  Utils._();
}
```

用途：

* 禁止外部实例化
* 配合 `static` 使用

---

## 八、继承中的构造函数

### 1️⃣6️⃣ 调用父类构造函数

```dart
class Animal {
  Animal(String name);
}

class Dog extends Animal {
  Dog() : super('dog');
}
```

---

### 1️⃣7️⃣ 父类命名构造函数

```dart
Dog() : super.named();
```

---

## 九、`late` 与构造函数

### 1️⃣8️⃣ 构造中初始化 `late`

```dart
class Session {
  late String token;

  Session() {
    token = 'abc';
  }
}
```

---

## 十、Dart 3 补充（进阶）

### 1️⃣9️⃣ `sealed / base class` 的构造

```dart
sealed class Result {
  const Result();
}

final class Success extends Result {
  const Success();
}
```

---

## 十一、构造函数能力对比表（速查）

| 类型    | 关键字            |
| ----- | -------------- |
| 默认    | `Class()`      |
| 命名    | `Class.name()` |
| 简写    | `this.xxx`     |
| 初始化列表 | `:`            |
| 重定向   | `: this()`     |
| 常量    | `const`        |
| 工厂    | `factory`      |
| 私有    | `Class._()`    |
| 父类    | `super()`      |

---

## 十二、常见面试 / 实战总结

> **Dart 构造函数 = 初始化列表 + 命名 + factory**

Flutter 开发最常见组合：

```dart
class Model {
  final String id;

  const Model(this.id);

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(json['id']);
  }
}
```

---

如果你愿意，下一步我可以：

* 用 **一个类演示所有构造函数写法**
* 对比 **Dart 构造函数 vs TS / Java**
* 深挖 `factory` 和 `const` 的底层差异

你直接告诉我下一步想看哪一个。
