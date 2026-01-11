

# 一、Flutter 网络请求的「底层认知」

在 Flutter / Dart 里：

* **网络请求 ≠ Flutter**
* 本质是 **Dart 的 HTTP 客户端**
* 一切请求都是 **异步 Future / Stream**

👉 Flutter 只是用这些数据来 **刷新 UI**



# 二、原生方案（必须懂）

## 1️⃣ `dart:io` → HttpClient（最底层）

### 适合谁？

* 想**彻底理解网络机制**
* 做 SDK / 底层封装 / 特殊协议

### 示例

```dart
import 'dart:io';
import 'dart:convert';

Future<void> fetchData() async {
  final client = HttpClient();
  final request = await client.getUrl(
    Uri.parse('https://api.example.com/data'),
  );
  final response = await request.close();

  final body = await response.transform(utf8.decoder).join();
  print(body);
}
```

### 特点

✅ 控制力最强
❌ 写法繁琐
❌ 日常开发**不推荐直接用**

👉 **理解即可，不是主力**

---

## 2️⃣ `http`（最常用 · 入门首选）

📦 包名：`http`

### 安装

```yaml
dependencies:
  http: ^1.2.0
```

---

### GET 请求

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> fetchData() async {
  final response = await http.get(
    Uri.parse('https://api.example.com/data'),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
  }
}
```

---

### POST（JSON）

```dart
await http.post(
  Uri.parse('https://api.example.com/login'),
  headers: {
    'Content-Type': 'application/json',
  },
  body: jsonEncode({
    'username': 'admin',
    'password': '123456',
  }),
);
```

---

### 特点

✅ 轻量
✅ 官方推荐
❌ 无拦截器
❌ 错误处理要自己写

👉 **学习网络请求的第一站**

---

# 三、进阶方案（企业级必学）

## 3️⃣ Dio ⭐⭐⭐⭐⭐（事实标准）

📦 包名：`dio`

### 为什么几乎所有 Flutter 项目都用 Dio？

| 功能       | Dio |
| -------- | --- |
| 拦截器      | ✅   |
| 请求取消     | ✅   |
| 超时       | ✅   |
| FormData | ✅   |
| 文件上传下载   | ✅   |
| 全局配置     | ✅   |

---

### 基础使用

```dart
final dio = Dio();

final response = await dio.get('https://api.example.com/data');
print(response.data);
```

---

### 全局配置

```dart
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.example.com',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 5),
    headers: {
      'Authorization': 'Bearer token',
    },
  ),
);
```

---

### 拦截器（核心）

```dart
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (options, handler) {
      print('请求: ${options.uri}');
      handler.next(options);
    },
    onResponse: (response, handler) {
      print('响应: ${response.data}');
      handler.next(response);
    },
    onError: (e, handler) {
      print('错误: ${e.message}');
      handler.next(e);
    },
  ),
);
```

---

### 文件上传

```dart
final formData = FormData.fromMap({
  'file': await MultipartFile.fromFile(path),
});

await dio.post('/upload', data: formData);
```

---

### 结论

> **Flutter 网络请求 = Dio**

---

# 四、声明式 / 架构型请求方式

## 4️⃣ Riverpod + 网络请求（推荐）

你之前就在学 **Riverpod**，这一步是**关键跃迁**。

---

### FutureProvider

```dart
final userProvider = FutureProvider((ref) async {
  final dio = Dio();
  final response = await dio.get('https://api.example.com/user');
  return response.data;
});
```

### UI 使用

```dart
ref.watch(userProvider).when(
  loading: () => CircularProgressIndicator(),
  error: (e, _) => Text('错误'),
  data: (data) => Text(data.toString()),
);
```

✅ loading
✅ error
✅ data
**全部自动管理**

---

## 5️⃣ Repository 模式（企业级）

### 网络层

```dart
class UserApi {
  final Dio dio;
  UserApi(this.dio);

  Future<User> getUser() async {
    final res = await dio.get('/user');
    return User.fromJson(res.data);
  }
}
```

### Repository

```dart
class UserRepository {
  final UserApi api;
  UserRepository(this.api);

  Future<User> fetchUser() => api.getUser();
}
```

👉 解耦 UI / 网络 / 数据

---

# 五、特殊场景请求方式

## 6️⃣ WebSocket（实时通信）

```dart
import 'dart:io';

final socket = await WebSocket.connect('wss://example.com/ws');
socket.listen((message) {
  print(message);
});
```

---

## 7️⃣ SSE（服务器推送）

* 用 Dio / http + Stream
* 用于 AI、日志流、推送

---

## 8️⃣ GraphQL

📦 `graphql_flutter`

```dart
Query(
  options: QueryOptions(
    document: gql('query { user { id name } }'),
  ),
  builder: (result, {fetchMore, refetch}) {
    if (result.isLoading) return CircularProgressIndicator();
    return Text(result.data.toString());
  },
);
```

---

# 六、Flutter 网络请求「正确学习路径」

### 第 1 阶段（必做）

* http
* Future / async / await
* JSON → Model

### 第 2 阶段（核心）

* Dio
* 拦截器
* 错误统一处理
* Token 管理

### 第 3 阶段（架构）

* Riverpod + FutureProvider
* Repository
* Clean Architecture

---

# 七、真实项目推荐组合（直接抄）

```txt
Dio
 + Interceptor
 + Model(fromJson)
 + Repository
 + Riverpod(FutureProvider / AsyncNotifier)
```

---

如果你愿意，下一步我可以直接帮你：

1️⃣ **用 Dio + Riverpod 写一个完整登录请求**
2️⃣ **封装一个 NetworkService（项目级）**
3️⃣ **错误码统一处理（401 自动跳登录）**

你选一个，我直接给你写「可复制进项目的版本」。
