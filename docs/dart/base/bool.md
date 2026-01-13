## bool

### bool 是什么

在 Dart 中，**bool 只有两个值**：

```dart
bool flag = true;
bool ok = false;
```

👉 特点：

- 只有 `true / false`
- **没有 0 / 1 的隐式转换**
- 强类型（非常重要）

### bool 的声明方式

```dart
bool isLogin = true;
var isDarkMode = false; // 自动推断 bool
```

⚠️ Dart **不允许**这样写：

```dart
if (1) {}      // ❌
if ("true") {}// ❌
```

## bool 的属性和方法

### bool 属性

| 属性                | 干什么                                     | 返回值 |
| ------------------- | ------------------------------------------ | ------ |
| hashcode(Object)    | 返回一个整数(常用于：Set、Map 的 key 比较) | number |
| runtimeType(Object) | 运行时类型调试、日志中偶尔使用             | bool   |

### bool 方法

| 方法           | 干什么                              | 返回值 |
| -------------- | ----------------------------------- | ------ |
| tostring()     | 日志 拼接字符串 调试输出            | String |
| noSuchMethod() | 几乎不会手动使用 主要用于反射、代理 | ？     |

```dart
print(true.toString());   // "true"
print(false.toString());  // "false"

true.noSuchMethod(Invocation.method(#test, []));

```

## bool 的来源（常见）

### 1️⃣ 比较表达式

```dart
bool a = 3 > 2;        // true
bool b = x == y;
```

### 2️⃣ 方法返回值

```dart
list.isEmpty;
map.containsKey("id");
```

### 3️⃣ 逻辑判断结果

```dart
bool valid = age >= 18 && isVip;
```

# 四、逻辑运算符（必考）

| 运算符 | 含义 |     |     |
| ------ | ---- | --- | --- |
| `&&`   | 与   |     |     |
| `      |      | `   | 或  |
| `!`    | 非   |     |     |

```dart
if (a && b) {}
if (a || b) {}
if (!a) {}
```

## 五、bool 与比较运算符（基础）

```dart
==  !=  >  <  >=  <=
```

示例：

```dart
if (age >= 18) {}
```

⚠️ `==` 是值比较（不是地址）

---

# 六、bool 与 null safety（🔥 必考）

## 1️⃣ 可空 bool

```dart
bool? isChecked;
```

---

## 2️⃣ 安全使用方式

```dart
if (isChecked == true) {}
```

或：

```dart
if (isChecked ?? false) {}
```

---

## 3️⃣ ❌ 常见错误

```dart
if (isChecked) {} // ❌ isChecked 可能为 null
```

---

# 七、bool 的判空 / 判状态技巧（高频）

## 1️⃣ 显式判断（推荐）

```dart
if (value != null && value.isNotEmpty) {}
```

---

## 2️⃣ 利用 bool 表达式

```dart
bool hasText = text.isNotEmpty;
```

---

## 3️⃣ 三元运算符

```dart
String msg = isLogin ? "已登录" : "未登录";
```

---

# 八、bool 在控制流中的使用（核心）

## 1️⃣ if / else

```dart
if (isLogin) {
  ...
} else {
  ...
}
```

---

## 2️⃣ while / do-while

```dart
while (isRunning) {}

do {
  ...
} while (isRunning);
```

---

## 3️⃣ for 中的 bool 条件

```dart
for (int i = 0; i < 10; i++) {}
```

---

# 九、bool 与函数（常见设计）

## 1️⃣ 返回 bool（校验函数）

```dart
bool isValid(String s) {
  return s.isNotEmpty;
}
```

---

## 2️⃣ 函数作为条件

```dart
if (isValid(input)) {}
```

---

# 十、bool 与集合（非常常见）

```dart
list.any((e) => e > 10);
list.every((e) => e > 0);
set.contains(1);
map.containsKey("id");
```

---

# 十一、Flutter 中 bool 的典型场景（🔥）

## 1️⃣ UI 状态控制

```dart
bool isLoading = false;
```

```dart
isLoading ? CircularProgressIndicator() : Text("加载完成");
```

---

## 2️⃣ Switch / Checkbox

```dart
Switch(
  value: isDark,
  onChanged: (v) {
    setState(() {
      isDark = v;
    });
  },
);
```

---

## 3️⃣ 表单校验

```dart
bool isValid = formKey.currentState?.validate() ?? false;
```

# 十三、一句话记忆版

> **Dart 的 bool = 强类型 + 只认 true / false + null 安全优先**
