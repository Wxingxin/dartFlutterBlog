下面给你一份 **Flutter `RadioListTile` 的「知识点 + 使用大全」**，这是**单选场景里最常用、最推荐的组件**之一，真实项目里几乎不会手写 `Radio + Row`。
我会按 **概念 → 原理 → 属性 → 实战 → 对比 → 常见坑 → 面试总结** 来讲，偏实战、可直接当长期笔记用 👍

---

## 一、RadioListTile 是什么？

`RadioListTile` = **Radio + ListTile**

👉 官方提供的 **“带文字的单选项组件”**

**解决了什么问题？**

* 不用手写 `Row + Radio + Text`
* 点击整行即可选中
* 自带间距、动画、无障碍支持

📌 **一句话**

> 只要是“单选 + 文本列表”，优先用 `RadioListTile`

---

## 二、RadioListTile 的核心原理（面试必问 ⭐⭐⭐）

`RadioListTile` 的选中逻辑 **完全继承自 Radio**

```dart
value == groupValue → 选中
```

### 两个关键参数

* `value`：当前这一项代表的值
* `groupValue`：当前组选中的值

📌 **重点**

> RadioListTile 本身不存状态，
> 状态一定在外部（变量 / 状态管理）

---

## 三、最基础用法（必须会）

### 示例：性别选择

```dart
String _gender = 'male';

Column(
  children: [
    RadioListTile<String>(
      title: Text('男'),
      value: 'male',
      groupValue: _gender,
      onChanged: (value) {
        setState(() {
          _gender = value!;
        });
      },
    ),
    RadioListTile<String>(
      title: Text('女'),
      value: 'female',
      groupValue: _gender,
      onChanged: (value) {
        setState(() {
          _gender = value!;
        });
      },
    ),
  ],
)
```

📌 **关键点**

* 所有 RadioListTile **共享同一个 groupValue**
* 修改的是 `_gender`，不是某一个 RadioListTile

---

## 四、RadioListTile 的核心属性 ⭐⭐⭐⭐⭐

```dart
RadioListTile<String>(
  value: 'a',
  groupValue: 'a',
  onChanged: (value) {},
  title: Text('标题'),
  subtitle: Text('副标题'),
  secondary: Icon(Icons.info),
  controlAffinity: ListTileControlAffinity.leading,
  activeColor: Colors.blue,
  toggleable: false,
  dense: false,
)
```

---

## 五、属性详解（非常重要）

### 1️⃣ title / subtitle（文本）

```dart
title: Text('微信支付'),
subtitle: Text('推荐使用'),
```

📌 常用于设置页、支付页、配置页

---

### 2️⃣ secondary（图标）

```dart
secondary: Icon(Icons.payment),
```

📌 位置与 `controlAffinity` 相关

---

### 3️⃣ controlAffinity（Radio 位置）⭐⭐⭐

```dart
controlAffinity: ListTileControlAffinity.leading,
```

| 值        | 说明           |
| -------- | ------------ |
| leading  | Radio 在左     |
| trailing | Radio 在右（默认） |
| platform | 跟随平台规范       |

📌 **国内 App 多用 leading**

---

### 4️⃣ activeColor（选中颜色）

```dart
activeColor: Colors.green,
```

---

### 5️⃣ toggleable（是否可取消选中）

```dart
toggleable: true,
```

```dart
String? selected;

RadioListTile<String>(
  value: 'A',
  groupValue: selected,
  toggleable: true,
  onChanged: (value) {
    setState(() {
      selected = value;
    });
  },
)
```

📌 再点一次 → 取消选中
默认是 `false`

---

### 6️⃣ dense（紧凑布局）

```dart
dense: true,
```

📌 设置项很多时非常有用

---

## 六、RadioListTile vs Radio（面试高频）

| 对比     | Radio | RadioListTile |
| ------ | ----- | ------------- |
| 是否带文本  | ❌     | ✅             |
| 是否整行可点 | ❌     | ✅             |
| 是否封装布局 | ❌     | ✅             |
| 项目推荐   | ❌     | ✅             |

👉 **面试答案**

> RadioListTile 是 Radio 的业务级封装，更适合真实项目使用

---

## 七、动态单选列表（高频实战）

```dart
List<String> options = ['微信', '支付宝', '银行卡'];
String selected = '微信';

Column(
  children: options.map((item) {
    return RadioListTile<String>(
      title: Text(item),
      value: item,
      groupValue: selected,
      onChanged: (value) {
        setState(() {
          selected = value!;
        });
      },
    );
  }).toList(),
)
```

📌 **单选的本质**

* 任何时刻，只允许一个值等于 groupValue

---

## 八、RadioListTile + enum（强烈推荐 ⭐⭐⭐⭐⭐）

### 定义枚举

```dart
enum PayType { wechat, alipay, bank }
```

### 使用

```dart
PayType _pay = PayType.wechat;

RadioListTile<PayType>(
  title: Text('微信'),
  value: PayType.wechat,
  groupValue: _pay,
  onChanged: (value) {
    setState(() {
      _pay = value!;
    });
  },
)
```

📌 **优势**

* 类型安全
* 可维护性高
* 面试加分

---

## 九、在 ListView 中使用（注意 key）

```dart
ListView.builder(
  itemCount: options.length,
  itemBuilder: (context, index) {
    final item = options[index];
    return RadioListTile<String>(
      key: ValueKey(item),
      title: Text(item),
      value: item,
      groupValue: selected,
      onChanged: (value) {
        setState(() {
          selected = value!;
        });
      },
    );
  },
)
```

⚠️ 不加 `key` → 滑动时选中错乱

---

## 十、禁用 RadioListTile

```dart
RadioListTile(
  value: 'A',
  groupValue: selected,
  onChanged: null, // 置空即禁用
  title: Text('不可选'),
)
```

---

## 十一、RadioListTile 与状态管理

RadioListTile **非常适合做“状态驱动 UI”**

推荐搭配：

* Provider / Riverpod
* Bloc / Cubit
* GetX

👉 UI 只关心 `value / groupValue`

---

## 十二、常见坑（重点）⚠️

❌ groupValue 写死，导致点不动
❌ 每个 RadioListTile 用不同 groupValue
❌ 用 bool 做 Radio（Radio 更适合 enum / String）
❌ ListView 中没加 key
❌ 用 Radio + Row 重复造轮子

---

## 十三、典型使用场景总结

* 性别选择
* 支付方式
* 配送方式
* 设置页互斥选项
* 配置策略选择

---

## 十四、面试一句话总结（背下来）

> RadioListTile 是 Flutter 中用于“单选列表”的高阶组件，
> 通过 value 与 groupValue 的相等关系控制选中状态，
> 支持整行点击，更适合业务开发。

---

## 十五、你可以继续深入的方向 👇

如果你愿意，我可以继续给你系统整理：

* ✅ **Radio / Checkbox / Switch 三者深度对比**
* ✅ **RadioListTile + Form 表单校验**
* ✅ **Material 3 中 RadioListTile 样式变化**
* ✅ **封装一套企业级「选择组件库」**
* ✅ **选择组件常见面试题合集**

你直接选一个，我继续给你往下拆 🚀
-----------------------------
下面按 **Flutter 官方 `RadioListTile` 构造函数源码顺序** 整理 **RadioListTile 参数大全**，**不改结构**，并且 **每个参数后直接写中文注释**，方便你 **直接对照源码 / IDE 跳转学习**。

> 说明
>
> * 基于 `flutter/material.dart`
> * 本质：`ListTile + Radio` 的组合组件
> * 顺序贴近官方构造函数
> * 注释偏向「源码语义级理解」

---

## RadioListTile 构造函数（源码结构 + 中文注释）

```dart
RadioListTile<T>({
  Key? key, // widget 唯一标识，用于 widget 树 diff 和重建

  required T value, // 当前选项代表的值
  required T? groupValue, // 当前选中值（与 value 相等时表示选中）

  required ValueChanged<T?>? onChanged, // 选中变化回调（为 null 时表示禁用）

  Widget? title, // 主标题组件（通常是 Text）
  Widget? subtitle, // 副标题组件

  Widget? secondary, // 标题前或后的组件（Icon / Avatar 等）

  bool isThreeLine = false, // 是否使用三行布局
  bool dense = false, // 是否使用紧凑布局

  bool? selected, // 是否处于选中高亮状态（影响文本样式）

  ValueChanged<bool>? onFocusChange, // 焦点变化回调

  Color? activeColor, // 选中状态下单选按钮的颜色
  Color? fillColor, // Material 3 中单选按钮填充色

  Color? tileColor, // ListTile 默认背景色
  Color? selectedTileColor, // 选中状态下 ListTile 背景色

  ShapeBorder? shape, // ListTile 形状（圆角、边框）

  FocusNode? focusNode, // 焦点控制节点
  bool autofocus = false, // 是否自动获取焦点

  ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform, 
  // 单选按钮相对于文本的位置（leading / trailing / platform）

  EdgeInsetsGeometry? contentPadding, // ListTile 内边距

  VisualDensity? visualDensity, // 视觉密度（整体紧凑程度）

  MouseCursor? mouseCursor, // 鼠标悬停时光标样式（桌面端）

  MaterialStateProperty<Color?>? overlayColor, // 点击/悬停时的覆盖颜色

  bool? toggleable, // 是否允许再次点击已选中项取消选择

  bool? enableFeedback, // 是否启用触觉/声音反馈

  Color? hoverColor, // 鼠标悬停背景色

  Color? splashColor, // 点击水波纹颜色
})
```

---

## 核心参数源码级理解

### 一、单选状态控制（最核心）

```dart
value
groupValue
onChanged
```

* `value`：本项的值
* `groupValue`：当前组选中的值
* `value == groupValue` ⇒ 当前项选中

👉 **所有 RadioListTile 共享同一个 groupValue**

---

### 二、ListTile 布局相关

```dart
title
subtitle
secondary
isThreeLine
dense
contentPadding
```

---

### 三、Radio 视觉 & 交互

```dart
activeColor
fillColor
overlayColor
toggleable
```

* `toggleable = true` 才能取消已选中的项（少见但有用）

---

### 四、焦点 & 桌面端支持

```dart
focusNode
autofocus
onFocusChange
mouseCursor
hoverColor
```

---

## 常见使用模板（源码对照理解）

```dart
String? gender;

RadioListTile<String>(
  title: const Text('男'),
  value: 'male',
  groupValue: gender,
  onChanged: (value) {
    setState(() {
      gender = value;
    });
  },
);
```

---

## 和 Radio 的本质区别（一句话）

> **RadioListTile = Radio + ListTile**

* Radio：只负责单选状态
* RadioListTile：负责 **状态 + 文本 + 点击区域 + 无障碍**

---

## 表单使用重要提醒

> ⚠️ `RadioListTile` **不是 FormField**

* ❌ 不支持 `validator`
* ❌ 不支持 `onSaved`
* 表单场景下需要：

  * `FormField<T>` 包一层
  * 或自定义 `RadioFormField`

---

## CheckboxListTile / RadioListTile / SwitchListTile 对照

| 组件               | 多选 | 单选 | 表单支持 |
| ---------------- | -- | -- | ---- |
| CheckboxListTile | ✅  | ❌  | ❌    |
| RadioListTile    | ❌  | ✅  | ❌    |
| SwitchListTile   | ❌  | ❌  | ❌    |

---

## 一句话总结（架构级）

> **RadioListTile 是“列表型单选组件”**
>
> * 性别 / 选项选择
> * 设置页单选项
> * 权限 / 模式选择

---

如果你愿意，我可以继续按这个 **源码对照风格** 给你整理：

* `SwitchListTile` 参数大全
* `FormField<T>` 参数大全（自定义表单必会）
* Flutter 表单组件体系完整脑图

你直接说下一个即可。
