
## 0）先确认环境

```bash
dart --version
dart --help
dart help <command>
```

查看 SDK 路径（有时排错用）：

```bash
dart info
```

---

## 1）创建项目（最常用）

### 1.1 创建 Dart 应用（命令行/控制台）

```bash
dart create my_app
cd my_app
```

指定模板（不同版本 SDK 模板略有差异，但常见是这些）：

```bash
dart create -t console my_console_app
dart create -t package my_package
dart create -t server-shelf my_server
```

查看可用模板：

```bash
dart create --list-templates
```

---

## 2）运行项目 / 执行脚本

### 2.1 运行入口文件

```bash
dart run
```

等价于运行 `bin/<project>.dart`（大多数模板）

指定文件：

```bash
dart run bin/main.dart
```

带参数：

```bash
dart run bin/main.dart --port=8080
```

### 2.2 运行 package 的可执行脚本

例如一些工具包提供可执行命令：

```bash
dart run build_runner build
dart run test
```

---

## 3）依赖管理（pub）

Dart 的包管理器是 **pub**，现在常用写法是 `dart pub ...`

### 3.1 拉取依赖（安装）

```bash
dart pub get
```

### 3.2 升级依赖（按约束升级）

```bash
dart pub upgrade
```

升级到最新可能破坏版本（不推荐随便用）：

```bash
dart pub upgrade --major-versions
```

### 3.3 添加/移除依赖（非常常用）

添加普通依赖：

```bash
dart pub add http
```

添加开发依赖：

```bash
dart pub add --dev test
```

指定版本：

```bash
dart pub add http:^1.2.0
```

移除：

```bash
dart pub remove http
```

### 3.4 查看依赖树 / 解决冲突

```bash
dart pub deps
dart pub deps --style=compact
dart pub outdated
```

### 3.5 清理缓存（排查“包下载坏了”）

```bash
dart pub cache repair
```

---

## 4）代码质量：格式化 / 静态分析 / 修复

### 4.1 格式化（dart format）

格式化整个项目：

```bash
dart format .
```

只格式化某个目录/文件：

```bash
dart format lib test bin
```

检查是否需要格式化（CI 常用）：

```bash
dart format --output=none --set-exit-if-changed .
```

### 4.2 静态分析（dart analyze）

```bash
dart analyze
```

分析指定路径：

```bash
dart analyze lib
```

> `analysis_options.yaml` 会控制 lints（很关键）

### 4.3 自动修复（dart fix）

预览可修复项：

```bash
dart fix --dry-run
```

应用修复：

```bash
dart fix --apply
```

---

## 5）测试（dart test）

前提：`dev_dependencies` 里有 `test`

运行测试：

```bash
dart test
```

运行单个文件：

```bash
dart test test/foo_test.dart
```

按名字筛选（用例名包含关键字）：

```bash
dart test -n "should"
```

生成覆盖率（需要配合 coverage 工具链，视你项目而定）

---

## 6）编译 / 发布（原生可执行文件）

Dart CLI 程序可以编译成 **原生可执行文件**（Windows/macOS/Linux）

### 6.1 编译成可执行文件（推荐）

```bash
dart compile exe bin/main.dart -o build/app
```

Windows 例子：

```bash
dart compile exe bin/main.dart -o build/app.exe
```

### 6.2 编译成 AOT 快照（更底层）

```bash
dart compile aot-snapshot bin/main.dart -o build/app.aot
```

---

## 7）全局激活工具（相当于“安装命令”）

安装全局工具（例如 `webdev`、`melos` 等）：

```bash
dart pub global activate melos
```

指定版本：

```bash
dart pub global activate melos 6.2.0
```

运行全局命令（如果 PATH 没配好可用这个方式）：

```bash
dart pub global run melos --version
```

查看全局激活列表：

```bash
dart pub global list
```

> 建议把 `~/.pub-cache/bin` 加到 PATH（否则全局命令找不到）

---

## 8）文档 / 其它实用命令

生成 API 文档（需要 `dartdoc`）：

```bash
dart pub global activate dartdoc
dartdoc
```

---

## 9）Flutter 项目里也常用到的 Dart 命令（你会经常混用）

Flutter 项目同样可以用：

```bash
dart format .
dart analyze
dart pub get
dart pub add <pkg>
```

但运行/构建一般用 `flutter run / flutter build ...`

---

# 你最该背下来的“高频 10 条”

```bash
dart --version
dart create <name>
dart run
dart pub get
dart pub add <pkg>
dart pub add --dev <pkg>
dart pub outdated
dart format .
dart analyze
dart test
```

