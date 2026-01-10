## 构造函数

### 构造函数的作用是什么？

在 Dart 中，构造函数（Constructor） 的作用就是：

✅ 当你“创建对象”的时候，自动执行一些初始化操作。

## 一、什么是 Dart 的默认构造函数

**默认构造函数 = 未命名构造函数（Unnamed Constructor）**

* **构造函数名 = 类名**
* **没有返回值类型**
* 用于创建类的实例、初始化对象状态

```dart
class User {
  User(); // 这就是默认构造函数
}
```

---

# 二、隐式默认构造函数（最容易忽略的点）

### 1️⃣ 什么是「隐式默认构造函数」

当你**完全没有写任何构造函数**时：

```dart
class Person {
  String name = "";
}
```

Dart 会**自动生成**一个：

```dart
Person();
```

等价于：

```dart
final p = Person();
```

### 2️⃣ 重要规则（考试 + 面试常考）

> ❗ **只要你写了任意一个构造函数，隐式默认构造函数就不会再生成**

```dart
class A {
  A.named(); // 一旦你写了这个
}
```

下面代码就 ❌ 报错：

```dart
A a = A(); // Error：没有无参默认构造函数
```

✅ 正确做法：**你要自己补一个**

```dart
class A {
  A();        // 显式默认构造
  A.named();
}
```

---

# 三、显式默认构造函数（你最常写的）

### 1️⃣ 无参默认构造

```dart
class Logger {
  Logger() {
    print("Logger created");
  }
}
```

使用：

```dart
final l = Logger();
```

---

### 2️⃣ 带参数的默认构造函数

```dart
class User {
  String name;
  int age;

  User(String name, int age) {
    this.name = name;
    this.age = age;
  }
}
```

---

# 四、默认构造函数 + `this` 语法糖（最常用）

### 1️⃣ 基本写法（强烈推荐）

```dart
class User {
  final String name;
  final int age;

  User(this.name, this.age);
}
```

等价于：

```dart
User(String name, int age)
    : name = name,
      age = age;
```

---

### 2️⃣ 命名参数版（业务中最推荐）

```dart
class Config {
  final String baseUrl;
  final int timeout;

  Config({
    required this.baseUrl,
    this.timeout = 5000,
  });
}
```

使用：

```dart
final c = Config(baseUrl: "https://api.xxx.com");
```

---

# 五、默认构造函数支持的参数形式（完整汇总）

| 参数类型        | 语法                                | 是否常用       |
| ----------- | --------------------------------- | ---------- |
| 必填位置参数      | `User(this.name, this.age)`       | ⚠️ 一般      |
| 可选位置参数      | `User(this.name, [this.age = 0])` | ❌ 少用       |
| 命名参数        | `User({required this.name})`      | ✅ **强烈推荐** |
| 默认值         | `this.age = 18`                   | ✅          |
| nullable 参数 | `String? name`                    | ✅          |

---

# 六、默认构造函数 + 初始化列表（重点）

### 1️⃣ 为什么要初始化列表

* `final` 字段必须在构造阶段完成初始化
* 构造函数体 `{}` 执行时已经 **太晚了**

### 2️⃣ 示例

```dart
class Order {
  final List<int> items;
  final int total;

  Order(List<int> items)
      : items = List.unmodifiable(items),
        total = items.fold(0, (sum, e) => sum + e);
}
```

---

### 3️⃣ 初始化列表中的 `assert`

```dart
class Range {
  final int min;
  final int max;

  Range(this.min, this.max)
      : assert(min <= max, "min must <= max");
}
```

---

# 七、默认构造函数 + 继承（super）

### 1️⃣ 子类必须调用父类构造

```dart
class Animal {
  final String name;
  Animal(this.name);
}

class Dog extends Animal {
  final int age;

  Dog(String name, this.age) : super(name);
}
```

---

### 2️⃣ 执行顺序（很重要）

1. 父类初始化列表
2. 父类构造函数体
3. 子类初始化列表
4. 子类构造函数体

---

# 八、默认构造函数的访问控制

### 1️⃣ 默认构造是 public

```dart
class A {
  A();
}
```

外部可：

```dart
A();
```

---

### 2️⃣ 私有默认构造（限制外部创建）

```dart
class Singleton {
  Singleton._();

  static final Singleton instance = Singleton._();
}
```

外部 ❌：

```dart
Singleton(); // Error
```

---

# 九、默认构造函数常见错误（必踩坑）

### ❌ 1. 写了命名构造却忘了补默认构造

```dart
class User {
  User.fromJson(Map json);
}

User(); // ❌
```

---

### ❌ 2. final 字段在构造体中赋值

```dart
class A {
  final int x;

  A() {
    x = 1; // ❌
  }
}
```

✅ 正确：

```dart
A() : x = 1;
```

---

### ❌ 3. super 写在函数体中

```dart
Dog() {
  super(); // ❌
}
```

✅ 正确：

```dart
Dog() : super();
```

---

# 十、真实项目中的默认构造使用建议（经验总结）

✅ **模型类（Model）**

```dart
const User({required this.id, required this.name});
```

✅ **配置类**

```dart
Config({required this.env, this.debug = false});
```

✅ **Widget（Flutter）**

```dart
const MyWidget({super.key, required this.title});
```

❌ 避免使用大量位置参数
❌ 避免构造函数里写复杂逻辑

---

# 十一、一句话总结（记住这几条就够了）

* 默认构造函数 = **未命名构造**
* 不写构造 → Dart 自动给你一个无参默认构造
* 一旦写了构造 → **必须自己写默认构造**
* `this.xxx` 是最常用、最干净的写法
* `final` 字段 → **初始化列表**
* 子类构造 → `: super(...)`

# 命名构造函数

下面我**只专讲 Dart 的 class「命名构造函数（Named Constructors）」**，从**语法规则 → 使用场景 → 初始化细节 → fromJson / empty 等经典套路 → 易错点 → 项目级最佳实践**，一次讲透。
你可以把这一篇当成 **Dart 命名构造函数的完整参考手册**。

---

# 一、什么是命名构造函数（Named Constructor）

### 1️⃣ 定义

> **命名构造函数 = 在类名后加一个点和名字的构造函数**

```dart
class User {
  User.guest();
}
```

调用：

```dart
final u = User.guest();
```

### 2️⃣ 为什么要用命名构造函数

* 一个类**有多种“创建语义”**
* 避免构造函数参数过多
* 提升可读性（比传一堆 bool 强太多）

❌ 不推荐：

```dart
User(true, false, true);
```

✅ 推荐：

```dart
User.guest();
User.admin();
User.fromJson(json);
```

---

# 二、基本语法规则（必须记住）

### 1️⃣ 基本语法

```dart
class ClassName {
  ClassName.name(parameters);
}
```

### 2️⃣ 关键规则

* ❌ **没有返回值**
* ❌ **不能用 `static`**
* ✔ 可以有参数
* ✔ 可以有初始化列表 `:`
* ✔ 可以调用 `super(...)`
* ✔ 可以重定向到其他构造函数

---

# 三、命名构造函数 vs 默认构造函数

```dart
class User {
  User();        // 默认构造
  User.guest();  // 命名构造
}
```

❗**只要你写了构造函数，隐式默认构造就不存在**

---

# 四、最常见的 5 类命名构造函数（重点）

---

## 1️⃣ `empty / default / init`：空对象 / 默认对象

```dart
class Profile {
  final String name;
  final String avatar;

  Profile(this.name, this.avatar);

  Profile.empty()
      : name = "",
        avatar = "";
}
```

使用：

```dart
final p = Profile.empty();
```

适用：

* 表单初始值
* UI 占位对象
* 避免 null

---

## 2️⃣ `fromJson`：JSON → 对象（非 factory）

```dart
class User {
  final String id;
  final String name;

  User({required this.id, required this.name});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"] as String,
        name = json["name"] as String;
}
```

使用：

```dart
final u = User.fromJson(json);
```

📌 特点：

* **一定创建新对象**
* 逻辑简单、性能好
* 最常见写法

---

## 3️⃣ `copy / clone`：拷贝构造（Dart 没有内建）

```dart
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  User.copy(User other)
      : name = other.name,
        age = other.age;
}
```

---

## 4️⃣ `guest / admin / dev`：特定身份 / 环境

```dart
class Account {
  final String role;
  final bool canEdit;

  Account(this.role, this.canEdit);

  Account.guest() : this("guest", false);
  Account.admin() : this("admin", true);
}
```

---

## 5️⃣ `withXxx`：语义化构造（配置型）

```dart
class HttpConfig {
  final String baseUrl;
  final int timeout;

  HttpConfig(this.baseUrl, this.timeout);

  HttpConfig.withTimeout(String baseUrl)
      : this(baseUrl, 3000);
}
```

---

# 五、命名构造函数 + 初始化列表（必会）

### 1️⃣ 基本形式

```dart
Class.name(params)
    : field1 = expr,
      field2 = expr;
```

### 2️⃣ final 字段只能在这里赋值

```dart
class Order {
  final int total;

  Order.fromItems(List<int> items)
      : total = items.fold(0, (a, b) => a + b);
}
```

---

### 3️⃣ 参数校验（assert）

```dart
class Range {
  final int min;
  final int max;

  Range.between(this.min, this.max)
      : assert(min <= max);
}
```

---

# 六、命名构造函数的重定向（Redirecting）

### 1️⃣ 语法

```dart
Class.name(...) : this(...);
```

### 2️⃣ 示例

```dart
class Env {
  final String name;
  final bool debug;

  Env(this.name, this.debug);

  Env.dev() : this("dev", true);
  Env.prod() : this("prod", false);
}
```

📌 规则：

* 重定向构造函数 **不能有函数体**
* 只能调用同一个类的其他构造函数

---

# 七、命名构造函数 + 继承（super）

```dart
class Animal {
  final String name;
  Animal(this.name);
}

class Dog extends Animal {
  final int age;

  Dog.fromJson(Map<String, dynamic> json)
      : age = json["age"],
        super(json["name"]);
}
```

📌 `super(...)` 必须写在初始化列表中

---

# 八、命名构造函数 vs factory 构造函数（关键区别）

| 对比项        | 命名构造           | factory 命名构造 |
| ---------- | -------------- | ------------ |
| 是否 new 对象  | ✅ 一定           | ❌ 不一定        |
| 是否能返回缓存    | ❌              | ✅            |
| 是否能返回子类    | ❌              | ✅            |
| 是否能返回 null | ❌              | ❌            |
| 常见用途       | fromJson、empty | 多态、单例、缓存     |

---

# 九、私有命名构造函数（_）

```dart
class Cache {
  Cache._internal();

  static final Cache instance = Cache._internal();
}
```

📌 用途：

* 限制外部创建
* 单例 / 工厂控制入口

---

# 十、常见错误（你一定会踩）

### ❌ 1. 以为命名构造是静态方法

```dart
User.fromJson(); // ❌ 不是 static
```

---

### ❌ 2. 构造函数写 return

```dart
User.empty() {
  return User(); // ❌
}
```

---

### ❌ 3. 忘记补默认构造

```dart
class A {
  A.named();
}

A(); // ❌
```

---

# 十一、项目级最佳实践（很重要）

### ✅ 命名规范

* `fromJson`
* `empty`
* `copy`
* `guest / admin`
* `dev / prod`

### ✅ 数据模型推荐结构

```dart
class Model {
  const Model({...});

  const Model.empty();

  factory Model.fromJson(Map<String, dynamic> json);

  Model copyWith({...});
}
```

---

# 十二、一句话总结

* 命名构造函数 = **有语义的构造入口**
* 用来表达 **“怎么创建这个对象”**
* `fromJson` / `empty` 是最常用
* `:` 初始化列表是灵魂
* 复杂逻辑 → `factory`
* 多构造共用逻辑 → 重定向 `this(...)`

---

如果你愿意，下一步我可以：

* **把命名构造 + factory 的使用边界画成一张“决策图”**
* **结合 Flutter Widget 构造（const / key / 命名构造）**
* **直接给你一套 AI 私人助手项目里的 Model 标准模板**

你说继续哪一块，我直接深入。


