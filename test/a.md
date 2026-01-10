


## 二、索引 & 截取类方法（非常常用）

### 6️⃣ `[]`

通过索引获取字符（返回 String）

```dart
String s = "dart";
print(s[0]); // d
```

---

### 7️⃣ `substring(int start, [int end])`

截取子串

```dart
print("flutter".substring(0, 4)); // flut
print("flutter".substring(2));    // utter
```

---

## 三、查找 & 判断（搜索类）

### 8️⃣ `contains(String other)`

是否包含子串

```dart
print("hello world".contains("world")); // true
```

---

### 9️⃣ `startsWith(String prefix)`

是否以某字符串开头

```dart
print("dartlang".startsWith("dart")); // true
```

---

### 🔟 `endsWith(String suffix)`

是否以某字符串结尾

```dart
print("main.dart".endsWith(".dart")); // true
```

---

### 1️⃣1️⃣ `indexOf(String pattern)`

第一次出现的位置

```dart
print("banana".indexOf("na")); // 2
```

---

### 1️⃣2️⃣ `lastIndexOf(String pattern)`

最后一次出现的位置

```dart
print("banana".lastIndexOf("na")); // 4
```

---

## 四、大小写 & 去空格（格式化）

### 1️⃣3️⃣ `toUpperCase()`

转大写

```dart
print("dart".toUpperCase()); // DART
```

---

### 1️⃣4️⃣ `toLowerCase()`

转小写

```dart
print("DART".toLowerCase()); // dart
```

---

### 1️⃣5️⃣ `trim()`

去除首尾空格

```dart
print("  hello  ".trim()); // hello
```

---

### 1️⃣6️⃣ `trimLeft()` / `trimRight()`

```dart
print("  hi".trimLeft());   // hi
print("hi  ".trimRight());  // hi
```

---

## 五、替换 & 分割（非常重要）

### 1️⃣7️⃣ `replaceAll(from, to)`

替换全部

```dart
print("a-b-c".replaceAll("-", ",")); // a,b,c
```

---

### 1️⃣8️⃣ `replaceFirst(from, to)`

只替换第一次

```dart
print("foo bar foo".replaceFirst("foo", "hi")); // hi bar foo
```

---

### 1️⃣9️⃣ `replaceRange(start, end, replacement)`

按范围替换

```dart
print("flutter".replaceRange(0, 3, "FL")); // FLtter
```

---

### 2️⃣0️⃣ `split(String pattern)`

分割字符串 → List<String>

```dart
print("a,b,c".split(",")); // [a, b, c]
```

---

### 2️⃣1️⃣ `splitMapJoin()`

高级分割 + 映射（少见但很强）

```dart
print("a1b2".splitMapJoin(
  RegExp(r'\d'),
  onMatch: (m) => "*",
)); // a*b*
```

---

## 六、比较 & 判断（逻辑类）

### 2️⃣2️⃣ `compareTo(String other)`

字符串比较（排序）

```dart
print("a".compareTo("b")); // <0
```

---

### 2️⃣3️⃣ `==`

字符串内容比较

```dart
print("dart" == "dart"); // true
```

---

### 2️⃣4️⃣ `hashCode`

哈希值（Map / Set）

```dart
print("dart".hashCode);
```

---

## 七、正则相关（必学）

### 2️⃣5️⃣ `contains(RegExp pattern)`

```dart
print("abc123".contains(RegExp(r'\d'))); // true
```

---

### 2️⃣6️⃣ `replaceAll(RegExp, String)`

```dart
print("a1b2".replaceAll(RegExp(r'\d'), "*")); // a*b*
```

---

### 2️⃣7️⃣ `split(RegExp)`

```dart
print("a1b2c".split(RegExp(r'\d'))); // [a, b, c]
```

---

## 八、字符串构建 & 拼接

### 2️⃣8️⃣ `+`

拼接字符串（不推荐大量使用）

```dart
String s = "hello " + "dart";
```

---

### 2️⃣9️⃣ 字符串插值（强烈推荐 ⭐）

```dart
String name = "Dart";
print("Hello $name");
print("2 + 3 = ${2 + 3}");
```

---

### 3️⃣0️⃣ `StringBuffer`（高性能拼接）

```dart
var buffer = StringBuffer();
buffer.write("Hello ");
buffer.write("Dart");
print(buffer.toString());
```

---

## 九、类型转换（开发中极常用）

### 3️⃣1️⃣ `int.parse()`

```dart
int n = int.parse("123");
```

---

### 3️⃣2️⃣ `double.parse()`

```dart
double d = double.parse("3.14");
```

---

### 3️⃣3️⃣ `toString()`

```dart
int x = 10;
print(x.toString());
```

---

## 十、少见但有用的方法

| 方法                     | 作用     |
| ---------------------- | ------ |
| `padLeft()`            | 左侧填充   |
| `padRight()`           | 右侧填充   |
| `replaceFirstMapped()` | 替换并映射  |
| `replaceAllMapped()`   | 高级正则替换 |

```dart
print("7".padLeft(3, "0")); // 007
```

---

## 十一、学习建议（非常重要）

你可以按这个**优先级学习**：

### ✅ 必须熟练（80% 场景）

* `length`
* `isEmpty / isNotEmpty`
* `substring`
* `split`
* `replaceAll`
* `contains`
* `toUpperCase / toLowerCase`
* 字符串插值

### 🔥 Flutter / 实战重点

* `trim`
* `indexOf`
* 正则 `RegExp`
* `StringBuffer`

---

## 如果你愿意，我可以继续帮你：

* 🔹 **String + 正则实战 20 例**
* 🔹 **Flutter 中字符串常见坑**
* 🔹 **String vs List vs StringBuffer 性能对比**
* 🔹 **Dart 面试中 String 高频考点**

你下一步想深入哪一块？
