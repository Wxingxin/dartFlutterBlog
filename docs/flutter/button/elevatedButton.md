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
-----------------------
下面我给你一份**Flutter `ElevatedButton` 组件属性与配置的系统化大全**，按「**基础 → 样式 → 状态 → 主题 → 高级用法**」来讲，偏**工程实战视角**，方便你直接在项目中用。

---

# 一、ElevatedButton 是什么

`ElevatedButton` 是 **Material 风格的主要按钮**，特点：

* 有 **背景色**
* 有 **阴影（elevation）**
* 有 **点击反馈**
* 用于 **核心 / 主要操作**

📌 官方推荐：

> **新项目优先使用 `ElevatedButton`，而不是旧的 `RaisedButton`（已废弃）**

---

# 二、最基础用法

```dart
ElevatedButton(
  onPressed: () {
    print('点击了按钮');
  },
  child: const Text('提交'),
)
```

⚠️ 只要 `onPressed == null`，按钮就是 **禁用状态**

---

# 三、核心属性总览（构造函数）

```dart
ElevatedButton({
  Key? key,
  required VoidCallback? onPressed,
  VoidCallback? onLongPress,
  ButtonStyle? style,
  FocusNode? focusNode,
  bool autofocus = false,
  Clip clipBehavior = Clip.none,
  Widget? child,
})
```

---

# 四、功能类属性（行为控制）

## 1️⃣ onPressed（必会）

```dart
onPressed: () {}
```

| 状态     | 效果       |
| ------ | -------- |
| 非 null | 按钮可点击    |
| null   | 按钮禁用（灰色） |

```dart
onPressed: isLoading ? null : submit;
```

---

## 2️⃣ onLongPress（长按）

```dart
onLongPress: () {
  print('长按');
}
```

---

## 3️⃣ autofocus（自动获取焦点）

```dart
autofocus: true
```

📌 常用于 **键盘 / TV / Web 场景**

---

## 4️⃣ focusNode（焦点控制）

```dart
focusNode: myFocusNode
```

用于表单或键盘导航控制。

---

## 5️⃣ clipBehavior（裁剪行为）

```dart
clipBehavior: Clip.hardEdge
```

| 值              | 说明     |
| -------------- | ------ |
| Clip.none      | 默认，不裁剪 |
| Clip.hardEdge  | 裁剪溢出   |
| Clip.antiAlias | 抗锯齿    |

---

# 五、样式配置（重点）

所有样式都通过 **`style: ButtonStyle`** 控制。

---

## ButtonStyle 常用属性总览

```dart
style: ButtonStyle(
  backgroundColor,
  foregroundColor,
  overlayColor,
  elevation,
  shadowColor,
  padding,
  minimumSize,
  fixedSize,
  maximumSize,
  shape,
  side,
  alignment,
  textStyle,
)
```

---

## 1️⃣ backgroundColor（背景色）

```dart
backgroundColor: MaterialStateProperty.all(Colors.blue)
```

### 状态控制（推荐）

```dart
backgroundColor: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.disabled)) {
    return Colors.grey;
  }
  return Colors.blue;
})
```

---

## 2️⃣ foregroundColor（文字 / 图标颜色）

```dart
foregroundColor: MaterialStateProperty.all(Colors.white)
```

---

## 3️⃣ overlayColor（点击水波纹）

```dart
overlayColor: MaterialStateProperty.all(
  Colors.white.withOpacity(0.2),
)
```

📌 控制点击、长按时的高亮效果

---

## 4️⃣ elevation（阴影高度）

```dart
elevation: MaterialStateProperty.all(6)
```

状态变化：

```dart
elevation: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.pressed)) return 2;
  return 6;
})
```

---

## 5️⃣ shadowColor（阴影颜色）

```dart
shadowColor: MaterialStateProperty.all(Colors.black)
```

---

## 6️⃣ padding（内边距）

```dart
padding: MaterialStateProperty.all(
  const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
)
```

---

## 7️⃣ size 相关（3 选 1）

### minimumSize（最小尺寸）

```dart
minimumSize: MaterialStateProperty.all(const Size(120, 48))
```

### fixedSize（固定尺寸）

```dart
fixedSize: MaterialStateProperty.all(const Size(200, 50))
```

### maximumSize（最大尺寸）

```dart
maximumSize: MaterialStateProperty.all(const Size(300, 60))
```

---

## 8️⃣ shape（形状 / 圆角）

```dart
shape: MaterialStateProperty.all(
  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
)
```

### 圆形按钮

```dart
shape: MaterialStateProperty.all(
  const CircleBorder(),
)
```

---

## 9️⃣ side（边框）

```dart
side: MaterialStateProperty.all(
  const BorderSide(color: Colors.red, width: 2),
)
```

📌 可做成 **“带边框的 ElevatedButton”**

---

## 🔟 textStyle（文字样式）

```dart
textStyle: MaterialStateProperty.all(
  const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  ),
)
```

---

## 1️⃣1️⃣ alignment（内容对齐）

```dart
alignment: Alignment.centerLeft
```

---

# 六、状态枚举（MaterialState）

```dart
MaterialState.pressed
MaterialState.hovered
MaterialState.focused
MaterialState.disabled
MaterialState.selected
```

📌 `resolveWith` 就是用来 **针对状态做样式变化**

---

# 七、带图标的 ElevatedButton

## 官方写法

```dart
ElevatedButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.send),
  label: const Text('发送'),
)
```

---

# 八、主题级配置（推荐）

## 全局统一按钮风格

```dart
MaterialApp(
  theme: ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  ),
)
```

📌 实际项目 **强烈建议用 Theme，而不是每个按钮单独写 style**

---

# 九、styleFrom（快速写法）

```dart
ElevatedButton(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    elevation: 4,
    padding: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  onPressed: () {},
  child: const Text('保存'),
)
```

⚠️ `styleFrom` 是 **语法糖**，底层仍然是 `ButtonStyle`

---

# 十、常见使用场景总结

| 场景      | 是否适合                             |
| ------- | -------------------------------- |
| 表单提交    | ✅ 非常适合                           |
| 登录 / 注册 | ✅                                |
| 主要 CTA  | ✅                                |
| 次要操作    | ❌（用 TextButton / OutlinedButton） |
| 工具栏按钮   | ❌                                |

---

# 十一、与其他按钮的关系

| 按钮                   | 适合场景             |
| -------------------- | ---------------- |
| ElevatedButton       | **主操作**          |
| FilledButton         | Material 3 推荐主按钮 |
| OutlinedButton       | 次级操作             |
| TextButton           | 最弱操作             |
| IconButton           | 图标操作             |
| FloatingActionButton | 全局核心操作           |

---

## 如果你愿意

我可以帮你继续补充：

* ✅ `ElevatedButton` **完整状态变化示例**
* ✅ **登录 / 表单按钮最佳实践**
* ✅ `ElevatedButton vs FilledButton`（Material 3）
* ✅ 自封装一个 **BaseButton 组件**
* ✅ Flutter 按钮组件 **学习优先级建议**

你可以直接告诉我下一步想看哪一个。
-----------------------------
下面是 **Flutter `ElevatedButton` 组件的参数大全**，**严格保持 Flutter SDK 源码中的构造函数结构**，**不改结构**，**仅在每个参数后直接追加中文注释**，方便你 **逐行对照源码学习（Material 2 按钮体系）**。

---

## ElevatedButton 构造函数（源码结构）

```dart
const ElevatedButton({
  super.key,                         // 组件唯一标识 Key
  required this.onPressed,           // 点击回调（为 null 时按钮禁用）
  this.onLongPress,                  // 长按回调（移动端）
  this.onHover,                      // 鼠标悬停回调（Web / Desktop）
  this.onFocusChange,                // 焦点变化回调（键盘 / 无障碍）
  this.style,                        // 按钮样式（背景色 / 阴影 / 圆角等）
  this.focusNode,                    // 焦点控制节点
  this.autofocus = false,            // 是否自动获取焦点
  this.clipBehavior = Clip.none,     // 子组件超出区域裁剪方式
  required this.child,               // 按钮内容（通常是 Text）
})
```

---

## 参数逐项说明（源码级理解）

### 1️⃣ onPressed（必传）

```dart
final VoidCallback? onPressed; // 点击触发回调，为 null 时进入 disabled 状态
```

* 所有 Material Button 禁用态的统一入口
* `null` ≈ `enabled = false`

---

### 2️⃣ onLongPress

```dart
final VoidCallback? onLongPress; // 长按触发（移动端更常见）
```

---

### 3️⃣ onHover

```dart
final ValueChanged<bool>? onHover; // 鼠标进入 / 离开按钮区域回调
```

* Web / Desktop 专用
* `true`：hover
* `false`：leave

---

### 4️⃣ onFocusChange

```dart
final ValueChanged<bool>? onFocusChange; // 焦点获得 / 失去时回调
```

* 键盘导航
* 无障碍支持（Accessibility）

---

### 5️⃣ style（⭐ElevatedButton 核心）

```dart
final ButtonStyle? style; // ElevatedButton 的视觉样式定义
```

常用于控制：

* `backgroundColor` → 背景色
* `foregroundColor` → 文字 / 图标颜色
* `elevation` → 阴影高度（ElevatedButton 核心特征）
* `shadowColor` → 阴影颜色
* `overlayColor` → 点击 / hover 水波纹
* `padding` → 内边距
* `shape` → 圆角形状

示例理解：

```dart
style: ElevatedButton.styleFrom(
  elevation: 4, // 阴影高度
)
```

---

### 6️⃣ focusNode

```dart
final FocusNode? focusNode; // 手动控制按钮焦点
```

---

### 7️⃣ autofocus

```dart
final bool autofocus; // 构建后是否自动获取焦点
```

* 默认 `false`
* Desktop / Web 更常用

---

### 8️⃣ clipBehavior

```dart
final Clip clipBehavior; // 子组件超出按钮区域的裁剪方式
```

* 通常保持 `Clip.none`
* 只有自定义复杂 child 时才调整

---

### 9️⃣ child（必传）

```dart
final Widget child; // 按钮内部内容（Text / Icon / Row 等）
```

---

## ElevatedButton 的继承关系（源码视角）

```text
ElevatedButton
  ↓
ButtonStyleButton
  ↓
StatefulWidget
```

* 与 `TextButton / OutlinedButton / FilledButton` 构造参数 **完全一致**
* 差异只体现在 **默认 ButtonStyle（M2 vs M3）**

---

## ElevatedButton 的默认特性（Material 2）

| 特性   | 说明            |
| ---- | ------------- |
| 背景   | 有填充色          |
| 阴影   | 明显（elevation） |
| 设计规范 | Material 2    |
| 使用建议 | 旧项目 / 需要明显层级感 |

---

## 与 FilledButton 的一句话源码级区别

> **ElevatedButton = M2 阴影按钮
> FilledButton = M3 填充按钮（弱或无阴影）**

---

如果你要继续“源码级深挖”，我可以直接帮你：

* ✅ `ElevatedButton.styleFrom` 参数全量中文注释
* ✅ `ButtonStyle` 全字段 + 状态映射（hover / pressed / disabled）
* ✅ 四种按钮默认 style 源码对照（Text / Outlined / Filled / Elevated）
* ✅ 从 ElevatedButton → InkWell → RenderObject 的事件链路

你直接说：**“继续 styleFrom”** 或 **“ButtonStyle 全字段”** 即可。
