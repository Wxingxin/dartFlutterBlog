下面给你一份 Flutter 项目里 **TextSpan 的使用配置大全 + 典型业务场景**。重点是：你在真实项目里如何用 `TextSpan` 解决“部分高亮/可点击/混排/搜索命中”等需求，并且写法可直接复制。

---

## 1) TextSpan 是什么，和 Text / RichText 的关系

* `TextSpan`：**富文本片段**（不能单独渲染），只能放在 `Text.rich(...)` 或 `RichText` 的 `text:` 里。
* `Text`：普通文本（可传 `style/maxLines/overflow/...`）。
* `Text.rich(TextSpan(...))`：等价于 `RichText(text: TextSpan(...))`，但 `Text.rich` 更省事。

最常用入口：

```dart
Text.rich(
  TextSpan(
    text: 'Hello ',
    children: [
      TextSpan(text: 'Flutter', style: TextStyle(fontWeight: FontWeight.bold)),
    ],
  ),
);
```

---

## 2) TextSpan 配置参数大全（项目里最常用的）

### 2.1 text / children（基础拼接）

```dart
TextSpan(
  text: '前缀',
  children: [
    TextSpan(text: '高亮片段'),
    TextSpan(text: '后缀'),
  ],
)
```

### 2.2 style（片段级样式）

* **父 TextSpan 的 style 会被子 span 继承**，子 span 可覆盖部分属性。

```dart
Text.rich(
  TextSpan(
    style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
    children: const [
      TextSpan(text: '普通文字 '),
      TextSpan(
        text: '强调',
        style: TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF2563EB)),
      ),
    ],
  ),
);
```

### 2.3 recognizer（点击交互：协议、@用户、#话题、链接）

> 注意：`TapGestureRecognizer` 需要 `dispose`，因此通常用 `StatefulWidget` 封装。

### 2.4 semanticsLabel（无障碍读屏文本）

当视觉文本被拆成很多 span 时，可用 `semanticsLabel` 提供更友好的朗读文本。

```dart
TextSpan(
  text: '¥',
  semanticsLabel: '人民币符号',
)
```

### 2.5 locale / spellOut / 其它

`TextSpan` 本身没有 `maxLines/overflow`；这些属于 `Text/RichText`。

---

## 3) 经典场景 1：用户协议/隐私政策（可点击链接）

这是最常见的 `TextSpan + recognizer` 业务。

```dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AgreementText extends StatefulWidget {
  const AgreementText({super.key});

  @override
  State<AgreementText> createState() => _AgreementTextState();
}

class _AgreementTextState extends State<AgreementText> {
  late final TapGestureRecognizer _userAgreementTap;
  late final TapGestureRecognizer _privacyTap;

  @override
  void initState() {
    super.initState();
    _userAgreementTap = TapGestureRecognizer()
      ..onTap = () {
        // TODO: 跳转到用户协议页面
        debugPrint('Open User Agreement');
      };

    _privacyTap = TapGestureRecognizer()
      ..onTap = () {
        // TODO: 跳转到隐私政策页面
        debugPrint('Open Privacy Policy');
      };
  }

  @override
  void dispose() {
    _userAgreementTap.dispose();
    _privacyTap.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;
    const linkStyle = TextStyle(
      color: Color(0xFF2563EB),
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
    );

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          const TextSpan(text: '我已阅读并同意 '),
          TextSpan(
            text: '《用户协议》',
            style: linkStyle,
            recognizer: _userAgreementTap,
          ),
          const TextSpan(text: ' 和 '),
          TextSpan(
            text: '《隐私政策》',
            style: linkStyle,
            recognizer: _privacyTap,
          ),
        ],
      ),
    );
  }
}
```

项目建议：

* 这类富文本强烈建议做成小组件，避免 recognizer 泄漏。
* 如果是外链，通常会配合 `url_launcher` 打开浏览器（你需要时我可以给你一份封装版本）。

---

## 4) 经典场景 2：@用户、#话题、URL 自动识别并可点击（类似 X/微博）

核心做法：**解析字符串 → 生成 spans**。下面给一个“可复制”的简化版（用正则）。

```dart
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ParsedRichText extends StatelessWidget {
  final String text;
  final void Function(String user)? onUserTap;
  final void Function(String tag)? onTagTap;
  final void Function(String url)? onUrlTap;

  const ParsedRichText({
    super.key,
    required this.text,
    this.onUserTap,
    this.onTagTap,
    this.onUrlTap,
  });

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyMedium ??
        const TextStyle(fontSize: 14, height: 1.4);

    const linkStyle = TextStyle(
      color: Color(0xFF2563EB),
      fontWeight: FontWeight.w600,
    );

    final spans = _buildSpans(text, base, linkStyle);

    return Text.rich(
      TextSpan(style: base, children: spans),
    );
  }

  List<InlineSpan> _buildSpans(String input, TextStyle base, TextStyle link) {
    // 匹配：@xxx、#xxx、http(s)://...
    final pattern = RegExp(r'(@\w+)|(#\w+)|(https?:\/\/[^\s]+)');
    final matches = pattern.allMatches(input).toList();

    if (matches.isEmpty) return [TextSpan(text: input)];

    final spans = <InlineSpan>[];
    int lastIndex = 0;

    for (final m in matches) {
      if (m.start > lastIndex) {
        spans.add(TextSpan(text: input.substring(lastIndex, m.start)));
      }

      final token = input.substring(m.start, m.end);

      if (token.startsWith('@')) {
        spans.add(
          TextSpan(
            text: token,
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onUserTap?.call(token.substring(1)),
          ),
        );
      } else if (token.startsWith('#')) {
        spans.add(
          TextSpan(
            text: token,
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onTagTap?.call(token.substring(1)),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: token,
            style: link,
            recognizer: TapGestureRecognizer()
              ..onTap = () => onUrlTap?.call(token),
          ),
        );
      }

      lastIndex = m.end;
    }

    if (lastIndex < input.length) {
      spans.add(TextSpan(text: input.substring(lastIndex)));
    }

    return spans;
  }
}
```

重要说明（项目级注意点）：

* 这里为了演示，每次 build 会创建 recognizer；严格来说更推荐封装 StatefulWidget 或用更成熟的富文本解析库以避免频繁创建对象。
* 如果你要“可控性能 + 安全释放”，我可以给你一个 `StatefulWidget` 版本，把 recognizer 缓存并在 dispose 统一释放。

---

## 5) 经典场景 3：搜索关键字高亮（列表筛选/全文检索）

```dart
TextSpan highlightKeyword({
  required String text,
  required String keyword,
  required TextStyle baseStyle,
  required TextStyle highlightStyle,
}) {
  if (keyword.isEmpty) return TextSpan(text: text, style: baseStyle);

  final lowerText = text.toLowerCase();
  final lowerKey = keyword.toLowerCase();

  final spans = <TextSpan>[];
  int start = 0;

  while (true) {
    final index = lowerText.indexOf(lowerKey, start);
    if (index < 0) {
      spans.add(TextSpan(text: text.substring(start), style: baseStyle));
      break;
    }

    if (index > start) {
      spans.add(TextSpan(text: text.substring(start, index), style: baseStyle));
    }

    spans.add(TextSpan(
      text: text.substring(index, index + keyword.length),
      style: highlightStyle,
    ));

    start = index + keyword.length;
  }

  return TextSpan(children: spans);
}

// 使用：
Text.rich(
  highlightKeyword(
    text: 'Flutter TextSpan 搜索高亮示例',
    keyword: 'TextSpan',
    baseStyle: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
    highlightStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      backgroundColor: Color(0xFFFFF3C4),
    ),
  ),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
);
```

---

## 6) 经典场景 4：混合样式（价格、单位、折扣、删除线）

```dart
Text.rich(
  TextSpan(
    style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
    children: const [
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

## 7) 关键限制与最佳实践（决定你代码质量的点）

1. **maxLines / overflow 属于 Text/RichText，不属于 TextSpan**

```dart
Text.rich(
  TextSpan(children: [...]),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
);
```

2. **recognizer 需要释放**

* 少量固定链接：用 `StatefulWidget` 缓存 recognizer（如协议示例）。
* 大量动态解析：更建议用成熟库或封装管理，避免 build 时无节制创建。

3. **样式继承要“父 style 设好”**
   父 span 给 baseStyle，子 span 只覆盖差异字段，维护成本最低。

4. **无障碍/读屏**
   拆得很碎时，考虑 `semanticsLabel` 或把外层 `RichText` 放到更可理解的语义结构里。

---

如果你告诉我你更偏向哪类场景（协议链接、@/#/URL 解析、搜索高亮、还是电商价格混排），我可以把对应那一块升级成“项目级封装组件”：

* 带主题（TextTheme）
* 可选点击回调
* recognizer 生命周期安全
* 性能更稳（避免重复创建）
