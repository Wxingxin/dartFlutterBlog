# dart



## 一句话先认识 Dart 🧠

> **Dart 是一门为 UI 而生的现代编程语言**
> 由 Google 推出，**Flutter 的官方语言**，主打：
> **简单、强类型、高性能、适合前端/客户端开发**

![Image](https://upload.wikimedia.org/wikipedia/commons/c/c6/Dart_logo.png)

![Image](https://docs.flutter.dev/assets/images/docs/app-architecture/guide/feature-architecture-simplified.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/0%2A04F1yf-obnxkUumN)

---

## 一、Dart 用来干嘛？

### 核心用途（记住这 3 个就够了）

1. **Flutter 开发 App（最重要）**

   * Android / iOS / Web / Windows / macOS / Linux
2. **前端 & UI 密集型应用**
3. **替代 JS 的一部分场景（但不是完全替代）**

👉 **90% 的人学 Dart = 为了 Flutter**

---

## 二、Dart 和 JavaScript / Java 的关系

如果你是前端（你之前问过 JS / React，我按这个背景讲）👇

| 对比  | Dart         | JavaScript |
| --- | ------------ | ---------- |
| 类型  | **强类型（可选）**  | 弱类型        |
| 运行  | AOT / JIT    | 解释执行       |
| 语法  | 像 JS + Java  | 灵活但易出错     |
| UI  | 天然适合 Flutter | 依赖框架       |
| 工程性 | ⭐⭐⭐⭐         | ⭐⭐⭐        |

👉 **Dart = 写起来像 JS，结构像 Java**

---

## 三、Dart 的核心特点（面试 & 学习重点）

### 1️⃣ 强类型，但不啰嗦

```dart
int a = 10;
String name = "Tom";
bool ok = true;
```

也可以偷懒：

```dart
var a = 10;     // 编译期自动推断
final b = 20;  // 运行时不可变
const c = 30;  // 编译期常量
```

👉 **推荐：`var + final` 用得最多**

---

### 2️⃣ 一切皆对象（很 Java）

```dart
int a = 10;
print(a.toString()); // int 也是对象
```

✔ 没有 primitive vs object 的割裂感

---

### 3️⃣ null safety（非常重要！）

Dart 最大特色之一：**空安全**

```dart
String name = "Tom"; 
// name = null ❌

String? name2 = null; // ✅ 允许为空
```

常用操作：

```dart
name2?.length;     // 安全访问
name2 ?? "默认值"; // 兜底
```

👉 **这点比 JS 强很多，Flutter 稳定性的关键**

---

## 四、函数 & 箭头函数（你会很熟）

```dart
int add(int a, int b) {
  return a + b;
}
```

箭头函数：

```dart
int add(int a, int b) => a + b;
```

可选参数（Flutter 用到爆）

```dart
void sayHi(String name, {int age = 18}) {
  print("$name $age");
}

sayHi("Tom", age: 20);
```

---

## 五、集合类型（和 JS 很像）

### List（数组）

```dart
List<int> nums = [1, 2, 3];
nums.add(4);
```

### Map（对象）

```dart
Map<String, dynamic> user = {
  "name": "Tom",
  "age": 18
};
```

### Set（去重）

```dart
Set<int> s = {1, 2, 3};
```

---

## 六、类 & 构造函数（Flutter 核心）

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void sayHi() {
    print("Hi, I'm $name");
  }
}
```

创建对象：

```dart
var p = Person("Tom", 18);
p.sayHi();
```

👉 **Flutter 的 Widget 全是 class**

---

## 七、异步：Future / async / await（重点）

```dart
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1));
  return "data";
}

void main() async {
  var res = await fetchData();
  print(res);
}
```

👉 思想 = JS 的 Promise
👉 写法 = 更严谨

---

## 八、Dart 的运行方式（为什么性能好）

| 模式  | 用途        |
| --- | --------- |
| JIT | 开发调试（热重载） |
| AOT | 发布上线（高性能） |

👉 Flutter 秒级热重载，全靠 Dart

---

## 九、学习 Dart 的正确路线（重点）

### ❌ 错误路线

* 纯刷 Dart 语法
* 看 Java 风格的教程
* 不碰 Flutter

### ✅ 正确路线（推荐）

**阶段 1（1–2 天）**

* Dart 基础语法
* null safety
* async / await

**阶段 2（立刻结合 Flutter）**

* Widget 是什么
* StatelessWidget / StatefulWidget
* 布局（Row / Column / Stack）

**阶段 3（项目驱动）**

* 一个 Todo App
* 一个列表 + 网络请求
* 一个简单状态管理

---

## 十、你可以马上开始的最小代码

```dart
void main() {
  print("Hello Dart");
}
```

---

## 总结一句话给你 💡

> **Dart 是一门“为 Flutter 服务”的语言**
> 学它的目的不是精通语法，而是：
> **快速写出稳定、好看的 UI 应用**

---

如果你愿意，我可以下一步直接帮你：
1️⃣ **用前端视角对比 Dart vs JS**
2️⃣ **直接进入 Flutter，不单独学 Dart**（更高效）
3️⃣ **给你一套 Dart + Flutter 学习清单（7 天）**

你选一个，我按你的节奏来。
