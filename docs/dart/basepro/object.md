

# 一、Object 是什么？（先给结论）

> **`Object` 是 Dart 中所有类的“根类”**

```dart
Object obj = 'hello';
Object obj2 = 123;
Object obj3 = true;
Object obj4 = [];
```

📌 **在 Dart 中：**

* 所有类型最终都继承自 `Object`
* 包括：`int`、`double`、`String`、`bool`、`List`、`Map`、`Function`、`Future`、你自定义的类

> 👉 **只要是“值”，它一定是 Object**

---

# 二、Object 在 Dart 类型体系中的位置

```text
          Object
             ↑
          dynamic
             ↑
         int / String / 自定义类
```

⚠️ 注意：

* `Object` ≠ `dynamic`
* `Object` 是**强类型**
* `dynamic` 是**关闭类型检查**

---

# 三、Object 的核心特性（非常重要）

## 1️⃣ 所有类型都可以赋值给 Object

```dart
Object a = 1;
Object b = 'abc';
Object c = [1, 2, 3];
Object d = () {};
```

但反过来 **不一定成立**：

```dart
Object a = 'hello';

// String s = a; ❌ 编译错误
String s = a as String; // ✅
```

---

## 2️⃣ Object 默认只允许用「Object 自带的方法」

```dart
Object obj = 'hello';

obj.toString(); // ✅
obj.hashCode;   // ✅

// obj.length ❌ 编译错误
```

📌 因为 `length` 不属于 Object，而属于 String

---

# 四、Object 中有哪些方法？（必考）

Object 类本身**只有这几个核心成员**👇

---

## 1️⃣ `toString()`

```dart
Object obj = 123;
print(obj.toString()); // 123
```

自定义类中常常重写：

```dart
class User {
  final String name;

  User(this.name);

  @override
  String toString() => 'User(name: $name)';
}
```

---

## 2️⃣ `==`（相等判断）

默认行为：

```dart
Object a = Object();
Object b = Object();

print(a == b); // false
```

📌 默认是 **引用比较**

### 重写 `==`

```dart
class User {
  final String name;

  User(this.name);

  @override
  bool operator ==(Object other) {
    return other is User && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
```

---

## 3️⃣ `hashCode`

> **必须与 `==` 成对重写**

```dart
@override
int get hashCode => name.hashCode;
```

📌 用在：

* `Set`
* `Map` 的 key

---

## 4️⃣ `runtimeType`

```dart
Object obj = 123;
print(obj.runtimeType); // int
```

⚠️ 调试用，**不建议用于业务判断**

---

# 五、Object 与 null（Dart 空安全核心）

## 1️⃣ Object 默认不包含 null

```dart
Object a = null; // ❌
```

---

## 2️⃣ Object? 才能接收 null

```dart
Object? a = null;
```

📌 **规则统一：**

> 所有类型：`T` 不可空，`T?` 可空

---

# 六、Object vs dynamic（重点对比）

| 对比点    | Object | dynamic |
| ------ | ------ | ------- |
| 是否类型安全 | ✅      | ❌       |
| 编译期检查  | 有      | 无       |
| 推荐使用   | ✅      | ❌（除非必要） |
| IDE 提示 | 强      | 弱       |

### 示例对比

```dart
Object obj = 'hello';
// obj.length ❌ 编译期报错

dynamic d = 'hello';
print(d.length); // ✅ 但可能运行时炸
```

📌 **结论：**

> 能用 Object，就不要用 dynamic

---

# 七、Object 与 Object? 的设计区别

```dart
Object a = 1;    // 永远非 null
Object? b = 1;  // 可能为 null
```

### 常见错误

```dart
Object? a = 'hi';

// print(a.length); ❌
print((a as String).length); // ✅
```

---

# 八、Object 在函数中的典型用法

## 1️⃣ 接收任意类型参数

```dart
void log(Object value) {
  print(value);
}
```

---

## 2️⃣ 结合类型判断（is）

```dart
void handle(Object value) {
  if (value is String) {
    print(value.length);
  } else if (value is int) {
    print(value + 1);
  }
}
```

📌 Dart 的 **类型收窄（Type Promotion）**

---

## 3️⃣ 返回 Object（慎用）

```dart
Object getValue(bool flag) {
  return flag ? 'hello' : 123;
}
```

⚠️ 调用方需要自己判断类型

---

# 九、Object 在集合中的使用

## 1️⃣ List<Object>

```dart
List<Object> list = [1, 'a', true];
```

📌 元素不能是 null

---

## 2️⃣ List<Object?>

```dart
List<Object?> list = [1, null, 'a'];
```

---

## 3️⃣ Map<String, Object>

```dart
Map<String, Object> map = {
  'id': 1,
  'name': 'Tom',
};
```

📌 JSON 解析常见

---

# 十、Object 在 Flutter / Dart 实战中的位置

## 1️⃣ JSON 原始数据

```dart
Map<String, Object?> json;
```

---

## 2️⃣ 通用回调参数

```dart
void onEvent(Object event) {}
```

---

## 3️⃣ 错误处理

```dart
catch (Object e) {
  print(e);
}
```

---

# 十一、Object 使用的最佳实践（经验）

✅ 推荐：

* 公共 API
* 工具函数
* JSON 中间层
* 日志、错误、事件

❌ 不推荐：

* 业务模型
* UI 强类型数据
* 代替泛型

---

# 十二、常见误区（你一定会遇到）

1️⃣ 以为 Object 可以随便用属性
2️⃣ 用 Object 替代 dynamic（但没做类型判断）
3️⃣ 忘记 Object 不包含 null
4️⃣ 重写 `==` 忘了 `hashCode`
5️⃣ 用 `runtimeType` 做业务逻辑
6️⃣ JSON 直接用 Object 不做转换

---

# 十三、一句话记住 Object

> **Object 是 Dart 的“安全兜底类型”，不是“万能类型”**

---

如果你愿意，下一步我可以直接带你进 **进阶层**：

* ✅ `Object` vs `num` vs `Object?` 设计取舍
* ✅ `Object` + 泛型的正确打开方式
* ✅ Flutter 中 Object 的真实使用场景
* ✅ 一套「什么时候该用 Object」的判断口诀

你挑一个，我继续往下给你“拉一层天花板”。
