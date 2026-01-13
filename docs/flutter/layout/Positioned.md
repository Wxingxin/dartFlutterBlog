下面为你系统、完整地整理 **Flutter 中 `Positioned` 组件的属性大全与配置规则大全**。内容按照**“是什么 → 属性 → 约束规则 → 常见组合 → 实战示例 → 常见坑”**的结构展开，适合作为**查阅手册 + 实战指南**。

---

# 一、Positioned 是什么

`Positioned` 是 **Stack 专属的定位组件**，用于在 `Stack` 中对某个子组件进行**绝对定位**。

* 类似 Web 中的 `position: absolute`
* 只能用在 `Stack` / `IndexedStack` 中
* 通过 **距离边界 + 尺寸约束** 决定位置和大小

```dart
Stack(
  children: [
    Positioned(
      top: 10,
      left: 10,
      child: Text('Hello'),
    ),
  ],
)
```

---

# 二、Positioned 构造函数

```dart
Positioned({
  Key? key,
  double? left,
  double? top,
  double? right,
  double? bottom,
  double? width,
  double? height,
  required Widget child,
})
```

---

# 三、Positioned 属性大全（核心）

## 1️⃣ 边距定位属性（位置相关）

| 属性       | 类型        | 说明          |
| -------- | --------- | ----------- |
| `top`    | `double?` | 距离 Stack 顶部 |
| `bottom` | `double?` | 距离 Stack 底部 |
| `left`   | `double?` | 距离 Stack 左侧 |
| `right`  | `double?` | 距离 Stack 右侧 |

📌 单位：**逻辑像素（dp）**

---

## 2️⃣ 尺寸约束属性（大小相关）

| 属性       | 类型        | 说明   |
| -------- | --------- | ---- |
| `width`  | `double?` | 固定宽度 |
| `height` | `double?` | 固定高度 |

---

## 3️⃣ child（必选）

```dart
child: Widget
```

被定位的子组件。

---

# 四、Positioned 的布局约束规则（非常重要）

### 规则 1：每个方向最多 2 个约束

| 水平方向                   | 允许组合          |
| ---------------------- | ------------- |
| `left + width`         | ✅             |
| `right + width`        | ✅             |
| `left + right`         | ✅（自动计算 width） |
| `left + right + width` | ❌（冲突）         |

| 垂直方向                    | 允许组合 |
| ----------------------- | ---- |
| `top + height`          | ✅    |
| `bottom + height`       | ✅    |
| `top + bottom`          | ✅    |
| `top + bottom + height` | ❌    |

---

### 规则 2：至少要有一个定位约束

❌ 错误示例：

```dart
Positioned(
  child: Text('无效')
)
```

✅ 正确示例：

```dart
Positioned(
  left: 0,
  child: Text('有效')
)
```

---

### 规则 3：left / right 决定 X 轴，top / bottom 决定 Y 轴

* 横向、纵向是 **独立计算**
* 可以只控制一个方向

```dart
Positioned(
  top: 20, // 只控制 Y
  child: Widget(),
)
```

---

# 五、Positioned 常见配置组合大全

## 1️⃣ 固定在某个角

### 左上角

```dart
Positioned(
  top: 0,
  left: 0,
  child: Widget(),
)
```

### 右下角

```dart
Positioned(
  bottom: 0,
  right: 0,
  child: Widget(),
)
```

---

## 2️⃣ 水平 / 垂直居中（不推荐）

```dart
Positioned(
  left: 0,
  right: 0,
  top: 0,
  bottom: 0,
  child: Center(child: Widget()),
)
```

📌 更推荐使用 `Align`：

```dart
Align(
  alignment: Alignment.center,
  child: Widget(),
)
```

---

## 3️⃣ 铺满 Stack（Positioned.fill）

```dart
Positioned.fill(
  child: Widget(),
)
```

等价于：

```dart
Positioned(
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
)
```

---

## 4️⃣ 顶部悬浮条

```dart
Positioned(
  top: 0,
  left: 0,
  right: 0,
  height: 56,
  child: AppBar(),
)
```

---

## 5️⃣ 右上角角标（超出容器）

```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    Image.network(url),
    Positioned(
      top: -6,
      right: -6,
      child: Badge(),
    ),
  ],
)
```

---

# 六、PositionedDirectional（国际化）

## 1️⃣ 是什么

`PositionedDirectional` 支持 **LTR / RTL 自动适配**

```dart
PositionedDirectional(
  start: 10,
  end: 10,
  top: 10,
  child: Widget(),
)
```

---

## 2️⃣ 属性对照表

| Positioned | PositionedDirectional |
| ---------- | --------------------- |
| `left`     | `start`               |
| `right`    | `end`                 |

📌 适用于阿拉伯语、希伯来语等 RTL 布局。

---

# 七、Positioned 与 Stack.alignment 的关系

| 项目               | 是否受 Stack.alignment 影响 |
| ---------------- | ---------------------- |
| Positioned 子组件   | ❌ 不受影响                 |
| 非 Positioned 子组件 | ✅ 受影响                  |

---

# 八、Positioned vs Align（面试必考）

| 对比项        | Positioned | Align |
| ---------- | ---------- | ----- |
| 定位方式       | 绝对定位       | 相对对齐  |
| 是否需要数值     | 是          | 否     |
| 是否依赖 Stack | 是          | 否     |
| 是否推荐居中     | ❌          | ✅     |

---

# 九、常见错误与坑点

## ❌ 1. 在 Column 中直接使用 Stack + Positioned

错误原因：**Stack 高度无约束**

解决方案：

```dart
SizedBox(
  height: 200,
  child: Stack(
    children: [
      Positioned(...)
    ],
  ),
)
```

---

## ❌ 2. Positioned 组合冲突

```dart
Positioned(
  left: 10,
  right: 10,
  width: 100, // ❌
)
```

---

## ❌ 3. 忘记 clipBehavior

角标不显示时：

```dart
Stack(
  clipBehavior: Clip.none,
)
```

---

# 十、一句话总结

> **Positioned = Stack 中的“绝对定位规则引擎”，通过 top / left / right / bottom / width / height 精确控制子组件位置与大小。**

---

如果你需要，我可以继续帮你：

* 整理 **Stack + Positioned 的常见 UI 模板**
* 对比 **Positioned / Align / Transform.translate**
* 给你一份 **Flutter 布局组件速查表（适合背）**

直接告诉我你下一步想深入哪一块即可。
