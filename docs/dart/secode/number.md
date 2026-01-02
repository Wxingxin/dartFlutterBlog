# 数值类型（Number）

Dart 中有两种数值类型：

- `int`：整数类型（没有小数）
- `double`：浮点数类型（带小数）
- `num`：是 `int` 和 `double` 的父类，可以同时表示两种类型。

---

> ## ✅ 1. 定义与赋值

```dart
int age = 20;
double price = 12.5;
num total = 100; // 可以是 int 或 double
total = 99.9; // ✅ 合法，因为 num 可以接收 double
```

---

> ## ✅ 2. 常用数值运算

```dart
int a = 10;
double b = 3.5;

print(a + b);   // 加法 -> 13.5
print(a - b);   // 减法 -> 6.5
print(a * b);   // 乘法 -> 35.0
print(a / b);   // 除法 -> 2.857...
print(a ~/ b);  // 整除 -> 2（取整）
print(a % b);   // 取余 -> 10 % 3.5 = 3.0
```

---

> ## ✅ 3. 数学函数（`dart:math`）

```dart
import 'dart:math';

void main() {
  print(sqrt(16));    // 平方根 4.0
  print(pow(2, 3));   // 幂次方 8.0
  print(max(3, 7));   // 最大值 7
  print(min(3, 7));   // 最小值 3
  print(pi);          // 圆周率 3.141592653589793
}
```

---

> ## ✅ 4. 类型转换

```dart
int a = 42;
double b = a.toDouble();  // int -> double
print(b);

double c = 3.1415;
int d = c.toInt();        // double -> int（直接舍弃小数）
print(d); // 3
```

字符串与数字之间的转换：

```dart
String s = '123';
int num1 = int.parse(s);       // String -> int
double num2 = double.parse('3.14'); // String -> double
print(num1 + num2);

String s2 = num1.toString();   // int -> String
```

---

> ## ✅ 5. 常见陷阱 ⚠️

```dart
print(0.1 + 0.2 == 0.3); // ❌ false（浮点精度误差）
```

👉 Dart 使用 IEEE 754 浮点数标准，所以计算机表示小数会有误差。
