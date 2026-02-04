## 一、Row 是干什么的？（一句话本质）

> **Row：把多个子组件，按照“水平方向”依次排列**

📌 关键词只有两个：
**横向（horizontal） + 多个 child**

## 二、Row 的典型使用场景

你每天都会用到 Row：

- 图标 + 文本（列表项）
- 左右按钮
- 表单一行多列
- 顶部工具栏
- 卡片中的横向信息展示

##

```dart
Row({
  Key? key, // Widget 的唯一标识，用于元素树更新

  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  // 主轴（水平方向）对齐方式：start / center / end / spaceBetween / spaceAround / spaceEvenly

  MainAxisSize mainAxisSize = MainAxisSize.max,
  // 主轴尺寸占用方式：max 占满父容器宽度 / min 根据子组件宽度自适应

  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  // 交叉轴（垂直方向）对齐方式：start / center / end / stretch / baseline

  TextDirection? textDirection,
  // 文本方向：ltr（从左到右） / rtl（从右到左），影响 start / end 的计算

  VerticalDirection verticalDirection = VerticalDirection.down,
  // 垂直方向排列顺序：down（从上到下） / up（从下到上），影响交叉轴方向

  TextBaseline? textBaseline,
  // 文本基线对齐方式（alphabetic / ideographic），仅在 crossAxisAlignment = baseline 时必须

  List<Widget> children = const <Widget>[],
  // 子组件列表，按顺序水平方向排列
})
```

下面**完全针对你给出的 `Row` 构造函数**，用**源码级视角**回答两个问题：

> **① 每个参数的默认值是什么**
> **② 它们能使用什么值（string / num / 还是固定值）**

## 一、Row 参数默认值（一眼查表）

| 参数                 | 默认值                      | 是否可省略   |
| -------------------- | --------------------------- | ------------ |
| `key`                | `null`                      | ✅           |
| `mainAxisAlignment`  | `MainAxisAlignment.start`   | ✅           |
| `mainAxisSize`       | `MainAxisSize.max`          | ✅           |
| `crossAxisAlignment` | `CrossAxisAlignment.center` | ✅           |
| `textDirection`      | `null`                      | ✅           |
| `verticalDirection`  | `VerticalDirection.down`    | ✅           |
| `textBaseline`       | `null`                      | ✅（有条件） |
| `children`           | `const <Widget>[]`          | ✅           |

## 二、每个参数「能用什么值」（重点）

> **结论先行：**
> ❌ **不能使用 string / num**
> ✅ **全部是强类型（enum / class）**

### 1️⃣ `Key? key`

```dart
Key? key
```

**可用类型**

- `Key`
- `ValueKey<T>`
- `ObjectKey`
- `UniqueKey`

```dart
key: ValueKey('row-1')
```

❌ 错误：

```dart
key: 'row-1'
```

### 2️⃣ `MainAxisAlignment mainAxisAlignment`

👉 控制 **横向排列方式**

```dart
MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start
```

📌 **枚举（enum）**

**可用固定值**

```dart
MainAxisAlignment.start
MainAxisAlignment.end
MainAxisAlignment.center
MainAxisAlignment.spaceBetween
MainAxisAlignment.spaceAround
MainAxisAlignment.spaceEvenly
```

| 值             | 含义               |
| -------------- | ------------------ |
| `start`        | 左对齐             |
| `center`       | 居中               |
| `end`          | 右对齐             |
| `spaceBetween` | 两端贴边，中间等分 |
| `spaceAround`  | 两侧有间距         |
| `spaceEvenly`  | 所有间距相等       |

📌 最常用：`start / spaceBetween / center`

### 3️⃣ `MainAxisSize mainAxisSize`

```dart
MainAxisSize mainAxisSize = MainAxisSize.max
```

📌 **枚举**

**可用值**

```dart
MainAxisSize.max
MainAxisSize.min
```

| 值            | 含义                |
| ------------- | ------------------- |
| `max`（默认） | Row 撑满父组件      |
| `min`         | Row 只包住 children |

👉 常用于 **按钮 / Chip / 标签**

### 4️⃣ `CrossAxisAlignment crossAxisAlignment`

```dart
CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center
```

📌 **枚举**

**可用值**

```dart
CrossAxisAlignment.start
CrossAxisAlignment.end
CrossAxisAlignment.center
CrossAxisAlignment.stretch
CrossAxisAlignment.baseline // ⚠️ 有条件
```

👉 控制 **垂直方向对齐**

| 值         | 含义             |
| ---------- | ---------------- |
| `start`    | 顶部             |
| `center`   | 居中（默认）     |
| `end`      | 底部             |
| `stretch`  | 拉伸（占满高度） |
| `baseline` | 基线对齐（文本） |

⚠️ 使用 `baseline` **必须设置 `textBaseline`**



### 5️⃣ `TextDirection? textDirection`

```dart
TextDirection? textDirection
```

📌 **枚举，可为 null**

**可用值**

```dart
TextDirection.ltr
TextDirection.rtl
```

📌 `null` 表示：

> 从 `Directionality`（MaterialApp / WidgetsApp）中继承

### 6️⃣ `VerticalDirection verticalDirection`

```dart
VerticalDirection verticalDirection = VerticalDirection.down
```

📌 **枚举**

**可用值**

```dart
VerticalDirection.down
VerticalDirection.up
```

👉 控制 **交叉轴 start / end 的方向**

（不常用，了解即可）

### 7️⃣ `TextBaseline? textBaseline`

```dart
TextBaseline? textBaseline
```

📌 **枚举，可为 null**

**可用值**

```dart
TextBaseline.alphabetic
TextBaseline.ideographic
```

⚠️ **仅在**

```dart
crossAxisAlignment: CrossAxisAlignment.baseline
```

时必须提供

### 8️⃣ `List<Widget> children`

```dart
List<Widget> children = const <Widget>[]
```

📌 **固定类型**

```dart
List<Widget>
```

✅ 正确：

```dart
children: [
  Text('A'),
  Icon(Icons.add),
]
```

❌ 错误：

```dart
children: ['A', 'B']
```

---

👉 你后面看到的各种布局效果，**全部来自这些属性**。

---








## 八、Row 最常见的错误 ❌（必踩）

### ❌ 错误：Row 里直接放超宽组件

```dart
Row(
  children: [
    Text('这是一个非常非常非常长的文本'),
  ],
)
```

👉 报错：

```
RenderFlex overflowed by XX pixels
```

---

### ✅ 正确解决方式 1：Expanded ⭐⭐⭐

```dart
Row(
  children: [
    Expanded(
      child: Text(
        '这是一个非常非常非常长的文本',
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
)
```

---

### ✅ 正确解决方式 2：Flexible

```dart
Flexible(
  child: Text('长文本'),
)
```

---

## 九、Expanded / Flexible（Row 的灵魂）

### Expanded（强制占满剩余空间）

```dart
Expanded(
  flex: 1,
  child: Widget,
)
```

### Flexible（允许压缩）

```dart
Flexible(
  fit: FlexFit.loose,
  child: Widget,
)
```

#### flex 比例分配示例

```dart
Row(
  children: [
    Expanded(flex: 1, child: Container(color: Colors.red)),
    Expanded(flex: 2, child: Container(color: Colors.blue)),
  ],
)
```

👉 宽度比例 = 1 : 2


## 十一、Row 的常见实战案例 ⭐⭐⭐

### 1️⃣ 图标 + 文本（列表项）

```dart
Row(
  children: [
    Icon(Icons.phone),
    SizedBox(width: 8),
    Text('联系电话'),
  ],
)
```

---

### 2️⃣ 左右布局（最常见）

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text('标题'),
    Icon(Icons.arrow_forward_ios),
  ],
)
```

---

### 3️⃣ 自适应一行多列

```dart
Row(
  children: [
    Expanded(child: Text('左侧内容')),
    Text('右侧'),
  ],
)
```


## Row 构造函数（源码结构 + 中文注释）

```dart
const Row({
  Key? key, // widget 唯一标识，用于 widget 树 diff 和重建

  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  // 主轴对齐方式（Row 中主轴是水平方向）

  MainAxisSize mainAxisSize = MainAxisSize.max,
  // 主轴尺寸占用策略（max 占满 / min 包裹内容）

  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
  // 交叉轴对齐方式（Row 中交叉轴是垂直方向）

  TextDirection? textDirection,
  // 水平方向的文本方向（影响 start / end 的含义）

  VerticalDirection verticalDirection = VerticalDirection.down,
  // 垂直方向排列顺序（down 从上到下，up 从下到上）

  TextBaseline? textBaseline,
  // 文本基线对齐方式（当 crossAxisAlignment 为 baseline 时必须提供）

  List<Widget> children = const <Widget>[],
  // 子组件列表（按顺序水平排列）
})
```


### 一、主轴（Horizontal）相关 ⭐⭐⭐

```dart
mainAxisAlignment
mainAxisSize
```

#### `mainAxisAlignment`

```dart
MainAxisAlignment.start        // 从左开始排列
MainAxisAlignment.end          // 从右开始排列
MainAxisAlignment.center       // 居中
MainAxisAlignment.spaceBetween // 两端对齐，中间等距
MainAxisAlignment.spaceAround  // 子组件两侧留空
MainAxisAlignment.spaceEvenly  // 所有间距完全一致
```

#### `mainAxisSize`

```dart
MainAxisSize.max // Row 占满父容器宽度（默认）
MainAxisSize.min // Row 宽度等于子组件宽度之和
```

---

### 二、交叉轴（Vertical）相关 ⭐⭐⭐

```dart
crossAxisAlignment
textBaseline
verticalDirection
```

#### `crossAxisAlignment`

```dart
CrossAxisAlignment.start    // 顶部对齐
CrossAxisAlignment.center  // 垂直居中（默认）
CrossAxisAlignment.end     // 底部对齐
CrossAxisAlignment.stretch // 拉伸填满高度（子组件不能有高度）
CrossAxisAlignment.baseline // 按文本基线对齐（⚠️ 仅用于文字）
```

⚠️ 使用 `baseline` 时 **必须** 设置：

```dart
textBaseline: TextBaseline.alphabetic
```

---

### 三、方向控制（国际化 & 排版）

```dart
textDirection
verticalDirection
```

#### `textDirection`

```dart
TextDirection.ltr // 从左到右（英文、中文）
TextDirection.rtl // 从右到左（阿拉伯语）
```

👉 影响 `start / end` 的方向含义

---

### 四、子组件

```dart
children
```

- Row **不支持滚动**
- 子组件超出宽度 ⇒ **直接溢出报错（黄黑条）**
- 常见解决方式：
  - `Expanded`
  - `Flexible`
  - `SingleChildScrollView`

---

## Row 的本质（源码级一句话）

> **Row 只是一个 `Flex(direction: Axis.horizontal)` 的语法糖**

等价于：

```dart
Flex(
  direction: Axis.horizontal,
  children: [...],
)
```

---

## 常见错误 & 源码级原因

### ❌ Row 溢出

```dart
Row(
  children: [
    Text('超长文本'),
    Text('超长文本'),
  ],
)
```

👉 Row **不会自动换行 / 滚动**

### ✅ 正确做法

```dart
Row(
  children: [
    Expanded(
      child: Text('超长文本'),
    ),
  ],
)
```

