这是一个**非常专业、也是做 Flutter 项目时必须搞清楚的问题**。
你列的这些 **并不是“所有按钮”**，但**已经覆盖了 Flutter 95% 的按钮使用场景**。

下面我从 **体系归类 → 使用频率 → 使用场景 → 是否必须学** 四个维度，一次性给你讲清楚。

---

# 一、先给你一个「按钮体系总览」（核心结论）

```
Material Button（主流）
├─ ElevatedButton        ← 主按钮（最高频）
├─ FilledButton          ← 新版主按钮（Material 3）
├─ OutlinedButton        ← 次按钮
├─ TextButton            ← 轻操作按钮
├─ IconButton            ← 图标按钮
├─ FloatingActionButton  ← 悬浮主操作（FAB）
├─ PopupMenuButton       ← 操作菜单
├─ DropdownButton        ← 选择（⚠️ 不完全是按钮）
├─ SegmentedButton       ← 分段选择（新）
│
└─ CupertinoButton       ← iOS 风格按钮
```

> **一句话总结**

* 你列的 **不是“按钮大全”**
* 而是 **Flutter 官方推荐的主流按钮体系**

---

# 二、每个按钮的使用频率 & 真实场景（重点）

下面按 **“你在真实项目中会用多少”** 排序。

---

## 1️⃣ ElevatedButton（⭐⭐⭐⭐⭐ 必学）

### 定位

> **最常用的主操作按钮**

```dart
ElevatedButton(
  onPressed: () {},
  child: Text('提交'),
)
```

### 使用频率

🔥🔥🔥🔥🔥（最高）

### 使用场景

* 登录
* 注册
* 提交表单
* 确认操作
* 保存

📌 **结论**

> 不会 ElevatedButton ≈ 不会 Flutter

---

## 2️⃣ FilledButton（⭐⭐⭐⭐ 新版趋势）

### 定位

> Material 3 的 **新主按钮**

```dart
FilledButton(
  onPressed: () {},
  child: Text('确定'),
)
```

### 使用频率

🔥🔥🔥🔥（增长中）

### 使用场景

* 新项目
* Material 3 设计体系
* 替代 ElevatedButton

📌 **结论**

* 老项目：ElevatedButton
* 新项目（M3）：FilledButton

---

## 3️⃣ OutlinedButton（⭐⭐⭐⭐）

### 定位

> **次级操作按钮**

```dart
OutlinedButton(
  onPressed: () {},
  child: Text('取消'),
)
```

### 使用频率

🔥🔥🔥🔥

### 使用场景

* 取消
* 返回
* 次要操作
* 辅助按钮

---

## 4️⃣ TextButton（⭐⭐⭐⭐）

### 定位

> **最轻量的按钮**

```dart
TextButton(
  onPressed: () {},
  child: Text('忘记密码'),
)
```

### 使用频率

🔥🔥🔥🔥

### 使用场景

* 文本操作
* 链接
* 弹窗底部操作
* AppBar actions

---

## 5️⃣ IconButton（⭐⭐⭐⭐）

### 定位

> **纯图标操作**

```dart
IconButton(
  icon: Icon(Icons.close),
  onPressed: () {},
)
```

### 使用频率

🔥🔥🔥🔥

### 使用场景

* AppBar
* 关闭按钮
* 设置按钮
* 删除 / 更多

---

## 6️⃣ FloatingActionButton（⭐⭐⭐）

### 定位

> **页面主操作（FAB）**

```dart
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)
```

### 使用频率

🔥🔥🔥

### 使用场景

* 新建
* 添加
* 发布
* 核心动作（页面级）

📌 **慎用**

> 一个页面通常 **只能有一个**

---

## 7️⃣ PopupMenuButton（⭐⭐⭐）

### 定位

> **更多操作菜单**

```dart
PopupMenuButton(
  itemBuilder: (context) => [
    PopupMenuItem(value: 1, child: Text('编辑')),
  ],
)
```

### 使用频率

🔥🔥🔥

### 使用场景

* “三个点”菜单
* 二级操作
* 操作不重要但要保留

---

## 8️⃣ DropdownButton（⭐⭐⭐）

### 定位

> **选择器（不是纯按钮）**

```dart
DropdownButton(
  items: [...],
  onChanged: (v) {},
)
```

### 使用频率

🔥🔥🔥

### 使用场景

* 筛选
* 设置项
* 选项切换

📌 **在 Form 中优先用**

> `DropdownButtonFormField`

---

## 9️⃣ SegmentedButton（⭐⭐ 新但有前途）

### 定位

> **分段选择（Tab-like）**

```dart
SegmentedButton(
  segments: [...],
  selected: {...},
  onSelectionChanged: (v) {},
)
```

### 使用频率

🔥🔥（目前较低）

### 使用场景

* 状态切换
* 过滤条件
* 多/单选模式

📌 **未来会越来越多**

---

## 🔟 CupertinoButton（⭐⭐）

### 定位

> **iOS 风格按钮**

```dart
CupertinoButton(
  onPressed: () {},
  child: Text('确定'),
)
```

### 使用频率

🔥🔥

### 使用场景

* 纯 iOS 风格 App
* CupertinoPageScaffold

📌 **Material 项目中很少混用**

---

# 三、是不是“按钮大全”？（关键澄清）

### ❌ 不是

Flutter 里还有：

* InkWell / GestureDetector（手势）
* RawMaterialButton（底层）
* 自定义按钮（Container + InkWell）

### ✅ 但你列的是

> **官方推荐 + 实战最常用的一整套按钮体系**

---

# 四、到底有没有必要都学？（结论级）

### ✅ 必学（90% 场景）

| 按钮             | 必须 |
| -------------- | -- |
| ElevatedButton | ✅  |
| OutlinedButton | ✅  |
| TextButton     | ✅  |
| IconButton     | ✅  |
| DropdownButton | ✅  |



### ⚠️ 了解即可

| 按钮                   | 原因     |
| -------------------- | ------ |
| FilledButton         | 新      |
| FloatingActionButton | 特定场景   |
| PopupMenuButton      | 固定模式   |
| SegmentedButton      | 新组件    |
| CupertinoButton      | iOS 专用 |

---

# 五、给你的学习建议（实战向）

> 不要 **一个个死记 API**

你只要掌握：

1. **Material 按钮体系**
2. **主 / 次 / 轻操作**
3. **按钮状态（enabled / disabled）**
4. **主题统一（ThemeData）**

剩下的你**自然会用**。

---

# 六、一句话终极总结

> 这些不是“按钮大全”，
> 但它们是 **Flutter 官方 + 实战中最重要的一整套按钮体系**。

如果你愿意，下一步我可以帮你：

* 做一张 **Flutter 按钮选择决策表**
* 或 **按钮主题统一方案（ThemeData）**
* 或 **用一个页面把所有按钮实战串起来**

你选一个，我直接给你。
