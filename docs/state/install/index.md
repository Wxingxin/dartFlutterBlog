在 Flutter 开发中，根据数据的复杂度、安全要求和大小，本地存储方案通常分为以下几类：**键值对存储、安全存储、非关系型数据库 (NoSQL)、关系型数据库 (SQL) 以及文件存储**。

以下是 Flutter 本地存储的“全家桶”对比与使用指南：

---

### 1. 轻量级键值对存储：`shared_preferences`

这是最常用的插件，用于存储少量的简单数据，如配置项、用户偏好设置、简单的标志位。

* **特点**：以 Key-Value 形式存储；支持基本类型（int, double, bool, String, StringList）。
* **底层**：Android 使用 `SharedPreferences`，iOS 使用 `NSUserDefaults`。
* **适用场景**：是否第一次启动 App、主题设置、记住账号。
* **代码示例**：
```dart
final prefs = await SharedPreferences.getInstance();
await prefs.setInt('counter', 10); // 写入
int? counter = prefs.getInt('counter'); // 读取

```



---

### 2. 安全存储：`flutter_secure_storage`

普通的存储在手机 Root/越狱后很容易被查看到。涉及敏感信息（如 Token、密码）必须使用加密存储。

* **特点**：数据加密存储。
* **底层**：Android 使用 **Keystore**，iOS 使用 **Keychain**。
* **适用场景**：登录 Token、用户私人 API 密钥、支付凭证。
* **代码示例**：
```dart
final storage = FlutterSecureStorage();
await storage.write(key: 'jwt_token', value: 'secret_value'); // 安全写入
String? token = await storage.read(key: 'jwt_token'); // 读取

```



---

### 3. 高性能 NoSQL 数据库：`Isar` / `Hive`

如果你的数据是对象形式（JSON），且不需要复杂的 SQL 关联查询，NoSQL 是性能最好的选择。

#### **Isar (目前官方最推荐)**

Isar 是 Hive 作者推出的下一代数据库，速度极快且功能强大。

* **优点**：支持索引、全文搜索、多线程、跨平台性能极佳。
* **适用场景**：大型离线缓存、复杂对象集合、消息列表。

#### **Hive**

* **优点**：纯 Dart 编写，无原生依赖（轻量），读写速度极快。
* **缺点**：目前处于维护状态，新项目建议直接上 Isar。

---

### 4. 关系型数据库 (SQL)：`sqflite` / `Drift`

当你需要处理复杂的关系（多表查询、事务、联表统计）时，SQL 是唯一的选择。

#### **sqflite**

* **特点**：标准的 SQLite 实现，需要自己写 SQL 语句。
* **适用场景**：传统业务逻辑、复杂关系数据。

#### **Drift (原名 Moor)**

* **特点**：在 `sqflite` 之上的高级封装，支持 **响应式编程**（数据变了 UI 自动更新）和 **类型安全**（不用手写 String SQL）。
* **适用场景**：中大型项目，对代码质量和类型安全有高要求的场景。

---

### 5. 原始文件存储：`path_provider`

当你需要直接保存图片、录音、视频或超大的文本文件时。

* **特点**：获取系统目录（临时目录、文档目录、外部存储）。
* **配合使用**：通常配合 `dart:io` 的 `File` 类使用。
* **代码示例**：
```dart
Directory appDocDir = await getApplicationDocumentsDirectory();
File file = File('${appDocDir.path}/my_file.txt');
await file.writeAsString('Hello Flutter'); // 写入文件内容

```



---

### 📊 方案对比总结表

| 方案 | 数据类型 | 查询能力 | 性能 | 安全性 | 推荐程度 |
| --- | --- | --- | --- | --- | --- |
| **shared_preferences** | 简单基本类型 | 极弱 | 一般 | 低 | ⭐⭐⭐⭐⭐ (基础配置) |
| **flutter_secure_storage** | 字符串 | 无 | 慢 (加密) | **极高** | ⭐⭐⭐⭐⭐ (Token必备) |
| **Isar** | 复杂对象 (NoSQL) | 强 (索引) | **极快** | 中 | ⭐⭐⭐⭐⭐ (离线数据首选) |
| **sqflite / Drift** | 关系表 (SQL) | **极强** | 快 | 中 | ⭐⭐⭐⭐ (复杂业务) |
| **path_provider** | 原始文件/媒体 | 取决于文件名 | 取决于IO | 低 | ⭐⭐⭐⭐ (存图/文件) |

---

### 💡 选型建议

1. **存个登录状态、主题颜色？** 选 `shared_preferences`。
2. **存登录后的 Token、API Key？** 选 `flutter_secure_storage`。
3. **存几十条/上百条新闻列表数据？** 选 `Isar`。
4. **存带有“作者-文章-评论”这种关联关系的数据？** 选 `Drift`。
5. **存用户下载的头像或大日志文件？** 选 `path_provider`。

**如果你正处于项目初期，建议直接学习 `Isar`，它能覆盖大部分中高级的本地存储需求，且性能优势巨大。**

# 

下面这份是**Flutter 本地存储「方法大全 + 选型指南 + 实战写法」**。
我会**从底层 → 常用 → 企业级**，并且告诉你 **什么时候用哪个，别乱选**。

---

# 一、Flutter 本地存储全景图（先给你方向感）

```txt
内存级（不落盘）
├─ 变量 / Provider / Riverpod

轻量键值（最多）
├─ SharedPreferences
├─ FlutterSecureStorage（加密）

文件级
├─ 文件读写（txt / json）
├─ path_provider

结构化数据库
├─ sqflite（SQLite）
├─ Drift（强烈推荐）
├─ Isar / Hive（NoSQL）

特殊
├─ MMKV（高性能）
```

---

# 二、内存级（不是“存储”，但必须理解）

## 1️⃣ 内存状态（变量 / Riverpod）

❗**App 关闭 = 数据丢失**

```dart
final counterProvider = StateProvider<int>((ref) => 0);
```

👉 适合：

* 页面状态
* 临时缓存
* 表单内容

---

# 三、轻量键值存储（80% 项目够用）

## 2️⃣ SharedPreferences（入门必学）

📦 `shared_preferences`

### 能存什么？

* `int`
* `double`
* `bool`
* `String`
* `List<String>`

### 使用

```dart
final prefs = await SharedPreferences.getInstance();

// 保存
await prefs.setString('token', 'abc');

// 读取
final token = prefs.getString('token');
```

### 适合

✅ 登录状态
✅ 首次启动标记
❌ 不适合大量数据

---

## 3️⃣ FlutterSecureStorage（安全存储 ⭐）

📦 `flutter_secure_storage`

👉 底层：

* iOS → Keychain
* Android → Keystore

### 使用

```dart
final storage = FlutterSecureStorage();

// 写
await storage.write(key: 'token', value: 'abc');

// 读
final token = await storage.read(key: 'token');
```

### 适合

🔐 token
🔐 密码
🔐 私密信息

❗**不要用 SharedPreferences 存 token**

---

# 四、文件存储（JSON / 文本）

## 4️⃣ path_provider + File

### 获取路径

```dart
final dir = await getApplicationDocumentsDirectory();
final file = File('${dir.path}/user.json');
```

### 写入

```dart
await file.writeAsString(jsonEncode(data));
```

### 读取

```dart
final content = await file.readAsString();
final json = jsonDecode(content);
```

### 适合

📁 导出文件
📁 大 JSON
📁 日志

---

# 五、数据库（结构化 / 大量数据）

## 5️⃣ sqflite（SQLite 原生）

📦 `sqflite`

### 建表

```dart
await db.execute('''
CREATE TABLE todo(
  id INTEGER PRIMARY KEY,
  title TEXT,
  done INTEGER
)
''');
```

### 查询

```dart
final list = await db.query('todo');
```

### 特点

✅ 成熟稳定
❌ SQL 手写
❌ 表结构变更麻烦

---

## 6️⃣ Drift ⭐⭐⭐⭐⭐（强烈推荐）

📦 `drift`

👉 本质：**类型安全的 SQLite**

### 表定义

```dart
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  BoolColumn get done => boolean().withDefault(const Constant(false))();
}
```

### 查询

```dart
final todos = await db.select(db.todos).get();
```

### 优点

✅ 自动迁移
✅ 类型安全
✅ 响应式查询

👉 **企业级首选**

---

# 六、NoSQL 本地数据库（简单粗暴）

## 7️⃣ Hive（轻量 NoSQL）

📦 `hive`

### 存储

```dart
final box = await Hive.openBox('settings');
box.put('theme', 'dark');
```

### 读取

```dart
final theme = box.get('theme');
```

### 适合

⚡ 配置
⚡ 本地缓存
❌ 复杂查询不行

---

## 8️⃣ Isar（性能怪兽）

📦 `isar`

👉 特点：

* 超快
* 强类型
* 类数据库

适合：

* 离线数据
* 大列表
* 搜索

---

# 七、极致性能方案

## 9️⃣ MMKV（微信同款）

📦 `flutter_mmkv`

👉 C++ 实现，**秒开**

适合：

* 高频读写
* 启动关键数据

---

# 八、真实项目选型（直接抄）

## 🔑 登录系统

```txt
Token → FlutterSecureStorage
UserInfo → Drift / Hive
```

---

## 📝 Todo / 笔记

```txt
Drift（结构化）
```

---

## ⚙️ 设置页

```txt
SharedPreferences / Hive
```

---

## 📦 离线缓存

```txt
Isar / Drift
```

---

# 九、结合 Riverpod 的「正确姿势」

```dart
final tokenProvider = FutureProvider<String?>((ref) async {
  final storage = FlutterSecureStorage();
  return storage.read(key: 'token');
});
```

---

# 十、学习路径（别乱学）

### 第 1 阶段

* SharedPreferences
* FlutterSecureStorage

### 第 2 阶段

* path_provider
* 文件读写

### 第 3 阶段

* Drift（重点）
* 数据迁移

---

## 最重要的一句话（送你）

> ❌ “什么都用 SharedPreferences”
> ✅ “按数据价值选存储方式”

---

如果你愿意，下一步我可以直接给你：

1️⃣ **用 Drift 写一个完整 Todo 本地数据库**
2️⃣ **本地存储 + Riverpod 持久化状态**
3️⃣ **登录系统（token 安全存储 + 自动登录）**

你选一个，我直接给你**项目级代码**。
