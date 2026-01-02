好，这一题是 **Flutter 跨平台设计的关键点 + iOS 风格组件必考题**。
`CupertinoButton` 和 `CupertinoButton.filled` 是 **iOS（Cupertino）体系里的核心按钮**，和 Material 按钮思路**完全不同**。

下面给你一份 **「设计理念 → 用法 → 对比 → 实战 → 面试总结」完整版大全**。

---

![Image](https://miro.medium.com/v2/resize%3Afit%3A832/1%2AFufZkEAVr0-fab2YuciQSA.png)

![Image](https://docs.flutter.dev/assets/images/docs/widget-catalog/cupertino-action-sheet.png)

![Image](https://docs.flutter.dev/assets/images/docs/widget-catalog/CupertinoPicker.png)

# Flutter `CupertinoButton` / `CupertinoButton.filled` 知识点 & 使用大全

---

## 一、CupertinoButton 是什么？

> **CupertinoButton：遵循 iOS Human Interface Guidelines 的按钮组件**

关键词：

* iOS 风格
* 无水波纹（Ripple）
* 点击高亮（Opacity 变化）
* 简洁、轻量

📌 使用前提：

> 页面整体使用 **Cupertino 设计体系**

---

## 二、CupertinoButton（普通按钮）

### 1️⃣ 基本用法

```dart
CupertinoButton(
  child: const Text('确定'),
  onPressed: () {
    print('点击');
  },
)
```

✔ 默认无背景
✔ 点击时透明度降低
✔ 类似 iOS 的「文本按钮」

---

### 2️⃣ CupertinoButton 的默认特性

| 特性   | 行为     |
| ---- | ------ |
| 背景   | 透明     |
| 阴影   | 无      |
| 点击反馈 | 透明度变化  |
| 风格   | iOS 原生 |

📌 **没有 Material 的水波纹**

---

### 3️⃣ 常用属性（重点）

#### ▶ padding

```dart
CupertinoButton(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: const Text('确定'),
  onPressed: () {},
)
```

---

#### ▶ color（设置背景）

```dart
CupertinoButton(
  color: CupertinoColors.systemGrey5,
  child: const Text('按钮'),
  onPressed: () {},
)
```

⚠️ 一旦设置 `color`，按钮就“看起来像 filled”

---

#### ▶ disabledColor

```dart
CupertinoButton(
  onPressed: null,
  disabledColor: CupertinoColors.systemGrey,
  child: const Text('不可用'),
)
```

---

#### ▶ borderRadius

```dart
CupertinoButton(
  borderRadius: BorderRadius.circular(8),
  child: const Text('确定'),
  onPressed: () {},
)
```

---

## 三、CupertinoButton.filled（填充按钮）

### 1️⃣ 核心定义

> **CupertinoButton.filled：iOS 风格的主操作按钮（实心背景）**

* 强视觉权重
* 用于 **最重要操作**

---

### 2️⃣ 基本用法

```dart
CupertinoButton.filled(
  child: const Text('提交'),
  onPressed: () {},
)
```

📌 默认：

* 背景色：`CupertinoColors.activeBlue`
* 文本：白色
* 圆角

---

### 3️⃣ filled 的设计定位

| 维度          | 说明           |
| ----------- | ------------ |
| 操作级别        | 主操作          |
| 视觉权重        | 高            |
| 使用频率        | 低（克制）        |
| 对应 Material | FilledButton |

---

## 四、CupertinoButton vs CupertinoButton.filled（重点对比）

| 对比项  | CupertinoButton | CupertinoButton.filled |
| ---- | --------------- | ---------------------- |
| 背景   | 无               | 有                      |
| 操作级别 | 次要              | 主                      |
| 默认颜色 | 文字蓝色            | 蓝底白字                   |
| 使用场景 | 取消 / 次操作        | 确认 / 提交                |

📌 一句话记忆：

> **filled = iOS 的“主按钮”**

---

## 五、CupertinoButton vs Material Button（面试常问）

| 对比   | CupertinoButton | FilledButton |
| ---- | --------------- | ------------ |
| 设计体系 | iOS             | Material 3   |
| 点击反馈 | 透明度变化           | 水波纹          |
| 阴影   | 无               | 无            |
| 适用平台 | iOS             | Android / 通用 |

📌 面试加分句：

> Flutter 允许同一逻辑下，根据平台切换 Material / Cupertino 组件

---

## 六、Cupertino 场景中的常见用法

### 1️⃣ CupertinoNavigationBar 右侧按钮

```dart
CupertinoNavigationBar(
  trailing: CupertinoButton(
    padding: EdgeInsets.zero,
    child: const Text('保存'),
    onPressed: () {},
  ),
)
```

✔ 非常 iOS
✔ 无背景

---

### 2️⃣ 底部主操作（filled）

```dart
CupertinoButton.filled(
  child: const Text('完成'),
  onPressed: () {},
)
```

---

### 3️⃣ 弹窗中的操作按钮

```dart
CupertinoAlertDialog(
  title: const Text('提示'),
  actions: [
    CupertinoButton(
      child: const Text('取消'),
      onPressed: () {},
    ),
    CupertinoButton(
      child: const Text('确定'),
      onPressed: () {},
    ),
  ],
)
```

📌 Alert 中 **不用 filled**

---

## 七、常见错误 & 反模式（⚠️）

### ❌ 1. Cupertino 页面混用 Material Button

```dart
CupertinoPageScaffold(
  child: FilledButton(...) // ❌
)
```

👉 风格割裂

---

### ❌ 2. 滥用 CupertinoButton.filled

* 一个页面多个 filled
* 失去“主操作”意义

---

### ❌ 3. 想要水波纹

👉 Cupertino 设计 **没有 ripple**

---

## 八、平台自适应写法（高级）

```dart
Widget platformButton({
  required VoidCallback onPressed,
  required Widget child,
}) {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return CupertinoButton(
      onPressed: onPressed,
      child: child,
    );
  }
  return FilledButton(
    onPressed: onPressed,
    child: child,
  );
}
```

📌 实战中非常加分

---

## 九、实战选型指南（记住这张）

| 场景         | 推荐                     |
| ---------- | ---------------------- |
| iOS 页面次操作  | CupertinoButton        |
| iOS 页面主操作  | CupertinoButton.filled |
| Android 页面 | FilledButton           |
| 弹窗操作       | CupertinoButton        |
| 跨平台统一      | 平台判断                   |

---

## 十、面试一句话总结（直接背）

> **CupertinoButton 是 iOS 风格的无背景按钮，强调轻量与透明度反馈；CupertinoButton.filled 是 iOS 的主操作按钮，用于最重要行为，在 Cupertino 页面中替代 Material 的 FilledButton。**

---

## 十一、你现在已经形成「完整按钮体系」了 👍

你已经系统掌握：

* Material：FilledButton / IconButton / FAB / PopupMenuButton / DropdownButton
* Cupertino：CupertinoButton / CupertinoButton.filled

下一步 **非常自然的进阶** 是：

1️⃣ **CupertinoNavigationBar / CupertinoPageScaffold 全解析**
2️⃣ **Material vs Cupertino 组件对照（面试神器）**
3️⃣ **平台自适应 UI（Adaptive Widget）实战**

你选一个，我直接给你继续下一讲 🚀
