

## 一、一句话结论（先给你结论）

> **`Object` 是 Dart 中所有类的“根类型”；`class` 是“定义类型的语法关键字”。**
> 二者不在同一个层级，**不是并列概念**。

---

## 二、`Object` 是什么？

### 1️⃣ 定义

`Object` 是 Dart **所有类的父类（根类）**。

```dart
class Person {}

void main() {
  Person p = Person();
  print(p is Object); // true
}
```

✔ 在 Dart 中：

* 一切皆对象（包括 `int`、`String`、`List`）
* 所有类型最终都继承自 `Object`

---

### 2️⃣ `Object` 提供的基础方法

`Object` 自带的方法非常少，但非常基础：

```dart
class Object {
  bool operator ==(Object other);
  int get hashCode;
  String toString();
  Type get runtimeType;
}
```

也就是说：

```dart
Object obj = "hello";

// 只能用 Object 的方法
obj.toString();
obj.hashCode;
obj.runtimeType;

// ❌ 不允许
obj.length; // 编译错误
```

---

### 3️⃣ `Object` 的作用

* **最通用的类型**
* 用于：

  * 接收任意对象
  * 类型擦除
  * API 设计中的“上界类型”

```dart
void log(Object value) {
  print(value);
}
```

---

## 三、`class` 是什么？

### 1️⃣ 定义

`class` 是 Dart 中**用来定义自定义类型的关键字**。

```dart
class Person {
  String name;
  Person(this.name);

  void sayHello() {
    print('Hello $name');
  }
}
```

✔ `class` 本身不是类型
✔ **class 定义的结果才是类型**

---

### 2️⃣ class 的本质

```dart
class Person {}
```

等价于：

* 创建了一个 **新类型**：`Person`
* 该类型 **默认继承 Object**

```dart
class Person extends Object {}
```

（`extends Object` 是隐式的）

---

## 四、核心区别对比表（重点）

| 对比点    | Object  | class   |
| ------ | ------- | ------- |
| 本质     | 根类型     | 定义类型的语法 |
| 是否是类型  | ✅ 是     | ❌ 不是    |
| 是否可实例化 | ❌（抽象意义） | ❌（关键字）  |
| 是否可继承  | ✅       | ❌       |
| 是否能写方法 | ❌       | ✅       |
| 是否有子类  | 所有类     | 定义后产生子类 |

---

## 五、代码对比（最容易理解的方式）

### 示例 1：Object 作为类型

```dart
Object a = 10;
Object b = "hello";
Object c = [1, 2, 3];
```

你可以存任何对象，但**只能当 Object 用**。

---

### 示例 2：class 定义类型

```dart
class User {
  String name;
  User(this.name);
}

User u = User("Tom");
u.name; // 正常
```

---

### 示例 3：Object vs dynamic

```dart
Object obj = "hello";
dynamic dyn = "hello";

// Object：编译期检查
obj.length; // ❌ 编译错误

// dynamic：运行期检查
dyn.length; // ✅ 但可能运行时报错
```

---

## 六、常见误区澄清（非常重要）

### ❌ 误区 1：Object 和 class 是同级概念

✅ **错误**

> `Object` 是类型，`class` 是语法关键字

---

### ❌ 误区 2：Object 就是“任意类型”

✅ **不完全正确**

* `Object`：安全、受限
* `dynamic`：完全放弃类型检查

---

### ❌ 误区 3：Object 可以代替 dynamic

✅ **不推荐**

```dart
void f(Object o) {
  // 必须先判断
  if (o is String) {
    print(o.length);
  }
}
```

---

## 七、什么时候用 Object？什么时候用 class？

### ✅ 使用 Object 的场景

* 接收未知类型参数
* API 通用参数
* Map 的 value 上界

```dart
Map<String, Object> json;
```

---

### ✅ 使用 class 的场景

* 定义业务模型
* 组件 / 状态 / 实体
* 面向对象设计

```dart
class UserModel {}
class OrderEntity {}
```

---

## 八、和 Java / TypeScript 的对比（你是前端，非常重要）

### Dart vs Java

| Dart   | Java   |
| ------ | ------ |
| Object | Object |
| class  | class  |

> 非常接近 Java

---

### Dart vs TypeScript

| Dart    | TypeScript       |
| ------- | ---------------- |
| Object  | unknown / object |
| dynamic | any              |
| class   | class            |

⚠ TS 的 `object` **≠ Dart 的 Object**

---

## 九、总结一句话（面试级）

> **`Object` 是 Dart 所有类型的根类，用作最通用但受限的类型；`class` 是用于定义新类型的语法关键字，本身并不是类型。**

---

如果你愿意，我可以继续帮你讲：

* `Object` vs `dynamic` vs `Object?`
* Dart 空安全下的 Object 设计哲学
* Dart 类型系统和 TypeScript 的深度对照

你直接说你想继续哪一个。
