下面**严格按照 Flutter 源码构造函数结构**列出
👉 **`FloatingActionButton` 的参数大全**
👉 **每个参数后直接写中文注释**
👉 **不改结构，方便你对照源码阅读**

---

## 一、`FloatingActionButton` 构造函数（源码结构 + 中文注释）

```dart
FloatingActionButton({
  Key? key,                               // widget 唯一标识
  Widget? child,                          // 按钮内部的子组件（通常是 Icon）
  String? tooltip,                        // 长按提示文字（无障碍 & UX）
  Color? foregroundColor,                 // 前景色（icon / text 颜色）
  Color? backgroundColor,                 // 背景颜色
  Color? focusColor,                      // 获得焦点时的颜色
  Color? hoverColor,                      // 悬停时的颜色（Web / Desktop）
  Color? splashColor,                     // 点击水波纹颜色
  Color? highlightColor,                  // 点击高亮颜色
  double? elevation,                      // 正常状态下的阴影高度
  double? focusElevation,                 // 获得焦点时的阴影高度
  double? hoverElevation,                 // 悬停时的阴影高度
  double? highlightElevation,             // 点击时的阴影高度
  double? disabledElevation,              // 禁用状态下的阴影高度
  VoidCallback? onPressed,                // 点击回调（为 null 时按钮禁用）
  MouseCursor? mouseCursor,               // 鼠标指针样式（Web / Desktop）
  bool mini = false,                      // 是否为小尺寸 FAB
  ShapeBorder? shape,                     // 按钮形状（圆形 / 圆角等）
  Clip clipBehavior = Clip.none,          // 子组件裁剪行为
  FocusNode? focusNode,                   // 焦点控制节点
  bool autofocus = false,                 // 是否自动获取焦点
  MaterialTapTargetSize? materialTapTargetSize, // 触摸目标尺寸策略
  bool isExtended = false,                // 是否为扩展 FAB（内部使用）
  bool enableFeedback = true,             // 是否开启触觉/音效反馈
})
```

---

## 二、`FloatingActionButton.extended`（扩展按钮）

```dart
FloatingActionButton.extended({
  Key? key,                               // widget 唯一标识
  required Widget label,                  // 文本标签（必须）
  Widget? icon,                           // 左侧图标
  String? tooltip,                        // 长按提示
  Color? foregroundColor,                 // 前景色
  Color? backgroundColor,                 // 背景色
  Color? focusColor,                      // 焦点颜色
  Color? hoverColor,                      // 悬停颜色
  Color? splashColor,                     // 水波纹颜色
  Color? highlightColor,                  // 高亮颜色
  double? elevation,                      // 正常阴影
  double? focusElevation,                 // 焦点阴影
  double? hoverElevation,                 // 悬停阴影
  double? highlightElevation,             // 点击阴影
  double? disabledElevation,              // 禁用阴影
  VoidCallback? onPressed,                // 点击回调
  MouseCursor? mouseCursor,               // 鼠标指针
  ShapeBorder? shape,                     // 形状
  Clip clipBehavior = Clip.none,           // 裁剪行为
  FocusNode? focusNode,                   // 焦点节点
  bool autofocus = false,                 // 自动聚焦
  MaterialTapTargetSize? materialTapTargetSize, // 触摸尺寸策略
  bool enableFeedback = true,             // 反馈控制
})
```

---

## 三、常见可配置属性说明（配置大全）

### 1️⃣ 尺寸相关

| 属性                      | 说明                       |
| ----------------------- | ------------------------ |
| `mini`                  | `true` → 小尺寸 FAB（常见于列表页） |
| `isExtended`            | 内部属性，通常用 `extended` 构造函数 |
| `materialTapTargetSize` | 控制触摸热区大小                 |

---

### 2️⃣ 颜色体系（非常常用）

| 属性                | 作用             |
| ----------------- | -------------- |
| `backgroundColor` | 按钮背景色          |
| `foregroundColor` | Icon / Text 颜色 |
| `splashColor`     | 点击水波纹          |
| `highlightColor`  | 点击高亮           |
| `hoverColor`      | 悬停色（Web）       |
| `focusColor`      | 焦点色            |

---

### 3️⃣ 阴影 & 立体感（Material 关键）

| 属性                   | 场景   |
| -------------------- | ---- |
| `elevation`          | 默认状态 |
| `hoverElevation`     | 悬停   |
| `focusElevation`     | 焦点   |
| `highlightElevation` | 点击   |
| `disabledElevation`  | 禁用   |

---

### 4️⃣ 形状 & 裁剪

| 属性             | 说明         |
| -------------- | ---------- |
| `shape`        | 自定义形状（如圆角） |
| `clipBehavior` | 是否裁剪子组件    |

示例：

```dart
shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(16),
)
```

---

### 5️⃣ 交互 & 可访问性

| 属性               | 作用          |
| ---------------- | ----------- |
| `onPressed`      | 事件回调        |
| `tooltip`        | 长按提示（无障碍重要） |
| `enableFeedback` | 是否震动/音效     |
| `focusNode`      | 键盘导航        |
| `autofocus`      | 自动获取焦点      |

---

## 四、典型使用示例（对照理解）

### 普通 FAB

```dart
FloatingActionButton(
  onPressed: () {},
  backgroundColor: Colors.blue,
  child: const Icon(Icons.add),
)
```

### Mini FAB

```dart
FloatingActionButton(
  mini: true,
  onPressed: () {},
  child: const Icon(Icons.edit),
)
```

### 扩展 FAB（推荐业务场景）

```dart
FloatingActionButton.extended(
  onPressed: () {},
  icon: const Icon(Icons.add),
  label: const Text('新增'),
)
```

---

## 五、你在真实项目中的选型建议（经验总结）

| 场景          | 推荐                              |
| ----------- | ------------------------------- |
| 页面主操作       | `FloatingActionButton`          |
| 带文字说明       | `FloatingActionButton.extended` |
| 次要操作        | `mini: true`                    |
| Material 风格 | 默认即可                            |
| iOS 风格      | 考虑 `CupertinoButton`            |

---

如果你愿意，**下一步我可以帮你做**：

* ✅ FAB + `Scaffold.floatingActionButtonLocation` 全布局讲解
* ✅ FAB 动画（滚动隐藏 / 显示）
* ✅ Flutter 中 FAB 的 Material 设计规范拆解

你可以直接告诉我你**现在在写什么页面**。

---

![Image](https://media.geeksforgeeks.org/wp-content/uploads/20220521021312/regorg.png)

![Image](https://i.sstatic.net/45HoJ.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2ALnXDP2_4aDdK_bSDO2k45A.png)

![Image](https://i.sstatic.net/DqKBJ.jpg)

# Flutter `FloatingActionButton` 知识点 & 使用大全

---

## 一、FloatingActionButton 是什么？

> **FAB：用于页面中最重要、最常用、最高频的主操作按钮**

关键词：

* **浮动（Floating）**
* **唯一主操作**
* **强视觉权重**

📌 Material 设计原则：

> 一个页面 **最多一个 FAB**

---

## 二、最基础用法（必须会）

```dart
Scaffold(
  floatingActionButton: FloatingActionButton(
    onPressed: () {
      print('点击 FAB');
    },
    child: const Icon(Icons.add),
  ),
);
```

✔ 默认圆形
✔ 自动阴影
✔ 自动浮动在右下角

---

## 三、FloatingActionButton 的核心属性（重点）

### 1️⃣ onPressed（是否可用）

```dart
onPressed: () {}  // 可用
onPressed: null  // 禁用
```

禁用时：

* 颜色变灰
* 无点击反馈

---

### 2️⃣ child（内容）

```dart
child: Icon(Icons.add)
```

📌 一般只放：

* `Icon`
* `CircularProgressIndicator`（加载态）

---

### 3️⃣ backgroundColor / foregroundColor

```dart
FloatingActionButton(
  backgroundColor: Colors.blue,
  foregroundColor: Colors.white,
  onPressed: () {},
  child: const Icon(Icons.edit),
)
```

⚠️ 实战建议：

* 优先使用 `Theme.of(context).colorScheme.primary`

---

### 4️⃣ elevation（阴影）

```dart
FloatingActionButton(
  elevation: 6,
  highlightElevation: 12,
  onPressed: () {},
  child: const Icon(Icons.add),
)
```

📌 FAB 是 **少数仍推荐使用阴影的组件**

---

### 5️⃣ heroTag（⚠️ 常见坑）

```dart
FloatingActionButton(
  heroTag: 'add_btn',
  onPressed: () {},
  child: const Icon(Icons.add),
)
```

⚠️ **同一个页面多个 FAB 必须设置不同 heroTag**
否则运行时报错（Hero 冲突）

---

## 四、FloatingActionButton 的位置控制

### 1️⃣ 默认位置

```dart
floatingActionButtonLocation:
    FloatingActionButtonLocation.endFloat,
```

---

### 2️⃣ 常见位置枚举

| 枚举值          | 说明                  |
| ------------ | ------------------- |
| endFloat     | 右下角（默认）             |
| centerFloat  | 底部居中                |
| endDocked    | 贴底（配合 BottomAppBar） |
| centerDocked | 底部居中贴底              |

---

### 3️⃣ 示例：底部居中

```dart
Scaffold(
  floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
)
```

---

## 五、Extended FAB（扩展按钮，M3 推荐）

### 1️⃣ 用法

```dart
FloatingActionButton.extended(
  onPressed: () {},
  icon: const Icon(Icons.add),
  label: const Text('新建'),
)
```

✔ 图标 + 文字
✔ 更强语义
✔ 更适合新手用户

---

### 2️⃣ 使用场景

✅ 推荐：

* “新建 / 添加 / 发布”
* 首次进入页面
* 需要明确行为含义

❌ 不适合：

* 高频重复操作
* 小屏复杂页面

---

## 六、FAB vs FilledButton（面试高频对比）

| 对比   | FAB    | FilledButton |
| ---- | ------ | ------------ |
| 位置   | 悬浮     | 布局内          |
| 阴影   | 有      | 无            |
| 操作级别 | 页面级主操作 | 区块级主操作       |
| 数量   | ≤1     | 可多个          |

📌 一句话：

> **FAB 是“页面的主行为”，FilledButton 是“区域的主行为”**

---

## 七、FAB + BottomAppBar（经典组合）

```dart
Scaffold(
  bottomNavigationBar: BottomAppBar(
    shape: const CircularNotchedRectangle(),
    child: Row(
      children: const [
        Spacer(),
      ],
    ),
  ),
  floatingActionButton: FloatingActionButton(
    onPressed: () {},
    child: const Icon(Icons.add),
  ),
  floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,
);
```

✔ FAB 镶嵌到底栏
✔ 符合 Material 规范

---

## 八、Material 3 中 FAB 的变化（重点）

### 1️⃣ M3 新增 FAB 尺寸概念（设计层）

* Small FAB
* Default FAB
* Large FAB
* Extended FAB

⚠️ Flutter 目前：

* **未完全拆成类**
* 主要通过 `FloatingActionButton.extended` 区分

---

### 2️⃣ M3 强调语义 > 造型

* 更推荐 **Extended FAB**
* 避免“只有一个加号但不知道干嘛”

---

## 九、常见错误 & 反模式（⚠️）

### ❌ 1. 一个页面多个 FAB

```dart
Column(
  children: [
    FloatingActionButton(...),
    FloatingActionButton(...),
  ],
)
```

❌ 严重违反设计规范

---

### ❌ 2. FAB 放次要操作

```dart
FAB = “取消” / “返回”
```

❌ 完全错误
FAB 只能是 **最重要动作**

---

### ❌ 3. 滥用 Hero 动画

* 多 FAB 不设 heroTag
* 页面跳转直接崩溃

---

## 十、实战案例（真实项目）

### 新建内容页

```dart
FloatingActionButton.extended(
  onPressed: () {
    Navigator.push(...);
  },
  icon: const Icon(Icons.add),
  label: const Text('新建文章'),
)
```

---

### 加载态 FAB

```dart
FloatingActionButton(
  onPressed: null,
  child: const CircularProgressIndicator(
    color: Colors.white,
  ),
)
```

---

## 十一、面试一句话总结（直接背）

> **FloatingActionButton 是页面级主操作按钮，具有浮动位置和视觉强调，一个页面最多一个，常用于“新增 / 创建”等高频核心操作。**

---

## 十二、学习路线建议（你现在走得很对）

你已经学了：

* FilledButton
* IconButton
* FloatingActionButton

下一步 **非常自然** 的进阶是：

1️⃣ **BottomNavigationBar + FAB 组合设计**
2️⃣ **Material 3 完整按钮体系选型题（面试）**
3️⃣ **Scaffold 常用槽位全解析**

你选一个，我直接给你展开下一讲 🚀
