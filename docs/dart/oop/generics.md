下面给你一份 **Dart 中 class 的 Generics（泛型）** 的**系统知识点大全 + 使用大全**。我会按**从“为什么要泛型 → 语法 → 约束 → 进阶 → 实战 → 常见坑”**来讲，覆盖你在 **Dart / Flutter / 架构 / 面试** 中真正会用到的全部内容。

---

# 一、为什么需要 Generics（先想清楚动机）

没有泛型会怎样？

```dart
class Box {
  Object value;
  Box(this.value);
}
```

使用时：

```dart
final box = Box(123);
final v = box.value as int; // ⚠️ 强制转换，风险高
```

❌ 问题：

* 类型不安全
* 到处 `as`
* 运行时才发现错误

---

## 泛型的目标（一句话）

> **让类型在“编译期”就确定下来，既安全，又通用**

---

# 二、最基础：泛型类（Class Generics）

## 1️⃣ 定义泛型类

```dart
class Box<T> {
  final T value;
  Box(this.value);
}
```

使用：

```dart
final box1 = Box<int>(10);
final box2 = Box<String>('hello');
```

📌 `T` 是**类型参数（Type Parameter）**

---

## 2️⃣ 类型推断（常用）

```dart
final box = Box(123); // Dart 自动推断 T = int
```

---

# 三、泛型能用在 class 的哪些地方？

## ✅ 泛型字段

```dart
class Wrapper<T> {
  T data;
  Wrapper(this.data);
}
```

---

## ✅ 泛型方法

```dart
class Utils {
  T echo<T>(T value) {
    return value;
  }
}
```

```dart
Utils().echo<String>('hi');
```

---

## ✅ 泛型构造函数

```dart
class Pair<K, V> {
  final K key;
  final V value;
  Pair(this.key, this.value);
}
```

---

# 四、多泛型参数（非常常见）

```dart
class MapEntry<K, V> {
  final K key;
  final V value;
  MapEntry(this.key, this.value);
}
```

使用：

```dart
final entry = MapEntry<String, int>('age', 18);
```

📌 顺序固定：`<K, V>`

---

# 五、泛型约束（extends）（重点）

## 1️⃣ 为什么要约束？

```dart
class Printer<T> {
  void printValue(T value) {
    value.length; // ❌ 不知道 T 有没有 length
  }
}
```

---

## 2️⃣ 使用 extends 进行约束

```dart
class Printer<T extends String> {
  void printValue(T value) {
    print(value.length);
  }
}
```

📌 `T extends String`
👉 T **必须是 String 或其子类型**

---

## 3️⃣ 常见约束写法

```dart
class Repository<T extends BaseModel> {
  void save(T model) {}
}
```

```dart
abstract class BaseModel {
  String get id;
}
```

---

# 六、泛型 + 抽象类（架构必用）

```dart
abstract class Repository<T> {
  T getById(String id);
  void save(T entity);
}
```

```dart
class UserRepository extends Repository<User> {
  @override
  User getById(String id) => User(id);
}
```

📌 Flutter / Clean Architecture **核心组合**

---

# 七、泛型 + implements / mixin

## implements

```dart
abstract class Cache<T> {
  void put(String key, T value);
  T? get(String key);
}
```

```dart
class MemoryCache<T> implements Cache<T> {
  final Map<String, T> _map = {};

  @override
  void put(String key, T value) {
    _map[key] = value;
  }

  @override
  T? get(String key) => _map[key];
}
```

---

## mixin（带泛型）

```dart
mixin Loggable<T> {
  void log(T value) {
    print(value);
  }
}
```

```dart
class Service with Loggable<String> {}
```

---

# 八、泛型方法 vs 泛型类（必会区分）

## 泛型类

```dart
class Box<T> {
  T value;
  Box(this.value);
}
```

* 类型跟随实例
* 适合“容器”

---

## 泛型方法

```dart
T first<T>(List<T> list) {
  return list.first;
}
```

* 类型只在方法中生效
* 适合“工具方法”

---

# 九、类型擦除（Dart 的一个重要特性）

⚠️ Dart 的泛型在运行时 **部分擦除**

```dart
print(List<int> is List<String>); // true
```

📌 意味着：

* 运行时不能可靠判断泛型参数
* 不要写依赖 T 类型判断的逻辑

---

# 十、泛型 + factory（高级）

```dart
abstract class Serializer<T> {
  T fromJson(Map<String, dynamic> json);
}
```

```dart
class UserSerializer implements Serializer<User> {
  @override
  User fromJson(Map<String, dynamic> json) {}
}
```

📌 用于：

* JSON 解析
* 网络层封装

---

# 十一、Flutter 中的真实泛型场景

## 1️⃣ Widget 泛型（你天天在用）

```dart
class State<T extends StatefulWidget> {}
```

```dart
class _HomePageState extends State<HomePage> {}
```

---

## 2️⃣ Future / Stream（核心）

```dart
Future<int> fetchCount() async => 10;
Stream<String> messageStream;
```

---

## 3️⃣ ValueNotifier

```dart
ValueNotifier<int> counter = ValueNotifier(0);
```

---

# 十二、常见错误 & 坑（一定要看）

## ❌ 忘记指定泛型

```dart
List list = []; // 等价 List<dynamic>
```

👉 丧失类型保护

---

## ❌ 滥用 dynamic 而不用泛型

```dart
dynamic value;
```

👉 能用泛型，**不要用 dynamic**

---

## ❌ 泛型类中强依赖具体类型

```dart
class Box<T> {
  void foo(T v) {
    print(v.length); // ❌
  }
}
```

👉 应使用 `extends` 约束

---

# 十三、什么时候用泛型？什么时候不用？

### ✅ 适合用泛型

* 容器类（Box / Cache / Repository）
* 工具方法（parse / convert）
* 框架级抽象

### ❌ 不适合用泛型

* 业务高度固定
* 只会有一种类型
* 可读性变差

---

# 十四、一句话总结（给你背的）

> **泛型让 Dart 在保持灵活的同时获得编译期类型安全，是构建可扩展架构的基础能力。**

---

如果你愿意，下一步我可以继续带你做👇

* 🔥 **泛型 + abstract class + polymorphism 的终极架构模板**
* 🔥 **Flutter 中 Repository / ViewModel 泛型设计实战**
* 🔥 **面试常见泛型陷阱题（含解析）**

你选一个，我继续带你进阶。
