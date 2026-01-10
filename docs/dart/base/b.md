下面给你一份**系统、可查表级别的 Dart `Future` 知识点 + 使用大全**。
我会按 **“是什么 → 怎么用 → 常见模式 → 错误处理 → 实战案例 → 易错点”** 的顺序来讲，适合你**学习 + 面试 + 实际写 Flutter / Dart 项目**。

---

## 一、Future 是什么（核心理解）

### 1️⃣ 定义

`Future<T>` 表示**一个将来某个时间点才会完成的值**：

* ✅ 成功完成 → 得到一个 `T`
* ❌ 失败 → 抛出一个 `Error / Exception`

```dart
Future<int> f = Future.value(10);
```

> **一句话记忆**：
> **Future = 现在拿不到结果，将来才能拿到**

---

### 2️⃣ Future 的三种状态（非常重要）

| 状态                   | 说明       |
| -------------------- | -------- |
| pending              | 正在执行，未完成 |
| completed with value | 成功完成     |
| completed with error | 失败完成     |

⚠️ **Future 只能完成一次，不可重复**

---

## 二、创建 Future 的所有方式（大全）

### ✅ 1. `Future.value`

```dart
Future<int> f = Future.value(100);
```

* 立即完成
* 常用于测试 / mock

---

### ✅ 2. `Future.error`

```dart
Future f = Future.error('出错了');
```

---

### ✅ 3. `Future.delayed`（最常见）

```dart
Future<String> fetchData() {
  return Future.delayed(
    Duration(seconds: 2),
    () => '数据返回',
  );
}
```

---

### ✅ 4. `async` 函数（**最推荐**）

```dart
Future<int> getNumber() async {
  return 42;
}
```

等价于：

```dart
Future<int> getNumber() {
  return Future.value(42);
}
```

---

### ✅ 5. `Future(() {})`

```dart
Future(() {
  print('异步任务');
});
```

> ⚠️ 会被放入 **事件队列（Event Queue）**

---

## 三、Future 的核心 API（必会）

---

### 1️⃣ `then` —— 处理成功结果

```dart
fetchData().then((value) {
  print(value);
});
```

* 链式调用
* 返回 **新的 Future**

```dart
Future<int> f = Future.value(1)
  .then((v) => v + 1)
  .then((v) => v * 10);
```

---

### 2️⃣ `catchError` —— 捕获异常

```dart
fetchData()
  .then(print)
  .catchError((e) {
    print('错误: $e');
  });
```

---

### 3️⃣ `whenComplete` —— 最终执行（类似 finally）

```dart
fetchData()
  .then(print)
  .catchError(print)
  .whenComplete(() {
    print('无论成功失败都会执行');
  });
```

---

### 4️⃣ `timeout`

```dart
fetchData().timeout(
  Duration(seconds: 1),
  onTimeout: () => '超时返回',
);
```

---

## 四、async / await（最重要部分）

### 1️⃣ 基本用法

```dart
Future<void> main() async {
  String result = await fetchData();
  print(result);
}
```

📌 **await 只能在 async 函数中使用**

---

### 2️⃣ 顺序执行（默认）

```dart
await task1();
await task2();
await task3();
```

---

### 3️⃣ 并发执行（性能关键）

❌ 错误写法（串行）：

```dart
await task1();
await task2();
```

✅ 正确并发：

```dart
final f1 = task1();
final f2 = task2();

await f1;
await f2;
```

---

## 五、Future 并发控制（重点）

---

### 1️⃣ `Future.wait`（全部完成）

```dart
final results = await Future.wait([
  fetchData1(),
  fetchData2(),
  fetchData3(),
]);
```

* 并发执行
* 有一个失败 → 整体失败

---

### 2️⃣ `Future.any`（第一个完成）

```dart
final result = await Future.any([
  fetchFast(),
  fetchSlow(),
]);
```

---

### 3️⃣ `Future.forEach`（顺序执行）

```dart
await Future.forEach(list, (item) async {
  await process(item);
});
```

---

### 4️⃣ `Future.doWhile`

```dart
int count = 0;
await Future.doWhile(() async {
  count++;
  return count < 5;
});
```

---

## 六、异常处理（必考）

### ✅ try-catch（推荐）

```dart
try {
  final data = await fetchData();
  print(data);
} catch (e, stack) {
  print(e);
}
```

---

### ❌ 错误写法（常见坑）

```dart
try {
  fetchData(); // ❌ 没 await，catch 不到
} catch (e) {}
```

---

### ✅ Future 内部抛异常

```dart
Future<String> errorFuture() async {
  throw Exception('出错');
}
```

---

## 七、Future 与 Flutter（非常重要）

---

### 1️⃣ `FutureBuilder`

```dart
FutureBuilder<String>(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    }
    if (snapshot.hasError) {
      return Text('错误');
    }
    return Text(snapshot.data!);
  },
);
```

---

### 2️⃣ 避免 FutureBuilder 重复执行

❌ 错误：

```dart
future: fetchData(),
```

✅ 正确：

```dart
late Future<String> _future;

@override
void initState() {
  super.initState();
  _future = fetchData();
}
```

---

## 八、Future vs Stream（面试常问）

| 对比   | Future  | Stream    |
| ---- | ------- | --------- |
| 返回次数 | 1 次     | 多次        |
| 使用场景 | 一次性结果   | 连续数据      |
| 典型   | HTTP 请求 | WebSocket |

---

## 九、Event Loop 与 Future（进阶）

### 微任务 vs 事件任务

```dart
Future(() => print('event'));
Future.microtask(() => print('microtask'));
```

执行顺序：

```
microtask
event
```

📌 **microtask 优先级更高**

---

## 十、常见坑总结（你一定会踩）

❌ 忘记 `await`
❌ try-catch 抓不到 Future 错误
❌ 在 build 中创建 Future
❌ 串行 await 导致性能问题
❌ FutureBuilder 重复请求

---

## 十一、完整实战案例（网络请求模拟）

```dart
Future<String> fetchUser() async {
  await Future.delayed(Duration(seconds: 2));
  return '张三';
}

Future<void> main() async {
  try {
    final user = await fetchUser();
    print(user);
  } catch (e) {
    print('失败');
  } finally {
    print('结束');
  }
}
```

---

## 十二、学习建议（给你一句实话）

> **Future 不难，难的是：**
>
> * 并发控制
> * 错误传播
> * Flutter 中的生命周期配合

如果你愿意，**下一步我可以帮你：**

* 🔥 画一张 **Future / async / await 执行流程图**
* 🔥 对比 **Future vs Stream vs Isolate**
* 🔥 写 **Flutter 项目中 Future 的最佳实践模板**

你想先学哪一个？
