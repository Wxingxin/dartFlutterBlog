

# 一、什么是 Record（记录类型）

**Record** 是 Dart 3 引入的一种 **轻量级、匿名、不可变的复合数据类型**。

你可以把它理解为：

> **“没有类名、没有字段定义的临时结构体 / 多返回值容器”**

```dart
var record = (1, 'hello', true);
```

✔ 有顺序
✔ 可带字段名
✔ 不可变
✔ 有类型系统支持
✔ 不需要 class

---

# 二、为什么需要 Record？

在 Dart 3 之前，你通常会这样做：

```dart
// 方式 1：Map（不安全）
Map<String, dynamic> result = {
  'code': 200,
  'msg': 'ok',
};

// 方式 2：自定义 class（太重）
class Result {
  final int code;
  final String msg;
  Result(this.code, this.msg);
}
```

**Record 的优势：**

| 对比项     | Record | Map | Class |
| ------- | ------ | --- | ----- |
| 类型安全    | ✅      | ❌   | ✅     |
| 轻量      | ✅      | ✅   | ❌     |
| 可读性     | ✅      | ❌   | ✅     |
| 适合返回多个值 | ⭐⭐⭐⭐⭐  | ⭐⭐  | ⭐⭐⭐   |

---

# 三、Record 的基本语法

## 1️⃣ 无名（位置）Record

```dart
var record = (1, 'hello', true);
```

访问方式：

```dart
print(record.$1); // 1
print(record.$2); // hello
print(record.$3); // true
```

📌 **位置从 `$1` 开始**

---

## 2️⃣ 命名 Record（推荐）

```dart
var record = (code: 200, msg: 'ok');
```

访问方式：

```dart
print(record.code); // 200
print(record.msg);  // ok
```

✅ 可读性更好
✅ 不依赖顺序

---

## 3️⃣ 混合 Record（位置 + 命名）

```dart
var record = (1, 'hello', success: true);
```

访问：

```dart
record.$1;        // 1
record.$2;        // hello
record.success;   // true
```

⚠️ 实际项目中**不太推荐混用**，可读性一般

---

# 四、Record 的类型声明

## 1️⃣ 显式类型声明

```dart
(int, String) record = (1, 'hello');
```

命名类型：

```dart
({int code, String msg}) result = (code: 200, msg: 'ok');
```

---

## 2️⃣ 函数返回 Record（核心用途）

```dart
(int, int) getPoint() {
  return (10, 20);
}
```

使用：

```dart
var point = getPoint();
print(point.$1); // 10
print(point.$2); // 20
```

命名返回（强烈推荐）：

```dart
({int x, int y}) getPoint() {
  return (x: 10, y: 20);
}
```

```dart
var p = getPoint();
print(p.x);
print(p.y);
```

---

# 五、Record 解构（非常重要）

## 1️⃣ 位置解构

```dart
var (a, b) = (1, 2);
print(a); // 1
print(b); // 2
```

---

## 2️⃣ 命名解构

```dart
var (:code, :msg) = (code: 200, msg: 'ok');
```

等价于：

```dart
var record = (code: 200, msg: 'ok');
var code = record.code;
var msg = record.msg;
```

---

## 3️⃣ 解构 + 重命名

```dart
var (:code: statusCode, :msg: message) = (code: 200, msg: 'ok');
```

---

## 4️⃣ 解构函数返回值（高频）

```dart
({int sum, int avg}) calc(List<int> nums) {
  final sum = nums.reduce((a, b) => a + b);
  return (sum: sum, avg: sum ~/ nums.length);
}

var (:sum, :avg) = calc([1, 2, 3, 4]);
```

---

# 六、Record 的不可变性（重点）

Record 是 **不可变的（immutable）**：

❌ 错误写法：

```dart
record.code = 300; // 编译错误
```

只能创建新 Record：

```dart
var newRecord = (code: record.code + 1, msg: record.msg);
```

---

# 七、Record 的比较规则

Record **支持 `==` 比较**（值比较）：

```dart
print((1, 2) == (1, 2)); // true
print((a: 1) == (a: 1)); // true
print((1, 2) == (2, 1)); // false
```

📌 比较规则：

* 顺序要一致
* 字段名要一致
* 值要一致

---

# 八、Record 与函数参数

## 1️⃣ Record 作为参数

```dart
void printUser(({String name, int age}) user) {
  print(user.name);
}
```

调用：

```dart
printUser((name: 'Tom', age: 18));
```

---

## 2️⃣ 解构参数（高级）

```dart
void printUser(({String name, int age}) (:name, :age)) {
  print('$name - $age');
}
```

---

# 九、Record vs 其他结构（实战对比）

## vs Map

❌ Map：

```dart
Map<String, dynamic> user = {'age': '18'};
```

✅ Record：

```dart
({String name, int age}) user = (name: 'Tom', age: 18);
```

---

## vs Class

❌ 过度设计：

```dart
class Pair {
  int a, b;
  Pair(this.a, this.b);
}
```

✅ Record：

```dart
(int, int) pair = (1, 2);
```

---

# 十、典型实战场景

## 1️⃣ 接口返回封装

```dart
({bool success, String message}) request() {
  return (success: true, message: 'ok');
}
```

---

## 2️⃣ 校验结果返回

```dart
({bool valid, String? error}) validate(String input) {
  if (input.isEmpty) {
    return (valid: false, error: 'empty');
  }
  return (valid: true, error: null);
}
```

---

## 3️⃣ 多值计算结果

```dart
({int min, int max}) findRange(List<int> list) {
  return (
    min: list.reduce(min),
    max: list.reduce(max),
  );
}
```

---

# 十一、使用建议（很重要）

✅ **什么时候用 Record**

* 函数返回多个值
* 临时组合数据
* 局部逻辑结果

❌ **什么时候不用**

* 需要方法、行为
* 长期持久化模型
* JSON 映射（用 class / model）

---

# 十二、学习路线建议（针对你）

你已经系统学了：

* `Object / dynamic / never`
* `Future / Stream`
* 集合类型

👉 **下一步强烈建议**：

1. `Pattern Matching（模式匹配）`
2. `sealed / base / final class`
3. Record + switch 解构（Dart 3 核心）

如果你愿意，我可以下一步直接给你一篇：

> **《Dart Record + Pattern Matching 实战大全（Flutter 场景）》**

要的话，直接说 👍
