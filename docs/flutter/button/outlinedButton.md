非常好 👍！你已经学完了 `ElevatedButton`（凸起按钮） 和 `TextButton`（文字按钮），
接下来要学的 **`OutlinedButton`（描边按钮）** 就是它们的“第三兄弟”。

它是一个非常常用、设计感很强的按钮，
👉 外观是一个带边框、透明背景的按钮，用于**次要操作**（如“取消”、“返回”、“更多”等）。

---

# 🧱 一、OutlinedButton 是什么

`OutlinedButton` 是 Flutter 的现代化按钮之一（取代了旧版 `OutlineButton`）。
它的特点是：

* 有边框（Outline）；
* 背景默认透明；
* 按下时会有轻微颜色反馈；
* 常用于次要操作。

---

# 🚀 二、OutlinedButton 最简单用法

```dart
OutlinedButton(
  onPressed: () {
    print('点击了按钮');
  },
  child: Text('点我'),
)
```

✅ 必须属性：

* `onPressed`：点击回调（null 表示禁用）
* `child`：按钮内容（通常是 Text、Icon、Row）

---

# 🧩 三、OutlinedButton 全部属性方法大全

| 属性 / 方法          | 类型                 | 说明              |
| ---------------- | ------------------ | --------------- |
| **onPressed**    | `void Function()?` | 点击事件            |
| **onLongPress**  | `void Function()?` | 长按事件            |
| **child**        | `Widget`           | 按钮内容（文字/图标/Row） |
| **style**        | `ButtonStyle?`     | 样式（颜色、边框、形状等）   |
| **focusNode**    | `FocusNode?`       | 控制焦点            |
| **autofocus**    | `bool`             | 是否自动获取焦点        |
| **clipBehavior** | `Clip`             | 内容裁剪方式          |
| **key**          | `Key?`             | 组件标识            |

---

# 🎨 四、OutlinedButton 样式设置方式大全

## ✅ 1️⃣ 使用 `OutlinedButton.styleFrom()`（最常用）

```dart
OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    foregroundColor: Colors.blue,          // 文字/图标颜色
    backgroundColor: Colors.white,         // 背景色
    side: BorderSide(color: Colors.blue),  // 边框颜色和粗细
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: Text('确定'),
)
```

📘 常用参数：

| 属性                | 说明             |
| ----------------- | -------------- |
| `foregroundColor` | 字体和图标颜色        |
| `backgroundColor` | 背景颜色（默认透明）     |
| `side`            | 边框样式（颜色、宽度）    |
| `padding`         | 内边距            |
| `textStyle`       | 字体样式           |
| `shape`           | 按钮形状（圆角矩形、圆形等） |
| `minimumSize`     | 最小尺寸           |

---

## ✅ 2️⃣ 使用 `ButtonStyle`（可动态控制状态）

```dart
OutlinedButton(
  onPressed: () {},
  style: ButtonStyle(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.blue, width: 2);
      }
      return BorderSide(color: Colors.grey);
    }),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) return Colors.blue;
      return Colors.black;
    }),
    overlayColor: MaterialStateProperty.all(Colors.blue.withOpacity(0.1)),
  ),
  child: Text('动态样式按钮'),
)
```

🧠 `MaterialStateProperty.resolveWith` 可以根据不同状态改变颜色或边框，比如：

* `MaterialState.pressed` → 按下
* `MaterialState.hovered` → 悬停
* `MaterialState.disabled` → 禁用

---

# 💡 五、经典案例

---

## 🌟 案例 1：最基础用法

```dart
OutlinedButton(
  onPressed: () {
    print('点击');
  },
  child: Text('OutlinedButton'),
)
```

---

## 🌟 案例 2：带图标的描边按钮

```dart
OutlinedButton.icon(
  onPressed: () {
    print('搜索');
  },
  icon: Icon(Icons.search),
  label: Text('搜索'),
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: Colors.teal),
    foregroundColor: Colors.teal,
  ),
)
```

📘 `OutlinedButton.icon()` 是工厂构造函数，方便创建带图标的按钮。

---

## 🌟 案例 3：圆角描边按钮

```dart
OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: Colors.purple),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
  child: Text('圆角按钮'),
)
```

---

## 🌟 案例 4：禁用按钮（onPressed = null）

```dart
OutlinedButton(
  onPressed: null,
  child: Text('禁用按钮'),
)
```

📘 当 `onPressed` 为 `null` 时，按钮自动灰化并禁用。

---

## 🌟 案例 5：动态变化的描边（按下改变颜色）

```dart
OutlinedButton(
  onPressed: () {},
  style: ButtonStyle(
    side: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) {
        return BorderSide(color: Colors.orange, width: 2);
      }
      return BorderSide(color: Colors.blue, width: 1);
    }),
    foregroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) return Colors.orange;
      return Colors.blue;
    }),
  ),
  child: Text('按下变色'),
)
```

效果：

* 默认蓝色边框；
* 按下后变橙色边框；
* 按下文字同步变橙色。

---

# ⚙️ 六、进阶：动态背景 + 边框 + 悬停颜色

```dart
OutlinedButton(
  onPressed: () {},
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.blue.withOpacity(0.1);
      }
      return Colors.transparent;
    }),
    side: MaterialStateProperty.all(BorderSide(color: Colors.blue)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  ),
  child: Text('悬停高亮'),
)
```

🧠 **适合桌面 / Web 端交互效果**。

---

# 🧠 七、OutlinedButton 与其他按钮对比

| 按钮类型               | 外观       | 常用场景          |
| ------------------ | -------- | ------------- |
| **ElevatedButton** | 实心、有阴影   | 主要操作（确定 / 提交） |
| **TextButton**     | 无边框、纯文字  | 链接 / 辅助操作     |
| **OutlinedButton** | 有边框、透明背景 | 次要操作（取消 / 返回） |

---

# 🧩 八、组合使用案例：确认与取消按钮

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    OutlinedButton(
      onPressed: () {
        print('取消');
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey[800],
        side: BorderSide(color: Colors.grey),
      ),
      child: Text('取消'),
    ),
    ElevatedButton(
      onPressed: () {
        print('确定');
      },
      child: Text('确定'),
    ),
  ],
)
```

📘 **常见场景**：弹窗底部的“取消 / 确定”按钮组。

---

# 🎯 九、总结表：OutlinedButton 属性总览

| 分类   | 属性                                       | 说明      |
| ---- | ---------------------------------------- | ------- |
| 行为   | `onPressed`, `onLongPress`               | 点击与长按   |
| 内容   | `child`, `icon`, `label`                 | 按钮内容    |
| 样式   | `style`                                  | 控制外观样式  |
| 样式构造 | `OutlinedButton.styleFrom()`             | 快速设置样式  |
| 边框   | `side: BorderSide()`                     | 设置颜色和粗细 |
| 状态   | `MaterialStateProperty.resolveWith()`    | 动态控制样式  |
| 形状   | `shape`                                  | 控制圆角、矩形 |
| 尺寸   | `padding`, `minimumSize`                 | 控制大小    |
| 辅助   | `focusNode`, `autofocus`, `clipBehavior` | 辅助功能    |

---

# 💎 十、总结一句话

> 🧩 **OutlinedButton = TextButton + 边框 + 状态控制**
> 它既有视觉层次感，又不会太强烈，非常适合次级操作按钮。

---

是否希望我接着帮你写一个「三种按钮统一风格系统（ElevatedButton + OutlinedButton + TextButton）」的实战小案例？
这个案例会展示如何用一个全局 `ButtonStyle` 统一全项目按钮风格（实际项目中很常用 🔥）。是否帮你写？