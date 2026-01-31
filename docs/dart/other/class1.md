下面我**逐行、按 Dart 语言特性**来讲解这段代码，重点放在：
👉 `final`、构造函数、方法 vs getter 的区别。

---

## 一、入口函数 `main`

```dart
void main() {
  final user = User(firstName: "wei", lastName: 'gao');
  user.getFullName();
  user.fullName;
}
```

### 1️⃣ `void main()`

* Dart 程序入口
* `void` 表示没有返回值

---

### 2️⃣ `final user = User(...)`

```dart
final user = User(firstName: "wei", lastName: 'gao');
```

含义拆解：

* `final`：

  * **变量只能被赋值一次**
  * 但对象本身 **仍然是可变的（如果字段不是 final）**

* `User(...)`：

  * 调用 `User` 类的**命名参数构造函数**
  * `firstName`、`lastName` 是 **required 命名参数**

📌 等价理解：

> user 这个“引用”不能变，但 user 指向的对象可以有行为

---

### 3️⃣ `user.getFullName();`

```dart
user.getFullName();
```

* 调用了一个 **普通方法**
* 返回 `String`
* ⚠️ 但这里**没有接收返回值**，所以结果被直接丢弃

等价但更合理的写法：

```dart
print(user.getFullName());
```

---

### 4️⃣ `user.fullName;`

```dart
user.fullName;
```

* 访问的是一个 **getter**
* 看起来像属性，但**本质是方法调用**
* 同样：返回值没有使用

---

## 二、`User` 类定义

```dart
class User {
  final String firstName;
  final String lastName;
```

### 1️⃣ `final String firstName`

* 成员变量
* `final` 表示：

  * **只能在构造函数中赋值**
  * 对象创建后不可修改（不可变字段）

📌 这是 Dart 中非常推荐的写法（不可变对象）

---

### 2️⃣ 构造函数（命名参数）

```dart
User({required this.firstName, required this.lastName});
```

逐点解释：

* `{}` → **命名参数**
* `required` → 调用时必须传
* `this.firstName` → 直接给成员变量赋值

等价展开写法（你平时几乎不用这样写）：

```dart
User({required String firstName, required String lastName})
    : this.firstName = firstName,
      this.lastName = lastName;
```

---

## 三、方法 vs Getter（重点）

### 1️⃣ 普通方法

```dart
String getFullName() => '$firstName $lastName';
```

特点：

* **必须加 `()` 调用**
* 语义是“执行一个动作”
* 可带参数（getter 不行）

调用方式：

```dart
user.getFullName();
```

---

### 2️⃣ Getter（计算属性）

```dart
String get fullName => '$firstName $lastName';
```

特点：

* 使用 `get` 关键字
* **像属性一样访问**
* 不能传参
* 适合「**根据已有字段计算得出的值**」

调用方式：

```dart
user.fullName;
```

---

### 3️⃣ 二者对比（面试 & 实战重点）

| 对比项         | 方法                   | getter          |
| ----------- | -------------------- | --------------- |
| 调用方式        | `user.getFullName()` | `user.fullName` |
| 语义          | 动作                   | 属性              |
| 是否可传参       | ✅                    | ❌               |
| 常见用途        | 行为 / 操作              | 计算属性            |
| Flutter 中使用 | 较少                   | **非常多**         |

📌 **Flutter / Dart 强烈偏向 getter 风格**

---

## 四、为什么两种写法都存在？

在 Dart / Flutter 中：

* **对外暴露值** → 用 `getter`
* **执行行为 / 有副作用** → 用方法

所以更推荐你写成：

```dart
String get fullName => '$firstName $lastName';
```

而不是 `getFullName()`

---

## 五、这段代码的“最佳实践版本”

```dart
void main() {
  final user = User(firstName: 'wei', lastName: 'gao');
  print(user.fullName);
}

class User {
  final String firstName;
  final String lastName;

  const User({required this.firstName, required this.lastName});

  String get fullName => '$firstName $lastName';
}
```

改进点：

* 使用 `const` 构造函数（不可变对象）
* 只保留 getter
* 使用返回值

---

## 六、你现在已经掌握的 Dart 核心点

✔ `final` vs 对象可变性
✔ 命名参数 + required
✔ 构造函数简写
✔ 方法 vs getter 设计哲学

如果你愿意，下一步我可以继续给你讲：

* `const` vs `final` 深度对比
* Dart 中不可变对象设计
* Flutter Widget 为什么大量用 getter
* `copyWith` 这种模式是怎么来的

你可以直接点一个继续 👍
