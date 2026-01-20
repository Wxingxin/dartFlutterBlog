这是个**很专业、也很容易被低估的 Flutter 组件**。
我直接给你一个**工程级**的讲解：**什么时候用、怎么配、坑在哪、真实项目怎么写**。

---

## 一、SelectableText 是什么？一句话说清

> **SelectableText = Text + 用户可选中 + 可复制**

它不是为了“好看”，而是为了**信息可操作性**。

```dart
SelectableText('这段文字可以被选中和复制');
```

---

## 二、SelectableText 和 Text 的本质区别（必懂）

| 能力   | Text | SelectableText |
| ---- | ---- | -------------- |
| 展示文字 | ✅    | ✅              |
| 用户选中 | ❌    | ✅              |
| 复制   | ❌    | ✅              |
| 长按交互 | ❌    | ✅              |
| 用于表单 | ❌    | ❌              |
| 可滚动  | ❌    | ❌（需包一层）        |

📌 **只要“用户可能想复制”，就该用 SelectableText**

---

## 三、SelectableText 核心属性大全（工程常用）

### 1️⃣ 基础属性（和 Text 类似）

```dart
SelectableText(
  'SelectableText 示例',
  style: TextStyle(
    fontSize: 16,
    color: Colors.black,
    height: 1.4,
  ),
  textAlign: TextAlign.left,
)
```

| 属性                | 说明       |
| ----------------- | -------- |
| `style`           | 字体、颜色、行高 |
| `textAlign`       | 对齐方式     |
| `maxLines`        | 最大行数     |
| `minLines`        | 最小行数     |
| `textScaleFactor` | 字体缩放     |
| `strutStyle`      | 行高精确控制   |

---

### 2️⃣ 光标 & 选中控制（重点）

```dart
SelectableText(
  '可选中文字',
  cursorColor: Colors.blue,
  cursorWidth: 2,
  cursorRadius: Radius.circular(2),
)
```

| 属性             | 作用     |
| -------------- | ------ |
| `cursorColor`  | 光标颜色   |
| `cursorWidth`  | 光标宽度   |
| `cursorRadius` | 圆角     |
| `showCursor`   | 是否显示光标 |

📌 用于 **暗色主题 / 品牌色**

---

### 3️⃣ 工具栏 & 交互控制（高级但实用）

```dart
SelectableText(
  '长按后弹出复制菜单',
  toolbarOptions: ToolbarOptions(
    copy: true,
    selectAll: true,
    cut: false,
    paste: false,
  ),
)
```

| 选项          | 是否常用 |
| ----------- | ---- |
| `copy`      | ✅ 必开 |
| `selectAll` | ✅    |
| `cut`       | ❌    |
| `paste`     | ❌    |

📌 **展示类文字，不要允许 cut / paste**

---

### 4️⃣ 文本选择回调（进阶）

```dart
SelectableText(
  '监听选择变化',
  onSelectionChanged: (selection, cause) {
    print(selection.start);
    print(selection.end);
  },
)
```

**使用场景**

* 统计用户行为
* 自定义复制逻辑
* 屏蔽部分区域选择

---

## 四、SelectableText.rich（必须掌握）

用于**富文本 + 可选中**（非常重要）

```dart
SelectableText.rich(
  TextSpan(
    text: '订单号：',
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(
        text: 'A123456789',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    ],
  ),
)
```

📌 **日志 / 订单 / Token / URL 场景必用**

---

## 五、经典使用场景（真实项目）

### ✅ 场景 1：日志 / 调试信息（最常见）

```dart
SelectableText(
  logContent,
  style: TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
  ),
)
```

📌 **开发者工具 / 错误页标配**

---

### ✅ 场景 2：订单号 / Token / ID

```dart
Row(
  children: [
    Text('订单号：'),
    SelectableText(
      orderId,
      style: TextStyle(color: Colors.blue),
    ),
  ],
)
```

---

### ✅ 场景 3：协议 / 文本详情页

```dart
SingleChildScrollView(
  padding: EdgeInsets.all(16),
  child: SelectableText(
    agreementText,
    textAlign: TextAlign.start,
  ),
)
```

⚠️ 一定要 **包 ScrollView**

---

### ✅ 场景 4：聊天记录（Flutter IM）

```dart
SelectableText(
  message.text,
  enableInteractiveSelection: true,
)
```

📌 IM / 客服系统中非常常见
👉 用户复制地址 / 电话 / 内容

---

## 六、常见坑（你迟早会踩）

### ❌ 坑 1：SelectableText 不滚动

👉 它不是 ScrollView

```dart
SingleChildScrollView(
  child: SelectableText(longText),
);
```

---

### ❌ 坑 2：列表中性能问题

* 大量 SelectableText
* 每个都有 selection layer

📌 解决方案：

* 只对“需要复制的文本”用
* 列表项不要全部 selectable

---

### ❌ 坑 3：SelectableText 不能编辑

它 ≠ TextField
❌ 不要用于输入场景

---

## 七、什么时候 **不该** 用 SelectableText？

| 场景       | 原因  |
| -------- | --- |
| 按钮文案     | 多余  |
| 表单 label | 干扰  |
| 标题       | 没必要 |
| 高性能长列表   | 成本高 |

---

## 八、一句话工程总结（你该记住）

> **SelectableText 是“信息型组件”，不是“展示型组件”**

* 用户**可能想复制 → 用它**
* 只是看 → `Text`

---

## 九、如果你愿意继续，我可以帮你

* 封装一个 **CopyText 组件（带复制提示）**
* 聊天 / 日志中 **SelectableText 的最佳实践**
* 对比 `SelectableText vs TextField(readOnly)`
* Flutter 中 **文本系统全家桶（Text / RichText / SelectableText）**

你更想往**哪一类项目**用？
