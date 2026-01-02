这个问题**非常好，而且非常“体系化”** 👍
你已经从「学单个组件」走到「**搭 UI 架构**」这一步了——**面试、做中大型项目必备能力**。

下面我帮你把 **Flutter 组件按“功能类型”系统分类**，并且：

* ✅ **Material / Cupertino 都覆盖**
* ✅ 标注 **高频 / 面试常考**
* ✅ 给出 **选型建议**

你可以把这份当成 **Flutter 组件地图** 来背和查。

---

# Flutter 组件分类大全（按功能类型）

---

## 一、按钮类（Button Components）⭐️⭐️⭐️⭐️⭐️

👉 **用于触发动作（Action）**

### 1️⃣ Material 按钮（Material 3）

| 组件                   | 用途     | 备注       |
| -------------------- | ------ | -------- |
| FilledButton         | 主操作按钮  | ⭐️ M3 首选 |
| FilledButton.tonal   | 次操作按钮  | ⭐️       |
| TextButton           | 轻量操作   | 无背景      |
| OutlinedButton       | 边框按钮   | 次级       |
| ElevatedButton       | 旧版主按钮  | ❌ M3 不推荐 |
| IconButton           | 图标操作   | 高频       |
| FloatingActionButton | 页面级主操作 | ⭐️⭐️⭐️   |
| PopupMenuButton      | 操作集合   | 次要       |

---

### 2️⃣ Cupertino（iOS）按钮

| 组件                     | 用途      |
| ---------------------- | ------- |
| CupertinoButton        | iOS 次操作 |
| CupertinoButton.filled | iOS 主操作 |

---

📌 **一句话**

> Button = 用户“点一下就发生事”的组件

---

## 二、表单类（Form & Input）⭐️⭐️⭐️⭐️⭐️

👉 **用于输入、选择、校验数据**

### 1️⃣ 文本输入

| 组件            | 用途        |
| ------------- | --------- |
| TextField     | 普通输入      |
| TextFormField | 表单输入（带校验） |

---

### 2️⃣ 选择类（单选 / 多选）

| 组件               | 类型      |
| ---------------- | ------- |
| Checkbox         | 多选      |
| CheckboxListTile | 多选 + 文本 |
| Radio            | 单选      |
| RadioListTile    | 单选 + 文本 |
| Switch           | 开关      |
| SwitchListTile   | 开关 + 文本 |

---

### 3️⃣ 下拉 / 选择器

| 组件                      | 体系               |
| ----------------------- | ---------------- |
| DropdownButton          | 旧版               |
| DropdownButtonFormField | 表单推荐             |
| DropdownMenu            | ⭐️ Material 3 推荐 |
| PopupMenuButton         | 选操作（非值）          |

---

### 4️⃣ 表单容器

| 组件        | 用途     |
| --------- | ------ |
| Form      | 表单容器   |
| FormField | 自定义表单项 |

---

📌 **一句话**

> Form = “用户要填数据，你要校验”

---

## 三、布局类（Layout）⭐️⭐️⭐️⭐️⭐️

👉 **控制位置、大小、排列**

### 1️⃣ 基础布局（必背）

| 组件         |
| ---------- |
| Row        |
| Column     |
| Stack      |
| Positioned |
| Expanded   |
| Flexible   |

---

### 2️⃣ 尺寸 / 间距

| 组件       |
| -------- |
| Padding  |
| SizedBox |
| Align    |
| Center   |
| Spacer   |

---

### 3️⃣ 自适应布局

| 组件                   |
| -------------------- |
| LayoutBuilder        |
| MediaQuery           |
| FractionallySizedBox |

---

📌 **一句话**

> Layout = “组件怎么摆”

---

## 四、容器 & 装饰类（Container & Decoration）

👉 **控制背景、边框、圆角、阴影**

| 组件           |
| ------------ |
| Container    |
| DecoratedBox |
| Card         |
| Material     |
| Ink          |
| InkWell      |

📌 Card / Material 常用于 **视觉分层**

---

## 五、导航 & 页面结构（Navigation & Scaffold）⭐️⭐️⭐️⭐️⭐️

👉 **页面骨架 + 页面跳转**

### 1️⃣ 页面骨架

| Material            | Cupertino              |
| ------------------- | ---------------------- |
| Scaffold            | CupertinoPageScaffold  |
| AppBar              | CupertinoNavigationBar |
| Drawer              | CupertinoDrawer（少用）    |
| BottomNavigationBar | CupertinoTabBar        |

---

### 2️⃣ 页面切换

| 组件                 |
| ------------------ |
| Navigator          |
| PageRoute          |
| MaterialPageRoute  |
| CupertinoPageRoute |

---

📌 **一句话**

> Scaffold = 页面框架
> Navigator = 页面跳转

---

## 六、列表 & 滚动类（List & Scroll）⭐️⭐️⭐️⭐️⭐️

👉 **展示大量内容**

| 组件                    |
| --------------------- |
| ListView              |
| ListView.builder      |
| GridView              |
| GridView.builder      |
| SingleChildScrollView |
| CustomScrollView      |
| SliverList            |
| SliverAppBar          |

📌 面试常问：**ListView vs CustomScrollView**

---

## 七、对话框 & 弹层（Dialog & Overlay）

👉 **打断用户流程**

### 1️⃣ Dialog

| Material     | Cupertino            |
| ------------ | -------------------- |
| AlertDialog  | CupertinoAlertDialog |
| SimpleDialog | —                    |

---

### 2️⃣ 底部弹层

| 组件                   |
| -------------------- |
| showModalBottomSheet |
| showBottomSheet      |

---

### 3️⃣ 提示

| 组件       |
| -------- |
| SnackBar |
| Tooltip  |

---

## 八、反馈 & 状态类（Feedback & State）

👉 **告诉用户“发生了什么”**

| 组件                        |
| ------------------------- |
| CircularProgressIndicator |
| LinearProgressIndicator   |
| RefreshIndicator          |
| Banner                    |

---

## 九、媒体 & 图标类（Media）

| 组件           |
| ------------ |
| Icon         |
| Image        |
| FadeInImage  |
| CircleAvatar |

---

## 十、Cupertino 专属组件（iOS 风格）

| 分类  | 组件                     |
| --- | ---------------------- |
| 页面  | CupertinoPageScaffold  |
| 导航  | CupertinoNavigationBar |
| 标签  | CupertinoTabScaffold   |
| 滑块  | CupertinoSlider        |
| 开关  | CupertinoSwitch        |
| 选择器 | CupertinoPicker        |

---

## 十一、面试级「组件选型速查表」

| 需求      | 选什么                    |
| ------- | ---------------------- |
| 主操作     | FilledButton / FAB     |
| 次操作     | FilledButton.tonal     |
| 图标点击    | IconButton             |
| 多操作集合   | PopupMenuButton        |
| 表单下拉    | DropdownMenu           |
| iOS 主按钮 | CupertinoButton.filled |
| 页面骨架    | Scaffold               |
| 列表      | ListView.builder       |

---

## 十二、学习建议（非常关键）

你现在的正确顺序是：

1️⃣ **组件分类（你现在这一步）✅**
2️⃣ 每一类挑 **2–3 个核心组件吃透**
3️⃣ 学 **“选型理由”而不是死记 API**

📌 **高级能力的标志**：

> “我为什么选这个组件，而不是另一个”

---

## 十三、如果你愿意，下一步我可以直接帮你：

* ✅ **画一张 Flutter 组件分类思维导图（背了就能面试）**
* ✅ **出 20 道「组件选型」面试题（非常狠）**
* ✅ **把 Material vs Cupertino 组件一一对照**

你选一个，我直接继续给你下一层 🔥
