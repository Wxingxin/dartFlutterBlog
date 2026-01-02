好，这一题也是 **Flutter 高频组件 + 面试常考 + 实战非常多**。
`PopupMenuButton` 不只是“右上角三个点”，它涉及 **菜单构建、返回值、位置控制、M3 风格、替代方案**。

下面给你一份 **真正能直接上项目用的 PopupMenuButton 使用大全**。

---

![Image](https://ptyagicodecamp.github.io/popupmenubutton_stateless.jpg)

![Image](https://flutterassets.com/wp-content/uploads/2021/12/appbar-popupmenubutton.jpg)

![Image](https://i.sstatic.net/6MQaY.jpg)

![Image](https://user-images.githubusercontent.com/1377460/198087775-bd710019-26ae-45c1-9ba4-806ef04c56dc.png)

# Flutter `PopupMenuButton` 知识点 & 使用大全

---

## 一、PopupMenuButton 是什么？

> **PopupMenuButton：点击后弹出一个浮层菜单，用于“次要 / 不常用 / 相关操作”**

典型场景：

* AppBar 右上角「更多」
* 列表项的「···」
* 工具操作集合（编辑 / 删除 / 分享）

📌 设计原则：

> **PopupMenu 里的操作，都是“非主操作”**

---

## 二、最基础用法（必须会）

```dart
PopupMenuButton<String>(
  onSelected: (value) {
    print(value);
  },
  itemBuilder: (context) => [
    const PopupMenuItem(
      value: 'edit',
      child: Text('编辑'),
    ),
    const PopupMenuItem(
      value: 'delete',
      child: Text('删除'),
    ),
  ],
)
```

✔ 点击按钮 → 弹出菜单
✔ 点击菜单项 → 回调 `onSelected`

---

## 三、PopupMenuButton 的核心结构（重点）

### 1️⃣ 泛型 T（非常重要）

```dart
PopupMenuButton<int>
PopupMenuButton<String>
PopupMenuButton<MyEnum>
```

📌 **菜单项的 value 类型 = PopupMenuButton 的泛型**

---

### 2️⃣ itemBuilder（菜单内容）

```dart
itemBuilder: (context) => <PopupMenuEntry<String>>[
  PopupMenuItem(
    value: 'share',
    child: Text('分享'),
  ),
]
```

* 返回的是 `PopupMenuEntry`
* 最常用的是 `PopupMenuItem`

---

### 3️⃣ onSelected（选中回调）

```dart
onSelected: (value) {
  // value 就是 PopupMenuItem.value
}
```

📌 点击后菜单自动关闭

---

### 4️⃣ onCanceled（点击空白）

```dart
onCanceled: () {
  print('用户点了空白区域');
}
```

---

## 四、PopupMenuButton 的触发按钮（重点）

### 1️⃣ 默认按钮（⋮）

```dart
PopupMenuButton(
  itemBuilder: ...
)
```

👉 默认是 `Icons.more_vert`

---

### 2️⃣ 自定义 icon

```dart
PopupMenuButton(
  icon: const Icon(Icons.more_horiz),
  itemBuilder: ...
)
```

---

### 3️⃣ 完全自定义 child（非常实用）

```dart
PopupMenuButton(
  child: Row(
    children: const [
      Icon(Icons.settings),
      SizedBox(width: 4),
      Text('更多'),
    ],
  ),
  itemBuilder: ...
)
```

📌 用了 `child` 就不能再用 `icon`

---

## 五、PopupMenuItem 的进阶用法

### 1️⃣ 图标 + 文本（最常见）

```dart
PopupMenuItem<String>(
  value: 'delete',
  child: Row(
    children: const [
      Icon(Icons.delete, size: 18),
      SizedBox(width: 8),
      Text('删除'),
    ],
  ),
)
```

---

### 2️⃣ 禁用菜单项

```dart
const PopupMenuItem(
  enabled: false,
  child: Text('不可用'),
)
```

---

### 3️⃣ 分割线（PopupMenuDivider）

```dart
itemBuilder: (context) => const [
  PopupMenuItem(value: 'edit', child: Text('编辑')),
  PopupMenuDivider(),
  PopupMenuItem(value: 'delete', child: Text('删除')),
]
```

---

## 六、PopupMenuButton 在 AppBar 中（高频）

```dart
AppBar(
  actions: [
    PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'setting', child: Text('设置')),
        PopupMenuItem(value: 'logout', child: Text('退出登录')),
      ],
    ),
  ],
)
```

✔ 极其常见
✔ 面试 100% 会遇到

---

## 七、PopupMenuButton 在列表中（实战）

```dart
ListTile(
  title: const Text('文件名'),
  trailing: PopupMenuButton<String>(
    onSelected: (value) {},
    itemBuilder: (context) => const [
      PopupMenuItem(value: 'rename', child: Text('重命名')),
      PopupMenuItem(value: 'delete', child: Text('删除')),
    ],
  ),
)
```

📌 比多个 IconButton 更整洁

---

## 八、位置 & 行为控制（进阶）

### 1️⃣ offset（菜单偏移）

```dart
PopupMenuButton(
  offset: const Offset(0, 40),
  itemBuilder: ...
)
```

---

### 2️⃣ shape（圆角）

```dart
PopupMenuButton(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  itemBuilder: ...
)
```

---

### 3️⃣ color（背景色）

```dart
PopupMenuButton(
  color: Colors.white,
  itemBuilder: ...
)
```

📌 M3 中更推荐用 Theme 控制

---

## 九、Material 3 中 PopupMenu 的变化

* 菜单圆角更大
* 阴影更柔和
* 文字 / 间距更舒适
* 更适合触控

📌 **逻辑用法没变，视觉由 Theme 统一控制**

---

## 十、PopupMenuButton vs BottomSheet（面试对比）

| 对比   | PopupMenuButton | BottomSheet |
| ---- | --------------- | ----------- |
| 操作数量 | 少               | 多           |
| 权重   | 轻               | 中           |
| 使用频率 | 低               | 中           |
| 位置   | 锚点弹出            | 底部弹出        |

📌 一句话：

> 少量次操作 → PopupMenu
> 多操作 / 破坏性操作 → BottomSheet

---

## 十一、常见错误 & 坑（⚠️）

### ❌ 1. 放主操作

* “提交”
* “确认”

👉 错，PopupMenu 只放次要操作

---

### ❌ 2. 菜单项太多

* 超过 5 个
* 用户难找

---

### ❌ 3. itemBuilder 里写逻辑

```dart
itemBuilder: (_) {
  doSomething(); // ❌
}
```

👉 这里只负责 UI

---

## 十二、完整实战案例（推荐模板）

```dart
PopupMenuButton<String>(
  tooltip: '更多操作',
  onSelected: (value) {
    switch (value) {
      case 'edit':
        break;
      case 'delete':
        break;
    }
  },
  itemBuilder: (context) => const [
    PopupMenuItem(
      value: 'edit',
      child: Text('编辑'),
    ),
    PopupMenuItem(
      value: 'delete',
      child: Text('删除'),
    ),
  ],
)
```

---

## 十三、面试一句话总结（直接背）

> **PopupMenuButton 是用于承载次要操作的浮层菜单组件，常用于 AppBar 或列表项，通过 itemBuilder 构建菜单，通过 onSelected 处理用户选择。**

---

## 十四、下一步你可以这样学（很顺）

你现在已经系统掌握了：

* FilledButton
* IconButton
* FloatingActionButton
* PopupMenuButton

接下来最值的 3 个进阶方向是：

1️⃣ **BottomSheet（showModalBottomSheet）对比 PopupMenu**
2️⃣ **Scaffold 全槽位组件实战（AppBar / FAB / Drawer）**
3️⃣ **Material 3 交互组件选型面试题合集**

你选一个，我直接继续给你下一讲 🚀
