非常棒 👍！你已经学了 `ElevatedButton`，现在我们来讲解它的“兄弟” —— **`TextButton`**。
它在 Flutter 中非常常用，是最简洁、最轻量的按钮类型之一。

这篇给你带来：

1. 🚀 **TextButton 概念与基本用法**
2. 🧩 **全部属性和方法大全（超全表格）**
3. 🎨 **样式设置方式详解（styleFrom 与 ButtonStyle）**
4. 💡 **经典案例（含图标、禁用、圆角、动态样式）**
5. ⚙️ **进阶技巧（MaterialStateProperty 状态样式）**
6. 🧠 **TextButton 与其他按钮的区别表**

---

## 🚀 一、TextButton 是什么？

`TextButton` 是一种**纯文本按钮**，没有背景、没有阴影，只有文字或图标。
通常用于**次要操作**、**链接按钮**、或**对话框的取消按钮**。

> ⚙️ 在 Flutter 2.0 之后，`FlatButton` 被废弃，由 `TextButton` 取代。

---

## 🧩 二、TextButton 基本结构

```dart
TextButton(
  onPressed: () {
    print('按钮被点击');
  },
  child: Text('点我'),
)
```

✅ **必须属性**：

* `onPressed`: 点击事件回调（为 null 时禁用）
* `child`: 显示内容（通常是 `Text`、`Icon` 或 `Row`）

---

## 📋 三、TextButton 属性与方法大全

| 属性 / 方法          | 类型                 | 说明              |
| ---------------- | ------------------ | --------------- |
| **onPressed**    | `void Function()?` | 点击事件            |
| **onLongPress**  | `void Function()?` | 长按事件            |
| **child**        | `Widget`           | 按钮内容（如文字、图标）    |
| **style**        | `ButtonStyle?`     | 控制样式（颜色、形状、大小等） |
| **focusNode**    | `FocusNode?`       | 控制焦点            |
| **autofocus**    | `bool`             | 是否自动获得焦点        |
| **clipBehavior** | `Clip`             | 内容裁剪方式          |
| **key**          | `Key?`             | 组件标识符（用于测试或重建）  |

---

## 🎨 四、TextButton 样式设置方式

`TextButton` 的外观是通过 `style` 属性设置的。
有两种常用方式：

---

### ✅ 1️⃣ 使用 `TextButton.styleFrom()`（简单直观）

```dart
TextButton(
  onPressed: () {},
  style: TextButton.styleFrom(
    foregroundColor: Colors.blue,     // 字体/图标颜色
    backgroundColor: Colors.blue[50], // 背景色
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: Text('确定'),
)
```

| 属性                | 说明                     |
| ----------------- | ---------------------- |
| `foregroundColor` | 前景色（文字、图标颜色）           |
| `backgroundColor` | 背景颜色（默认透明）             |
| `shadowColor`     | 阴影颜色（通常不使用）            |
| `elevation`       | 阴影高度（TextButton 通常为 0） |
| `padding`         | 内边距                    |
| `shape`           | 按钮形状（圆角等）              |
| `minimumSize`     | 按钮最小尺寸                 |
| `textStyle`       | 字体样式                   |

---

### ✅ 2️⃣ 使用 `ButtonStyle`（灵活控制状态）

```dart
TextButton(
  onPressed: () {},
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(Colors.blue),
    overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.1)),
    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
    textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18)),
  ),
  child: Text('登录'),
)
```

> 使用 `MaterialStateProperty` 可以为不同状态定义不同样式，比如：
>
> * `MaterialState.pressed` → 按下时
> * `MaterialState.hovered` → 悬停时
> * `MaterialState.disabled` → 禁用状态

---

## 💡 五、经典案例

---

### 🌟 案例 1：基础文字按钮

```dart
TextButton(
  onPressed: () => print('点击了按钮'),
  child: Text('点我'),
)
```

---

### 🌟 案例 2：带图标的文字按钮

```dart
TextButton.icon(
  onPressed: () => print('搜索中...'),
  icon: Icon(Icons.search),
  label: Text('搜索'),
  style: TextButton.styleFrom(foregroundColor: Colors.teal),
)
```

📘 `TextButton.icon()` 是一个工厂构造函数，用来快速创建带图标的按钮。

---

### 🌟 案例 3：禁用状态按钮

```dart
TextButton(
  onPressed: null, // 禁用按钮
  child: Text('不可点击'),
)
```

✅ 当 `onPressed` 为 `null` 时：

* 按钮自动禁用；
* 颜色会变淡（遵循 Material Design 规范）。

---

### 🌟 案例 4：圆角、背景色与悬停变化

```dart
TextButton(
  onPressed: () {},
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) return Colors.blue[100];
      if (states.contains(MaterialState.pressed)) return Colors.blue[200];
      return Colors.transparent;
    }),
    foregroundColor: MaterialStateProperty.all(Colors.blue),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  child: Text('悬停变色'),
)
```

📘 **效果说明：**

* 悬停时浅蓝背景；
* 按下时更深蓝；
* 默认透明背景。

---

### 🌟 案例 5：自定义尺寸与字体

```dart
TextButton(
  onPressed: () {},
  style: TextButton.styleFrom(
    minimumSize: Size(150, 48),
    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  child: Text('注册'),
)
```

---

## ⚙️ 六、进阶技巧：使用 MaterialStateProperty 动态样式

```dart
TextButton(
  onPressed: () {},
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) return Colors.orange;
      if (states.contains(MaterialState.hovered)) return Colors.green;
      return Colors.blue;
    }),
  ),
  child: Text('动态颜色按钮'),
)
```

🧠 说明：

* 按下 → 橙色
* 悬停 → 绿色
* 默认 → 蓝色

这样可以做出交互反馈的按钮。

---

## 🎯 七、TextButton 与 ElevatedButton / OutlinedButton 对比

| 按钮类型               | 特点          | 常用场景              |
| ------------------ | ----------- | ----------------- |
| **TextButton**     | 无阴影、无边框、无背景 | 链接、取消按钮、非主要操作     |
| **ElevatedButton** | 有阴影、立体感     | 主要操作（提交、确认）       |
| **OutlinedButton** | 有边框但透明背景    | 次要操作（比如“返回”、“更多”） |

---

## 💎 八、组合使用案例（登录页底部操作）

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text("没有账号？"),
    TextButton(
      onPressed: () {
        print("跳转注册页");
      },
      style: TextButton.styleFrom(foregroundColor: Colors.blue),
      child: Text("立即注册"),
    ),
  ],
)
```

💡 **用途：**

* 常用于登录注册页底部；
* 与文本组合成一个链接效果。

---

## 🧠 九、总结表：TextButton 样式属性总览

| 分类   | 属性 / 方法                                                               | 说明     |
| ---- | --------------------------------------------------------------------- | ------ |
| 行为   | `onPressed`, `onLongPress`                                            | 点击与长按  |
| 内容   | `child`, `icon`, `label`                                              | 按钮内容   |
| 样式   | `style`                                                               | 按钮样式   |
| 样式辅助 | `TextButton.styleFrom()`                                              | 快速构造样式 |
| 状态控制 | `MaterialStateProperty.resolveWith()`                                 | 动态样式控制 |
| 焦点   | `focusNode`, `autofocus`                                              | 控制焦点行为 |
| 视觉   | `padding`, `shape`, `backgroundColor`, `foregroundColor`, `textStyle` | 控制外观   |

---

## ✅ 十、练习建议

是否希望我接着帮你写一个：

> 「TextButton 实现网页风格的链接按钮（点击后变色 + 下划线）」

这个案例非常适合练习 `MaterialStateProperty` 和 `RichText` 的结合，
而且在真实项目（比如 Flutter Web）中经常会用到。
要我帮你写这个练习版吗？
-------------------------------
下面给你一份**Flutter `TextButton` 组件的属性与配置大全**，我会按**工程实战 + 易记忆结构**来讲，并且和你前面看的 `ElevatedButton / OutlinedButton` 保持一致，方便你形成**完整按钮体系认知**。

---

# 一、TextButton 是什么

`TextButton` 是 **Material 风格中“最弱”的按钮**：

* **无背景**
* **无边框**
* **只有文字（或图标）**
* 点击时只有 **水波纹 / 颜色变化**

📌 官方定位：

```
Elevated / FilledButton  → 主操作
OutlinedButton           → 次操作
TextButton               → 辅助操作
```

---

# 二、最基础用法

```dart
TextButton(
  onPressed: () {
    print('点击 TextButton');
  },
  child: const Text('忘记密码？'),
)
```

---

# 三、构造函数与核心属性

```dart
TextButton({
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

⚠️ `onPressed == null` → **禁用状态**

---

# 四、行为相关属性

## 1️⃣ onPressed（点击）

```dart
onPressed: () {}
```

```dart
onPressed: isDisabled ? null : handleClick;
```

---

## 2️⃣ onLongPress（长按）

```dart
onLongPress: () {}
```

---

## 3️⃣ focusNode / autofocus

```dart
focusNode: myFocusNode,
autofocus: true,
```

用于 **Web / 键盘 / TV 端**

---

## 4️⃣ clipBehavior

```dart
clipBehavior: Clip.hardEdge
```

---

# 五、样式配置（ButtonStyle）

所有样式都通过：

```dart
style: ButtonStyle(...)
```

---

## ButtonStyle（TextButton 常用属性）

```dart
style: ButtonStyle(
  foregroundColor,
  overlayColor,
  padding,
  minimumSize,
  fixedSize,
  maximumSize,
  shape,
  alignment,
  textStyle,
)
```

⚠️ **TextButton 没有 backgroundColor / side**

---

# 六、核心样式属性详解

---

## 1️⃣ foregroundColor（文字 / 图标颜色）

```dart
foregroundColor: MaterialStateProperty.all(Colors.blue)
```

### 状态控制（推荐）

```dart
foregroundColor: MaterialStateProperty.resolveWith((states) {
  if (states.contains(MaterialState.disabled)) {
    return Colors.grey;
  }
  return Colors.blue;
})
```

---

## 2️⃣ overlayColor（水波纹 / 点击态）

```dart
overlayColor: MaterialStateProperty.all(
  Colors.blue.withOpacity(0.1),
)
```

📌 用于 hover / press / focus 状态

---

## 3️⃣ padding（点击区域）

```dart
padding: MaterialStateProperty.all(
  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
)
```

📌 TextButton 常用于 **小点击目标**

---

## 4️⃣ size 控制（三选一）

### minimumSize

```dart
minimumSize: MaterialStateProperty.all(const Size(48, 36))
```

### fixedSize

```dart
fixedSize: MaterialStateProperty.all(const Size(80, 36))
```

### maximumSize

```dart
maximumSize: MaterialStateProperty.all(const Size(200, 48))
```

---

## 5️⃣ shape（点击区域形状）

```dart
shape: MaterialStateProperty.all(
  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(6),
  ),
)
```

📌 即使没边框，也会影响 **水波纹区域**

---

## 6️⃣ textStyle（文字样式）

```dart
textStyle: MaterialStateProperty.all(
  const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  ),
)
```

---

## 7️⃣ alignment（内容对齐）

```dart
alignment: Alignment.centerLeft
```

---

# 七、状态枚举（MaterialState）

```dart
MaterialState.pressed
MaterialState.hovered
MaterialState.focused
MaterialState.disabled
MaterialState.selected
```

📌 在 TextButton 中主要控制：

* 文字颜色
* 水波纹颜色

---

# 八、带图标的 TextButton

```dart
TextButton.icon(
  onPressed: () {},
  icon: const Icon(Icons.help_outline),
  label: const Text('帮助'),
)
```

---

# 九、Theme 级统一配置（强烈推荐）

```dart
MaterialApp(
  theme: ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        textStyle: const TextStyle(
          fontSize: 14,
        ),
      ),
    ),
  ),
)
```

📌 项目实践建议：

> **所有 TextButton 都走 Theme，避免单独 style**

---

# 十、styleFrom（快速写法）

```dart
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: Colors.red,
    padding: const EdgeInsets.symmetric(horizontal: 12),
  ),
  onPressed: () {},
  child: const Text('删除'),
)
```

---

# 十一、典型使用场景

| 场景      | 是否适合 |
| ------- | ---- |
| 忘记密码    | ✅    |
| 协议 / 链接 | ✅    |
| 次级提示操作  | ✅    |
| 表单提交    | ❌    |
| 危险操作    | ❌    |

---

# 十二、三种按钮快速对比（记忆表）

| 特性   | Elevated | Outlined | Text |
| ---- | -------- | -------- | ---- |
| 背景   | ✅        | ❌        | ❌    |
| 边框   | ❌        | ✅        | ❌    |
| 阴影   | ✅        | ❌        | ❌    |
| 强度   | 高        | 中        | 低    |
| 常用场景 | 提交       | 取消       | 链接   |

---

# 十三、学习与实践建议

### 实战顺序（非常重要）

1. **ElevatedButton**
2. **OutlinedButton**
3. **TextButton**
4. IconButton / FAB

### 项目中常见组合

```dart
Row(
  children: [
    OutlinedButton(onPressed: onCancel, child: Text('取消')),
    const SizedBox(width: 12),
    ElevatedButton(onPressed: onSubmit, child: Text('提交')),
  ],
)
```

---

## 如果你愿意，我可以继续帮你：

* 把 **三种按钮做成一张“配置对照表”**
* Material 3 下的 `FilledButton` 全解析
* 表单页按钮 **最佳 UX 规范**
* 封装一个 `AppTextButton`

你直接说下一步想看哪一个即可。
--------------------------
下面是 **Flutter `TextButton` 组件的参数大全**，**严格保持源码结构**，仅在 **每个参数后追加中文注释**，不改动原有结构，方便你 **对照 Flutter SDK 源码学习**。

---

## TextButton 构造函数（源码结构）

```dart
const TextButton({
  super.key,                         // 组件唯一标识 Key
  required this.onPressed,           // 点击回调（为 null 时按钮禁用）
  this.onLongPress,                  // 长按回调
  this.onHover,                      // 鼠标悬停回调（Web / Desktop）
  this.onFocusChange,                // 焦点变化回调（键盘 / 无障碍）
  this.style,                        // 按钮样式（颜色、内边距、形状等）
  this.focusNode,                    // 焦点控制节点
  this.autofocus = false,            // 是否自动获取焦点
  this.clipBehavior = Clip.none,     // 超出区域裁剪方式
  required this.child,               // 按钮子组件（通常是 Text）
})
```

---

## 参数逐项说明（深入理解）

### 1️⃣ onPressed（必传）

```dart
final VoidCallback? onPressed; // 点击按钮时触发，为 null 表示禁用态
```

* 为 `null` → 按钮灰色、不可点击
* 非 `null` → 正常可交互
* **所有 Material Button 的禁用机制核心**

---

### 2️⃣ onLongPress

```dart
final VoidCallback? onLongPress; // 长按触发（移动端常用）
```

* Android / iOS 生效
* Web/桌面一般不常用

---

### 3️⃣ onHover

```dart
final ValueChanged<bool>? onHover; // 鼠标进入 / 离开按钮区域
```

* `true`：鼠标移入
* `false`：鼠标移出
* **仅 Web / Desktop 有意义**

---

### 4️⃣ onFocusChange

```dart
final ValueChanged<bool>? onFocusChange; // 焦点获得 / 失去时回调
```

* 键盘 Tab 导航
* 无障碍（Accessibility）
* Desktop / Web 常用

---

### 5️⃣ style（⭐重点）

```dart
final ButtonStyle? style; // 按钮外观样式配置
```

用于控制：

* 文字颜色
* 背景色
* 内边距
* 圆角
* 水波纹
* 对齐方式

示例（理解即可）：

```dart
TextButton(
  style: TextButton.styleFrom(
    foregroundColor: Colors.blue,    // 文字颜色
    padding: EdgeInsets.all(12),      // 内边距
  ),
)
```

---

### 6️⃣ focusNode

```dart
final FocusNode? focusNode; // 控制按钮焦点的节点
```

* 精确控制焦点流
* 表单 / 键盘交互 / 无障碍场景

---

### 7️⃣ autofocus

```dart
final bool autofocus; // 构建后是否自动获取焦点
```

* 默认 `false`
* Web / Desktop 场景更常用

---

### 8️⃣ clipBehavior

```dart
final Clip clipBehavior; // 子组件超出按钮区域的裁剪方式
```

常见值：

* `Clip.none`（默认，不裁剪）
* `Clip.hardEdge`
* `Clip.antiAlias`

⚠️ **通常只在自定义复杂 child 时使用**

---

### 9️⃣ child（必传）

```dart
final Widget child; // 按钮内部内容（通常是 Text）
```

常见：

```dart
Text('确定')
Icon(Icons.add)
Row(...)
```

---

## TextButton 的继承关系（理解用）

```text
TextButton
  ↓
ButtonStyleButton
  ↓
StatefulWidget
```

👉 所有行为最终由 **ButtonStyleButton** 实现
👉 `style` 本质是传给 ButtonStyleButton 的状态样式系统

---

## 常见对比理解（一句话）

| 按钮             | 说明           |
| -------------- | ------------ |
| TextButton     | 纯文本按钮（无默认背景） |
| ElevatedButton | 有背景、有阴影      |
| OutlinedButton | 有边框          |

---

如果你愿意，下一步我可以帮你做：

* ✅ `TextButton.styleFrom` 参数大全（源码级）
* ✅ `ButtonStyle` 全字段拆解（状态机级）
* ✅ `TextButton` 在 **ThemeData** 中的全局配置
* ✅ TextButton / ElevatedButton / OutlinedButton 源码差异对照表

你可以直接告诉我：**“继续拆 style”** 或 **“看源码流转”**。
