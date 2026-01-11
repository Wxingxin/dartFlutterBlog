好，这一条我**直接按“新手可运行”的方式教你**。
你不用理解所有原理，**照着写 → 跑起来 → 再回头理解**。

下面 3 个例子，**正好对应你列的 3 个能力**，而且它们是**同一套状态管理思想**。

---

# 一、计数器（加减，不能小于 0）✅

### 你要学会的点

* `int` 状态
* `setState`
* 简单业务判断（不能 < 0）

---

### 完整示例（直接可跑）

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2AM5frRuylTPwJoz5sQF9kbg.png)

![Image](https://i.sstatic.net/sn7oY.png)

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int count = 0; // 👈 状态

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('计数器')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$count',
              style: const TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: decrement,
                  child: const Text('-'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: increment,
                  child: const Text('+'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
```

### 你必须记住的一句话

> **状态 = count**
> **UI = Text('$count')**
> **setState = 通知 Flutter 重画**

---

# 二、简单表单：输入框 → 文字实时预览 ✅

### 你要学会的点

* `String` 状态
* `TextField`
* `onChanged`

---

### 示例：输入什么，下面就显示什么

![Image](https://miro.medium.com/1%2A42mjJQVCPqJYsuGJmQ_-TQ.png)

![Image](https://media2.dev.to/cdn-cgi/image/width%3D800%2Cheight%3D%2Cfit%3Dscale-down%2Cgravity%3Dauto%2Cformat%3Dauto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F6uywrw82xkkowk3th8ms.png)

```dart
class InputPreviewPage extends StatefulWidget {
  const InputPreviewPage({super.key});

  @override
  State<InputPreviewPage> createState() => _InputPreviewPageState();
}

class _InputPreviewPageState extends State<InputPreviewPage> {
  String text = ''; // 👈 状态

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('输入预览')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              decoration: const InputDecoration(
                labelText: '请输入内容',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '你输入的是：$text',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 关键理解

```text
TextField 输入
→ onChanged 回调
→ 修改状态 text
→ setState
→ Text 自动更新
```

---

# 三、Tab 切换：不同状态显示不同内容 ✅

### 你要学会的点

* 用 `int` 表示“当前选中哪个”
* 用条件渲染 UI

---

### 示例：3 个 Tab，切换内容

![Image](https://blog.logrocket.com/wp-content/uploads/2021/02/flutter-tabbar-diagram.png)

![Image](https://i.sstatic.net/chXJh.png)

```dart
class TabSwitchPage extends StatefulWidget {
  const TabSwitchPage({super.key});

  @override
  State<TabSwitchPage> createState() => _TabSwitchPageState();
}

class _TabSwitchPageState extends State<TabSwitchPage> {
  int currentIndex = 0; // 👈 状态

  Widget buildContent() {
    if (currentIndex == 0) {
      return const Text('首页内容', style: TextStyle(fontSize: 24));
    } else if (currentIndex == 1) {
      return const Text('消息内容', style: TextStyle(fontSize: 24));
    } else {
      return const Text('我的内容', style: TextStyle(fontSize: 24));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tab 切换')),
      body: Center(child: buildContent()),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: '消息'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
```

### 你要形成的思维

> **Tab 切换 ≠ 页面跳转**
> **Tab 切换 = 状态变了，显示不同 Widget**

---

# 四、这 3 个例子，其实是同一件事（非常重要）

| 示例  | 状态类型     | 状态变量           |
| --- | -------- | -------------- |
| 计数器 | `int`    | `count`        |
| 输入框 | `String` | `text`         |
| Tab | `int`    | `currentIndex` |

### 通用公式（记住它）

```text
定义状态
↓
UI 使用状态
↓
事件中 setState 改状态
↓
UI 自动刷新
```

---

# 五、你现在“已经会状态管理了”（真的）

你现在已经会了：

* ✔ 局部状态
* ✔ setState
* ✔ UI 随状态变化

👉 **这就是 Flutter 状态管理的地基**

---

## 给你一个下一步（别跳）

下一步我建议你做这个（很关键）：

> 🔥 **把上面任意一个例子，拆成 2～3 个 Widget**

比如：

* 计数器：`CounterText` + `CounterButtons`
* Tab：`TabContent` + `BottomBar`

如果你愿意，**你可以把你写的代码直接贴出来**，
我帮你一行一行改，告诉你**哪里该拆、为什么要拆**。
