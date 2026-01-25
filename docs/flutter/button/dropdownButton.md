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
-----下面是 **Flutter `DropdownButton` 构造函数参数大全**，**严格保持源码中的参数顺序与结构**，**每个参数后面直接写中文注释**，不做重排、不做抽象，方便你 **直接对照 Flutter 源码 / IDE 跳转逐项学习**。

> 对应源码位置：`material/dropdown.dart`

---

```dart
DropdownButton({
  Key? key,                               // Widget 的唯一标识
  required List<DropdownMenuItem<T>>? items, // 下拉菜单项列表
  DropdownButtonBuilder? selectedItemBuilder, // 自定义选中项显示构建器
  T? value,                               // 当前选中的值
  Widget? hint,                           // 未选择时显示的占位内容
  Widget? disabledHint,                   // 禁用状态下显示的占位内容
  required ValueChanged<T?>? onChanged,   // 选中项变化回调（为 null 时禁用）
  VoidCallback? onTap,                    // 点击下拉按钮时回调
  int elevation = 8,                      // 下拉菜单弹出时的阴影高度
  TextStyle? style,                       // 下拉菜单文本样式
  Widget? underline,                      // 下划线组件
  Widget? icon,                           // 右侧下拉箭头图标
  Color? iconDisabledColor,               // 禁用状态图标颜色
  Color? iconEnabledColor,                // 启用状态图标颜色
  double iconSize = 24.0,                 // 图标大小
  bool isDense = false,                   // 是否使用紧凑高度
  bool isExpanded = false,                // 是否横向占满父布局
  double? itemHeight,                     // 每个菜单项高度
  Color? focusColor,                      // 获取焦点时的背景颜色
  FocusNode? focusNode,                   // 焦点控制节点
  bool autofocus = false,                 // 是否自动获取焦点
  Color? dropdownColor,                   // 下拉菜单背景颜色
  double? menuMaxHeight,                  // 下拉菜单最大高度
  bool? enableFeedback,                   // 是否启用触觉/声音反馈
  AlignmentGeometry alignment = AlignmentDirectional.centerStart, // 内容对齐方式
  BorderRadius? borderRadius,             // 下拉菜单圆角
});
```

---

## 一、最核心参数（必须掌握）

### `items`

```dart
required List<DropdownMenuItem<T>>? items, // 下拉菜单的所有选项
```

* 每一项必须是 `DropdownMenuItem<T>`
* `value` 必须在 items 的 value 中存在

---

### `value`

```dart
T? value, // 当前选中的值
```

* 为 null 时显示 hint
* 必须与某个 `DropdownMenuItem.value` 相等

---

### `onChanged`

```dart
required ValueChanged<T?>? onChanged, // 选中变化回调
```

* 为 null ⇒ 整个 Dropdown 禁用
* 触发于选择菜单项后

---

### `hint`

```dart
Widget? hint, // 未选择时显示的提示内容
```

---

## 二、外观 & 布局相关（高频）

### `icon`

```dart
Widget? icon, // 右侧下拉箭头图标
```

---

### `iconSize`

```dart
double iconSize = 24.0, // 图标尺寸
```

---

### `underline`

```dart
Widget? underline, // 下拉按钮下方的下划线
```

* 传 `SizedBox.shrink()` 可去除

---

### `isExpanded`

```dart
bool isExpanded = false, // 是否横向占满父布局
```

* 常见于表单布局

---

### `isDense`

```dart
bool isDense = false, // 是否使用紧凑高度
```

---

### `style`

```dart
TextStyle? style, // 选中项和菜单项的文本样式
```

---

## 三、菜单弹出相关（进阶）

### `dropdownColor`

```dart
Color? dropdownColor, // 下拉菜单背景色
```

---

### `elevation`

```dart
int elevation = 8, // 菜单弹出时的阴影高度
```

---

### `menuMaxHeight`

```dart
double? menuMaxHeight, // 菜单最大高度（超出可滚动）
```

---

### `itemHeight`

```dart
double? itemHeight, // 每一项的高度
```

---

### `alignment`

```dart
AlignmentGeometry alignment, // 选中内容在按钮中的对齐方式
```

---

### `borderRadius`

```dart
BorderRadius? borderRadius, // 菜单弹出层圆角
```

---

## 四、焦点 & 交互（了解即可）

### `focusNode`

```dart
FocusNode? focusNode, // 焦点控制
```

---

### `autofocus`

```dart
bool autofocus = false, // 是否自动获取焦点
```

---

### `focusColor`

```dart
Color? focusColor, // 聚焦时背景颜色
```

---

### `onTap`

```dart
VoidCallback? onTap, // 点击下拉按钮时触发
```

---

### `enableFeedback`

```dart
bool? enableFeedback, // 是否启用触觉/音效反馈
```

---

## 五、禁用态相关

### `disabledHint`

```dart
Widget? disabledHint, // 禁用状态显示内容
```

---

### `iconDisabledColor`

```dart
Color? iconDisabledColor, // 禁用状态下图标颜色
```

---

### `iconEnabledColor`

```dart
Color? iconEnabledColor, // 启用状态下图标颜色
```

---

## 六、典型使用示例（对照源码理解）

```dart
DropdownButton<String>(
  value: value,
  hint: Text('请选择'),
  isExpanded: true,
  items: items.map((e) {
    return DropdownMenuItem<String>(
      value: e,
      child: Text(e),
    );
  }).toList(),
  onChanged: (v) {
    setState(() => value = v);
  },
);
```

---

## 七、相关组件关系（建议你顺着看源码）

```text
DropdownButton
├── DropdownMenuItem
├── _DropdownButtonState
├── _DropdownRoute
└── PopupRoute
```

---

## 八、源码学习建议（给你明确路线）

你可以重点跳这几个位置：

1️⃣ `material/dropdown.dart`
2️⃣ `_DropdownRoute`（弹出层）
3️⃣ `DropdownMenuItem`

---

如果你愿意，下一步我可以继续给你：

* ✅ **DropdownButtonFormField 参数大全**
* ✅ **DropdownButton vs PopupMenuButton 区别**
* ✅ **为什么 DropdownButton 不适合大数据量（源码角度）**

你想继续哪一个？
