好，这次我们**不讲比例、不讲理念**，就做你要的这件事：
👉 **Flutter 中“能够展示文字和数据”的组件大全**
我会按**功能分类**，保证你以后查组件、选组件都不乱。

---

# 一、最基础：文字原子（所有文字的源头）

### 1️⃣ **Text**

```dart
Text('Hello')
```

* 最基础
* 所有文字展示的起点

---

### 2️⃣ **RichText**

```dart
RichText(
  text: TextSpan(text: 'Hello'),
)
```

* 多样式文本
* 比 Text 更底层

---

### 3️⃣ **TextSpan**（不是 Widget）

* 富文本片段
* 只能用于 RichText

---

### 4️⃣ **SelectableText**

```dart
SelectableText('可复制文本')
```

* 支持复制
* 日志 / Token / 链接

---

# 二、输入 & 展示结合（文本型数据）

### 5️⃣ **TextField**

### 6️⃣ **TextFormField**

* 表单输入
* 展示 + 编辑数据

---

# 三、列表 / 结构化数据展示（非常常用）

### 7️⃣ **ListTile**

```dart
ListTile(
  title: Text('标题'),
  subtitle: Text('描述'),
)
```

---

### 8️⃣ **ExpansionTile**

```dart
ExpansionTile(
  title: Text('订单'),
  children: [...],
)
```

---

### 9️⃣ **ListView / GridView**

> 本身不展示文字，但**承载展示数据的子组件**

---

# 四、按钮（文字 + 行为）

### 10️⃣ **ElevatedButton**

### 11️⃣ **TextButton**

### 12️⃣ **OutlinedButton**

> 内部通过 Text 展示文字

---

# 五、标签 / 状态 / 轻量数据展示

### 13️⃣ **Chip**

### 14️⃣ **InputChip**

### 15️⃣ **ChoiceChip**

### 16️⃣ **FilterChip**

* 标签
* 分类
* 状态

---

# 六、提示 & 辅助说明

### 17️⃣ **Tooltip**

```dart
Tooltip(
  message: '提示文字',
)
```

---

### 18️⃣ **SnackBar**

```dart
SnackBar(content: Text('操作成功'))
```

---

### 19️⃣ **AlertDialog**

```dart
AlertDialog(
  title: Text('标题'),
  content: Text('内容'),
)
```

---

# 七、导航 / 结构组件中的文字展示

### 20️⃣ **AppBar**

```dart
AppBar(title: Text('标题'))
```

---

### 21️⃣ **BottomNavigationBar**

```dart
BottomNavigationBarItem(
  label: '首页',
)
```

---

### 22️⃣ **TabBar**

```dart
Tab(text: 'Tab1')
```

---

### 23️⃣ **Drawer**

* 内部通常用 ListTile

---

# 八、表格 & 数据密集型（低频但完整）

### 24️⃣ **DataTable**

### 25️⃣ **DataRow / DataCell**

* 表格数据

---

# 九、其他能“承载文字”的组件（间接）

### 26️⃣ **IconButton（tooltip / label）**

### 27️⃣ **PopupMenuButton**

### 28️⃣ **DropdownButton**

### 29️⃣ **Badge（Material 3）**

---

# 十、总结性总表（收藏级）

| 分类   | 组件                               |
| ---- | -------------------------------- |
| 基础文字 | Text / RichText / SelectableText |
| 输入   | TextField / TextFormField        |
| 列表数据 | ListTile / ExpansionTile         |
| 标签状态 | Chip 系列                          |
| 按钮   | Elevated / Text / OutlinedButton |
| 提示弹窗 | Tooltip / SnackBar / Dialog      |
| 导航文字 | AppBar / TabBar / BottomNav      |
| 表格   | DataTable                        |

---

# 十一、最重要的一句话（帮你建立体系）

> **Flutter 中所有“文字和数据展示”最终都由 Text（或 RichText）完成，
> 其它组件只是“语义 + 布局 + 交互”的封装。**

---

如果你愿意，我下一步可以直接给你：

* ✅ **Flutter 页面组件选型决策表（看到需求立刻选组件）**
* ✅ **RN View/Text → Flutter Widget 全量映射表**
* ✅ **真实项目中 80% 页面是如何由这几个组件组合出来的**

你说一个，我继续带你往“工程级 Flutter”走。
