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
------------------------------------------------------

下面给你一份 **Flutter 中 `SelectableText` 组件的属性与配置大全**，按照**真实业务使用频率 + 可维护性 + 和 Text 的差异**系统整理，适合你在项目中长期对照使用。

---

## 一、SelectableText 是什么？（先建立正确认知）

> `SelectableText` = **可选择、可复制的 Text**

* 支持 **长按选择**
* 支持 **复制 / 全选**
* 常用于：

  * 日志展示
  * 代码片段
  * 协议条款
  * 用户 ID / Token / 链接

```dart
SelectableText(
  '这段文字可以被选中',
)
```

---

## 二、SelectableText 与 Text 的核心区别（重要）

| 对比项   | Text          | SelectableText         |
| ----- | ------------- | ---------------------- |
| 是否可选中 | ❌             | ✅                      |
| 复制    | ❌             | ✅                      |
| 点击事件  | ✅（配合 Gesture） | ⚠️ 有限制                 |
| 富文本   | ❌             | ✅（SelectableText.rich） |
| 性能    | 更好            | 稍低                     |

📌 **注意**：SelectableText 本质是 `RenderEditable`

---

## 三、SelectableText 核心属性大全（⭐⭐⭐⭐⭐）

### 1️⃣ 文本样式与排版（和 Text 高度一致）

| 属性                | 类型               | 说明     |
| ----------------- | ---------------- | ------ |
| `style`           | `TextStyle?`     | 文本样式   |
| `textAlign`       | `TextAlign?`     | 对齐方式   |
| `textDirection`   | `TextDirection?` | 文本方向   |
| `softWrap`        | `bool`           | 是否自动换行 |
| `maxLines`        | `int?`           | 最大行数   |
| `minLines`        | `int?`           | 最小行数   |
| `textScaleFactor` | `double?`        | 缩放比例   |
| `locale`          | `Locale?`        | 本地化    |

---

### 2️⃣ 溢出控制（⚠️ 注意差异）

```dart
SelectableText(
  text,
  maxLines: 2,
)
```

⚠️ **SelectableText 不支持 `TextOverflow.ellipsis`**

| 行为   | 说明    |
| ---- | ----- |
| 超出行数 | 直接裁剪  |
| 省略号  | ❌ 不支持 |

---

### 3️⃣ 选择行为控制（SelectableText 特有）

| 属性                           | 类型                       | 说明      |
| ---------------------------- | ------------------------ | ------- |
| `enableInteractiveSelection` | `bool`                   | 是否允许选择  |
| `toolbarOptions`             | `ToolbarOptions?`        | 控制工具栏按钮 |
| `cursorColor`                | `Color?`                 | 光标颜色    |
| `cursorRadius`               | `Radius?`                | 光标圆角    |
| `cursorWidth`                | `double?`                | 光标宽度    |
| `selectionControls`          | `TextSelectionControls?` | 自定义选择控件 |

```dart
SelectableText(
  text,
  enableInteractiveSelection: true,
  toolbarOptions: ToolbarOptions(
    copy: true,
    selectAll: true,
  ),
)
```

---

### 4️⃣ 选择高亮 & 光标样式

```dart
SelectableText(
  text,
  selectionControls: materialTextSelectionControls,
)
```

📌 可用于 **定制 Android / iOS 风格**

---

## 四、SelectableText.rich（富文本）

```dart
SelectableText.rich(
  TextSpan(
    text: '账号：',
    children: [
      TextSpan(
        text: 'abc123',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)
```

📌 **支持多样式文本整体可选**

---

## 五、SelectableText 常见实战场景

### 1️⃣ 用户 ID / Token（强烈推荐）

```dart
SelectableText(
  userId,
  style: TextStyle(fontFamily: 'monospace'),
)
```

---

### 2️⃣ 协议 / 隐私政策

```dart
SelectableText(
  agreementText,
  textAlign: TextAlign.start,
)
```

---

### 3️⃣ 代码展示

```dart
SelectableText(
  code,
  style: TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
  ),
)
```

---

### 4️⃣ 禁止选择（只展示）

```dart
SelectableText(
  text,
  enableInteractiveSelection: false,
)
```

---

## 六、SelectableText 的限制与坑（经验总结）

| 问题           | 原因                 |
| ------------ | ------------------ |
| 无法加省略号       | 设计限制               |
| onTap 不灵     | 选择手势优先             |
| 与 Gesture 冲突 | 内部手势处理             |
| 长文本性能差       | RenderEditable 开销大 |

📌 **列表中不要大量使用 SelectableText**

---

## 七、SelectableText vs Text.rich vs RichText

| 场景     | 推荐组件                  |
| ------ | --------------------- |
| 普通展示   | `Text`                |
| 多样式    | `Text.rich`           |
| 可复制文本  | `SelectableText`      |
| 可复制富文本 | `SelectableText.rich` |

---

## 八、进阶技巧（你以后会用到）

### 1️⃣ 长按复制按钮（非选区）

```dart
GestureDetector(
  onLongPress: () {
    Clipboard.setData(ClipboardData(text: text));
  },
  child: Text(text),
)
```

📌 **比 SelectableText 性能好**

---

### 2️⃣ 与 ScrollView 搭配

```dart
SingleChildScrollView(
  child: SelectableText(longText),
)
```

---

## 九、最佳实践建议（项目级）

1. **不要滥用** SelectableText
2. **只在“需要复制”的地方用**
3. Token / ID / 日志统一 monospace 字体
4. 列表项中避免使用

---

## 十、你可以继续深入的方向

如果你愿意，我可以继续给你：

1. **SelectableText 自定义复制菜单**
2. **Flutter 文本选择原理（RenderEditable）**
3. **Text / EditableText / SelectableText 底层差异**
4. **封装一个可切换 Text / SelectableText 组件**

你只需要选一个方向，我直接给你完整方案。
