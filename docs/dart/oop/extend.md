下面我把 **Dart 中 `extends`（继承）** 按**从入门到项目级**完整梳理一遍：**语法规则 → 构造函数与 super → 方法重写 → 字段与访问控制 → abstract / override → 多态 → mixin 对比 → 常见坑 → 最佳实践**。
你可以把这篇当作 **Dart 继承的权威速查 + 使用手册**。

---

# 一、`extends` 是什么（核心概念）

> `extends` 用于 **子类继承父类**
> 子类 **获得父类的非私有成员（字段 + 方法）**，并可以 **扩展或重写行为**

```dart
class Animal {
  void eat() => print("eat");
}

class Dog extends Animal {
  void bark() => print("bark");
}
```

使用：

```dart
final dog = Dog();
dog.eat();  // 来自父类
dog.bark(); // 子类新增
```

---

# 二、基本规则（必须记住）

1. **Dart 只支持单继承**

```dart
class B extends A {}        // ✅
class C extends A, B {}    // ❌
```

2. 一个类 **只能 `extends` 一个父类**
3. 所有类最终都隐式继承自 `Object`

```dart
class A {}        // 实际是：class A extends Object
```

---

# 三、继承能得到什么？不能得到什么？

### ✅ 可以继承

* 非私有字段（不是 `_xxx`）
* 非私有方法
* getter / setter
* 运算符重载

### ❌ 不能继承

* 构造函数本身（只能调用，不能继承）
* 父类的私有成员（以下划线开头）

```dart
class A {
  int x = 1;
  int _y = 2;
}

class B extends A {
  void test() {
    print(x);  // ✅
    // print(_y); // ❌
  }
}
```

---

# 四、构造函数 + `extends`（重点必考）

## 1️⃣ 父类没有无参构造函数 → 子类必须 `super(...)`

```dart
class Animal {
  final String name;
  Animal(this.name);
}

class Dog extends Animal {
  Dog(String name) : super(name);
}
```

❌ 错误写法：

```dart
class Dog extends Animal {
  Dog(); // Error：父类没有无参构造
}
```

---

## 2️⃣ 初始化顺序（非常重要）

构造一个子类对象时，执行顺序是：

1. 父类初始化列表
2. 父类构造函数体
3. 子类初始化列表
4. 子类构造函数体

```dart
class A {
  A() {
    print("A");
  }
}

class B extends A {
  B() {
    print("B");
  }
}
```

输出：

```
A
B
```

---

## 3️⃣ `super` 只能写在初始化列表中

❌ 错误：

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

# 五、方法重写（override）

## 1️⃣ 重写规则

* 方法名、参数、返回类型 **必须兼容**
* 使用 `@override`（强烈推荐）

```dart
class Animal {
  void speak() {
    print("animal sound");
  }
}

class Dog extends Animal {
  @override
  void speak() {
    print("wang");
  }
}
```

---

## 2️⃣ 调用父类方法：`super.xxx()`

```dart
class LoggedDog extends Dog {
  @override
  void speak() {
    super.speak();
    print("logged");
  }
}
```

---

# 六、字段继承与遮蔽（不推荐但要懂）

```dart
class A {
  int x = 1;
}

class B extends A {
  int x = 2; // 遮蔽父类字段
}
```

```dart
final b = B();
print(b.x);        // 2
print((b as A).x); // 1
```

📌 **不建议字段重名**，容易混乱

---

# 七、getter / setter 的继承与重写

```dart
class Rect {
  double width;
  double height;

  Rect(this.width, this.height);

  double get area => width * height;
}

class Square extends Rect {
  Square(double size) : super(size, size);

  @override
  double get area => super.area;
}
```

---

# 八、`abstract` + `extends`（非常常见）

## 1️⃣ 抽象类不能被实例化

```dart
abstract class Shape {
  double area();
}
```

## 2️⃣ 子类必须实现抽象方法

```dart
class Circle extends Shape {
  final double r;
  Circle(this.r);

  @override
  double area() => 3.14 * r * r;
}
```

---

# 九、`extends` 实现多态（核心思想）

```dart
void printArea(Shape shape) {
  print(shape.area());
}

printArea(Circle(2));
printArea(Rectangle(2, 3));
```

📌 **父类引用 → 子类对象**

---

# 十、`extends` vs `implements` vs `with`

| 关键字          | 含义           |
| ------------ | ------------ |
| `extends`    | 继承实现 + 状态    |
| `implements` | 只实现接口（必须全实现） |
| `with`       | 混入行为（多继承行为）  |

### extends + with（常见组合）

```dart
class Animal {}

mixin Flyable {
  void fly() => print("fly");
}

class Bird extends Animal with Flyable {}
```

---

# 十一、`Object` 中你默认继承的方法

所有类默认继承：

* `toString()`
* `==`
* `hashCode`
* `runtimeType`
* `noSuchMethod`

```dart
class User {
  final String name;
  User(this.name);

  @override
  String toString() => "User(name: $name)";
}
```

---

# 十二、常见错误（必踩坑）

### ❌ 1. 父类无无参构造，子类忘记 super

```dart
class A {
  A(int x);
}

class B extends A {
  B(); // ❌
}
```

---

### ❌ 2. 试图继承多个类

```dart
class C extends A, B {} // ❌
```

---

### ❌ 3. 重写方法但签名不一致

```dart
@override
int foo(String s) {} // 父类是 void foo()
```

---

# 十三、项目级最佳实践（非常重要）

### ✅ 什么时候用 extends？

* **is-a 关系**

  * Dog is an Animal
  * Page is a Widget
* 有共享状态 + 行为

### ❌ 不要为了复用代码滥用 extends

* 只是想复用方法 → 用 `mixin`
* 只是想约束接口 → 用 `implements`

### ✅ Flutter 中的经典继承

```dart
class MyPage extends StatelessWidget {}
class MyPage extends StatefulWidget {}
```

---

# 十四、一句话总结

* `extends` = **单继承**
* 子类 **自动拥有父类非私有成员**
* 构造函数必须正确 `super`
* 方法重写用 `@override`
* 多态 = 父类引用指向子类对象
* 行为复用优先 `mixin`，接口约束用 `implements`

---

如果你愿意，下一步我可以帮你：

* **用一张图讲清 extends / implements / mixin 的选择策略**
* **结合 Flutter Widget 继承体系（Element / Widget / RenderObject）**
* **用你毕设里的业务模型（User / Message / Session）设计一套合理继承结构**

你说继续哪一块，我直接给你拆到源码级。
