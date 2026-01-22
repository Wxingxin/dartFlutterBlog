下面给你一份 Flutter 项目里 **Text 的“使用配置大全 + 常见场景”**，以“你在真实项目里会怎么写”为标准，配合可直接复制的经典代码片段。

---

## 1) Text 的核心：你真正需要掌握的参数

### 1.1 基本用法

```dart
Text('Hello Flutter');
```

### 1.2 style：字体/颜色/粗细/行高/字距/装饰

```dart
Text(
  '标题 Title',
  style: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Color(0xFF111827),
    height: 1.2,          // 行高倍数
    letterSpacing: 0.2,   // 字距
    decoration: TextDecoration.none,
  ),
);
```

### 1.3 maxLines + overflow：防止 UI 破版（列表/卡片必用）

```dart
Text(
  '这是一段很长很长的文案……',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
);
```

### 1.4 softWrap：是否换行（有时用于横向滚动区域）

```dart
Text(
  '不会自动换行的长字符串',
  softWrap: false,
  overflow: TextOverflow.fade,
);
```

### 1.5 textAlign：对齐

```dart
Text(
  '右对齐',
  textAlign: TextAlign.right,
);
```

### 1.6 textScaleFactor / MediaQuery：适配系统字体缩放

一般不建议“强行固定”，但有些 UI（徽标/按钮）会要求一致。

```dart
Text(
  '按钮文字',
  textScaler: const TextScaler.linear(1.0), // Flutter 3.13+ 推荐 textScaler
);
```

### 1.7 locale：多语言/不同地区排版差异

```dart
Text(
  '١٢٣', // 阿拉伯数字示意
  locale: const Locale('ar'),
);
```

### 1.8 strutStyle：保证多语言/不同字体行高一致（内容流产品很常用）

```dart
Text(
  '中英文混排 Text',
  strutStyle: const StrutStyle(
    fontSize: 14,
    height: 1.4,
    forceStrutHeight: true,
  ),
);
```

---

## 2) 经典场景与“项目级写法”

## 2.1 列表卡片：标题 + 摘要 + 时间（最常见）

```dart
class FeedCard extends StatelessWidget {
  final String title;
  final String content;
  final String time;

  const FeedCard({
    super.key,
    required this.title,
    required this.content,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
              color: Color(0xFF4B5563),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            time,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 2.2 “价格/重要数字”：等宽字体 + 对齐（电商/数据面板常用）

```dart
Text(
  '¥ 12,345.67',
  style: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontFeatures: [FontFeature.tabularFigures()], // 数字等宽，避免跳动
  ),
);
```

---

## 2.3 单行不够：自适应缩小（标题必须一行但不想省略）

用 `FittedBox`（注意：会整体缩放，适合短文本/徽标/金额）

```dart
SizedBox(
  width: 180,
  child: FittedBox(
    fit: BoxFit.scaleDown,
    alignment: Alignment.centerLeft,
    child: Text(
      '这是很长但必须一行显示的标题',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
  ),
);
```

---

## 2.4 富文本：部分高亮、点击链接（协议/评论/搜索高亮）

```dart
RichText(
  text: TextSpan(
    style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
    children: const [
      TextSpan(text: '我已阅读并同意 '),
      TextSpan(
        text: '《用户协议》',
        style: TextStyle(
          color: Color(0xFF2563EB),
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
      TextSpan(text: ' 和 '),
      TextSpan(
        text: '《隐私政策》',
        style: TextStyle(
          color: Color(0xFF2563EB),
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
        ),
      ),
    ],
  ),
);
```

如果你要“可点击链接”，要在 `TextSpan` 上挂 `TapGestureRecognizer`（项目里记得 dispose，通常用 StatefulWidget 或封装小组件）。

---

## 2.5 国际化：避免硬编码 + 文案长度变化（产品级必须考虑）

* 不要写死宽度（尤其是按钮/标题）
* 多用 `Expanded/Flexible` + `maxLines/ellipsis`
* 语言变长时仍能稳住布局

示例（按钮文案自动适配）：

```dart
Row(
  children: [
    Expanded(
      child: Text(
        'Continue with Apple / 使用 Apple 继续',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ),
  ],
);
```

---

## 3) 项目里“最推荐”的写法：统一管理 TextStyle

你不应该在每个 Text 上都写一长串 TextStyle；更推荐用 Theme 统一。

### 3.1 使用 Theme.of(context).textTheme

```dart
Text(
  '页面标题',
  style: Theme.of(context).textTheme.titleLarge,
);
```

### 3.2 自定义一套 AppText（更可控）

```dart
class AppText {
  static const title = TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
  static const body = TextStyle(fontSize: 14, height: 1.5);
  static const muted = TextStyle(fontSize: 12, color: Color(0xFF6B7280));
}
```

使用：

```dart
Text('标题', style: AppText.title);
Text('正文内容', style: AppText.body);
Text('次要信息', style: AppText.muted);
```

---

## 4) 常见坑位清单（你做项目一定会遇到）

1. **列表里不加 maxLines/ellipsis** → UI 直接撑爆
2. **中英文混排行高不一致** → 用 `height` 或 `StrutStyle` 统一
3. **数字金额跳动**（位数变化导致宽度变化）→ `FontFeature.tabularFigures()`
4. **强行固定 textScaler** → 可用但要谨慎（会影响无障碍体验）
5. **RichText 可点击忘记 dispose** → recognizer 需要释放（封装成组件最稳）

---

如果你愿意，我可以基于你现在的 UI 风格（你之前偏简约风）给你整理一套“可直接落地的 Typography 规范（title/body/caption/mono）+ 一个完整示例页面（列表、详情、按钮、表单）”，让 Text 的用法在你项目里形成统一标准。
-------------------------------
下面给你一份 **Flutter 中 `Text` 组件的属性与配置大全**，按**真实项目使用频率 + 可维护性**系统整理，适合作为长期查阅文档。

---

## 一、Text 最基础用法（认知入口）

```dart
Text(
  'Hello Flutter',
)
```

---

## 二、Text 核心属性大全（⭐⭐⭐⭐⭐）

### 1️⃣ 文本内容与样式（最核心）

| 属性                | 类型               | 说明     |
| ----------------- | ---------------- | ------ |
| `style`           | `TextStyle?`     | 文本样式集合 |
| `textAlign`       | `TextAlign?`     | 对齐方式   |
| `textDirection`   | `TextDirection?` | 文本方向   |
| `softWrap`        | `bool?`          | 是否自动换行 |
| `overflow`        | `TextOverflow?`  | 溢出处理   |
| `maxLines`        | `int?`           | 最大行数   |
| `textScaleFactor` | `double?`        | 文本缩放比例 |
| `semanticsLabel`  | `String?`        | 无障碍描述  |

---

### 2️⃣ TextStyle 详细属性大全（重点中的重点）

```dart
TextStyle(
  color: Colors.black,
  fontSize: 16,
)
```

| 分类   | 属性                | 说明      |
| ---- | ----------------- | ------- |
| 颜色   | `color`           | 字体颜色    |
| 字号   | `fontSize`        | 字体大小    |
| 字重   | `fontWeight`      | 字体粗细    |
| 字体   | `fontFamily`      | 字体名称    |
| 样式   | `fontStyle`       | 斜体      |
| 间距   | `letterSpacing`   | 字符间距    |
| 间距   | `wordSpacing`     | 单词间距    |
| 行高   | `height`          | 行高倍数    |
| 装饰   | `decoration`      | 下划线/删除线 |
| 装饰色  | `decorationColor` | 装饰颜色    |
| 装饰样式 | `decorationStyle` | 虚线/实线   |
| 阴影   | `shadows`         | 文字阴影    |
| 背景   | `background`      | 背景画刷    |

#### 字重常用值

```dart
FontWeight.w400 // 常规
FontWeight.w500 // 中等
FontWeight.w600 // 半粗
FontWeight.bold
```

---

### 3️⃣ 溢出 & 行数控制（列表必用）

```dart
Text(
  '超长文本',
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)
```

| TextOverflow | 效果     |
| ------------ | ------ |
| `ellipsis`   | 省略号    |
| `clip`       | 裁剪     |
| `fade`       | 渐隐     |
| `visible`    | 可见（慎用） |

---

### 4️⃣ 对齐方式

```dart
textAlign: TextAlign.center
```

| 值         | 说明   |
| --------- | ---- |
| `left`    | 左对齐  |
| `right`   | 右对齐  |
| `center`  | 居中   |
| `justify` | 两端对齐 |

---

## 三、富文本（TextSpan / RichText）

### 1️⃣ Text.rich（推荐）

```dart
Text.rich(
  TextSpan(
    text: '价格：',
    children: [
      TextSpan(
        text: '¥99',
        style: TextStyle(color: Colors.red),
      ),
    ],
  ),
)
```

📌 **优点**：继承 Text 的属性、易维护

---

### 2️⃣ RichText（更底层）

```dart
RichText(
  text: TextSpan(
    text: 'Hello ',
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(
        text: 'Flutter',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
)
```

---

## 四、文本方向 & 国际化相关

```dart
Text(
  'مرحبا',
  textDirection: TextDirection.rtl,
)
```

| 属性              | 说明        |
| --------------- | --------- |
| `textDirection` | RTL / LTR |
| `locale`        | 语言区域      |

---

## 五、无障碍（Accessibility）

```dart
Text(
  '关闭',
  semanticsLabel: '关闭按钮',
)
```

📌 屏幕阅读器会读 `semanticsLabel`

---

## 六、Text 与系统缩放（重要）

### ❗ 默认 Text 会随系统字体缩放

```dart
textScaleFactor: 1.0 // 固定
```

📌 **列表 / UI 密集区域**常设置为 `1.0`

---

## 七、常见实战场景

### 1️⃣ 单行标题

```dart
Text(
  title,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
)
```

---

### 2️⃣ 多行正文

```dart
Text(
  content,
  style: TextStyle(height: 1.6),
)
```

---

### 3️⃣ 标签 / Badge

```dart
Container(
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  child: Text(
    'NEW',
    style: TextStyle(fontSize: 12, color: Colors.white),
  ),
)
```

---

### 4️⃣ 点击文本（链接）

```dart
GestureDetector(
  onTap: () {},
  child: Text(
    '点击查看',
    style: TextStyle(color: Colors.blue),
  ),
)
```

---

## 八、Text 常见坑总结（经验）

| 问题     | 原因                 |
| ------ | ------------------ |
| 文本不换行  | 父容器宽度无限            |
| 行高异常   | `height` 设置不合理     |
| 富文本不生效 | style 未继承          |
| 字体无效   | 未配置 `pubspec.yaml` |

---

## 九、Text 的“最佳实践”（项目级）

### ✅ 封装统一样式

```dart
class AppTextStyle {
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
  static const body = TextStyle(fontSize: 14);
}
```

```dart
Text('标题', style: AppTextStyle.title)
```

---

## 十、你可以继续深入的方向（建议）

如果你愿意，我可以继续帮你：

1. **TextStyle 体系设计（类似 Material Theme）**
2. **多语言 + RTL 实战**
3. **自定义字体全流程**
4. **Flutter 排版原理（行高、baseline）**
5. **封装类似 RN 的 Text 组件**

你只需要选一个方向，我直接给你完整方案。
