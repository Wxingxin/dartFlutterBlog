我先把你问的两件事一句话定性清楚，然后把 **Isolate 的属性/方法**按“实例成员 / 静态成员 / 常量”给你列全，并配一个最常见的 `spawn + SendPort/ReceivePort` 通信例子。

---

## 1) Stream 是什么？类型 / 内置方法？

`Stream` **不是方法**，而是 Dart 的**内置抽象泛型类**（`Stream<T>`），表示“**异步事件序列**”（会持续产出 0~N 个数据/错误/结束事件）。([api.dart.dev][1])
你处理它最常见的方式是 `listen()` 或 `await for`。([api.flutter.dev][2])

---

## 2) Isolate 是什么？（你写的 lsolate 指 Isolate）

`Isolate` 也是 Dart 的**内置类**（`dart:isolate`），代表一个**隔离的执行上下文**：

* 每个 isolate 有自己的事件循环、自己的内存堆
* isolate 之间**不能共享对象内存**，只能通过 `SendPort/ReceivePort` 传“可发送”的数据进行通信 ([api.dart.dev][3])

---

# 3) Isolate 的属性大全（Properties）

下面这些是 `Isolate` 类文档里直接列出来的属性：([api.dart.dev][3])

### 实例属性（instance properties）

* `controlPort -> SendPort`：控制该 isolate 的控制端口（用于 pause/kill 等控制消息）([api.dart.dev][3])
* `debugName -> String?`：调试显示用的名字（只读）([api.dart.dev][3])
* `errors -> Stream`：该 isolate 的**未捕获错误**广播流（broadcast stream）([api.dart.dev][3])
* `pauseCapability -> Capability?`：是否有权限暂停该 isolate ([api.dart.dev][3])
* `terminateCapability -> Capability?`：是否有权限终止该 isolate ([api.dart.dev][3])

（另外还有继承自 `Object` 的 `hashCode/runtimeType` 等常规属性，通常不作为 isolate 学习重点。）

### 静态属性（static properties）

* `Isolate.current -> Isolate`：当前 isolate 的引用 ([api.dart.dev][3])
* `Isolate.packageConfig -> Future<Uri?>`：当前 isolate 的 package config 位置（异步）([api.dart.dev][3])
* `Isolate.packageConfigSync -> Uri?`：同上（同步）([api.dart.dev][3])

---

# 4) Isolate 的方法大全（Methods）

这些是文档列出的实例方法 + 静态方法：([api.dart.dev][3])

## A. 实例方法（控制 & 监听）

* `addErrorListener(SendPort port)`：把未捕获错误发送到某个端口 ([api.dart.dev][3])
* `removeErrorListener(SendPort port)`：移除错误监听 ([api.dart.dev][3])
* `addOnExitListener(SendPort responsePort, {Object? response})`：isolate 结束时往端口发退出消息 ([api.dart.dev][3])
* `removeOnExitListener(SendPort responsePort)`：移除退出监听 ([api.dart.dev][3])
* `pause([Capability? resumeCapability]) -> Capability`：暂停 isolate（返回用于恢复的 capability）([api.dart.dev][3])
* `resume(Capability resumeCapability)`：恢复暂停 ([api.dart.dev][3])
* `kill({int priority = beforeNextEvent})`：请求关闭 isolate ([api.dart.dev][3])
* `ping(SendPort responsePort, {Object? response, int priority = immediate})`：让 isolate 回发一个响应（常用于探活/同步点）([api.dart.dev][3])
* `setErrorsFatal(bool errorsAreFatal)`：设置未捕获错误是否让 isolate 直接终止（需要 terminateCapability）([api.flutter.dev][4])

## B. 静态方法（创建 / 运行 / 退出）

* `Isolate.spawn<T>(entryPoint, message, {paused, errorsAreFatal, onExit, onError, debugName})`：创建新 isolate（同代码）([api.dart.dev][5])
* `Isolate.spawnUri(uri, args, message, {...})`：用某个脚本 URI 启动新 isolate ([api.dart.dev][6])
* `Isolate.run<R>(computation, {debugName})`：把一个函数丢到新 isolate 执行并拿回结果（更“傻瓜式”）([api.flutter.dev][7])
* `Isolate.exit([SendPort? finalMessagePort, Object? message]) -> Never`：当前 isolate 立即退出，可选发最终消息 ([api.dart.dev][3])
* `resolvePackageUri / resolvePackageUriSync`：解析 `package:` URI ([api.dart.dev][3])

## C. 常量（priority）

* `Isolate.immediate`：立即执行（给 `kill/ping` 用）([api.dart.dev][3])
* `Isolate.beforeNextEvent`：在下一个 event 前执行（给 `kill/ping` 用）([api.dart.dev][3])

---

# 5) 最常用 Isolate 通信例子（spawn + 端口）

这个例子展示：主 isolate 创建子 isolate，互发消息。

```dart
import 'dart:isolate';

void worker(SendPort mainSendPort) async {
  // 子 isolate 自己也创建一个接收口，用来接收主 isolate 的消息
  final workerReceivePort = ReceivePort();
  // 把“我这边的 SendPort”发给主 isolate，这样主 isolate 就能给我发消息
  mainSendPort.send(workerReceivePort.sendPort);

  await for (final msg in workerReceivePort) {
    if (msg is int) {
      mainSendPort.send('worker got $msg, squared = ${msg * msg}');
    } else if (msg == 'close') {
      workerReceivePort.close();
      Isolate.exit(mainSendPort, 'worker exit');
    }
  }
}

Future<void> main() async {
  final mainReceivePort = ReceivePort();

  final isolate = await Isolate.spawn(worker, mainReceivePort.sendPort);

  // 第一次收到的是子 isolate 发来的它自己的 SendPort
  final workerSendPort = await mainReceivePort.first as SendPort;

  workerSendPort.send(7);
  print(await mainReceivePort.first); // worker 的计算结果

  workerSendPort.send('close');
  print(await mainReceivePort.first); // worker exit

  mainReceivePort.close();
  isolate.kill(); // 一般这行用不上：子 isolate 已 exit
}
```

---

如果你下一步想“真正掌握”Isolate，我建议你紧接着学这 3 个点（很实战）：

1. **哪些对象能通过 SendPort 发送**（可发送性规则）
2. `Isolate.run` vs `spawn`：什么时候用哪个
3. Flutter 场景：CPU 密集任务（JSON 大解析/图片处理）怎么用 isolate 避免卡 UI

你想先从哪一个点继续？

[1]: https://api.dart.dev/dart-async/Stream-class.html?utm_source=chatgpt.com "Stream class - dart:async library"
[2]: https://api.flutter.dev/flutter/dart-async/Stream/listen.html?utm_source=chatgpt.com "listen method - Stream class - dart:async library"
[3]: https://api.dart.dev/dart-isolate/Isolate-class.html "Isolate class - dart:isolate library - Dart API"
[4]: https://api.flutter.dev/flutter/dart-isolate/Isolate/setErrorsFatal.html?utm_source=chatgpt.com "setErrorsFatal method - Isolate class - dart:isolate library"
[5]: https://api.dart.dev/dart-isolate/Isolate/spawn.html?utm_source=chatgpt.com "spawn method - Isolate class"
[6]: https://api.dart.dev/dart-isolate/Isolate/spawnUri.html?utm_source=chatgpt.com "spawnUri method - Isolate class"
[7]: https://api.flutter.dev/flutter/dart-isolate/Isolate/run.html?utm_source=chatgpt.com "run method - Isolate class - dart:isolate library - Dart API"
