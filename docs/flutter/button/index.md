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

- 你列的 **不是“按钮大全”**
- 而是 **Flutter 官方推荐的主流按钮体系**

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

- 登录
- 注册
- 提交表单
- 确认操作
- 保存

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

- 新项目
- Material 3 设计体系
- 替代 ElevatedButton

📌 **结论**

- 老项目：ElevatedButton
- 新项目（M3）：FilledButton

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

- 取消
- 返回
- 次要操作
- 辅助按钮

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

- 文本操作
- 链接
- 弹窗底部操作
- AppBar actions

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

- AppBar
- 关闭按钮
- 设置按钮
- 删除 / 更多

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

- 新建
- 添加
- 发布
- 核心动作（页面级）

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

- “三个点”菜单
- 二级操作
- 操作不重要但要保留

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

- 筛选
- 设置项
- 选项切换

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

- 状态切换
- 过滤条件
- 多/单选模式

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

- 纯 iOS 风格 App
- CupertinoPageScaffold

📌 **Material 项目中很少混用**

---

# 三、是不是“按钮大全”？（关键澄清）

### ❌ 不是

Flutter 里还有：

- InkWell / GestureDetector（手势）
- RawMaterialButton（底层）
- 自定义按钮（Container + InkWell）

### ✅ 但你列的是

> **官方推荐 + 实战最常用的一整套按钮体系**

---

# 四、到底有没有必要都学？（结论级）

### ✅ 必学（90% 场景）

| 按钮           | 必须 |
| -------------- | ---- |
| ElevatedButton | ✅   |
| OutlinedButton | ✅   |
| TextButton     | ✅   |
| IconButton     | ✅   |
| DropdownButton | ✅   |

### ⚠️ 了解即可

| 按钮                 | 原因     |
| -------------------- | -------- |
| FilledButton         | 新       |
| FloatingActionButton | 特定场景 |
| PopupMenuButton      | 固定模式 |
| SegmentedButton      | 新组件   |
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

- 做一张 **Flutter 按钮选择决策表**
- 或 **按钮主题统一方案（ThemeData）**
- 或 **用一个页面把所有按钮实战串起来**

## 你选一个，我直接给你。

下面我把你给出的内容**整理成一份「可直接用于学习 / 项目选型的 Flutter 按钮选择决策表」**，并补充**使用场景与取舍逻辑**，保证你在实际项目中“知道为什么选它”。

---

## ✅ Flutter 按钮选择决策表（实战向）

### 一、**必须掌握（高频 / 通用 / 官方推荐）**

| 按钮               | 是否必须 | 典型使用场景                  | 选型理由                                        |
| ------------------ | -------- | ----------------------------- | ----------------------------------------------- |
| **ElevatedButton** | ✅       | 表单提交、确认、主要操作      | 最常用的 **主按钮**，有高度和阴影，视觉权重最高 |
| **OutlinedButton** | ✅       | 次要操作、取消按钮            | 语义清晰，不抢主操作注意力                      |
| **TextButton**     | ✅       | 弱操作、链接式按钮            | 用于低风险、非关键动作                          |
| **IconButton**     | ✅       | 工具栏、列表操作（删除/编辑） | 图标语义强，占用空间小                          |
| **DropdownButton** | ✅       | 枚举选择、筛选条件            | 最基础的下拉选择组件                            |

> **结论**
> 👉 如果你只学 5 个按钮，**就是这 5 个**，能覆盖 **90% 业务场景**。

---

### 二、⚠️ 了解即可（场景受限 / 新组件 / 平台相关）

| 按钮                     | 建议程度 | 使用场景             | 为什么不是必须                      |
| ------------------------ | -------- | -------------------- | ----------------------------------- |
| **FilledButton**         | ⚠️       | Material 3 项目      | M3 新增，和 ElevatedButton 职责重叠 |
| **FloatingActionButton** | ⚠️       | 地图 / 列表新增      | 只适合「页面唯一核心操作」          |
| **PopupMenuButton**      | ⚠️       | 更多操作（三点菜单） | 交互固定、灵活性不高                |
| **SegmentedButton**      | ⚠️       | Tab / 筛选切换       | 新组件，老项目多用 TabBar           |
| **CupertinoButton**      | ⚠️       | 纯 iOS 风格页面      | 跨平台项目使用率低                  |

---

## 🧠 快速决策口诀（非常重要）

### 1️⃣ 这是页面**最重要的操作**？

👉 **ElevatedButton**

---

### 2️⃣ 次要 / 取消 / 辅助操作？

👉 **OutlinedButton / TextButton**

---

### 3️⃣ 只有图标，没有文字？

👉 **IconButton**

---

### 4️⃣ 从一组值里选一个？

👉 **DropdownButton**
（表单中更常用 `DropdownButtonFormField`）

---

### 5️⃣ 页面只有一个“新增 / 创建”？

👉 **FloatingActionButton（谨慎）**

---

## 📌 实际项目中的“真实用法比例”（经验值）

| 按钮           | 使用频率   |
| -------------- | ---------- |
| ElevatedButton | ⭐⭐⭐⭐⭐ |
| OutlinedButton | ⭐⭐⭐⭐   |
| TextButton     | ⭐⭐⭐⭐   |
| IconButton     | ⭐⭐⭐⭐⭐ |
| DropdownButton | ⭐⭐⭐     |
| 其他           | ⭐         |

---

## 🎯 给你的学习建议（非常关键）

> **不要把时间平均分给所有按钮**

### 推荐顺序：

1. **ElevatedButton / OutlinedButton / TextButton**
   - styleFrom
   - disabled 状态
   - loading 状态（自己封装）

2. **IconButton**
   - AppBar / ListTile / 卡片操作

3. **DropdownButton**
   - 表单结合
   - 枚举数据源

4. 其他按钮 → **看到项目再查即可**

---

如果你愿意，下一步我可以帮你做这几件事之一：

- ✅ **给你一套「按钮封装规范」（统一样式）**
- ✅ **Material 2 vs Material 3 按钮差异对照表**
- ✅ **表单页面中按钮的正确组合示例（提交 / 取消 / 重置）**

## 你可以直接选一个继续。

下面给你一套“按钮主题统一方案（ThemeData）”，覆盖你上面提到的按钮：**ElevatedButton / OutlinedButton / TextButton / IconButton / DropdownButton**，并兼容你后面提到的 **FilledButton / FloatingActionButton / PopupMenuButton / SegmentedButton / CupertinoButton（可选）**。你可以直接拷贝进项目使用，然后按需微调。

---

## 1) 目标与原则（你在项目里会用到的取舍）

- **统一尺寸**：高度、圆角、内边距、最小点击区域一致
- **统一字体与权重**：按钮文本风格一致
- **统一状态**：disabled / pressed / hover（Web/桌面）表现一致
- **统一颜色语义**：primary（主）、secondary（次）、danger（危险）通过组件/封装层实现，不建议在 ThemeData 里写死“危险红按钮”（避免污染全局语义）

---

## 2) 一份可直接用的 ThemeData（Material 3 推荐）

> 如果你项目是新建的 Flutter（近几年默认），建议 `useMaterial3: true`。

```dart
import 'package:flutter/material.dart';

ThemeData buildAppTheme({
  required Color seedColor, // 你的品牌色
  Brightness brightness = Brightness.light,
}) {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: brightness,
  );

  const radius = 12.0;
  const buttonHeight = 44.0;
  const horizontalPadding = 16.0;

  // 统一形状
  final shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(radius),
  );

  // 统一文本
  final buttonTextStyle = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // 统一 overlay（按压/hover 水波纹）
  MaterialStateProperty<Color?> overlay(Color base) {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) return base.withOpacity(0.12);
      if (states.contains(MaterialState.hovered)) return base.withOpacity(0.08);
      if (states.contains(MaterialState.focused)) return base.withOpacity(0.10);
      return null;
    });
  }

  // 统一 disabled 颜色策略
  MaterialStateProperty<Color?> disabledForeground(Color normal) {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) return normal.withOpacity(0.38);
      return normal;
    });
  }

  MaterialStateProperty<Color?> disabledBackground(Color normal) {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) return normal.withOpacity(0.12);
      return normal;
    });
  }

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: colorScheme,

    // 可选：全局字体
    // fontFamily: 'YourFont',

    // 统一输入等组件密度
    visualDensity: VisualDensity.standard,

    // 统一按钮的默认最小尺寸与内边距（对大多数按钮生效）
    //（注意：不同按钮仍以各自 theme 为准）
    textTheme: Typography.material2021().black.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(64, buttonHeight),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        shape: MaterialStateProperty.all(shape),
        textStyle: MaterialStateProperty.all(buttonTextStyle),

        // 主按钮：背景为 primary
        backgroundColor: disabledBackground(colorScheme.primary),
        foregroundColor: disabledForeground(colorScheme.onPrimary),
        overlayColor: overlay(colorScheme.onPrimary),
        elevation: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) return 0;
          if (states.contains(MaterialState.pressed)) return 1;
          return 2;
        }),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(64, buttonHeight),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        shape: MaterialStateProperty.all(shape),
        textStyle: MaterialStateProperty.all(buttonTextStyle),

        foregroundColor: disabledForeground(colorScheme.primary),
        overlayColor: overlay(colorScheme.primary),
        side: MaterialStateProperty.resolveWith((states) {
          final isDisabled = states.contains(MaterialState.disabled);
          final c = isDisabled
              ? colorScheme.outline.withOpacity(0.4)
              : colorScheme.outline;
          return BorderSide(color: c, width: 1);
        }),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(48, buttonHeight),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 12),
        ),
        shape: MaterialStateProperty.all(shape),
        textStyle: MaterialStateProperty.all(buttonTextStyle),

        foregroundColor: disabledForeground(colorScheme.primary),
        overlayColor: overlay(colorScheme.primary),
      ),
    ),

    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        // IconButton 通常不需要和普通按钮一样高，但要保证点击区域
        minimumSize: MaterialStateProperty.all(const Size(40, 40)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        foregroundColor: disabledForeground(colorScheme.onSurfaceVariant),
        overlayColor: overlay(colorScheme.onSurface),
      ),
    ),

    // DropdownButton：更推荐 DropdownMenu（M3）或 DropdownButtonFormField
    // 这里主要统一菜单与表单样式：通过 InputDecorationTheme + MenuTheme 来间接统一
    inputDecorationTheme: InputDecorationTheme(
      isDense: true,
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.6),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: colorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: colorScheme.primary, width: 1.2),
      ),
    ),

    // M3 的 DropdownMenu/PopupMenu 使用 MenuTheme 来统一圆角/背景
    menuTheme: MenuThemeData(
      style: MenuStyle(
        shape: MaterialStateProperty.all(shape),
        backgroundColor: MaterialStateProperty.all(colorScheme.surface),
        elevation: MaterialStateProperty.all(4),
      ),
    ),

    // PopupMenuButton 也会吃到 menuTheme（同时可用 popupMenuTheme）
    popupMenuTheme: PopupMenuThemeData(
      shape: shape,
      color: colorScheme.surface,
      elevation: 4,
      textStyle: TextStyle(color: colorScheme.onSurface),
    ),

    // 了解即可的按钮也顺手统一（可删）
    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(
          const Size(64, buttonHeight),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: horizontalPadding),
        ),
        shape: MaterialStateProperty.all(shape),
        textStyle: MaterialStateProperty.all(buttonTextStyle),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),

    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(buttonTextStyle),
        shape: MaterialStateProperty.all(shape),
      ),
    ),
  );
}
```

---

## 3) 在 main.dart 里怎么接入

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: buildAppTheme(seedColor: const Color(0xFF3B82F6)), // 你的品牌色
      darkTheme: buildAppTheme(
        seedColor: const Color(0xFF3B82F6),
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatelessWidget {
  const DemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buttons Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Primary')),
            OutlinedButton(onPressed: () {}, child: const Text('Secondary')),
            TextButton(onPressed: () {}, child: const Text('Link')),
            IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),

            // 下拉：建议用 DropdownButtonFormField 更工程化
            SizedBox(
              width: 220,
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Type'),
                items: const [
                  DropdownMenuItem(value: 'a', child: Text('Option A')),
                  DropdownMenuItem(value: 'b', child: Text('Option B')),
                ],
                onChanged: (_) {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 4) 关于 DropdownButton 的“统一主题”现实点（你需要知道）

- `DropdownButton` 自己能统一的东西有限，**更工程化的做法**是：
  - **表单用** `DropdownButtonFormField`，吃 `InputDecorationTheme`
  - Material 3 推荐 `DropdownMenu`（更好主题化，也更现代）

- 所以我在 ThemeData 里主要通过：
  - `inputDecorationTheme`（表单外观统一）
  - `menuTheme / popupMenuTheme`（弹出菜单统一）

---

## 5) CupertinoButton 怎么统一（可选）

`CupertinoButton` 不吃 `ThemeData`，而吃 `CupertinoThemeData`。通常做法：

- iOS 页面用 `CupertinoApp` 或在局部包一层 `CupertinoTheme`
- 或者跨平台项目直接优先 Material 体系，iOS 也用 Material 3 统一设计语言


