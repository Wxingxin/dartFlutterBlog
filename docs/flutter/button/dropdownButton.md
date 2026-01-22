下面给你一份 **Flutter `DropdownButton` 组件的属性与配置大全**。
我会从 **概念 → 构造函数 → 核心属性 → 样式 → 状态 → 变体（DropdownButtonFormField）→ 实战建议** 逐层展开，偏**工程实用**，方便你直接用在项目里。

---

# 一、DropdownButton 是什么

`DropdownButton` 是 **下拉选择组件**，用于：

* 从 **有限选项中选择一个值**
* 表单 / 设置页 / 筛选条件
* 通常搭配 `DropdownMenuItem`

📌 本质结构：

```
DropdownButton
 └── DropdownMenuItem<T>
      └── child（Text / Widget）
```

---

# 二、最基础用法

```dart
String? _value;

DropdownButton<String>(
  value: _value,
  hint: const Text('请选择'),
  items: const [
    DropdownMenuItem(value: 'a', child: Text('选项 A')),
    DropdownMenuItem(value: 'b', child: Text('选项 B')),
  ],
  onChanged: (value) {
    setState(() {
      _value = value;
    });
  },
)
```

---

# 三、构造函数与核心属性总览

```dart
DropdownButton<T>({
  Key? key,
  required List<DropdownMenuItem<T>>? items,
  T? value,
  Widget? hint,
  Widget? disabledHint,
  required ValueChanged<T?>? onChanged,
  VoidCallback? onTap,
  int elevation = 8,
  TextStyle? style,
  Widget? underline,
  Widget? icon,
  Color? iconDisabledColor,
  Color? iconEnabledColor,
  double iconSize = 24.0,
  bool isDense = false,
  bool isExpanded = false,
  double? itemHeight,
  AlignmentGeometry alignment = Alignment.centerLeft,
  BorderRadius? borderRadius,
  Color? dropdownColor,
  FocusNode? focusNode,
  bool autofocus = false,
  MenuMaxHeight? menuMaxHeight,
})
```

---

# 四、核心功能属性（必会）

---

## 1️⃣ items（下拉选项）

```dart
items: const [
  DropdownMenuItem(
    value: 1,
    child: Text('选项 1'),
  ),
]
```

📌 要求：

* `value` 类型必须和 `DropdownButton<T>` 一致
* `value` 必须存在于 `items` 中

---

## 2️⃣ value（当前选中值）

```dart
value: _value
```

⚠️ 注意：

* `value == null` → 显示 `hint`
* `value` 不在 `items` 中 → **直接报错**

---

## 3️⃣ onChanged（选择回调）

```dart
onChanged: (value) {
  setState(() {
    _value = value;
  });
}
```

📌 禁用状态：

```dart
onChanged: null
```

---

## 4️⃣ hint（未选择时显示）

```dart
hint: const Text('请选择城市'),
```

---

## 5️⃣ disabledHint（禁用时显示）

```dart
disabledHint: const Text('不可选择'),
```

📌 当 `onChanged == null` 时生效

---

## 6️⃣ onTap（展开前回调）

```dart
onTap: () {
  print('点击下拉框');
}
```

---

# 五、样式与外观配置

---

## 1️⃣ style（文字样式）

```dart
style: const TextStyle(
  color: Colors.black,
  fontSize: 16,
),
```

📌 作用于 **选中项文字**

---

## 2️⃣ underline（下划线）

```dart
underline: Container(
  height: 1,
  color: Colors.blue,
)
```

❌ 去掉下划线：

```dart
underline: const SizedBox.shrink()
```

---

## 3️⃣ icon（右侧箭头）

```dart
icon: const Icon(Icons.arrow_drop_down),
```

---

## 4️⃣ iconSize / iconEnabledColor / iconDisabledColor

```dart
iconSize: 28,
iconEnabledColor: Colors.blue,
iconDisabledColor: Colors.grey,
```

---

## 5️⃣ dropdownColor（下拉菜单背景）

```dart
dropdownColor: Colors.white,
```

---

## 6️⃣ elevation（菜单阴影）

```dart
elevation: 8,
```

---

## 7️⃣ borderRadius（菜单圆角）

```dart
borderRadius: BorderRadius.circular(8),
```

---

## 8️⃣ alignment（选中项对齐）

```dart
alignment: Alignment.centerLeft,
```

---

## 9️⃣ itemHeight（每一项高度）

```dart
itemHeight: 48,
```

---

## 🔟 isDense（紧凑模式）

```dart
isDense: true,
```

📌 常用于表单 / 列表

---

## 1️⃣1️⃣ isExpanded（是否撑满父组件）

```dart
isExpanded: true,
```

📌 **非常常用**，解决文字被截断问题

---

## 1️⃣2️⃣ menuMaxHeight（下拉最大高度）

```dart
menuMaxHeight: 300,
```

📌 选项很多时必配

---

# 六、焦点与可访问性

---

## focusNode / autofocus

```dart
focusNode: myFocusNode,
autofocus: true,
```

📌 Web / 桌面 / TV 端使用

---

# 七、DropdownButtonFormField（表单版，强烈推荐）

📌 实际项目中 **80% 用这个，而不是 DropdownButton**

---

## 基本用法

```dart
DropdownButtonFormField<String>(
  value: _value,
  items: const [
    DropdownMenuItem(value: 'a', child: Text('A')),
    DropdownMenuItem(value: 'b', child: Text('B')),
  ],
  onChanged: (value) {
    setState(() {
      _value = value;
    });
  },
  decoration: const InputDecoration(
    labelText: '选择类型',
    border: OutlineInputBorder(),
  ),
)
```

---

## 常见优势

| 特性                | DropdownButton | DropdownButtonFormField |
| ----------------- | -------------- | ----------------------- |
| 表单校验              | ❌              | ✅                       |
| label / errorText | ❌              | ✅                       |
| 外观统一              | ❌              | ✅                       |
| 表单提交              | ❌              | ✅                       |

---

## 校验示例

```dart
validator: (value) {
  if (value == null) {
    return '请选择一项';
  }
  return null;
},
```

---

# 八、常见错误与坑

---

### ❌ value 不在 items 中

```dart
value: 'c', // items 没有
```

✔️ 必须保证一致

---

### ❌ items 为空但 value 非 null

```dart
items: [],
value: 'a',
```

---

### ❌ 文本溢出

✔️ 解决：

```dart
isExpanded: true,
```

---

# 九、典型使用场景

| 场景   | 推荐           |
| ---- | ------------ |
| 表单选择 | ✅（FormField） |
| 设置页  | ✅            |
| 筛选条件 | ✅            |
| 大量数据 | ❌（用搜索下拉）     |
| 复杂交互 | ❌            |

---

# 十、DropdownButton vs 其他选择组件

| 组件                      | 适用     |
| ----------------------- | ------ |
| DropdownButton          | 简单选择   |
| DropdownButtonFormField | 表单     |
| PopupMenuButton         | 操作菜单   |
| CupertinoPicker         | iOS 风格 |
| Autocomplete            | 搜索选择   |

---

# 十一、学习与实践建议（给你一个结论）

✅ **优先学 DropdownButtonFormField**
✅ 简单页面再用 DropdownButton
✅ 一定注意 `value` 和 `items` 一致
✅ 长列表一定设置 `menuMaxHeight`

---

## 如果你愿意，我可以继续帮你：

* `DropdownButtonFormField` 完整表单实战
* Flutter 下拉选择 **搜索版实现**
* Dropdown vs PopupMenuButton 详细对比
* 封装一个通用 `SelectField` 组件
* Flutter 表单组件（TextFormField / Checkbox / Radio）全关系图

你直接告诉我下一步想看哪一个即可。
