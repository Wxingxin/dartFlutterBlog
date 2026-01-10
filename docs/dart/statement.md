

# 一、什么是 Dart 的语句？

👉 **语句 = 控制程序执行流程的最小单位**

比如：

```dart
print('Hello');      // 表达式语句
if (a > b) {}        // 条件语句
for (var i = 0; i < 5; i++) {} // 循环语句
```


# 二、Dart 语句整体分类（全景图）

Dart 的语句可以分为 **7 大类**：

1. **表达式语句**
2. **声明语句**
3. **条件判断语句**
4. **循环语句**
5. **跳转控制语句**
6. **异常处理语句**
7. **异步控制语句（async / await）**



# 三、表达式语句（Expression Statements）

### 1️⃣ 普通表达式

```dart
a + b;
foo();
i++;
```



### 2️⃣ 赋值语句

```dart
a = 10;
a += 1;
```



### 3️⃣ 方法调用语句

```dart
print('Hello');
list.add(1);
```



# 四、声明语句（Declaration Statements）

## 1️⃣ 变量声明

```dart
var a = 10;
final b = 20;
const c = 30;
late String name;
```

### 区别速记：

* `var`：可变
* `final`：运行时常量
* `const`：编译期常量
* `late`：延迟初始化



## 2️⃣ 函数声明

```dart
int add(int a, int b) {
  return a + b;
}
```



## 3️⃣ 类 / 枚举 / typedef

```dart
class Person {}
enum Status { success, fail }
typedef IntOp = int Function(int, int);
```



# 五、条件判断语句（Conditional）

## 1️⃣ `if / else if / else`

```dart
void main() {
  int score = 85;

  // 基本的 if 语句
  if (score >= 90) {
    print("优秀");
  }
  // else if 表示当上面条件不满足时，尝试另一个条件
  else if (score >= 80) {
    print("良好");
  }
  else if (score >= 60) {
    print("及格");
  }
  // else 表示以上所有条件都不满足时执行
  else {
    print("不及格");
  }
}
```

🧠 **说明：**

- 条件必须是 `bool` 类型（true / false）。
- Dart 不支持像 JavaScript 那样的“非零即真”语法，必须写成明确的布尔表达式。




## 2️⃣ `switch / case` ⭐ Dart 强项

```dart
switch (status) {
  case Status.success:
    print('成功');
    break;
  case Status.fail:
    print('失败');
    break;
  default:
    print('未知');
}
```

```dart
void main() {
  String role = "admin";

  switch (role) {
    case "admin":
      print("管理员权限");
      break;

    case "user":
      print("普通用户权限");
      break;

    case "guest":
      print("游客权限");
      break;

    default:
      print("未知身份");
  }
}
```

Dart 的 `switch` 比较独特：

- 支持 **字符串**、**枚举**、甚至 **对象**。
- `case` 后面的表达式必须是常量。
- 每个 `case` 语句块**必须以 `break`、`return` 或 `continue` 结束**。


### Dart 3 新特性（了解）

```dart
switch (value) {
  case > 0:
    print('正数');
  case < 0:
    print('负数');
  default:
    print('零');
}
```



## 3️⃣ 条件表达式（语句中常用）

```dart
var result = isVip ? 'VIP' : '普通';
```



# 六、循环语句（Loop）

## 1️⃣ `for`
```dart
void main() {
  for (int i = 1; i <= 5; i++) {
    print("第 $i 次循环");
  }
}
```

🧠 **说明：**

- 三个部分分别是：

  1. 初始化：`int i = 1`
  2. 条件判断：`i <= 5`
  3. 迭代操作：`i++`

- 每执行一轮循环后，都会检查条件是否为真。



## 2️⃣ `for-in`

```dart
void main() {
  List<String> fruits = ["苹果", "香蕉", "橙子"];

  for (String fruit in fruits) {
    print("我喜欢吃 $fruit");
  }
}
```

💡 Flutter 中非常常见，例如遍历一个组件列表：

```dart
for (var item in items) Text(item)
```


## 3️⃣ `while`

```dart
void main() {
  int i = 1;

  while (i <= 5) {
    print("当前数字：$i");
    i++;
  }
}
```

🧠 **说明：**

- `while` 先判断条件，再执行代码块；
- 如果第一次条件为 `false`，循环体**一次都不会执行**。


## 4️⃣ `do-while`
```dart
void main() {
  int count = 0;

  do {
    print("执行第 ${count + 1} 次");
    count++;
  } while (count < 3);
}
```

🧠 **区别：**

- `do...while` 会**先执行一次循环体**，再判断条件；
- 所以即使一开始条件是 `false`，也至少执行一次。



## 5️⃣ `await for`（异步流）

```dart
await for (var event in stream) {
  print(event);
}
```



# 七、跳转控制语句（Jump）

## 1️⃣ `break`

```dart
for (;;) {
  break;
}
```



## 2️⃣ `continue`

```dart
for (var i = 0; i < 5; i++) {
  if (i == 2) continue;
  print(i);
}
```



## 3️⃣ `return`

```dart
return value;
```



## 4️⃣ `yield / yield*`（生成器）

```dart
Iterable<int> numbers() sync* {
  yield 1;
  yield 2;
  yield* [3, 4];
}
```



# 八、异常处理语句（Exception）

## 1️⃣ `try / catch / finally`

```dart
try {
  int.parse('abc');
} catch (e) {
  print(e);
} finally {
  print('结束');
}
```



## 2️⃣ 捕获指定异常

```dart
try {
  // ...
} on FormatException catch (e) {
  print(e.message);
}
```



## 3️⃣ 抛出异常

```dart
throw Exception('出错了');
```



## 4️⃣ 重新抛出

```dart
rethrow;
```



# 九、异步控制语句（Async）

## 1️⃣ `async / await`

```dart
Future<void> fetch() async {
  var data = await loadData();
}
```



## 2️⃣ `async* / sync*`

```dart
Stream<int> count() async* {
  yield 1;
  yield 2;
}
```



# 十、代码块与作用域

```dart
{
  int a = 10;
}
// a 在这里不可用
```



# 十一、Flutter / Dart 高频实战语句

### ✅ 1. 条件渲染

```dart
if (isLogin) ...[
  Text('欢迎'),
]
```



### ✅ 2. 列表构建

```dart
for (var item in items)
  ListTile(title: Text(item))
```



### ✅ 3. 空安全判断

```dart
if (user != null) {
  print(user.name);
}
```



# 十二、常见错误（一定避开）

❌ `switch` 忘记 `break`
❌ `for` 循环修改集合
❌ `late` 未初始化就使用
❌ `await` 忘记 `async`


