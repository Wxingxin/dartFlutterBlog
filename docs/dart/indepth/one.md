我来把 Dart 单线程里的 **消息循环（event loop）** 讲透：先把机制讲清楚，再用一堆“能跑的例子”帮你建立直觉（你一眼就能判断输出顺序）。

## 1) 核心概念：Dart 单线程怎么“同时做很多事”？

Dart（在 main isolate 里）是**单线程执行**：同一时刻只跑一段代码。它能处理异步，是靠：

- **Call Stack（调用栈）**：当前正在执行的同步代码
- **Microtask Queue（微任务队列）**：优先级高，用于“尽快执行但必须等同步代码结束”
- **Event Queue（事件队列）**：普通优先级，用于 I/O、Timer、UI 事件、Future 的一些回调等
- **Event Loop（消息循环）**：不停地做选择题

  1. 先执行完所有同步代码
  2. 清空 **microtask queue**（一直清到空）
  3. 取出 **event queue** 头部一个事件执行
  4. 执行完后，再回到 2)（先清 microtask）
  5. 循环往复

一句话：**同步 > 微任务 > 事件（每次只拿一个事件，但会先把微任务清空）**

## 2) 两个队列分别装什么？

### 微任务队列 Microtask Queue（高优先级）

典型来源：

- `scheduleMicrotask(() {})`
- `Future.microtask(() {})`
- `Future((){}).then(...)` 的 `then` 回调**很多情况下**会走微任务（你可把 then 当成“比事件更快的回调”来理解）
- 一些底层框架/库内部用来“在本轮事件结束后立刻收尾”的任务

特点：

- **只要微任务队列不空，就不会去处理事件队列**
- 如果你不断往微任务里塞微任务，可能造成 **事件饿死（event starvation）**：Timer/I/O 一直得不到执行机会

### 事件队列 Event Queue（普通优先级）

典型来源：

- `Timer.run(() {})`、`Timer(Duration...)`
- I/O：文件/网络/Socket 完成事件
- UI 事件（Flutter 的手势/绘制等）
- `Future(() {})`（也就是 `Future` 构造函数创建的异步任务，通常走事件队列）

特点：

- 每轮 event loop 只取一个事件来执行
  执行完这个事件后，会先**清空微任务**，再取下一个事件

## 3) 最重要的顺序规则（背下来就稳了）

**规则 A：同步代码永远先跑完**
**规则 B：同步跑完后，先清空所有微任务**
**规则 C：再取一个事件执行**
**规则 D：每执行完一个事件，又会先清空微任务**

## 4) 经典案例 1：同步 / 微任务 / 事件的输出顺序

```dart
import 'dart:async';

void main() {
  print('A sync start');

  scheduleMicrotask(() => print('B microtask'));
  Future.microtask(() => print('C microtask (Future.microtask)'));

  Future(() => print('D event (Future)'));
  Timer.run(() => print('E event (Timer.run)'));

  print('F sync end');
}
```

你应该预期的输出顺序是：

1. `A sync start`（同步）
2. `F sync end`（同步）
3. `B microtask`
4. `C microtask (Future.microtask)`
5. `D event (Future)`
6. `E event (Timer.run)`

解释：同步先跑完 → 清空微任务（B、C）→ 再处理事件（D、E）。

> 注意：`D event` 和 `E event` 两者先后，在大多数实现里通常按入队顺序，但不同来源在极少数情况下会受实现细节影响。学习阶段你可以把它们都归为“事件队列里的任务”，重点是它们 **一定晚于微任务**。

## 5) 经典案例 2：事件执行完后，会先清微任务再进下一个事件

```dart
import 'dart:async';

void main() {
  Timer.run(() {
    print('A event 1');

    scheduleMicrotask(() => print('B microtask inside event 1'));
  });

  Timer.run(() {
    print('C event 2');
  });
}
```

输出顺序会是：

1. `A event 1`
2. `B microtask inside event 1`
3. `C event 2`

解释：执行第一个事件时塞了一个微任务。事件结束后，event loop 先清掉微任务，再去取下一个事件。

## 6) 经典案例 3：微任务“饿死”事件（别这么写）

```dart
import 'dart:async';

void main() {
  Timer.run(() => print('Timer fired'));

  void loopMicrotask() {
    scheduleMicrotask(() {
      print('microtask');
      loopMicrotask(); // 不断往微任务队列塞微任务
    });
  }

  loopMicrotask();
}
```

现象：你会看到一直打印 `microtask`，`Timer fired` 可能永远不会出现。
原因：微任务队列永远不空，事件队列永远轮不到。

**结论：微任务适合做短小的“收尾/衔接”，不适合做无限循环或重任务。**

## 7) 经典案例 4：`async/await` 到底在哪个队列？

关键点：

- `await` 会把后续代码变成“稍后执行”的 continuation
- 这个 continuation 通常会被安排为“尽快执行”的任务（很多场景可当作微任务优先级来理解）

例子：

```dart
import 'dart:async';

Future<void> foo() async {
  print('A foo start');
  await Future(() => print('B event in await (Future)'));
  print('C foo after await');
}

void main() {
  print('main start');
  foo();
  scheduleMicrotask(() => print('microtask in main'));
  print('main end');
}
```

一个常见输出顺序是：

1. `main start`
2. `A foo start`
3. `main end`
4. `microtask in main`
5. `B event in await (Future)`
6. `C foo after await`

解释：

- `foo()` 先同步打印 A
- `await Future(...)` 会让 `B` 作为事件执行
- `await` 后面的 `C` 要等 `B` 完成后再继续
- 同时 main 里的 microtask 会先于事件执行

## 8) 你写代码时的实用判断法（非常好用）

当你看到一个任务，先问自己三个问题：

1. 这是同步吗？（print、普通函数调用）
   → **马上执行**，不会进队列

2. 这是微任务吗？（`scheduleMicrotask` / `Future.microtask` / 很多 then）
   → **同步结束后立刻**执行，优先于 Timer / I/O

3. 这是事件吗？（`Future((){})` / `Timer` / I/O 完成回调）
   → **等微任务清空后**再执行

## 9) 在 Flutter 里跟你最相关的两点

- **不要在 build 里做副作用**（发请求、弹 toast、导航），通常要放到：

  - `initState` + `Future.microtask` / `addPostFrameCallback`（Flutter 专用）
  - 或用 Riverpod 的 `ref.listen` 去做副作用

- **UI 卡顿**通常不是“队列顺序”问题，而是你在单线程里做了太重的同步计算

  - 重计算用 `Isolate` / `compute`（Flutter）分出去

## 10) 小练习：你来预测输出（训练直觉）

你可以自己想一下顺序（不急着跑）：

```dart
import 'dart:async';

void main() {
  print('1');

  Future(() => print('2 event'));
  scheduleMicrotask(() => print('3 micro'));

  Future.microtask(() => print('4 micro'));
  Timer.run(() => print('5 event'));

  print('6');

  Future(() {
    print('7 event');
    scheduleMicrotask(() => print('8 micro inside 7'));
  });

  scheduleMicrotask(() => print('9 micro'));
}
```

如果你把你预测的顺序发我，我会帮你逐行对照解释（并指出你思维里可能混淆的点）。
