下面给你一份 **Flutter 导航神器 `go_router` 的「使用大全」**，从**为什么用 → 基础 → 进阶 → 企业级写法**，一篇直接吃透。
（偏实战，代码可直接抄 👍）

---

## 一、为什么用 go_router（它解决了什么）

在 Flutter 里，原生 `Navigator` / `Navigator 2.0`：

* ❌ 写法冗长
* ❌ 深层路由、Web URL 同步很痛苦
* ❌ 鉴权 / 重定向很难维护

**go_router = 官方推荐的声明式路由方案**

优点一句话总结：

> **路由像配置表一样写，URL、参数、鉴权、嵌套路由一次搞定**

---

## 二、安装与基础配置

### 1️⃣ 添加依赖

```yaml
dependencies:
  go_router: ^13.2.0
```

---

### 2️⃣ 最小可运行示例

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/detail',
        builder: (context, state) => const DetailPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
```

---

## 三、页面跳转的几种方式（重点）

### 1️⃣ 普通跳转（push）

```dart
context.push('/detail');
```

➡ 保留返回栈

---

### 2️⃣ 替换当前页面（go）

```dart
context.go('/detail');
```

➡ **直接替换**，不能返回
👉 常用于：登录成功、首页切换

---

### 3️⃣ 返回上一页

```dart
context.pop();
```

---

## 四、路由参数（非常重要）

### ✅ 1. 路径参数（Path Parameter）

```dart
GoRoute(
  path: '/user/:id',
  builder: (context, state) {
    final id = state.pathParameters['id'];
    return UserPage(id: id!);
  },
);
```

跳转：

```dart
context.push('/user/1001');
```

---

### ✅ 2. 查询参数（Query Parameter）

```dart
context.push('/search?keyword=flutter&page=2');
```

获取：

```dart
final keyword = state.uri.queryParameters['keyword'];
final page = state.uri.queryParameters['page'];
```

---

### ✅ 3. 复杂对象参数（最常用）

```dart
context.push(
  '/detail',
  extra: Product(id: 1, name: 'iPhone'),
);
```

接收：

```dart
final product = state.extra as Product;
```

👉 **推荐：复杂对象一律用 `extra`**

---

## 五、嵌套路由（页面结构清晰）

适合：Tab 页 / 子页面

```dart
GoRoute(
  path: '/home',
  builder: (context, state) => const HomePage(),
  routes: [
    GoRoute(
      path: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
```

跳转到子路由：

```dart
context.push('/home/profile');
```

---

## 六、ShellRoute（底部 Tab / Scaffold 不变）

🔥 **企业级必用**

![Image](https://miro.medium.com/v2/resize%3Afit%3A1400/1%2Atnrv44oP3pDvmGTaljs3Ag.png)

![Image](https://i.sstatic.net/flKAr.gif)

```dart
final router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/mine',
          builder: (context, state) => const MinePage(),
        ),
      ],
    ),
  ],
);
```

👉 底部导航切换 **只换 body，不重建 Scaffold**

---

## 七、路由重定向（登录鉴权必备）

### 1️⃣ 全局登录拦截

```dart
final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLogin = AuthService.isLogin;
    final loggingIn = state.matchedLocation == '/login';

    if (!isLogin && !loggingIn) return '/login';
    if (isLogin && loggingIn) return '/home';

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (_, __) => LoginPage()),
    GoRoute(path: '/home', builder: (_, __) => HomePage()),
  ],
);
```

---

### 2️⃣ 页面级 redirect

```dart
GoRoute(
  path: '/vip',
  redirect: (context, state) {
    if (!User.isVip) return '/upgrade';
    return null;
  },
  builder: (context, state) => VipPage(),
);
```

---

## 八、404 页面 & 错误处理

```dart
GoRouter(
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(state.error.toString()),
      ),
    );
  },
);
```

---

## 九、Web / URL 同步（Flutter Web 核心优势）

* `/user/1001` 可直接浏览器访问
* 刷新不丢页面
* SEO / 分享链接友好

**这点 Navigator 做不到，go_router 原生支持**

---

## 十、常见最佳实践（经验总结）

### ✅ 推荐写法

```dart
class AppRoutes {
  static const home = '/home';
  static const login = '/login';
  static const detail = '/detail';
}
```

```dart
context.go(AppRoutes.home);
```

---

### ❌ 不推荐

* 在 build 里疯狂 `context.go`
* 用 path 参数传大对象
* 所有逻辑都写在 redirect（会很乱）

---

## 十一、go_router vs Navigator 对比

| 对比项    | Navigator | go_router |
| ------ | --------- | --------- |
| 写法     | 命令式       | 声明式       |
| Web 支持 | 一般        | ⭐⭐⭐⭐⭐     |
| 鉴权     | 难         | 简单        |
| 嵌套     | 复杂        | 清晰        |
| 官方推荐   | ❌         | ✅         |

---

## 十二、学习路线建议（给你这种在学 Flutter 的）

1️⃣ 会用 `push / go / pop`
2️⃣ 掌握 `path / query / extra`
3️⃣ 熟练 `ShellRoute + 底部导航`
4️⃣ 上线前一定加 `redirect`（登录）

---

## 最后一句话总结

> **go_router = Flutter 项目中「必须会」的导航方案**
> 写得好，项目结构直接清爽一个档次 🚀

如果你愿意，我可以下一步帮你👇

* 🔹 写一个 **完整登录 + Tab + 详情页 Demo**
* 🔹 对比 **GetX / auto_route / go_router**
* 🔹 手把手改你现有项目的导航结构

你选一个，我直接开写。
