# ElevatedButton 是什么？

`ElevatedButton` 是 Flutter 中常用的**凸起按钮**，带有**阴影 和 立体**效果，通常用于强调性的操作按钮（如“提交”、“保存”、“登录”）。

> 它取代了旧版的 `RaisedButton`（Flutter 2.0 后废弃）。

### 基本结构与最小用法

```dart
ElevatedButton(
  onPressed: () {
    print('按钮被点击');
  },
  child: Text('点我'),
)
```

✅ **最少要两个参数**：

- `onPressed`: 点击事件回调（若为 `null`，按钮会自动变灰禁用）
- `child`: 按钮内容（通常是 `Text` 或 `Row`）

---

### ElevatedButton 常用属性大全（超全）

| 属性             | 类型               | 作用                                 |
| ---------------- | ------------------ | ------------------------------------ |
| **onPressed**    | `void Function()?` | 点击时触发的回调函数                 |
| **onLongPress**  | `void Function()?` | 长按时触发                           |
| **style**        | `ButtonStyle?`     | 自定义按钮样式（颜色、形状、阴影等） |
| **child**        | `Widget`           | 按钮内容（文字、图标等）             |
| **focusNode**    | `FocusNode?`       | 控制按钮焦点                         |
| **autofocus**    | `bool`             | 是否自动获取焦点                     |
| **clipBehavior** | `Clip`             | 内容裁剪行为（一般用于圆角）         |
| **key**          | `Key?`             | 用于标识组件                         |

# 🎨 四、ButtonStyle 样式属性大全

使用 `style: ElevatedButton.styleFrom()` 或 `ButtonStyle()` 自定义外观。

---

## ✅ **1. ElevatedButton.styleFrom 常见样式属性**

```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,        // 背景颜色
    foregroundColor: Colors.white,       // 文字/图标颜色
    shadowColor: Colors.black54,         // 阴影颜色
    elevation: 5,                        // 阴影高度
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // 内边距
    textStyle: TextStyle(fontSize: 18),  // 字体样式
    shape: RoundedRectangleBorder(       // 按钮形状
      borderRadius: BorderRadius.circular(12),
    ),
    minimumSize: Size(120, 48),          // 最小尺寸
  ),
  child: Text('确定'),
)
```

---

## ✅ **2. ButtonStyle（更灵活）**

```dart
ElevatedButton(
  onPressed: () {},
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.teal),
    foregroundColor: MaterialStateProperty.all(Colors.white),
    overlayColor: MaterialStateProperty.all(Colors.redAccent.withOpacity(0.1)),
    elevation: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) return 10;
      return 5;
    }),
  ),
  child: Text('动态按钮样式'),
)
```

> 🧠 `MaterialStateProperty` 可以根据不同状态（按下、悬停、禁用）定义样式，常见状态有：
>
> - `MaterialState.pressed`：按下时
> - `MaterialState.hovered`：悬停时
> - `MaterialState.disabled`：禁用时
> - `MaterialState.focused`：聚焦时

---

# 💡 五、经典案例 1：带图标的 ElevatedButton

```dart
ElevatedButton.icon(
  onPressed: () {
    print('登录');
  },
  icon: Icon(Icons.login, size: 20),
  label: Text('登录'),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  ),
)
```

📘 **要点**：
`ElevatedButton.icon()` 是 `ElevatedButton` 的工厂构造函数，方便同时显示图标和文字。

---

# 💎 六、经典案例 2：自定义圆角 + 阴影 + 禁用状态

```dart
class ButtonExample extends StatefulWidget {
  @override
  _ButtonExampleState createState() => _ButtonExampleState();
}

class _ButtonExampleState extends State<ButtonExample> {
  bool _enabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ElevatedButton 示例')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _enabled
                  ? () {
                      print('点击成功');
                    }
                  : null, // null 时自动禁用
              style: ElevatedButton.styleFrom(
                backgroundColor: _enabled ? Colors.blue : Colors.grey,
                elevation: _enabled ? 6 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text('提交'),
            ),
            SizedBox(height: 20),
            Switch(
              value: _enabled,
              onChanged: (v) => setState(() => _enabled = v),
            ),
          ],
        ),
      ),
    );
  }
}
```

📘 **效果**：

- 开启 switch → 按钮可点击；
- 关闭 switch → 按钮自动灰化（onPressed = null）；
- 自动根据状态变化修改样式。

---

# ⚙️ 七、进阶技巧：状态变化样式（MaterialStateProperty）

```dart
ElevatedButton(
  onPressed: () {},
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return Colors.orange; // 按下颜色
      } else if (states.contains(MaterialState.hovered)) {
        return Colors.blueAccent; // 悬停颜色
      }
      return Colors.blue; // 默认颜色
    }),
  ),
  child: Text('动态状态按钮'),
)
```

🧠 **技巧说明：**

- `resolveWith` 可以根据不同状态返回不同样式；
- 用于制作带交互反馈的按钮效果。

---

# 🧠 八、ElevatedButton 与其他按钮对比

| 按钮类型           | 特点             | 常见用途               |
| ------------------ | ---------------- | ---------------------- |
| **ElevatedButton** | 有阴影、立体感   | 主要操作（提交、确定） |
| **OutlinedButton** | 边框按钮，无背景 | 次要操作               |
| **TextButton**     | 无阴影、无边框   | 链接式操作、取消按钮   |
| **IconButton**     | 仅图标按钮       | 工具栏按钮等           |

---

# 🧩 九、配合布局使用案例

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton(onPressed: () {}, child: Text('确定')),
    ElevatedButton(onPressed: () {}, child: Text('取消')),
  ],
)
```

📘 结合 `Row`、`Column`、`Wrap` 等可以实现灵活排版。

---

# 🔥 十、总结表：ElevatedButton 全部属性 & 常用样式

| 分类     | 属性                                                                                                               | 说明                           |
| -------- | ------------------------------------------------------------------------------------------------------------------ | ------------------------------ |
| 行为     | `onPressed`, `onLongPress`                                                                                         | 点击与长按                     |
| 样式     | `style`                                                                                                            | 控制外观（背景、边框、阴影等） |
| 内容     | `child`, `icon`, `label`                                                                                           | 按钮内容                       |
| 外观     | `backgroundColor`, `foregroundColor`, `shadowColor`, `shape`, `elevation`, `padding`, `minimumSize`, `maximumSize` | 各种视觉控制                   |
| 状态控制 | `MaterialStateProperty.resolveWith()`                                                                              | 根据状态返回不同样式           |
| 辅助     | `focusNode`, `autofocus`, `clipBehavior`                                                                           | 焦点和裁剪                     |

---

# 💬 十一、进阶挑战（推荐你练习）

是否希望我帮你写一个「漂亮的多状态按钮组件」？
比如一个按钮：

- 点击后切换为“加载中”状态（显示 CircularProgressIndicator）；
- 成功后变绿色；
- 失败后变红色。

这个可以帮你学会 `setState`、`ButtonStyle`、和 `Future` 的结合，非常实用 🔥。
要我帮你写这个进阶版吗？
