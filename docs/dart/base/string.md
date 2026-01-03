

# 字符串（String）

Dart 字符串是 **UTF-16 编码的字符序列**，支持中文、Emoji、转义、插值等功能。


## ✅ 1. 定义字符串

```dart
String s1 = 'Hello';
String s2 = "World";

String s3 = '''
多行字符串1
支持换行
''';

String s4 = """
多行字符串2
""";
```

---

## ✅ 2. 字符串拼接与插值

```dart
String name = 'Jiaxing';
int age = 21;

print('Hello ' + name);               // 拼接
print('My name is $name');            // 插值
print('I am ${age + 1} years old.');  // 表达式插值
```

---

## ✅ 3. 字符串常用方法大全

| 方法                                       | 说明             | 示例                           |
| ------------------------------------------ | ---------------- | ------------------------------ |
| `.length`                                  | 获取字符串长度   | `'abc'.length → 3`             |
| `.isEmpty` / `.isNotEmpty`                 | 是否为空         | `"".isEmpty → true`            |
| `.toUpperCase()` / `.toLowerCase()`        | 大小写转换       | `'abc'.toUpperCase() → ABC`    |
| `.contains(sub)`                           | 是否包含         | `'dart'.contains('ar') → true` |
| `.startsWith(prefix)`                      | 以某字符开头     | `'dart'.startsWith('da')`      |
| `.endsWith(suffix)`                        | 以某字符结尾     | `'dart'.endsWith('rt')`        |
| `.indexOf()` / `.lastIndexOf()`            | 查找子串位置     | `'dartlang'.indexOf('a')`      |
| `.substring(start, end)`                   | 截取字符串       | `'dart'.substring(1, 3) → ar`  |
| `.replaceAll(a, b)`                        | 全局替换         | `'a-b-c'.replaceAll('-', '/')` |
| `.split()`                                 | 拆分字符串为列表 | `'a,b,c'.split(',')`           |
| `.trim()` / `.trimLeft()` / `.trimRight()` | 去空格           | `' hello '.trim() → 'hello'`   |

---

## ✅ 4. 多行字符串格式化输出

```dart
String msg = '''
Hello $name,
Welcome to Dart world!
Today is ${DateTime.now().year}.
''';
print(msg);
```

---

## ✅ 5. 原始字符串（避免转义）

```dart
String path = r'C:\Users\Dart\bin'; // 使用 r 前缀
print(path); // 输出 C:\Users\Dart\bin
```

---

## ✅ 6. 字符串与数字互转

```dart
String s = '100';
int num = int.parse(s);  // String → int
String s2 = num.toString(); // int → String
```

---
