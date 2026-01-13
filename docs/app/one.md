下面我按 **Flutter 官方语义与实际工程使用习惯**，对 **「容器类 Widget」** 和 **「布局类 Widget」** 进行**系统、完整、可查阅式**的整理，并区分用途、特点和常见组合方式。内容偏工程实战，而不是简单罗列。

---

# 一、Flutter 容器类 Widget（Container / Box 类）

> **容器类 Widget 的核心职责：**
>
> * 提供尺寸（width / height / constraints）
> * 提供装饰（颜色、圆角、边框、阴影）
> * 提供内外边距（padding / margin）
> * 包裹单个子 Widget（Single-child）

---

## 1. Container（万能容器）

```dart
Container(
  width: 100,
  height: 100,
  padding: EdgeInsets.all(8),
  margin: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text('Hello'),
)
```

**能力合集：**

* 尺寸（width / height / constraints）
* padding / margin
* alignment
* decoration（颜色、圆角、边框、阴影）
* transform

**本质：**

> Container = Padding + Align + DecoratedBox + ConstrainedBox 的组合

---

## 2. SizedBox（定宽高盒子）

```dart
SizedBox(width: 100, height: 50)
```

**用途：**

* 占位
* 间距
* 强制子组件尺寸

---

## 3. ConstrainedBox / UnconstrainedBox

### ConstrainedBox（加约束）

```dart
ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: 100,
    maxWidth: 200,
  ),
  child: ...
)
```

### UnconstrainedBox（移除约束）

```dart
UnconstrainedBox(
  child: ...
)
```

---

## 4. Padding（内边距）

```dart
Padding(
  padding: EdgeInsets.all(16),
  child: ...
)
```

---

## 5. Align / Center（对齐）

### Align

```dart
Align(
  alignment: Alignment.topRight,
  child: ...
)
```

### Center

```dart
Center(child: ...)
```

---

## 6. DecoratedBox / ColoredBox

### DecoratedBox

```dart
DecoratedBox(
  decoration: BoxDecoration(color: Colors.red),
  child: ...
)
```

### ColoredBox（轻量）

```dart
ColoredBox(color: Colors.blue, child: ...)
```

---

## 7. FractionallySizedBox（比例尺寸）

```dart
FractionallySizedBox(
  widthFactor: 0.5,
  heightFactor: 0.5,
  child: ...
)
```

---

## 8. Transform（变换容器）

```dart
Transform.rotate(
  angle: 0.3,
  child: ...
)
```

---

## 9. Clip 系列（裁剪容器）

| Widget    | 说明    |
| --------- | ----- |
| ClipRect  | 矩形裁剪  |
| ClipRRect | 圆角裁剪  |
| ClipOval  | 圆形裁剪  |
| ClipPath  | 自定义路径 |

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.network(...)
)
```

---

# 二、Flutter 布局类 Widget（Layout Widgets）

> **布局类 Widget 的核心职责：**
>
> * 多子 Widget
> * 排列、分布、约束
> * 控制子元素位置关系

---

## 1. Row（横向布局）

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [],
)
```

### 常用属性

* mainAxisAlignment
* crossAxisAlignment
* mainAxisSize

---

## 2. Column（纵向布局）

```dart
Column(
  children: [],
)
```

---

## 3. Flex（Row / Column 的底层）

```dart
Flex(
  direction: Axis.horizontal,
  children: [],
)
```

---

## 4. Expanded / Flexible（弹性布局）

```dart
Expanded(
  flex: 1,
  child: ...
)
```

| Widget   | 区别   |
| -------- | ---- |
| Expanded | 强制占满 |
| Flexible | 允许松散 |

---

## 5. Stack（层叠布局）

```dart
Stack(
  children: [
    Positioned(top: 0, left: 0, child: ...),
  ],
)
```

### 子组件

* Positioned
* Align

---

## 6. Wrap（自动换行）

```dart
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [],
)
```

> 常用于：标签、关键词、Chip 列表

---

## 7. Flow（高性能自定义布局）

```dart
Flow(
  delegate: FlowDelegate(),
  children: [],
)
```

⚠ 一般业务很少直接使用

---

## 8. Table（表格布局）

```dart
Table(
  children: [
    TableRow(children: [...]),
  ],
)
```

---

## 9. Grid 布局

### GridView（滚动网格）

```dart
GridView.count(
  crossAxisCount: 2,
)
```

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,
  ),
)
```

---

## 10. List 布局（滚动）

| Widget             | 说明    |
| ------------------ | ----- |
| ListView           | 列表    |
| ListView.builder   | 大数据列表 |
| ListView.separated | 带分割线  |

---

## 11. Sliver 系列（高级布局）

| Widget           | 用途         |
| ---------------- | ---------- |
| CustomScrollView | 组合 Sliver  |
| SliverList       | 列表         |
| SliverGrid       | 网格         |
| SliverAppBar     | 可折叠 AppBar |

---

## 12. LayoutBuilder / MediaQuery

### LayoutBuilder（父约束感知）

```dart
LayoutBuilder(
  builder: (context, constraints) {
    return ...
  },
)
```

### MediaQuery（屏幕信息）

```dart
MediaQuery.of(context).size
```

---

# 三、容器 vs 布局 —— 快速对比

| 分类           | 特点         |
| ------------ | ---------- |
| 容器类          | 单子组件、装饰、尺寸 |
| 布局类          | 多子组件、排列关系  |
| Container    | 最常用，但不推荐滥用 |
| Row / Column | 最核心布局      |

---

# 四、实际开发推荐组合

### 常见结构

```dart
Padding
 └─ Column
     ├─ Row
     │   ├─ Expanded
     │   └─ SizedBox
     └─ Container
```

### 性能建议

* 能用 `SizedBox / Padding` 不用 `Container`
* 长列表优先 `ListView.builder`
* 复杂滚动用 `Sliver`

---

如果你愿意，下一步我可以帮你做：

1. **容器与布局的性能对比清单**
2. **Flutter 布局“约束系统”原理图解**
3. **企业级页面常见布局模板**
4. **Flutter vs React Native 布局思想对照**

你可以直接指定一个方向。
