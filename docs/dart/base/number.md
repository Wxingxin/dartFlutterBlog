## Dart 的数字类型

### Dart 基本概念

Dart 中的数字类型主要有 **3 个**：

```dart
num    // 抽象父类
int    // 整数
double // 浮点数
```

👉 继承关系：

```
Object
 └── num
     ├── int
     └── double
```

## int（整数）

### int 基本概念

1️⃣ 定义

```dart
int a = 10;
var b = 20; // 自动推断 int
```

2️⃣ 特点（重要）

- **没有 long / short / byte**
- 整数 **自动扩容（大整数）**
- 不会溢出（不像 Java）

```dart
int big = 999999999999999999999;
```

3️⃣ 常用属性 / 方法

```dart
a.isEven
a.isOdd
a.abs()
a.sign        // -1 / 0 / 1
```

4️⃣ 位运算（了解）

```dart
a << 1
a >> 1
a & b
a | b
a ^ b
```

### api 属性大全

| 属性      | 干什么                                      | 返回值              |
| --------- | ------------------------------------------- | ------------------- |
| isEven    | int 是偶数吗                                | boolean             |
| isOdd     | int 是奇数吗                                | boolean             |
| bitLength | 表示该整数所需的最少二进制位数 (不含符号位) | number              |
| sign      | 判断 int 是负数 0 正数                      | -1:负数 0:零 1:正数 |

| 属性       | 干什么 | 返回值  |
| ---------- | ------ | ------- |
| isFinite   | a      | boolean |
| isInfinite | a      | boolean |
| isNaN      | a      | boolean |

### api 方法大全

| 方法                | 干什么                     | 返回值 |
| ------------------- | -------------------------- | ------ |
| toDouble()          | (数值转换)将 int -> double | number |
| toString([radix])   | (数值转换)进制转换         | String |
| abs()               | 绝对值                     | number |
| clamp(min，max)     | 限制范围                   | number |
| compareTo([number]) | 比较 compareTo 中的 number | number |

```dart
int a = 255;

a.toString();    // "255"
a.toString(2);   // "11111111"
a.toString(8);   // "377"
a.toString(16);  // "ff"

```

```dart
int score = 120;
score.clamp(0, 100); // 100
```

```dart
10.compareTo(5);   // 1
5.compareTo(10);   // -1
5.compareTo(5);    // 0
```

## double（浮点数）

### 是什么

- double 表示 64 位双精度浮点数
- 遵循 IEEE 754
- 本质上是 num 的子类

```dart
double d = 3.14;
var x = 2.0;
```

### 特点（⚠️ 面试点）

- IEEE 754 双精度
- **存在精度误差**

```dart
print(0.1 + 0.2); // 0.30000000000000004
```

---

### 方法和属性大全

| 分类 | 方法 / 属性                                |
| ---- | ------------------------------------------ |
| 判断 | isFinite / isInfinite / isNaN / isNegative |
| 取整 | ceil / floor / round / truncate            |
| 数学 | abs / clamp / remainder                    |
| 转换 | toInt / toString / toStringAsFixed         |
| 比较 | compareTo                                  |
| 常量 | infinity / nan / maxFinite / minPositive   |

### double 属性

| 属性       | 干什么                      | 返回值  |
| ---------- | --------------------------- | ------- |
| isFinite   | 是否是有限数                | boolean |
| isInfinite | 是否为无穷大（∞）           | boolean |
| isNaN      | 是否是 NaN (Not a Number)   | boolean |
| isNegative | 是否为负数                  | boolean |
| sign       | 返回符号 (-1.0 / 0.0 / 1.0) | number  |
| hashcode   | 对象的哈希值 (很少直接用)   | ?       |

```dart
//isFinite
double a = 10.5;
print(a.isFinite); // true

//isInfinite
double a = double.infinity;
print(a.isInfinite); // true

//isNaN
double a = 0.0 / 0.0;
print(a.isNaN); // true

//isNegative
double a = -3.14;
print(a.isNegative); // true

//sign
print(10.0.sign);   // 1.0
print(-5.0.sign);   // -1.0
print(0.0.sign);    // 0.0

//hashcode
print(3.14.hashCode);

```

### double 的静态常量

| 静态常量             | 干什么             | 返回值                  |
| ---------------- | ------------------ | ----------------------- |
| infinity         | 正无穷大           | Infinity                |
| negativeInfinity | 负无穷大           | -Infinity               |
| nan              | 非数字             | NaN                     |
| maxFinite        | 最大有限 double 值 | 1.7976931348623157e+308 |
| minPositive      | 最小正数（接近 0） | 5e-324                  |

```dart
double a = double.infinity;
  print(a);//Infinity

  double b = double.negativeInfinity;
  print(b);//-Infinity

  double c = double.nan;
  print(c);//NaN

  double d = double.maxFinite;
  print(d);//1.7976931348623157e+308

  double e = double.minPositive;
  print(e);//5e-324
```

### double 的方法大全

| 方法                     | 干什么                                  | 返回值 |
| ------------------------ | --------------------------------------- | ------ |
| ceil()                   | (1 取整相关)向上取整                    | number |
| floor()                  | (1 取整相关) 向下取整                   | number |
| round()                  | (1 取整相关) 四舍五入                   | number |
| truncate()               | (1 取整相关)直接截断小数                | number |
| abs()                    | (2 数值变换)绝对值                      | number |
| clamp(min, max)          | (2 数值变换) 限制范围 (UI 非常常用)     | number |
| compareTo(other)         | (3 比较)(<0：小于)( 0：等于 )(>0：大于) | number |
| toInt()                  | (4 转换类型)转为 int (截断)             | number |
| toString()               | (4 转换类型)转字符串                    | String |
| toStringAsFixed(n)       | (4 转换类型) 保留 n 位小数 (金融、展示) | number |
| toStringAsPrecision(n)   | (4 转换类型)保留 n 位有效数字           | number |
| toStringAsExponential(n) | (4 转换类型)科学计数法                  | number |

```dart

print(3.2.ceil()); // 4

print(3.8.floor()); // 3

print(3.5.round()); // 4
print(3.9.truncate()); // 3

/////

print((-3.14).abs()); // 3.14

double v = 120.0;
print(v.clamp(0.0, 100.0)); // 100.0

/////比较
print(3.0.compareTo(5.0)); // -1

//转换类型
print(3.9.toInt()); // 3

print(3.14159.toString());

print(3.14159.toStringAsFixed(2)); // 3.14
print(123.456.toStringAsPrecision(4)); // 123.5
print(12345.0.toStringAsExponential(2)); // 1.23e+4
//判断是否为整数 没有专门的api

double x = 5.0;
print(x == x.roundToDouble()); // true

bool isInt(double x) => x % 1 == 0;

```
### double的易错

错误示例

`print(0.1 + 0.2); // 0.30000000000000004`

正确处理 (显示层)

`print((0.1 + 0.2).toStringAsFixed(1)); // 0.3`

不要用 double做金额计算用int（分）或Decimal库

浮点数比较（⚠️ 面试高频）

❌ 错误方式：

```dart
if (a == b) {}
```

✅ 正确方式：

```dart
const eps = 1e-10;
if ((a - b).abs() < eps) {}
```




## num

### num学习

> **要学 `num`，但不需要像 `int / double` 那样“背大全”。**

**学习优先级：**

```
int / double（必须精通）  ＞  num（理解 + 会用）  ＞  Object（知道即可）
```

1️⃣ 那为什么「不需要」背 `num` 大全？

原因只有一个（很重要）：

> **`num` 本身几乎没有“独有方法”**

绝大多数方法你已经在：

* `int`
* `double`

里学过了。

`num` 主要提供的是「抽象层」，不是新能力

这意味着：

* **所有 `num` 的方法**
* `int` 和 `double` **都能用**

### ✅ 1️⃣ 什么时候用 `num`？

#### ✔ 正确场景

```dart
num a = 10;
num b = 3.14;
```

```dart
num value = json['count'];
```

```dart
num size = width * scale;
```

📌 **不确定是 int 还是 double → 用 num**

---

### ❌ 不推荐场景

```dart
num total = 0;
total += 0.1; // 精度问题不明显但存在
```

👉 你**明确知道类型时**，就用 `int` / `double`

---

### ✅ 2️⃣ `num` 的核心方法（只需这几个）

这些你已经“会了”，只是换个名字出现而已：

| 方法                                      | 说明       |
| --------------------------------------- | -------- |
| abs()                                   | 绝对值      |
| clamp(min, max)                         | 范围限制     |
| compareTo()                             | 数值比较     |
| toInt()                                 | 转 int    |
| toDouble()                              | 转 double |
| round() / floor() / ceil() / truncate() | 取整       |

✔️ **会用即可，不用死记**

---

### ✅ 3️⃣ `num` + `toDouble()` 是 Flutter 必修组合

```dart
final num raw = json['price'];
final double price = raw.toDouble();
```

📌 **这是 Flutter 网络层最常见代码之一**

---

### ✅ 4️⃣ 不要在“数学精度”上依赖 `num`

> `num` ≠ 更安全
> `num` 只是 **类型灵活**

金额、精度计算：

* ❌ `num`
* ❌ `double`
* ✅ `int（分）`
* ✅ `Decimal`

---

### ✅ 5️⃣ 看懂 `num` ≠ 写很多 `num`

> **你更常“读到” `num`，而不是“写很多” `num`**

这是经验结论。


## 一句话记忆版

> **Dart 的 Number = int 自动扩容 + double 有精度问题 + num 统一操作**

