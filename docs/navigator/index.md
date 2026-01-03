这个问题问得**非常到位**👌
**页面导航 = Flutter 应用的骨架**。我按「**怎么跳 → 怎么回 → 怎么传值 → 实际项目怎么选**」一步步给你讲清楚。

---

## 一、Flutter 页面导航的本质（一句话）

> **Flutter 的页面导航，本质是一个“页面栈（Stack）”**

- 进入新页面 👉 **push（压栈）**
- 返回上一个页面 👉 **pop（出栈）**

你可以把它想成一摞卡片：

![Image](https://media.licdn.com/dms/image/v2/D5622AQH_kvA9_-kmtg/feedshare-shrink_800/feedshare-shrink_800/0/1732255165566?e=2147483647&t=IByfE2ggKS1osy2juZ3NcaCjVhPNniYC6brh4PaVk54&v=beta)

![Image](https://miro.medium.com/v2/resize%3Afit%3A419/1%2AiXAUo6hQRPF5kwy9CsN0ag.png)

![Image](https://i.sstatic.net/hFv0g.png)

---

## 二、最基础：`Navigator.push / pop`

### 1️⃣ 页面跳转（push）

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(),
  ),
);
```

含义拆解：

- `Navigator`：导航管理器
- `push`：压栈
- `MaterialPageRoute`：一条“路由规则”
- `builder`：返回目标页面 Widget

📌 **每次 push，都会新建一个页面实例**

---

### 2️⃣ 页面返回（pop）

```dart
Navigator.pop(context);
```

等价于：

- 返回上一个页面
- 销毁当前页面

---

## 三、页面跳转时传值（非常常用）

### 1️⃣ 跳转时传值（构造函数）

```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => DetailPage(id: 100),
  ),
);
```

```dart
class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Text('id = $id');
  }
}
```

📌 **Flutter 推荐方式：构造函数传参**

---

### 2️⃣ 返回时传值（pop 返回结果）

```dart
final result = await Navigator.push(
  context,
  MaterialPageRoute(builder: (_) => SelectPage()),
);
print(result);
```

```dart
Navigator.pop(context, "选择结果");
```

📌 常见场景：

- 选择城市
- 选择图片
- 表单提交返回

---

## 四、命名路由（适合中大型项目）

当页面多了，你不想每次都 `MaterialPageRoute` 👇

---

### 1️⃣ 定义路由表

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomePage(),
    '/detail': (context) => DetailPage(),
  },
);
```

---

### 2️⃣ 使用命名路由跳转

```dart
Navigator.pushNamed(context, '/detail');
```

### 3️⃣ 返回

```dart
Navigator.pop(context);
```

📌 优点：

- 页面集中管理
- 路径语义清晰

📌 缺点：

- 传参稍微麻烦

---

## 五、命名路由传参（两种方式）

### ✅ 方式一：arguments（最常见）

```dart
Navigator.pushNamed(
  context,
  '/detail',
  arguments: 100,
);
```

```dart
final id = ModalRoute.of(context)!.settings.arguments as int;
```

---

### ✅ 方式二：onGenerateRoute（更灵活）

```dart
onGenerateRoute: (settings) {
  if (settings.name == '/detail') {
    final id = settings.arguments as int;
    return MaterialPageRoute(
      builder: (_) => DetailPage(id: id),
    );
  }
}
```

📌 **企业级项目更推荐这个**

---

## 六、替换页面 & 清空栈（登录场景必考）

### 1️⃣ 替换当前页面（不能返回）

```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (_) => HomePage()),
);
```

📌 用于：

- 登录成功 → 首页

---

### 2️⃣ 清空所有页面（只能去新页面）

```dart
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_) => HomePage()),
  (route) => false,
);
```

📌 用于：

- 退出登录
- 启动页 → 首页

---

## 七、Flutter 2.x：声明式导航（了解即可）

```dart
Navigator(
  pages: [
    MaterialPage(child: HomePage()),
    if (showDetail)
      MaterialPage(child: DetailPage()),
  ],
  onPopPage: (route, result) {
    showDetail = false;
    return route.didPop(result);
  },
);
```

📌 特点：

- 类似 React Router
- 学习成本高
- Web / 多端更有优势

---

## 八、导航方式对比总结（重点）

| 方式            | 场景     | 推荐度     |
| --------------- | -------- | ---------- |
| push / pop      | 简单页面 | ⭐⭐⭐⭐⭐ |
| 构造函数传参    | 强类型   | ⭐⭐⭐⭐⭐ |
| 命名路由        | 页面多   | ⭐⭐⭐⭐   |
| onGenerateRoute | 企业级   | ⭐⭐⭐⭐⭐ |
| pushReplacement | 登录     | ⭐⭐⭐⭐   |
| 声明式导航      | Web      | ⭐⭐       |

---

## 九、一句话终极总结（面试必背）

> **Flutter 页面导航是基于“路由栈”的管理模型** > **push = 进页面，pop = 回页面，replace = 换页面，removeUntil = 清空栈**

---

## 十、我可以继续帮你 👇

如果你愿意，我可以直接：

- ✅ 写一个**完整 Demo（首页 → 详情 → 返回带值）**
- ✅ 总结 **Flutter 导航面试题**
- ✅ 讲 **Navigator 1.0 vs 2.0**
- ✅ 教你 **项目中路由如何拆文件管理**

你直接说一句：
👉 **「来个完整 Demo」** 或 **「讲面试题」**
