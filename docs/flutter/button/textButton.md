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