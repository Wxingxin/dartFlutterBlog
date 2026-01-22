下面是一份**Flutter 中 `Table` 组件的属性与配置大全**，我会按**定位 → 构造函数 → 属性详解 → 列宽算法 → 使用示例 → 对比 → 注意事项**的结构系统讲解，适合你做成自己的 Flutter 布局笔记。

---

## 一、Table 是什么（定位）

`Table` 是 Flutter 中用于 **行 × 列二维布局** 的组件，类似 HTML 的 `<table>`。

### 适用场景

* 表格数据展示
* 表单对齐
* 多列内容严格对齐

📌 注意：
`Table` **不是滚动组件**，大表格通常需要包一层 `SingleChildScrollView`

---

## 二、Table 构造函数

```dart
Table({
  Key? key,
  required List<TableRow> children,
  Map<int, TableColumnWidth>? columnWidths,
  TableColumnWidth defaultColumnWidth = const FlexColumnWidth(1.0),
  TextDirection? textDirection,
  TableBorder? border,
  TableCellVerticalAlignment defaultVerticalAlignment =
      TableCellVerticalAlignment.top,
})
```

---

## 三、核心属性大全

---

### 1️⃣ `children`（必填）

```dart
List<TableRow> children
```

* 表格的**每一行**
* 每个 `TableRow` 的 `children` 数量必须一致

示例：

```dart
Table(
  children: [
    TableRow(children: [
      Text("姓名"),
      Text("年龄"),
    ]),
    TableRow(children: [
      Text("张三"),
      Text("18"),
    ]),
  ],
)
```

❌ 不允许列数不一致（会报错）

---

### 2️⃣ `columnWidths`（列宽控制）⭐ 重点

```dart
Map<int, TableColumnWidth> columnWidths
```

* key：列索引（从 0 开始）
* value：列宽算法

示例：

```dart
columnWidths: {
  0: FixedColumnWidth(100),
  1: FlexColumnWidth(1),
}
```

---

### 3️⃣ `defaultColumnWidth`（默认列宽）

```dart
TableColumnWidth defaultColumnWidth
```

* 未在 `columnWidths` 中指定的列，使用该规则
* 默认值：

```dart
const FlexColumnWidth(1.0)
```

---

### 4️⃣ `border`（表格边框）

```dart
TableBorder? border
```

常见配置：

```dart
border: TableBorder.all(
  color: Colors.grey,
  width: 1,
)
```

其他可选：

```dart
TableBorder(
  top: BorderSide(),
  bottom: BorderSide(),
  left: BorderSide(),
  right: BorderSide(),
  horizontalInside: BorderSide(),
  verticalInside: BorderSide(),
)
```

---

### 5️⃣ `defaultVerticalAlignment`（单元格垂直对齐）

```dart
TableCellVerticalAlignment defaultVerticalAlignment
```

可选值：

| 值          | 说明        |
| ---------- | --------- |
| `top`      | 顶部对齐（默认）  |
| `middle`   | 垂直居中      |
| `bottom`   | 底部对齐      |
| `baseline` | 基线对齐（仅文本） |
| `fill`     | 填满单元格     |

---

### 6️⃣ `textDirection`

```dart
TextDirection? textDirection
```

* 控制列的 **从左到右 / 从右到左**
* RTL 语言（如阿拉伯语）使用

---

## 四、TableRow 属性大全

```dart
TableRow({
  Decoration? decoration,
  List<Widget> children,
})
```

### 1️⃣ `children`（单元格）

```dart
List<Widget> children
```

* 一行中的每一列

---

### 2️⃣ `decoration`（行背景）

```dart
decoration: BoxDecoration(
  color: Colors.grey[200],
)
```

常用于：

* 表头背景
* 斑马纹表格

---

## 五、TableColumnWidth 列宽算法大全 ⭐⭐⭐

### 1️⃣ `FixedColumnWidth`

```dart
FixedColumnWidth(100)
```

* 固定像素宽度

---

### 2️⃣ `FlexColumnWidth`（最常用）

```dart
FlexColumnWidth(2)
```

* 按比例分配剩余空间
* 类似 `Expanded(flex)`

---

### 3️⃣ `IntrinsicColumnWidth`

```dart
IntrinsicColumnWidth()
```

* 根据内容自适应
* ⚠ 性能开销大（不推荐大表格）

---

### 4️⃣ `FractionColumnWidth`

```dart
FractionColumnWidth(0.3)
```

* 占父容器宽度的百分比

---

### 5️⃣ `MaxColumnWidth`

```dart
MaxColumnWidth(
  FixedColumnWidth(100),
  FlexColumnWidth(1),
)
```

* 取两个规则中**更大**的宽度

---

### 6️⃣ `MinColumnWidth`

```dart
MinColumnWidth(
  FixedColumnWidth(80),
  IntrinsicColumnWidth(),
)
```

* 取两个规则中**更小**的宽度

---

## 六、完整示例（常见配置）

```dart
Table(
  border: TableBorder.all(color: Colors.grey),
  columnWidths: {
    0: FixedColumnWidth(80),
    1: FlexColumnWidth(1),
    2: FlexColumnWidth(2),
  },
  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
  children: [
    TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: [
        Padding(padding: EdgeInsets.all(8), child: Text("ID")),
        Padding(padding: EdgeInsets.all(8), child: Text("姓名")),
        Padding(padding: EdgeInsets.all(8), child: Text("描述")),
      ],
    ),
    TableRow(children: [
      Padding(padding: EdgeInsets.all(8), child: Text("1")),
      Padding(padding: EdgeInsets.all(8), child: Text("张三")),
      Padding(padding: EdgeInsets.all(8), child: Text("Flutter 开发者")),
    ]),
  ],
)
```

---

## 七、Table vs ListView + Row

| 对比   | Table | Row / Column |
| ---- | ----- | ------------ |
| 列对齐  | ⭐⭐⭐⭐⭐ | ❌            |
| 性能   | 中     | 高            |
| 复杂度  | 中     | 低            |
| 动态数据 | 一般    | 更灵活          |
| 滚动支持 | ❌     | ✅            |

---

## 八、常见问题与注意事项

### ❗ 1. Table 不支持滚动

✔ 解决：

```dart
SingleChildScrollView(
  scrollDirection: Axis.horizontal,
  child: Table(...),
)
```

---

### ❗ 2. 列数不一致直接报错

* 每个 `TableRow` 的 `children.length` 必须相同

---

### ❗ 3. IntrinsicColumnWidth 性能问题

* 大数据表避免使用
* 会触发多次 layout

---

## 九、使用建议（实战经验）

* 表格展示 → `Table`
* 可滚动数据 → `ListView + Row`
* 简单两列对齐 → `Row + Expanded`
* 大数据表格 → 自定义 List + 对齐逻辑

---

## 十、一句话总结

> **Table 是 Flutter 中用于“严格列对齐”的二维布局组件，核心在于列宽算法（TableColumnWidth）的合理选择。**

如果你愿意，我可以下一步帮你整理：

* `DataTable` vs `Table` 的真实使用区别
* 表格滚动（横向 + 纵向）完整方案
* 表单场景下 Table 的最佳实践
