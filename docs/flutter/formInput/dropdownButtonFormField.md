下面给你一份 **Flutter 中 `DropdownButtonFormField` 组件的属性与配置大全**，按照 **表单集成 → 下拉行为 → 样式控制 → 校验与实战 → 常见坑** 的顺序系统整理，适合你在 **Form 表单、筛选条件、设置页** 中直接使用。

---

## 一、DropdownButtonFormField 是什么？（核心定位）

> `DropdownButtonFormField<T>`
> = **DropdownButton + FormField**

✔ 自带 **表单校验**
✔ 可参与 `Form.validate / save / reset`
✔ 是表单中**标准下拉选择组件**

```dart
DropdownButtonFormField<String>(
  items: [],
  onChanged: (value) {},
)
```

---

## 二、基础结构（先有整体认知）

```dart
DropdownButtonFormField<String>(
  value: selectedValue,
  items: [
    DropdownMenuItem(
      value: 'a',
      child: Text('选项 A'),
    ),
  ],
  onChanged: (value) {},
)
```

---

## 三、核心属性大全（⭐⭐⭐⭐⭐ 必会）

### 1️⃣ 与 Form 相关的属性（最重要）

| 属性                 | 类型                       | 说明            |
| ------------------ | ------------------------ | ------------- |
| `value`            | `T?`                     | 当前选中值         |
| `onChanged`        | `ValueChanged<T?>?`      | 选中变化回调        |
| `validator`        | `FormFieldValidator<T>?` | 表单校验          |
| `onSaved`          | `FormFieldSetter<T>?`    | Form.save 时调用 |
| `autovalidateMode` | `AutovalidateMode?`      | 自动校验策略        |
| `enabled`          | `bool`                   | 是否可用          |

```dart
validator: (value) {
  if (value == null) return '请选择一项';
  return null;
}
```

---

### 2️⃣ 下拉内容（必填）

| 属性                    | 类型                           | 说明        |
| --------------------- | ---------------------------- | --------- |
| `items`               | `List<DropdownMenuItem<T>>?` | 下拉选项列表    |
| `selectedItemBuilder` | `DropdownButtonBuilder?`     | 自定义选中态 UI |

```dart
items: list.map((e) {
  return DropdownMenuItem(
    value: e.id,
    child: Text(e.name),
  );
}).toList(),
```

⚠️ **items 不能为空**

---

## 四、DropdownButton 行为控制属性

### 1️⃣ 展示与交互

| 属性                  | 类型        | 说明     |
| ------------------- | --------- | ------ |
| `hint`              | `Widget?` | 未选择时提示 |
| `disabledHint`      | `Widget?` | 禁用状态提示 |
| `isExpanded`        | `bool`    | 是否占满宽度 |
| `icon`              | `Widget?` | 下拉图标   |
| `iconSize`          | `double`  | 图标大小   |
| `iconEnabledColor`  | `Color?`  | 图标颜色   |
| `iconDisabledColor` | `Color?`  | 禁用图标颜色 |

```dart
hint: Text('请选择城市'),
isExpanded: true,
```

📌 **表单中强烈建议 `isExpanded: true`**

---

### 2️⃣ 下拉菜单样式

| 属性              | 类型                  | 说明    |
| --------------- | ------------------- | ----- |
| `dropdownColor` | `Color?`            | 菜单背景色 |
| `menuMaxHeight` | `double?`           | 最大高度  |
| `borderRadius`  | `BorderRadius?`     | 菜单圆角  |
| `elevation`     | `int`               | 阴影高度  |
| `alignment`     | `AlignmentGeometry` | 对齐方式  |

```dart
menuMaxHeight: 300,
dropdownColor: Colors.white,
```

---

## 五、InputDecoration（外观样式，极其重要）

> `DropdownButtonFormField` **本质是一个 FormField**
> 👉 样式通过 `decoration` 控制

```dart
decoration: InputDecoration(
  labelText: '性别',
  border: OutlineInputBorder(),
)
```

### 常用 InputDecoration 属性

| 属性              | 说明   |
| --------------- | ---- |
| `labelText`     | 浮动标签 |
| `hintText`      | 占位文字 |
| `errorText`     | 错误文本 |
| `prefixIcon`    | 前缀图标 |
| `suffixIcon`    | 后缀图标 |
| `enabledBorder` | 默认边框 |
| `focusedBorder` | 聚焦边框 |
| `errorBorder`   | 错误边框 |

📌 **99% 的 UI 定制都在 decoration 里**

---

## 六、完整 Form 实战示例（强烈推荐）

```dart
String? gender;

DropdownButtonFormField<String>(
  value: gender,
  decoration: InputDecoration(
    labelText: '性别',
    border: OutlineInputBorder(),
  ),
  items: const [
    DropdownMenuItem(value: 'male', child: Text('男')),
    DropdownMenuItem(value: 'female', child: Text('女')),
  ],
  onChanged: (value) {
    gender = value;
  },
  validator: (value) {
    if (value == null) return '请选择性别';
    return null;
  },
);
```

---

## 七、DropdownButtonFormField 常见高级用法

### 1️⃣ 禁用状态

```dart
enabled: false,
```

---

### 2️⃣ 动态数据（异步加载）

```dart
items: data.isEmpty
  ? []
  : data.map((e) => DropdownMenuItem(
      value: e.id,
      child: Text(e.name),
    )).toList(),
```

⚠️ value 必须存在于 items 中，否则会报错

---

### 3️⃣ 自定义选中显示（selectedItemBuilder）

```dart
selectedItemBuilder: (context) {
  return items.map((e) {
    return Text(
      e.label,
      style: TextStyle(color: Colors.blue),
    );
  }).toList();
},
```

---

## 八、DropdownButtonFormField 常见坑（非常重要）

| 问题                  | 原因                |
| ------------------- | ----------------- |
| 报错：value 不在 items 中 | value 与 items 不匹配 |
| 宽度太小                | 未设置 `isExpanded`  |
| 校验不触发               | 未放入 Form          |
| 样式奇怪                | decoration 未配置    |
| hint 不显示            | 已设置 value         |

---

## 九、DropdownButton vs DropdownButtonFormField

| 对比         | DropdownButton | DropdownButtonFormField |
| ---------- | -------------- | ----------------------- |
| 表单校验       | ❌              | ✅                       |
| decoration | ❌              | ✅                       |
| Form 集成    | ❌              | ✅                       |
| 使用场景       | 简单选择           | 表单选择                    |

📌 **在 Form 中：永远优先用 DropdownButtonFormField**

---

## 十、最佳实践（项目级总结）

1. 始终使用 `isExpanded: true`
2. `value` 与 `items` 强一致
3. 表单中必须写 `validator`
4. UI 样式统一用 `InputDecoration`
5. 异步数据注意 value 重置

---

## 十一、你可以继续深入的方向

如果你愿意，我可以继续帮你：

1. **DropdownButtonFormField + 联动选择（省市区）**
2. **封装一个通用 SelectFormField**
3. **多选下拉（Checkbox + Overlay）**
4. **DropdownButtonFormField vs CupertinoPicker**
5. **仿 Web Select 的 Flutter 组件设计**

你只要说一个方向，我直接给你完整实战方案。
