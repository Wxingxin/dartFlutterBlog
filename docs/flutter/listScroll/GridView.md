下面为你系统、完整地整理 **Flutter `GridView` 组件的知识点大全与属性大全**。内容结构偏向**“官方手册级 + 实战总结”**，适合在真实项目中直接查阅与对照使用。

---

# 一、GridView 是什么

`GridView` 是 Flutter 中用于**二维网格布局**的核心滚动组件，用来以**行 × 列**的方式展示大量同类型子组件。

* 本质：**可滚动的二维列表**
* 底层：基于 `ScrollView + SliverGrid`
* 典型用途：

  * 商品列表
  * 图片瀑布流（规则网格）
  * 功能入口九宫格
  * 图标面板

---

# 二、GridView 的常见构造方式（必会）

## 1️⃣ GridView.count（固定列数）

```dart
GridView.count(
  crossAxisCount: 3,
  children: [...],
)
```

适合：**列数固定、子项数量不多**

---

## 2️⃣ GridView.extent（固定最大宽度）

```dart
GridView.extent(
  maxCrossAxisExtent: 120,
  children: [...],
)
```

适合：**自适应列数（屏幕大小变化）**

---

## 3️⃣ GridView.builder（推荐）

```dart
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
  ),
  itemBuilder: (context, index) => Item(),
  itemCount: 100,
)
```

适合：**大数据量、性能优先**

---

## 4️⃣ GridView.custom（进阶）

```dart
GridView.custom(
  gridDelegate: ...,
  childrenDelegate: ...,
)
```

适合：**高度自定义、很少使用**

---

# 三、GridView 的核心组成结构

```text
GridView
├── ScrollView 属性（滚动行为）
├── SliverGridDelegate（网格规则）
└── 子项 Widget
```

---

# 四、GridDelegate（网格规则，核心重点）

## 1️⃣ SliverGridDelegateWithFixedCrossAxisCount

> 固定 **列数**

```dart
SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 2,
  mainAxisSpacing: 10,
  crossAxisSpacing: 10,
  childAspectRatio: 1.2,
)
```

### 属性大全

| 属性                 | 说明        |
| ------------------ | --------- |
| `crossAxisCount`   | 列数        |
| `mainAxisSpacing`  | 主轴间距（竖向）  |
| `crossAxisSpacing` | 交叉轴间距（横向） |
| `childAspectRatio` | 宽 / 高 比例  |

---

## 2️⃣ SliverGridDelegateWithMaxCrossAxisExtent

> 固定 **最大宽度**

```dart
SliverGridDelegateWithMaxCrossAxisExtent(
  maxCrossAxisExtent: 150,
)
```

### 属性大全

| 属性                   | 说明           |
| -------------------- | ------------ |
| `maxCrossAxisExtent` | 单个 item 最大宽度 |
| `mainAxisSpacing`    | 主轴间距         |
| `crossAxisSpacing`   | 交叉轴间距        |
| `childAspectRatio`   | 宽 / 高        |

---

# 五、GridView 通用属性大全（重点）

这些属性 **继承自 ScrollView / BoxScrollView**

---

## 1️⃣ 滚动方向相关

| 属性                | 说明                          |
| ----------------- | --------------------------- |
| `scrollDirection` | 滚动方向（vertical / horizontal） |
| `reverse`         | 是否反向滚动                      |

```dart
scrollDirection: Axis.vertical
```

---

## 2️⃣ 滚动物理效果

| 属性           | 说明    |
| ------------ | ----- |
| `physics`    | 滚动行为  |
| `controller` | 滚动控制器 |

```dart
physics: BouncingScrollPhysics()
```

---

## 3️⃣ 尺寸与布局控制

| 属性           | 说明       |
| ------------ | -------- |
| `shrinkWrap` | 是否包裹内容   |
| `padding`    | 内边距      |
| `primary`    | 是否为主滚动视图 |

```dart
shrinkWrap: true
```

⚠️ `shrinkWrap: true` **性能开销大**

---

## 4️⃣ 缓存与性能

| 属性                       | 说明    |
| ------------------------ | ----- |
| `cacheExtent`            | 预加载距离 |
| `addAutomaticKeepAlives` | 自动保活  |
| `addRepaintBoundaries`   | 重绘边界  |
| `addSemanticIndexes`     | 无障碍索引 |

---

## 5️⃣ 键与语义

| 属性                   | 说明        |
| -------------------- | --------- |
| `key`                | Widget 标识 |
| `semanticChildCount` | 无障碍子项数    |

---

# 六、GridView 子项布局细节

## 1️⃣ childAspectRatio 的计算

```text
childAspectRatio = width / height
```

* > 1：宽扁
* = 1：正方形
* < 1：高条

---

## 2️⃣ 间距真实计算方式

```text
item 实际宽度 =
(屏幕宽度 - padding - 间距总和) / 列数
```

---

# 七、GridView 常见实战配置模板

## 1️⃣ 九宫格功能入口

```dart
GridView.count(
  crossAxisCount: 3,
  mainAxisSpacing: 12,
  crossAxisSpacing: 12,
  children: List.generate(9, (i) => Icon(Icons.apps)),
)
```

---

## 2️⃣ 商品列表（推荐写法）

```dart
GridView.builder(
  padding: EdgeInsets.all(12),
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.75,
    mainAxisSpacing: 12,
    crossAxisSpacing: 12,
  ),
  itemCount: products.length,
  itemBuilder: (_, i) => ProductCard(products[i]),
)
```

---

## 3️⃣ 嵌套在 Column 中（重点）

```dart
Expanded(
  child: GridView.builder(
    gridDelegate: ...,
    itemBuilder: ...,
  ),
)
```

或：

```dart
GridView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
)
```

---

# 八、GridView vs ListView

| 对比项   | GridView   | ListView   |
| ----- | ---------- | ---------- |
| 维度    | 二维         | 一维         |
| 布局复杂度 | 高          | 低          |
| 性能    | builder 相同 | builder 相同 |
| 使用频率  | 商品 / 图片    | 文本列表       |

---

# 九、常见错误与坑点

## ❌ 1. GridView 放在 Column 中报错

原因：**高度无约束**

解决：

* `Expanded`
* 或 `shrinkWrap: true`

---

## ❌ 2. childAspectRatio 设置不合理

导致：

* item 被压扁
* 图片变形

---

## ❌ 3. 小数据却用 GridView.builder

小数据直接 `GridView.count` 更直观

---

# 十、一句话总结

> **GridView = Flutter 中展示大量同构数据的二维滚动布局核心组件，性能与灵活性并存，`GridView.builder` 是项目首选。**

---

如果你愿意，下一步我可以帮你：

* 对比 **GridView / Wrap / MasonryGrid**
* 总结 **GridView 性能优化清单**
* 整理 **GridView + SliverGrid 高级用法**
* 给你一份 **Flutter 布局组件速查表（Grid / List / Stack）**

你可以直接告诉我你更想偏「实战模板」还是「底层原理」。
