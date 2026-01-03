下面给你一份 **Flutter `Checkbox` 的「知识点 + 使用大全」**，覆盖 **基础 → 常用属性 → 进阶用法 → 实战场景 → 常见坑**，偏实战、可直接当笔记用 👍

---

## 一、Checkbox 是什么？

`Checkbox` 是 **布尔选择组件**，用于表示：

* 勾选 / 不勾选（同意协议、设置项）
* 多选列表中的单个选项
* 与 `Switch`（开关）不同：**Checkbox 更偏“选择项”**

📌 **一句话**

> Checkbox 负责“是否选择”，Switch 负责“是否开启”

---

## 二、最基础用法（必须会）

```dart
bool _checked = false;

Checkbox(
  value: _checked,
  onChanged: (value) {
    setState(() {
      _checked = value!;
    });
  },
)
```

⚠️ 关键点：

* `value`：当前状态（true / false）
* `onChanged`：状态变化回调
* **Checkbox 本身不保存状态，状态必须由你管理**

---

## 三、核心属性一览 ⭐⭐⭐⭐⭐

```dart
Checkbox(
  value: _checked,
  onChanged: (bool? value) {},
  activeColor: Colors.blue,
  checkColor: Colors.white,
  tristate: false,
)
```

| 属性          | 说明     |
| ----------- | ------ |
| value       | 是否选中   |
| onChanged   | 状态改变回调 |
| activeColor | 选中背景色  |
| checkColor  | √ 的颜色  |
| tristate    | 是否支持三态 |

---

## 四、三态 Checkbox（进阶）

### 1️⃣ 什么是三态？

```dart
true    // 选中
false   // 未选中
null    // 未确定
```

### 2️⃣ 用法

```dart
bool? _value;

Checkbox(
  value: _value,
  tristate: true,
  onChanged: (value) {
    setState(() {
      _value = value;
    });
  },
)
```

📌 常见场景：

* “全选 / 半选 / 未选”
* 权限配置

---

## 五、Checkbox + 文本（常用组合）

❌ 不推荐手写 Row
✅ **用官方组件 `CheckboxListTile`**

---

## 六、CheckboxListTile（强烈推荐）⭐⭐⭐⭐⭐

```dart
bool _checked = false;

CheckboxListTile(
  value: _checked,
  onChanged: (value) {
    setState(() {
      _checked = value!;
    });
  },
  title: Text('我已阅读并同意用户协议'),
)
```

### 常用属性

```dart
CheckboxListTile(
  title: Text('标题'),
  subtitle: Text('副标题'),
  secondary: Icon(Icons.info),
  controlAffinity: ListTileControlAffinity.leading,
)
```

| 属性              | 作用     |
| --------------- | ------ |
| title           | 主文本    |
| subtitle        | 副文本    |
| secondary       | 左/右侧图标 |
| controlAffinity | 复选框位置  |

---

## 七、多选列表（实战必考）

### 示例：多选兴趣标签

```dart
List<String> hobbies = ['篮球', '足球', '游戏'];
Set<String> selected = {};

Column(
  children: hobbies.map((item) {
    return CheckboxListTile(
      title: Text(item),
      value: selected.contains(item),
      onChanged: (checked) {
        setState(() {
          checked!
              ? selected.add(item)
              : selected.remove(item);
        });
      },
    );
  }).toList(),
)
```

📌 核心思想：

* Checkbox 只负责展示
* **选中逻辑在数据层（Set / List）**

---

## 八、全选 / 反选（高频）

```dart
bool allChecked = false;

CheckboxListTile(
  title: Text('全选'),
  value: allChecked,
  onChanged: (value) {
    setState(() {
      allChecked = value!;
      selected = value
          ? hobbies.toSet()
          : {};
    });
  },
)
```

📌 可扩展为三态（部分选中）

---

## 九、禁用 Checkbox

```dart
Checkbox(
  value: true,
  onChanged: null, // 置空即禁用
)
```

或：

```dart
CheckboxListTile(
  value: true,
  onChanged: null,
  title: Text('不可操作'),
)
```

---

## 十、样式控制（UI 定制）

### 1️⃣ 改颜色

```dart
Checkbox(
  activeColor: Colors.green,
  checkColor: Colors.white,
)
```

---

### 2️⃣ 改形状（Material 3 常用）

```dart
Checkbox(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(4),
  ),
)
```

---

## 十一、Checkbox 与状态管理

### ❌ 不推荐

```dart
setState(() {});
```

### ✅ 推荐

* Provider / Riverpod
* Bloc / Cubit
* GetX

📌 Checkbox **非常适合做“状态驱动 UI”示例**

---

## 十二、Checkbox vs Switch（面试必问）

| 对比   | Checkbox | Switch |
| ---- | -------- | ------ |
| 语义   | 选择       | 开关     |
| 使用场景 | 多选 / 协议  | 设置     |
| 交互   | 点击勾选     | 滑动     |

👉 **面试回答**

> Checkbox 表示“是否被选中”，Switch 表示“是否开启功能”

---

## 十三、常见坑（重点）⚠️

❌ 忘了 setState
❌ value 为 null 却没开 tristate
❌ Checkbox 放在 ListView 中状态错乱（key 问题）
❌ 直接在 Checkbox 内部存状态（不可能）

---

## 十四、典型实战场景汇总

* 登录页「同意用户协议」
* 设置页多选项
* 表单勾选确认
* 列表批量选择
* 权限配置页

---

## 十五、面试一句话总结

> Checkbox 是 Flutter 中最基础的布尔选择组件，
> 本身不保存状态，
> 通常配合状态管理或 CheckboxListTile 使用。

---

## 十六、你可以继续深入的方向 👇

如果你愿意，我可以继续帮你整理：

* ✅ **Radio / RadioListTile 全解**
* ✅ **Switch / SwitchListTile**
* ✅ **Checkbox + 表单（FormField 自定义）**
* ✅ **Material 3 中 Checkbox 的变化**
* ✅ **统一封装「选择组件库」**

你选一个，我继续给你系统梳理 💪
