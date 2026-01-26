在 Flutter 中，**设置 App 字体**主要分为「全局字体」和「局部字体」两大类。下面按**真实项目常用方式 + 原理层级**系统说明，便于你理解和查源码。

---

## 一、使用自定义字体（完整标准流程）

### 1️⃣ 准备字体文件

支持格式：

* `.ttf`
* `.otf`

示例结构（推荐）：

```text
project_root/
├─ assets/
│  └─ fonts/
│     ├─ Inter-Regular.ttf
│     ├─ Inter-Medium.ttf
│     └─ Inter-Bold.ttf
```

---

### 2️⃣ 在 `pubspec.yaml` 中声明字体

```yaml
flutter:
  assets:
    - assets/fonts/

  fonts:
    - family: Inter               # 字体家族名（后续使用这个名字）
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
          weight: 400             # 字重
        - asset: assets/fonts/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

📌 **关键点**

* `family` 是你在代码中使用的名字
* `weight` / `style` 用于自动匹配 `FontWeight`

---

## 二、全局设置字体（最常用）

### 方式 1：在 `ThemeData` 中设置（推荐）

```dart
MaterialApp(
  theme: ThemeData(
    fontFamily: 'Inter',           // 全局默认字体
  ),
  home: MyHomePage(),
);
```

✔️ 所有效果：

* Text
* AppBar title
* Button 文本
* 默认 Material 文本

都会使用该字体

---

### 方式 2：结合 `TextTheme` 精细控制（项目级）

```dart
MaterialApp(
  theme: ThemeData(
    fontFamily: 'Inter',
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontSize: 14),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ),
);
```

📌 适合：

* 设计稿有明确文字层级（H1 / Body / Caption）

---

## 三、局部设置字体（组件级）

### 1️⃣ 单个 Text 设置

```dart
Text(
  'Hello Flutter',
  style: TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
);
```

📌 优先级 **高于 Theme**

---

### 2️⃣ 使用 `DefaultTextStyle`（包裹一片区域）

```dart
DefaultTextStyle(
  style: const TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
  ),
  child: Column(
    children: [
      Text('文本一'),
      Text('文本二'),
    ],
  ),
);
```

---

## 四、Cupertino（iOS 风格）字体设置

```dart
CupertinoApp(
  theme: CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        fontFamily: 'Inter',
      ),
    ),
  ),
);
```

📌 注意：

* iOS 默认使用 **San Francisco**
* 自定义字体会覆盖系统字体

---

## 五、平台相关注意事项（非常重要）

### 📱 Android

* 无额外配置
* 字体文件会被打包进 APK / AAB

### 🍎 iOS

* Flutter 会自动处理
* **不需要**在 `Info.plist` 手动声明

### 🌐 Web

* 字体体积影响首屏加载
* 建议只引入必要字重

---

## 六、常见问题与坑点

### ❌ 字体不生效

检查：

1. `pubspec.yaml` 缩进是否正确
2. `family` 名字是否一致
3. 是否执行了：

```bash
flutter clean
flutter pub get
```

---

### ❌ FontWeight 不生效

原因：

* 没有声明对应 `weight` 的字体文件
* Flutter 会 fallback 到最接近的字重

---

## 七、系统字体 vs 自定义字体

### 使用系统字体（不引入文件）

```dart
ThemeData(
  fontFamily: null,   // 使用平台默认字体
);
```

平台默认：

* Android：Roboto
* iOS：San Francisco
* Web：浏览器默认

---

## 八、真实项目推荐方案（总结）

| 场景         | 推荐方式                    |
| ---------- | ----------------------- |
| 全 App 统一字体 | `ThemeData.fontFamily`  |
| 设计系统       | `ThemeData + TextTheme` |
| 局部特殊字体     | `TextStyle.fontFamily`  |
| 大段区域       | `DefaultTextStyle`      |
| iOS 原生风格   | `CupertinoThemeData`    |

---

如果你愿意，下一步我可以帮你：

* 设计一套 **Flutter 字体设计系统（H1 / Body / Caption）**
* 或结合 **Material 3 TextTheme 完整拆解**
* 或讲清楚 **Flutter 字体匹配 FontWeight 的内部机制**

你可以直接告诉我你现在是 **Material / Cupertino / Web / 多端统一** 的哪一种项目。
