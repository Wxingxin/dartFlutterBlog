下面给你一份 **Flutter CLI（命令行工具）完整大全**，我按**使用频率 + 学习路径 + 实战场景**来整理。
这份你可以直接当 **Flutter 命令行速查表 + 学习清单**。

---

# 🚀 Flutter CLI 命令大全（工程师级）

---

## 一、Flutter 环境 & 诊断（最先会）

### 1️⃣ `flutter doctor`（必会）

```bash
flutter doctor
flutter doctor -v
```

**作用**

* 检查 Flutter SDK
* Android / iOS / Web / Desktop 环境
* IDE、模拟器、依赖状态

📌 **第一条命令，没有之一**

---

### 2️⃣ `flutter --version`

```bash
flutter --version
```

查看：

* Flutter 版本
* Dart 版本
* Channel（stable / beta / dev）

---

### 3️⃣ Flutter Channel 管理

```bash
flutter channel
flutter channel stable
flutter upgrade
```

📌 建议：**长期用 stable**

---

## 二、项目创建 & 管理

### 4️⃣ 创建项目

```bash
flutter create my_app
```

常用参数：

```bash
flutter create -t app my_app       # 默认
flutter create -t package my_pkg   # 创建 Dart 包
flutter create -t plugin my_plugin # 创建插件
```

---

### 5️⃣ 指定平台创建（减少垃圾文件）

```bash
flutter create --platforms=android,ios my_app
flutter create --platforms=web my_web_app
```

---

### 6️⃣ 项目清理（解决 80% 的玄学问题）

```bash
flutter clean
```

作用：

* 删除 build 缓存
* 强制重新构建

📌 遇到怪问题 → **先 clean 再说**

---

## 三、依赖管理（pub）

### 7️⃣ 获取依赖

```bash
flutter pub get
```

---

### 8️⃣ 升级依赖

```bash
flutter pub upgrade
flutter pub upgrade --major-versions
```

---

### 9️⃣ 查看依赖树（排查冲突）

```bash
flutter pub deps
```

---

### 🔟 添加 / 删除依赖（推荐）

```bash
flutter pub add riverpod
flutter pub remove riverpod
```

比手改 `pubspec.yaml` 更安全

---

## 四、运行 & 调试（高频）

### 1️⃣1️⃣ 查看可用设备

```bash
flutter devices
```

---

### 1️⃣2️⃣ 运行项目

```bash
flutter run
```

指定设备：

```bash
flutter run -d chrome
flutter run -d emulator-5554
```

---

### 1️⃣3️⃣ 调试模式

```bash
flutter run --debug
flutter run --profile
flutter run --release
```

| 模式      | 用途   |
| ------- | ---- |
| debug   | 开发   |
| profile | 性能分析 |
| release | 发布   |

---

### 1️⃣4️⃣ 热重载 / 热重启（运行中）

```text
r  → hot reload
R  → hot restart
q  → quit
```

📌 **Flutter 核心体验**

---

## 五、构建 & 打包（上线必会）

### Android

```bash
flutter build apk
flutter build appbundle
```

---

### iOS（macOS）

```bash
flutter build ios
```

---

### Web

```bash
flutter build web
```

---

### Desktop

```bash
flutter build windows
flutter build macos
flutter build linux
```

---

## 六、测试相关

### 1️⃣5️⃣ 运行测试

```bash
flutter test
```

---

### 1️⃣6️⃣ 单个测试

```bash
flutter test test/widget_test.dart
```

---

### 1️⃣7️⃣ 覆盖率

```bash
flutter test --coverage
```

生成：

```text
coverage/lcov.info
```

---

## 七、代码质量 & 分析

### 1️⃣8️⃣ 静态分析（非常重要）

```bash
flutter analyze
```

📌 CI / 提交前必跑

---

### 1️⃣9️⃣ 格式化代码

```bash
flutter format .
```

---

### 2️⃣0️⃣ Dart fix（自动修复）

```bash
dart fix --apply
```

---

## 八、国际化 & 资源

### 2️⃣1️⃣ 生成国际化代码

```bash
flutter gen-l10n
```

---

### 2️⃣2️⃣ 生成资源索引（M3 推荐）

```bash
flutter gen-assets
```

---

## 九、Flutter 工具类命令（进阶）

### 2️⃣3️⃣ 查看 Flutter 配置

```bash
flutter config
flutter config --enable-web
```

---

### 2️⃣4️⃣ 模拟器管理

```bash
flutter emulators
flutter emulators --launch emulator_name
```

---

### 2️⃣5️⃣ 日志查看

```bash
flutter logs
```

---

## 十、Dart CLI（Flutter 必备搭档）

### Dart 运行

```bash
dart run
dart run build_runner build
```

---

### Dart 格式化 & 分析

```bash
dart format .
dart analyze
```

---

## 十一、Flutter + Riverpod / 代码生成

### build_runner

```bash
flutter pub run build_runner build
flutter pub run build_runner watch
flutter pub run build_runner build --delete-conflicting-outputs
```

📌 用于：

* riverpod_generator
* json_serializable
* freezed

---

## 十二、最常见问题速查

### ❓ 卡死 / 异常

```bash
flutter clean
flutter pub get
flutter run
```

---

### ❓ Android 编译失败

```bash
flutter doctor
flutter doctor --android-licenses
```

---

### ❓ 依赖冲突

```bash
flutter pub deps
```

---

## 🧠 推荐学习顺序（非常重要）

```
1️⃣ flutter doctor / run / devices
2️⃣ flutter pub get / add / upgrade
3️⃣ flutter run + 热重载
4️⃣ flutter build
5️⃣ flutter analyze / test
6️⃣ build_runner
```

---

## 📌 工程师建议（掏心窝子）

* **CLI 是 Flutter 的“真实入口”**
* IDE 只是 GUI 包装
* 会 CLI = 能解决 90% 环境 & 构建问题
* 面试高级 Flutter，CLI 是必问点

---

## 下一步我可以继续帮你：

1️⃣ **Flutter CLI + Riverpod 实战流程**
2️⃣ **Flutter 项目从 0 → 构建 → 发布完整 CLI 流程**
3️⃣ **Flutter CLI 常见报错 & 原因解析（踩坑合集）**
4️⃣ **Dart CLI vs Flutter CLI 的职责边界**

你选一个，我直接带你深入实战。
