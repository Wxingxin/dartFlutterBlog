好，这一题是 **Flutter 表单组件核心 + 面试高频 + 实战非常常见**。
`DropdownButton` 看起来只是个下拉框，但实际上牵涉到 **状态管理、泛型、样式、M3 替代方案、易踩坑**。

下面给你一份 **真正“项目级”的 DropdownButton 使用大全**。

---

![Image](https://miro.medium.com/1%2A7su1KTk9EGTjcf4wwMWL7w.png)

![Image](https://miro.medium.com/1%2AFhrNsBiHkTkb_MldQsPx0Q.png)

![Image](https://user-images.githubusercontent.com/36861262/200902638-8938d2cc-2805-4d74-ae02-0db77a7c9842.png)

![Image](https://miro.medium.com/0%2Asazn3HbfuspABCLR.png)

# Flutter `DropdownButton` 知识点 & 使用大全

---

## 一、DropdownButton 是什么？

> **DropdownButton：点击后从下拉菜单中选择一个值的组件**

典型用途：

* 性别选择
* 状态选择
* 分类 / 类型选择
* 表单中的枚举值

📌 特点：

* **一次只能选一个**
* 必须有一个 **当前选中值**

---

## 二、最基础用法（必须会）

```dart
String dropdownValue = 'A';

DropdownButton<String>(
  value: dropdownValue,
  items: const [
    DropdownMenuItem(value: 'A', child: Text('选项 A')),
    DropdownMenuItem(value: 'B', child: Text('选项 B')),
    DropdownMenuItem(value: 'C', child: Text('选项 C')),
  ],
  onChanged: (value) {
    setState(() {
      dropdownValue = value!;
    });
  },
)
```

✔ 泛型指定类型
✔ value 必须在 items 里

---

## 三、DropdownButton 的核心规则（⚠️ 面试必考）

### 1️⃣ value 必须满足条件

```dart
value != null
value ∈ items.map((e) => e.value)
```

❌ 否则直接运行时报错：

> There should be exactly one item with value …

---

### 2️⃣ DropdownButton 是 **无状态组件**

* 当前值必须由外部维护
* 通常配合 `StatefulWidget`

---

## 四、DropdownMenuItem（重点）

### 1️⃣ 基本结构

```dart
DropdownMenuItem<String>(
  value: 'A',
  child: Text('选项 A'),
)
```

📌 `value` 是逻辑值
📌 `child` 是显示内容

---

### 2️⃣ value ≠ child

```dart
DropdownMenuItem<int>(
  value: 1,
  child: Text('男'),
)
```

---

## 五、常用属性详解（重点）

### 1️⃣ hint（未选中提示）

```dart
DropdownButton<String>(
  hint: const Text('请选择'),
  value: null,
  items: ...
)
```

⚠️ 使用 hint 时：

* `value` 必须为 null

---

### 2️⃣ isExpanded（非常常用）

```dart
DropdownButton(
  isExpanded: true,
)
```

✔ 占满父容器宽度
✔ 表单中几乎必开

---

### 3️⃣ icon / iconSize

```dart
DropdownButton(
  icon: const Icon(Icons.arrow_drop_down),
  iconSize: 28,
)
```

---

### 4️⃣ underline（去掉下划线）

```dart
DropdownButton(
  underline: const SizedBox(),
)
```

📌 常用于自定义 UI

---

### 5️⃣ disabledHint（禁用提示）

```dart
DropdownButton(
  onChanged: null,
  disabledHint: const Text('不可选'),
)
```

---

## 六、DropdownButtonFormField（强烈推荐）

> **表单场景优先用 DropdownButtonFormField**

### 1️⃣ 用法示例

```dart
DropdownButtonFormField<String>(
  decoration: const InputDecoration(
    labelText: '性别',
    border: OutlineInputBorder(),
  ),
  value: dropdownValue,
  items: const [
    DropdownMenuItem(value: 'male', child: Text('男')),
    DropdownMenuItem(value: 'female', child: Text('女')),
  ],
  onChanged: (value) {
    setState(() {
      dropdownValue = value!;
    });
  },
)
```

✔ 自动对齐表单样式
✔ 支持校验

---

### 2️⃣ 校验（validator）

```dart
validator: (value) {
  if (value == null) {
    return '请选择性别';
  }
  return null;
}
```

---

## 七、DropdownButton vs PopupMenuButton（面试对比）

| 对比      | DropdownButton | PopupMenuButton |
| ------- | -------------- | --------------- |
| 用途      | 表单选择           | 操作选择            |
| 是否显示当前值 | ✅              | ❌               |
| 状态依赖    | 强              | 弱               |
| 典型场景    | 筛选条件           | 更多操作            |

📌 一句话：

> **Dropdown 是“选值”，PopupMenu 是“选动作”**

---

## 八、Material 3 新组件：DropdownMenu（重点）

> **M3 推荐用 DropdownMenu（不是 DropdownButton）**

### 示例

```dart
DropdownMenu<String>(
  label: const Text('城市'),
  dropdownMenuEntries: const [
    DropdownMenuEntry(value: 'bj', label: '北京'),
    DropdownMenuEntry(value: 'sh', label: '上海'),
  ],
  onSelected: (value) {
    print(value);
  },
)
```

✔ 更现代
✔ 支持搜索（可选）
✔ 更符合 M3 设计

📌 面试可加一句：

> Material 3 中，DropdownMenu 是 DropdownButton 的推荐替代方案

---

## 九、常见错误 & 坑（⚠️）

### ❌ 1. value 不在 items 中

```dart
value = 'D';
items = ['A','B','C'];
```

---

### ❌ 2. items 动态变更但 value 没更新

```dart
setState(() {
  items = newList;
  // 忘了更新 value
});
```

---

### ❌ 3. 表单中用 DropdownButton

👉 应该用 `DropdownButtonFormField`

---

## 十、实战案例（真实项目）

### 筛选栏

```dart
DropdownButton<String>(
  isExpanded: true,
  value: filter,
  items: filters
      .map((e) => DropdownMenuItem(
            value: e,
            child: Text(e),
          ))
      .toList(),
  onChanged: (v) {
    setState(() => filter = v!);
  },
)
```

---

## 十一、面试一句话总结（直接背）

> **DropdownButton 是 Flutter 中用于单选值的下拉选择组件，value 必须存在于 items 中，表单场景推荐使用 DropdownButtonFormField，Material 3 推荐使用 DropdownMenu。**

---

## 十二、你现在的学习路线非常对 👍

你已经系统学完：

* FilledButton
* IconButton
* FloatingActionButton
* PopupMenuButton
* DropdownButton

接下来 **最自然的进阶** 是：

1️⃣ **Form / TextFormField / 校验体系**
2️⃣ **Material 3 DropdownMenu 深度解析**
3️⃣ **表单组件选型 & 面试题合集**

你选一个，我直接继续下一讲 🚀
