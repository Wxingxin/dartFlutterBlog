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
