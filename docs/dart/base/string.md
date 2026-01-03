下面给你一份**📘 Dart 语言 String（字符串）知识点大全**，我按**基础 → 常用 API → 高级用法 → Flutter / 面试坑**系统整理，和你前面的 **List / Map / Set** 完全对齐，学完这块你对 Dart 基础类型就非常扎实了。

---

# 一、String 是什么（核心概念）

在 Dart 中，**String 是不可变（immutable）的 UTF-16 字符序列**：

```dart
String s = "hello";
```

👉 核心特性：

* 不可变（所有修改都会生成新字符串）
* 支持 Unicode（中文 / emoji）
* 有丰富的内置方法
* `String` 是一个类，不是基本类型

---

# 二、String 的声明方式（必会）

## 1️⃣ 双引号 / 单引号（等价）

```dart
String a = "hello";
String b = 'world';
```

---

## 2️⃣ 多行字符串（常用）

```dart
String text = '''
第一行
第二行
第三行
''';
```

---

## 3️⃣ raw 字符串（r 前缀）

```dart
String path = r"C:\Windows\System32";
```

👉 不解析转义字符 `\n \t $`

---

## 4️⃣ const / final String

```dart
final s = "hello";
const s2 = "world";
```

⚠️ 都不可修改内容（String 本身不可变）

---

# 三、字符串插值（🔥 Dart 特色）

```dart
var name = "Tom";
var age = 18;

print("name: $name, age: $age");
print("next year: ${age + 1}");
```

👉 `${}` 里可以是**任意表达式**

---

# 四、String 常用属性（基础）

```dart
s.length
s.isEmpty
s.isNotEmpty
```

⚠️ `length` 是 **UTF-16 code unit 数量**，不是“用户看到的字符数”（emoji 会踩坑，后面讲）

---

# 五、String 拼接方式（必考）

## 1️⃣ `+` 拼接（不推荐多次）

```dart
var s = "a" + "b";
```

---

## 2️⃣ 插值（推荐）

```dart
var s = "$a$b";
```

---

## 3️⃣ StringBuffer（🔥 高频）

```dart
var buffer = StringBuffer();
buffer.write("hello");
buffer.write(" ");
buffer.write("world");

var result = buffer.toString();
```

👉 **大量拼接必须用 StringBuffer**

---

# 六、String 常用方法大全（核心）

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

---

# 九、String 与数字互转（必会）

## String → num

```dart
int.parse("123");
double.parse("3.14");
```

⚠️ 防异常写法：

```dart
int.tryParse("abc"); // null
```

---

## num → String

```dart
(123).toString();
(3.1415).toStringAsFixed(2); // "3.14"
```

---

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

---

# 十四、Flutter 中 String 的典型场景

## 1️⃣ Text 显示

```dart
Text("Hello $name");
```

---

## 2️⃣ TextField 输入

```dart
TextEditingController controller = TextEditingController();
controller.text;
```

---

## 3️⃣ 表单校验

```dart
if (value == null || value.trim().isEmpty) {
  return "不能为空";
}
```

---

# 十五、String 常见错误总结（面试必考）

❌ 频繁 `+` 拼接字符串
❌ 混淆 `null` 和 `""`
❌ `substring` 越界
❌ emoji 用 `length` 计算字符数
❌ parse 不处理异常

---

# 十六、一句话记忆版

> **Dart 的 String = 不可变 + 插值强大 + StringBuffer 提效**

---

## 接下来我可以继续帮你👇

* ✅ **Dart 数字类型（int / double / num）大全**
* ✅ **Dart DateTime / 时间处理**
* ✅ **Flutter 表单 String 校验实战**
* ✅ **String + 正则 + 算法题**

你直接说下一步学哪个即可 👍
