好，这一块是 **Flutter Material 3（M3）按钮体系的核心更新点**，而且**面试 + 实战都会考**。
我给你一份 **「概念 → 区别 → 用法 → 场景 → 易踩坑」完整版总结**，看完就能直接用在项目里。

---

![Image](https://i.sstatic.net/mTtHX.png)

![Image](https://user-images.githubusercontent.com/39990307/210893290-50c49229-aef0-4375-a91e-f9d22ea3069d.png)

![Image](https://composables.com/static/images/material3/filled-button.png)

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2Aogyml6wOYWC9Jo6eAZ4fdw.png)

# Flutter 中 `FilledButton` / `FilledButton.tonal` 知识点大全（Material 3）

---

## 一、背景：为什么 M3 要新增 FilledButton？

在 **Material 2** 里：

* `ElevatedButton`：有阴影 + 有背景
* `TextButton`：没背景
* `OutlinedButton`：有边框

👉 **问题**：

* 层级不清晰
* 阴影在移动端滥用
* 深色模式不友好

📌 **Material 3 解决方案**：
引入 **Filled Button 系列**，用 **颜色层级** 而不是 **阴影层级**

---

## 二、FilledButton —— 填充按钮（主操作）

### 1️⃣ 核心定义

> **FilledButton：没有阴影，但有强背景色的主按钮**

* ❌ 无 elevation（阴影）
* ✅ 有明显背景色
* ✅ 用颜色强调“主操作”

---

### 2️⃣ 基本用法

```dart
FilledButton(
  onPressed: () {
    print('提交');
  },
  child: const Text('提交'),
)
```

📌 **默认颜色**

* 背景：`colorScheme.primary`
* 文字：`onPrimary`

---

### 3️⃣ 自定义样式

```dart
FilledButton(
  style: FilledButton.styleFrom(
    backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  onPressed: () {},
  child: const Text('确认'),
)
```

---

### 4️⃣ 使用场景（非常重要）

✅ **必须用 FilledButton 的地方**

* 提交表单
* 确认 / 保存
* 页面最重要的 CTA（Call To Action）

❌ 不适合：

* 次要操作
* 辅助功能按钮

---

## 三、FilledButton.tonal —— 色调填充按钮（次要操作）

### 1️⃣ 核心定义

> **FilledButton.tonal：颜色更柔和的填充按钮，用于次要操作**

* 背景色 ≠ primary
* 使用 `secondaryContainer`
* 对比度低于 FilledButton

---

### 2️⃣ 基本用法

```dart
FilledButton.tonal(
  onPressed: () {
    print('取消');
  },
  child: const Text('取消'),
)
```

📌 默认颜色：

* 背景：`colorScheme.secondaryContainer`
* 文字：`onSecondaryContainer`

---

### 3️⃣ 自定义样式

```dart
FilledButton.tonal(
  style: FilledButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 20),
  ),
  onPressed: () {},
  child: const Text('稍后再说'),
)
```

---

### 4️⃣ 使用场景

✅ **推荐**

* 取消
* 次确认
* 辅助操作

❌ 不适合：

* 页面唯一主操作

---

## 四、FilledButton vs FilledButton.tonal（重点对比）

| 对比项  | FilledButton | FilledButton.tonal |
| ---- | ------------ | ------------------ |
| 操作级别 | 主操作          | 次操作                |
| 背景色  | primary      | secondaryContainer |
| 对比度  | 高            | 中                  |
| 强调程度 | 强            | 弱                  |
| 典型文案 | 提交 / 保存      | 取消 / 稍后            |

📌 **一句话记忆**：

> Filled = “你现在就该点”
> Tonal = “你可以考虑点”

---

## 五、和 ElevatedButton 的关系（面试常问）

### 1️⃣ 为什么不用 ElevatedButton？

```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('提交'),
)
```

❌ 问题：

* 默认有阴影
* 不符合 M3 设计规范
* 深色模式表现差

### 2️⃣ 官方推荐

> **Material 3 中：优先使用 FilledButton，避免 ElevatedButton**

---

## 六、实战组合案例（非常实用）

### ✅ 表单底部按钮（标准写法）

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FilledButton.tonal(
      onPressed: () {},
      child: const Text('取消'),
    ),
    const SizedBox(width: 12),
    FilledButton(
      onPressed: () {},
      child: const Text('提交'),
    ),
  ],
)
```

✔ 视觉层级清晰
✔ 完全符合 M3 规范

---

### ✅ 设置页操作

```dart
Column(
  children: [
    FilledButton(
      onPressed: () {},
      child: const Text('保存设置'),
    ),
    const SizedBox(height: 8),
    FilledButton.tonal(
      onPressed: () {},
      child: const Text('恢复默认'),
    ),
  ],
)
```

---

## 七、禁用状态（细节）

```dart
FilledButton(
  onPressed: null, // 禁用
  child: const Text('提交'),
)
```

📌 M3 会自动：

* 降低透明度
* 调整文字对比度
* 无需手动处理

---

## 八、易踩坑总结（⚠️）

❌ **FilledButton ≠ ElevatedButton**

* 没阴影是设计目标，不是缺点

❌ **别滥用 FilledButton**

* 一个页面只允许 1 个主 FilledButton（极限 2 个）

❌ **不要手动 hardcode 颜色**

* 优先使用 `Theme.of(context).colorScheme`

---

## 九、一句话面试总结（直接背）

> **FilledButton 是 Material 3 的主操作按钮，通过颜色而非阴影体现层级；FilledButton.tonal 是次级操作，颜色更柔和，用于辅助行为。**

---

## 十、下一步我可以继续帮你

如果你愿意，我可以继续给你：

1️⃣ **M3 所有按钮完整对照表（Text / Outlined / Filled / Tonal）**
2️⃣ **Flutter 面试：按钮 & Theme 高频题**
3️⃣ **按钮状态设计（hover / pressed / focused）详解**

你挑一个，我直接展开 🔥
-=---------------------
下面是 **Flutter `FilledButton` 组件的参数大全**，**严格按照 Flutter SDK 源码构造函数结构**，**不改结构**，**仅在每个参数后直接追加中文注释**，方便你 **逐行对照源码（Material 3）学习**。

---

## FilledButton 构造函数（源码结构）

```dart
const FilledButton({
  super.key,                         // 组件唯一标识 Key
  required this.onPressed,           // 点击回调（为 null 时按钮禁用）
  this.onLongPress,                  // 长按回调（移动端）
  this.onHover,                      // 鼠标悬停回调（Web / Desktop）
  this.onFocusChange,                // 焦点变化回调（键盘 / 无障碍）
  this.style,                        // 按钮样式（背景色 / 前景色 / 圆角等）
  this.focusNode,                    // 焦点控制节点
  this.autofocus = false,            // 是否自动获取焦点
  this.clipBehavior = Clip.none,     // 子组件超出按钮区域裁剪方式
  required this.child,               // 按钮内容（通常是 Text）
})
```

> ⚠️ 注意：**FilledButton 是 Material 3（M3）按钮**，Flutter 3.7+ 引入，用于取代部分 `ElevatedButton` 使用场景。

---

## 参数逐项说明（源码级理解）

### 1️⃣ onPressed（必传）

```dart
final VoidCallback? onPressed; // 点击触发回调，为 null 时按钮进入禁用态
```

* `null` → disabled
* 非 `null` → 可交互
* 所有 Material Button 统一的禁用判断入口

---

### 2️⃣ onLongPress

```dart
final VoidCallback? onLongPress; // 长按触发（主要用于移动端）
```

---

### 3️⃣ onHover

```dart
final ValueChanged<bool>? onHover; // 鼠标进入 / 离开按钮区域回调
```

* 仅 Web / Desktop 有意义
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

### 5️⃣ style（⭐FilledButton 核心）

```dart
final ButtonStyle? style; // FilledButton 的视觉样式定义
```

常用于控制：

* `backgroundColor` → 填充背景色（FilledButton 核心）
* `foregroundColor` → 文本 / 图标颜色
* `overlayColor` → 点击 / hover 水波纹
* `padding` → 内边距
* `shape` → 圆角形状
* `elevation` → 阴影（默认很轻或无）

示例理解：

```dart
style: FilledButton.styleFrom(
  backgroundColor: Colors.blue, // 填充背景
)
```

---

### 6️⃣ focusNode

```dart
final FocusNode? focusNode; // 手动控制焦点节点
```

* 表单
* 键盘操作
* 无障碍导航

---

### 7️⃣ autofocus

```dart
final bool autofocus; // 构建后是否自动获取焦点
```

* 默认 `false`
* Desktop / Web 更常见

---

### 8️⃣ clipBehavior

```dart
final Clip clipBehavior; // 超出按钮区域的裁剪方式
```

* 通常保持 `Clip.none`
* 自定义 child 溢出时才考虑修改

---

### 9️⃣ child（必传）

```dart
final Widget child; // 按钮内部子组件（Text / Icon / Row 等）
```

---

## FilledButton 的继承关系（源码视角）

```text
FilledButton
  ↓
ButtonStyleButton
  ↓
StatefulWidget
```

* 与 `TextButton / OutlinedButton / ElevatedButton` **完全同构**
* **区别仅在默认 ButtonStyle（Material 3 规范）**

---

## FilledButton 的默认特性（Material 3）

| 特性   | 说明                        |
| ---- | ------------------------- |
| 背景   | 有填充色（Primary / Secondary） |
| 阴影   | 极弱或无（不同于 ElevatedButton）  |
| 设计规范 | Material You（M3）          |
| 推荐场景 | 主操作按钮（Primary Action）     |

---

## 与 ElevatedButton 的一句话源码级区别

> **FilledButton 是 M3 语义按钮，ElevatedButton 是 M2 视觉按钮**

---

如果你继续深入，我可以直接给你：

* ✅ `FilledButton.styleFrom` 参数源码级全注释
* ✅ FilledButton vs ElevatedButton 默认 style 对照表
* ✅ `ButtonStyle` 全字段 + 状态机（hover / pressed / disabled）
* ✅ Material 2 / Material 3 按钮体系完整对比

你直接说：**“继续 styleFrom”** 或 **“ButtonStyle 全字段”** 即可。
