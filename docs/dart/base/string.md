## String

### String 的基础

在 Dart 中，**String 是不可变（immutable）的 UTF-16 字符序列**：

```dart
String s = "hello";
```

👉 核心特性：

- 不可变（所有修改都会生成新字符串）
- 支持 Unicode（中文 / emoji）
- 有丰富的内置方法
- `String` 是一个类，不是基本类型

### String 的声明方式

1️⃣ 双引号 / 单引号（等价）

```dart
String a = "hello";
String b = 'world';
```

2️⃣ 多行字符串（常用）

```dart
String text = '''
第一行
第二行
第三行
''';
```

3️⃣ raw 字符串（r 前缀）

```dart
String path = r"C:\Windows\System32";
```

👉 不解析转义字符 `\n \t $`

4️⃣ const / final String

```dart
final s = "hello";
const s2 = "world";
```

⚠️ 都不可修改内容（String 本身不可变）

## String 的拼接和展示

### String 在 print 的拼接

字符串插值（🔥 Dart 特色）

```dart
var name = "Tom";
var age = 18;

print("name: $name, age: $age");
print("next year: ${age + 1}");
```

👉 `${}` 里可以是**任意表达式**

1️⃣ `+` 拼接（不推荐多次）

```dart
var s = "a" + "b";
```

2️⃣ 插值（推荐）

```dart
var s = "$a$b";
```

3️⃣ StringBuffer（🔥 高频）

```dart
var buffer = StringBuffer();
buffer.write("hello");
buffer.write(" ");
buffer.write("world");

var result = buffer.toString();
```

👉 **大量拼接必须用 StringBuffer**

## String 的属性和方法

### String 属性

| 属性       | 干什么                          | 返回值  |
| ---------- | ------------------------------- | ------- |
| length     | 字符串长度（字符数）            | number  |
| isEmpty    | 是否为空字符串                  | boolean |
| isNotEmpty | 是否非空                        | boolean |
| codeUnits  | 返回 UTF-16 编码的整数列表      | list    |
| runes      | 返回 Unicode 码点（支持 emoji） | Runes   |

### 1️⃣ `length`

字符串长度（字符数）

```dart
String s = "hello";
print(s.length); // 5
```

⚠️ 注意：对 emoji、中文等，一个字符 ≠ 一个字节

```dart
print("😊".length); // 2（UTF-16）
```

### 2️⃣ `isEmpty`

是否为空字符串

```dart
print("".isEmpty);   // true
print("a".isEmpty);  // false
```

### 3️⃣ `isNotEmpty`

是否非空

```dart
print("hello".isNotEmpty); // true
```

### 4️⃣ `codeUnits`

返回 UTF-16 编码的整数列表

```dart
print("ABC".codeUnits); // [65, 66, 67]
```

### 5️⃣ `runes`

返回 Unicode 码点（支持 emoji）

```dart
print("😊".runes); // (128522)
```

⚠️ `length` 是 **UTF-16 code unit 数量**，不是“用户看到的字符数”（emoji 会踩坑，后面讲）

## 1️⃣ 查找 / 判断

```dart
s.contains("he");
s.startsWith("he");
s.endsWith("lo");
s.indexOf("l");
s.lastIndexOf("l");
```

---

## 2️⃣ 截取

```dart
s.substring(0, 3);
```

⚠️ 左闭右开 `[start, end)`

---

## 3️⃣ 替换

```dart
s.replaceAll("a", "b");
s.replaceFirst("a", "b");
```

---

## 4️⃣ 大小写

```dart
s.toUpperCase();
s.toLowerCase();
```

---

## 5️⃣ 去空格（必考）

```dart
s.trim();
s.trimLeft();
s.trimRight();
```

---

# 七、String 分割 & 合并（高频）

## split

```dart
var arr = "a,b,c".split(",");
```

---

## join（List → String）

```dart
var s = arr.join("-");
```

---

# 八、String 与正则（🔥 面试常考）

```dart
RegExp reg = RegExp(r'\d+');

reg.hasMatch("abc123");
"abc123".replaceAll(reg, "*");
```

---

## 提取匹配内容

```dart
var matches = reg.allMatches("a1b22c333");
for (var m in matches) {
  print(m.group(0));
}
```

# 十、String 与 null safety（必考）

```dart
String? s;        // 可为 null
String s = "";    // 空字符串 ≠ null
```

常见判断：

```dart
if (s?.isNotEmpty == true) {}
```

---

# 十一、String 与 Unicode / emoji（⚠️ 高阶坑）

```dart
String s = "😀";
print(s.length); // 2 ❗
```

原因：emoji 占 **两个 UTF-16 code unit**

### 正确按“字符”遍历：

```dart
import 'dart:core';

for (var rune in s.runes) {
  print(String.fromCharCode(rune));
}
```

---

# 十二、String 比较（必考）

```dart
"a" == "a";       // true
"a".compareTo("b"); // -1
```

👉 Dart 字符串比较是 **值比较**

---

# 十三、String 与 List / Map（结合场景）

## 1️⃣ String ↔ List

```dart
var chars = s.split('');
var s2 = chars.join();
```

---

## 2️⃣ String 作为 Map key（常见）

```dart
Map<String, dynamic> json = {
  "name": "Tom",
  "age": 18,
};
```

# 十六、一句话记忆版

> **Dart 的 String = 不可变 + 插值强大 + StringBuffer 提效**
