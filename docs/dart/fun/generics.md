下面我给你一份**Dart 函数泛型（Generics in Functions）知识点 + 使用大全**。
目标不是“知道语法”，而是**你什么时候该用、怎么写才专业、面试怎么讲**。

---

# 一、什么是函数泛型（核心认知）

### 一句话理解

> **函数泛型 = 让函数“先不指定类型”，由调用方决定类型**

```dart
T identity<T>(T value) {
  return value;
}
```

调用时：

```dart
identity<int>(10);
identity<String>('hello');
```

---

# 二、为什么要用函数泛型（不只是为了“优雅”）

## 1️⃣ 避免重复代码（最现实的价值）

❌ 不用泛型（写废了）：

```dart
int getInt(int v) => v;
String getString(String v) => v;
```

✅ 用泛型：

```dart
T get<T>(T v) => v;
```

---

## 2️⃣ 保证类型安全（关键）

```dart
T first<T>(List<T> list) {
  return list.first;
}
```

✔ 编译期就能发现错误
❌ `dynamic` 做不到

---

## 3️⃣ API 设计更通用（框架级思想）

Flutter / Dart SDK 中 **大量使用函数泛型**

```dart
Future<T>
Stream<T>
List<T>
Map<K, V>
```

---

# 三、函数泛型的基本语法（必会）

## 1️⃣ 泛型声明位置

```dart
返回值 函数名<泛型参数>(参数)
```

```dart
T echo<T>(T value) {
  return value;
}
```

📌 泛型写在 **函数名后面**

---

## 2️⃣ 多泛型参数

```dart
Map<K, V> pair<K, V>(K key, V value) {
  return {key: value};
}
```

---

## 3️⃣ 泛型可以省略（类型推断）

```dart
echo(123);        // Dart 推断 T = int
echo('hello');    // T = String
```

📌 **面试点：Dart 支持泛型类型推断**

---

# 四、函数泛型 + 集合（高频组合）

```dart
T last<T>(List<T> list) => list.last;
```

```dart
List<T> filter<T>(List<T> list, bool Function(T) test) {
  return list.where(test).toList();
}
```

---

# 五、泛型约束（extends）——高级必会

## 1️⃣ 基本约束

```dart
T max<T extends num>(T a, T b) {
  return a > b ? a : b;
}
```

📌 说明：

* `T` **必须是 num 或其子类**
* 可以用 `+ - > <`

---

## 2️⃣ 使用接口约束

```dart
abstract class Animal {
  void speak();
}

void talk<T extends Animal>(T animal) {
  animal.speak();
}
```

---

## 3️⃣ 多接口约束（Dart 3）

```dart
void fn<T extends Object & Comparable>(T v) {}
```

---

# 六、函数泛型 vs dynamic（面试必问）

| 对比   | 泛型    | dynamic |
| ---- | ----- | ------- |
| 类型检查 | 编译期   | 运行期     |
| 自动补全 | 有     | 无       |
| 错误发现 | 提前    | 延迟      |
| 推荐度  | ⭐⭐⭐⭐⭐ | ❌       |

❌ 不推荐：

```dart
dynamic get(dynamic v) => v;
```

---

# 七、泛型函数作为参数（非常重要）

```dart
void process<T>(T value, T Function(T) handler) {
  print(handler(value));
}
```

调用：

```dart
process<int>(10, (v) => v * 2);
```

---

# 八、泛型 + typedef（专业写法）

```dart
typedef Mapper<T> = T Function(T);

T apply<T>(T value, Mapper<T> mapper) {
  return mapper(value);
}
```

---

# 九、泛型函数返回泛型函数（进阶）

```dart
T Function(T) makeIdentity<T>() {
  return (T value) => value;
}
```

---

# 十、泛型与 async / Future（高频）

```dart
Future<T> fetch<T>(Future<T> future) async {
  return await future;
}
```

或：

```dart
Future<T> delay<T>(T value) async {
  await Future.delayed(Duration(seconds: 1));
  return value;
}
```

---

# 十一、泛型与 null safety（必会）

```dart
T? nullable<T>(T? value) {
  return value;
}
```

约束非空：

```dart
T notNull<T extends Object>(T value) => value;
```

---

# 十二、真实项目中的典型泛型函数

### 1️⃣ JSON 工具函数

```dart
T fromJson<T>(Map<String, dynamic> json, T Function(Map) parser) {
  return parser(json);
}
```

---

### 2️⃣ Flutter 通用 Navigator

```dart
Future<T?> push<T>(BuildContext context, Widget page) {
  return Navigator.push<T>(
    context,
    MaterialPageRoute(builder: (_) => page),
  );
}
```

📌 Flutter SDK 大量使用这种设计

---

# 十三、常见错误（你一定会踩）

❌ 泛型写在返回值前
❌ 用 dynamic 替代泛型
❌ 泛型约束过宽 / 过窄
❌ 泛型参数命名混乱（T, K, V）

---

# 十四、命名规范（专业细节）

| 泛型名 | 含义      |
| --- | ------- |
| T   | Type    |
| K   | Key     |
| V   | Value   |
| E   | Element |
| R   | Result  |

---

# 十五、一句话总结（送你）

> **函数泛型是 Dart “类型安全 + 复用能力”的核心**
>
> 能正确使用函数泛型，说明你已经不是初学者了。

---

如果你愿意，我可以继续给你：

* 🔥 **类泛型 vs 函数泛型（什么时候选哪个）**
* 🔥 **Flutter 源码中的泛型设计拆解**
* 🔥 **泛型 + Stream / Future 综合实战**
* 🔥 **泛型面试题 & 标准答案**

你选一个，我直接给你“能拿去面试”的版本。
