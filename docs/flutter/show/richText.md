下面给你一份 Flutter 项目里 **RichText 的使用配置大全 + 高频业务场景**。我会按“你在真实项目里怎么用、怎么封装、怎么避坑”的标准给出经典代码。

---

## 1) RichText 是什么，什么时候用它

* `RichText` 用于渲染 **多样式/多片段** 的文本（由 `InlineSpan` 树组成，最常见是 `TextSpan`）。
* 如果只是“简单富文本”，优先用 `Text.rich(TextSpan(...))`，API 更简洁。
* 当你需要更底层控制（比如 `textAlign/textDirection/locale/softWrap/overflow/maxLines/strutStyle/textScaler/selection` 等）或与布局/性能结合更紧密时，用 `RichText`。

最基础写法：

```dart
RichText(
  text: const TextSpan(
    text: 'Hello ',
    style: TextStyle(fontSize: 14, color: Color(0xFF111827)),
    children: [
      TextSpan(
        text: 'Flutter',
        style: TextStyle(fontWeight: FontWeight.w700),
      ),
    ],
  ),
);
```

---

## 2) RichText 配置参数大全（项目里常用且“容易忽略”）

> 注意：这些参数属于 `RichText`（或 `Text`），不是 `TextSpan`。

### 2.1 text（必填）：InlineSpan 树

```dart
text: TextSpan(...)
```

### 2.2 textAlign：对齐

```dart
textAlign: TextAlign.center,
```

### 2.3 maxLines + overflow：防止撑爆（列表卡片必用）

```dart
maxLines: 2,
overflow: TextOverflow.ellipsis,
```

### 2.4 softWrap：是否自动换行

```dart
softWrap: true,
```

### 2.5 textScaler：系统字体缩放适配（更推荐 Flutter 3.13+）

```dart
textScaler: MediaQuery.textScalerOf(context),
```

### 2.6 strutStyle：强制行高一致（中英文混排/多字体）

```dart
strutStyle: const StrutStyle(
  fontSize: 14,
  height: 1.4,
  forceStrutHeight: true,
),
```

### 2.7 textDirection：RTL/LTR（阿语/希伯来语）

```dart
textDirection: TextDirection.ltr,
```

### 2.8 locale：区域语言影响排版

```dart
locale: const Locale('zh', 'CN'),
```

---

## 3) 经典场景 1：协议/隐私政策（可点击富文本）

业务最典型：部分可点击 + 下划线 + 跳转。

```dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AgreementRichText extends StatefulWidget {
  const AgreementRichText({super.key});

  @override
  State<AgreementRichText> createState() => _AgreementRichTextState();
}

class _AgreementRichTextState extends State<AgreementRichText> {
  late final TapGestureRecognizer _tapUser;
  late final TapGestureRecognizer _tapPrivacy;

  @override
  void initState() {
    super.initState();
    _tapUser = TapGestureRecognizer()..onTap = () => debugPrint('Open User Agreement');
    _tapPrivacy = TapGestureRecognizer()..onTap = () => debugPrint('Open Privacy Policy');
  }

  @override
  void dispose() {
    _tapUser.dispose();
    _tapPrivacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium ??
        const TextStyle(fontSize: 14, height: 1.4, color: Color(0xFF111827));

    const linkStyle = TextStyle(
      color: Color(0xFF2563EB),
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    );

    return RichText(
      textScaler: MediaQuery.textScalerOf(context),
      text: TextSpan(
        style: base,
        children: [
          const TextSpan(text: '我已阅读并同意 '),
          TextSpan(text: '《用户协议》', style: linkStyle, recognizer: _tapUser),
          const TextSpan(text: ' 和 '),
          TextSpan(text: '《隐私政策》', style: linkStyle, recognizer: _tapPrivacy),
        ],
      ),
    );
  }
}
```

要点：

* recognizer 必须 `dispose()`，因此建议封装成组件。
* `textScaler` 走系统缩放，避免无障碍被破坏。

---

## 4) 经典场景 2：价格/单位/删除线/优惠标签（电商类）

```dart
RichText(
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
  text: const TextSpan(
    style: TextStyle(fontSize: 14, color: Color(0xFF111827)),
    children: [
      TextSpan(text: '到手价 '),
      TextSpan(
        text: '¥199',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      TextSpan(text: '  '),
      TextSpan(
        text: '¥299',
        style: TextStyle(
          color: Color(0xFF9CA3AF),
          decoration: TextDecoration.lineThrough,
        ),
      ),
      TextSpan(text: '  '),
      TextSpan(
        text: '限时优惠',
        style: TextStyle(color: Color(0xFFDC2626), fontWeight: FontWeight.w700),
      ),
    ],
  ),
);
```

---

## 5) 经典场景 3：搜索关键字高亮（列表筛选/全文检索）

把“命中词”切分成多个 span。

```dart
TextSpan buildHighlightSpan({
  required String text,
  required String keyword,
  required TextStyle base,
  required TextStyle highlight,
}) {
  if (keyword.isEmpty) return TextSpan(text: text, style: base);

  final lowerText = text.toLowerCase();
  final lowerKey = keyword.toLowerCase();

  final spans = <TextSpan>[];
  int start = 0;

  while (true) {
    final index = lowerText.indexOf(lowerKey, start);
    if (index < 0) {
      spans.add(TextSpan(text: text.substring(start), style: base));
      break;
    }

    if (index > start) {
      spans.add(TextSpan(text: text.substring(start, index), style: base));
    }

    spans.add(TextSpan(
      text: text.substring(index, index + keyword.length),
      style: highlight,
    ));

    start = index + keyword.length;
  }

  return TextSpan(children: spans);
}

// 使用：
RichText(
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  text: buildHighlightSpan(
    text: 'Flutter RichText 搜索高亮示例',
    keyword: 'RichText',
    base: const TextStyle(fontSize: 14, color: Color(0xFF111827), height: 1.4),
    highlight: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      backgroundColor: Color(0xFFFFF3C4),
    ),
  ),
);
```

---

## 6) 经典场景 4：@用户 / #话题 / URL 自动解析并可点击（社交内容）

核心思路：解析字符串 -> 生成 spans；点击回调交给外部。

> 这里给的是“可复制演示版”。严谨的项目实现建议把 recognizer 生命周期集中管理（我可以继续给你封装版）。

```dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SocialRichText extends StatelessWidget {
  final String text;
  final void Function(String user)? onUserTap;
  final void Function(String tag)? onTagTap;
  final void Function(String url)? onUrlTap;

  const SocialRichText({
    super.key,
    required this.text,
    this.onUserTap,
    this.onTagTap,
    this.onUrlTap,
  });

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium ??
        const TextStyle(fontSize: 14, height: 1.4, color: Color(0xFF111827));

    const link = TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.w600);

    return RichText(
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(style: base, children: _parse(text, link)),
    );
  }

  List<InlineSpan> _parse(String input, TextStyle linkStyle) {
    final reg = RegExp(r'(@\w+)|(#\w+)|(https?:\/\/[^\s]+)');
    final matches = reg.allMatches(input).toList();
    if (matches.isEmpty) return [TextSpan(text: input)];

    final spans = <InlineSpan>[];
    var last = 0;

    for (final m in matches) {
      if (m.start > last) {
        spans.add(TextSpan(text: input.substring(last, m.start)));
      }

      final token = input.substring(m.start, m.end);

      if (token.startsWith('@')) {
        spans.add(TextSpan(
          text: token,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onUserTap?.call(token.substring(1)),
        ));
      } else if (token.startsWith('#')) {
        spans.add(TextSpan(
          text: token,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onTagTap?.call(token.substring(1)),
        ));
      } else {
        spans.add(TextSpan(
          text: token,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () => onUrlTap?.call(token),
        ));
      }

      last = m.end;
    }

    if (last < input.length) {
      spans.add(TextSpan(text: input.substring(last)));
    }

    return spans;
  }
}
```

---

## 7) 经典场景 5：一个组件里复用 RichText（推荐封装：避免散落）

把“富文本拼装”做成可复用函数/组件，便于统一样式与逻辑：

```dart
RichText buildCountText({
  required int count,
  required String unit,
}) {
  return RichText(
    text: TextSpan(
      style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
      children: [
        TextSpan(
          text: '$count',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        TextSpan(text: ' $unit'),
      ],
    ),
  );
}
```

---

## 8) RichText 常见坑位与最佳实践（很关键）

1. **maxLines/overflow 要写在 RichText 上**，不是 TextSpan
2. **点击 span 需要 recognizer，且需要 dispose**（固定链接用 Stateful；动态大量解析建议更成熟封装/库）
3. **多语言/字体混排行高不一致**：用 `strutStyle` 或统一 `TextStyle.height`
4. **别在每个 span 都写完整 style**：父 `TextSpan(style: base)`，子 span 只写差异项
5. **长列表性能**：避免在 `build()` 里频繁 new recognizer（尤其列表滚动），可做缓存或改为更轻量实现

---

如果你现在的项目更偏“社交/聊天内容”（你前面在做 RN 聊天组件），我建议你下一步做两个封装，我可以直接给你：

1. `AppRichTextLinks`：解析 @/#/URL，点击回调 + 安全释放 recognizer
2. `HighlightRichText`：搜索/命中词高亮，支持多关键词与大小写策略

你告诉我你更需要哪一个，我就按“可直接复制进项目”的结构给你完整文件组织与用法。
