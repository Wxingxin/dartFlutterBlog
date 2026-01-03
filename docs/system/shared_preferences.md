下面给你一份 **Flutter 本地存储 `shared_preferences` 的学习大全**，按**入门 → 常用 → 进阶 → 实战**来讲，专门给你这种在系统学 Flutter 的节奏来写的。

> 一句话先立住概念：
> **shared_preferences = 轻量级 Key–Value 本地存储（适合配置、登录状态、简单数据）**

---

## 一、shared_preferences 是什么？适合存什么？

### ✅ 能存什么

| 类型           | 示例        |
| ------------ | --------- |
| bool         | 是否已登录     |
| int          | 启动次数      |
| double       | 音量        |
| String       | token、用户名 |
| List<String> | 搜索历史      |

### ❌ 不适合

* 大数据（图片、文件）
* 复杂对象（Model 列表）
* 高安全性数据（密码）

👉 **核心用途**：

> App 配置、引导页标记、登录状态、简单缓存

---

## 二、安装与初始化

### 1️⃣ 添加依赖

```yaml
dependencies:
  shared_preferences: ^2.2.2
```

---

### 2️⃣ 获取实例（最重要的一步）

```dart
import 'package:shared_preferences/shared_preferences.dart';

final prefs = await SharedPreferences.getInstance();
```

⚠️ 注意：

* **必须 async / await**
* 一般在 `initState` / 启动逻辑 / service 中用

---

## 三、最基础的增删改查（必会）

### ✅ 写数据（set）

```dart
await prefs.setBool('isLogin', true);
await prefs.setInt('count', 3);
await prefs.setDouble('volume', 0.8);
await prefs.setString('token', 'abc123');
await prefs.setStringList('history', ['flutter', 'dart']);
```

---

### ✅ 读数据（get）

```dart
bool isLogin = prefs.getBool('isLogin') ?? false;
int count = prefs.getInt('count') ?? 0;
double volume = prefs.getDouble('volume') ?? 1.0;
String token = prefs.getString('token') ?? '';
List<String> history = prefs.getStringList('history') ?? [];
```

⚠️ 一定要加 `?? 默认值`

---

### ✅ 删除

```dart
await prefs.remove('token');
```

---

### ✅ 清空（慎用）

```dart
await prefs.clear();
```

---

## 四、在 Widget 中正确使用（重点）

### ❌ 错误示范（新手常犯）

```dart
@override
void initState() {
  super.initState();
  final prefs = SharedPreferences.getInstance(); // ❌ 不是 await
}
```

---

### ✅ 正确写法

```dart
class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool('isLogin') ?? false;
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', true);
    setState(() {
      isLogin = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(isLogin ? '已登录' : '未登录'),
        ElevatedButton(
          onPressed: _save,
          child: const Text('登录'),
        ),
      ],
    );
  }
}
```

---

## 五、存对象怎么办？（必考）

### ❌ 不能直接存对象

```dart
prefs.setObject(user); // ❌ 没这个 API
```

---

### ✅ 正确方案：JSON

#### 1️⃣ Model

```dart
class User {
  final int id;
  final String name;

  User(this.id, this.name);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name']);
  }
}
```

---

#### 2️⃣ 存

```dart
import 'dart:convert';

final user = User(1, 'Tom');
prefs.setString('user', jsonEncode(user.toJson()));
```

---

#### 3️⃣ 取

```dart
final jsonStr = prefs.getString('user');
if (jsonStr != null) {
  final user = User.fromJson(jsonDecode(jsonStr));
}
```

👉 **面试答案模板**

> shared_preferences 不能存对象，一般通过 JSON 序列化为 String 存储

---

## 六、封装成工具类（强烈推荐）

### ✅ AppPreferences（企业级写法）

```dart
class AppPrefs {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isLogin => _prefs.getBool('isLogin') ?? false;

  static Future setLogin(bool value) =>
      _prefs.setBool('isLogin', value);

  static String get token => _prefs.getString('token') ?? '';

  static Future setToken(String value) =>
      _prefs.setString('token', value);

  static Future clear() => _prefs.clear();
}
```

### main.dart 初始化

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPrefs.init();
  runApp(const MyApp());
}
```

之后 anywhere 用：

```dart
if (AppPrefs.isLogin) {}
```

---

## 七、真实项目常见使用场景

### ✅ 1️⃣ 启动页 / 引导页

```dart
bool firstOpen = prefs.getBool('firstOpen') ?? true;
```

---

### ✅ 2️⃣ 登录态 + go_router 联动

```dart
redirect: (context, state) {
  if (!AppPrefs.isLogin) return '/login';
  return null;
}
```

---

### ✅ 3️⃣ 主题 / 深色模式

```dart
prefs.setBool('darkMode', true);
```

---

### ✅ 4️⃣ 搜索历史（List<String>）

```dart
prefs.setStringList('history', historyList);
```

---

## 八、shared_preferences vs 其他存储

| 方案                     | 用途         |
| ---------------------- | ---------- |
| shared_preferences     | 简单配置       |
| hive                   | 本地对象数据库    |
| sqflite                | 关系型数据库     |
| flutter_secure_storage | token / 密码 |

👉 **记住一句**：

> 简单用 SP，复杂用数据库，敏感用 secure

---

## 九、常见坑总结（很重要）

❗ 每次 `getInstance` 都是 async
❗ 一定要给默认值
❗ 不要存大对象
❗ Web 下数据存在 localStorage
❗ 不要在 build 里 await

---

## 十、一句话总结

> **shared_preferences 是 Flutter 项目里「必学必用」的本地存储方案**
> 小而稳，配合路由、状态管理，能解决 80% 本地数据需求。

---

如果你愿意，下一步我可以直接帮你做👇

* 🔹 **shared_preferences + go_router 登录态完整联动**
* 🔹 **对比 Hive / SecureStorage 怎么选**
* 🔹 **给你一个真实项目的本地存储设计方案**

你选一个，我直接写。
