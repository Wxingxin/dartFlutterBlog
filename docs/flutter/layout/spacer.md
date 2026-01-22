下面是一份**Flutter 中 `Spacer` 组件的属性与配置大全**。我会按**定位 → 属性 → 行为原理 → 对比 → 场景 → 注意事项**的结构来讲，方便你系统理解，并且和你刚学过的 `Flexible / Expanded` 串起来。

---

## 一、Spacer 是什么（定位）

`Spacer` 是 **Flex 布局体系（Row / Column / Flex）中的“空白占位组件”**。

> 作用只有一个：
> **在主轴方向上占据可用空间，用来“撑开”其他组件。**

📌 本质上：

```dart
Spacer === Flexible(child: SizedBox.shrink())
```

---

## 二、Spacer 的构造函数

```dart
const Spacer({
  Key? key,
  int flex = 1,
})
```

---

## 三、属性大全

### 1️⃣ `flex`（权重 / 占比）✅ 核心属性

```dart
int flex = 1
```

#### 含义

* 在主轴方向上占据的空间比例
* 和 `Flexible / Expanded` 的 `flex` 完全一致

#### 示例：左右留白不等

```dart
Row(
  children: [
    Text("左"),
    Spacer(flex: 1),
    Text("中"),
    Spacer(flex: 2),
    Text("右"),
  ],
)
```

📐 空间比例：

* 左-中：1
* 中-右：2

---

### 2️⃣ `key`（很少用）

```dart
Key? key
```

* 用于 Widget 树识别
* 与布局行为无关

---

## 四、Spacer 的布局行为原理（重要）

### 核心规则

* `Spacer`：

  * **不渲染任何内容**
  * 只参与 **主轴方向剩余空间分配**
* 使用的是：

  * `Flexible`
  * `FlexFit.tight`
  * 空 child

等价实现：

```dart
Flexible(
  fit: FlexFit.tight,
  child: SizedBox.shrink(),
)
```

---

## 五、Spacer vs SizedBox vs Expanded

| 组件       | 是否占空间 | 是否有内容 | 是否参与 flex | 是否固定尺寸 |
| -------- | ----- | ----- | --------- | ------ |
| Spacer   | ✅     | ❌     | ✅         | ❌      |
| SizedBox | ✅     | ❌     | ❌         | ✅      |
| Expanded | ✅     | ✅     | ✅         | ❌      |
| Flexible | ✅     | ✅     | ✅         | ❌      |

---

## 六、Spacer vs MainAxisAlignment（非常重要）

### 使用 `MainAxisAlignment.spaceBetween`

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text("左"),
    Text("中"),
    Text("右"),
  ],
)
```

特点：

* 只能平均分布
* 不可精细控制比例

---

### 使用 `Spacer`（更灵活）

```dart
Row(
  children: [
    Text("左"),
    Spacer(flex: 1),
    Text("中"),
    Spacer(flex: 3),
    Text("右"),
  ],
)
```

✔ 可精确控制间距比例
✔ 推荐在复杂布局中使用

---

## 七、常见使用场景大全

### ✅ 1. 两端对齐（最常见）

```dart
Row(
  children: [
    Text("标题"),
    Spacer(),
    Icon(Icons.more_vert),
  ],
)
```

---

### ✅ 2. 底部按钮顶到最下方

```dart
Column(
  children: [
    Text("内容"),
    Spacer(),
    ElevatedButton(onPressed: () {}, child: Text("提交")),
  ],
)
```

---

### ✅ 3. 多段留白控制

```dart
Row(
  children: [
    Icon(Icons.menu),
    Spacer(flex: 1),
    Text("标题"),
    Spacer(flex: 2),
    Icon(Icons.search),
  ],
)
```

---

### ✅ 4. 替代空 Container（更语义化）

```dart
// 不推荐
Container()

// 推荐
Spacer()
```

---

## 八、使用限制与注意事项

### ❌ 1. 只能在 Flex 容器中使用

```dart
// ❌ 会报错
Stack(
  children: [Spacer()],
)
```

✔ 正确：

```dart
Row(children: [Spacer()]);
```

---

### ❌ 2. Spacer 不能控制交叉轴

* `Spacer` **只作用于主轴**
* 高度 / 宽度由父级决定

---

### ❌ 3. Spacer ≠ margin / padding

* 不影响组件自身尺寸
* 只是“撑空间”

---

## 九、何时用 Spacer（经验法则）

* 想 **推开组件** → `Spacer`
* 想 **固定空隙** → `SizedBox`
* 想 **内容填满空间** → `Expanded`
* 想 **内容可大可小** → `Flexible`

---

## 十、一句话总结

> **Spacer 是 Flex 布局中“纯占位、不渲染内容”的弹性空白组件，用来精确控制主轴间距。**

如果你愿意，我可以下一步帮你整理：

* `MainAxisAlignment` 与 `Spacer` 的组合策略
* `Spacer` 在复杂 Column / ListTile 中的实战布局
* Flutter 常见“布局不生效”的真实原因分析
