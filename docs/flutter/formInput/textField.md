下面给你一份**Flutter 中 `TextField` 的「知识点 + 使用大全」**，偏**实战型**，你可以直接当笔记或查表用 👍
（我会从**基础 → 常用属性 → 进阶 → 表单/校验 → 常见坑**一步一步来）

---

## 一、TextField 是什么？

`TextField` 是 **Flutter 中最常用的文本输入组件**，用于：

* 输入文字（账号、密码、搜索）
* 数字输入（手机号、验证码）
* 多行文本（备注、评论）
* 自定义输入（只允许数字、限制长度等）

📌 **特点**

* 即时输入（不像 `TextFormField` 自带校验）
* 高度可定制（样式、行为、键盘、事件）
* 常和 `TextEditingController` 搭配使用

---

## 二、最基础用法

```dart
TextField()
```

最简单，但几乎不会这样用 😅
一般至少会配点提示文字。

```dart
TextField(
  decoration: InputDecoration(
    hintText: '请输入用户名',
  ),
)
```

---

## 三、核心三件套（必须掌握）

### 1️⃣ TextEditingController（控制器）

👉 **用于获取 / 设置输入内容**

```dart
final TextEditingController _controller = TextEditingController();

TextField(
  controller: _controller,
)
```

获取内容：

```dart
print(_controller.text);
```

设置内容：

```dart
_controller.text = "Hello";
```

⚠️ **记得释放**

```dart
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}
```

---

### 2️⃣ onChanged / onSubmitted（输入回调）

```dart
TextField(
  onChanged: (value) {
    print("实时输入：$value");
  },
  onSubmitted: (value) {
    print("点击完成：$value");
  },
)
```

* `onChanged`：**每次输入都会触发**
* `onSubmitted`：点击键盘「完成 / 搜索」触发

---

### 3️⃣ decoration（样式入口）

几乎 **90% 的 UI 都在这里**

```dart
TextField(
  decoration: InputDecoration(
    labelText: '用户名',
    hintText: '请输入用户名',
    prefixIcon: Icon(Icons.person),
    border: OutlineInputBorder(),
  ),
)
```

---

## 四、InputDecoration 常用属性大全 ⭐⭐⭐

```dart
InputDecoration(
  labelText: '账号',
  hintText: '请输入账号',
  helperText: '6-20 位字符',
  errorText: '账号不能为空',

  prefixIcon: Icon(Icons.person),
  suffixIcon: Icon(Icons.clear),

  border: OutlineInputBorder(),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
  ),
)
```

| 属性            | 作用    |
| ------------- | ----- |
| labelText     | 浮动标签  |
| hintText      | 占位提示  |
| helperText    | 辅助说明  |
| errorText     | 错误提示  |
| prefixIcon    | 前缀图标  |
| suffixIcon    | 后缀图标  |
| border        | 默认边框  |
| enabledBorder | 未聚焦边框 |
| focusedBorder | 聚焦边框  |

---

## 五、常见输入类型（键盘控制）

### 1️⃣ 普通文本

```dart
keyboardType: TextInputType.text
```

### 2️⃣ 数字

```dart
keyboardType: TextInputType.number
```

### 3️⃣ 手机号

```dart
keyboardType: TextInputType.phone
```

### 4️⃣ 邮箱

```dart
keyboardType: TextInputType.emailAddress
```

---

## 六、密码输入（高频）

```dart
bool _obscure = true;

TextField(
  obscureText: _obscure,
  decoration: InputDecoration(
    labelText: '密码',
    suffixIcon: IconButton(
      icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
      onPressed: () {
        setState(() {
          _obscure = !_obscure;
        });
      },
    ),
  ),
)
```

📌 关键属性：

* `obscureText: true`
* 自定义 `suffixIcon` 切换可见性

---

## 七、多行文本（备注 / 评论）

```dart
TextField(
  maxLines: 5,
  minLines: 3,
)
```

或：

```dart
TextField(
  keyboardType: TextInputType.multiline,
  maxLines: null,
)
```

---

## 八、输入限制（非常重要）

### 1️⃣ 最大长度

```dart
TextField(
  maxLength: 11,
)
```

隐藏计数器：

```dart
counterText: ""
```

---

### 2️⃣ 只允许数字（InputFormatter）

```dart
inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
]
```

---

### 3️⃣ 正则限制（如手机号）

```dart
inputFormatters: [
  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
]
```

---

## 九、焦点控制（FocusNode）

```dart
FocusNode _focusNode = FocusNode();

TextField(
  focusNode: _focusNode,
)
```

获取焦点：

```dart
_focusNode.requestFocus();
```

取消焦点（收起键盘）：

```dart
_focusNode.unfocus();
```

📌 **常用于**

* 自动聚焦
* 点击空白处收起键盘

---

## 十、样式相关（字体 / 光标）

```dart
TextField(
  style: TextStyle(
    fontSize: 16,
    color: Colors.black,
  ),
  cursorColor: Colors.red,
  cursorWidth: 2,
)
```

---

## 十一、禁用 / 只读

### 禁用（不可输入）

```dart
enabled: false
```

### 只读（可选中）

```dart
readOnly: true
```

---

## 十二、TextField vs TextFormField ⭐⭐⭐

| 对比        | TextField | TextFormField |
| --------- | --------- | ------------- |
| 是否支持校验    | ❌         | ✅             |
| 是否用于表单    | ❌         | ✅             |
| 是否需要 Form | ❌         | ✅             |
| 使用场景      | 简单输入      | 登录 / 注册       |

👉 **有校验需求 → 用 `TextFormField`**

---

## 十三、常见错误 & 坑

❌ 忘记 dispose controller
❌ 在 `build` 里 new Controller
❌ `maxLines` + `obscureText` 同时用
❌ 表单校验还用 TextField

---

## 十四、常见实战模板（登录输入框）

```dart
TextField(
  controller: _controller,
  keyboardType: TextInputType.emailAddress,
  decoration: InputDecoration(
    labelText: '邮箱',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
)
```

---

## 十五、一句话总结（面试可用）

> TextField 是 Flutter 中最基础、最灵活的输入组件，
> 核心是 **Controller + Decoration + 输入控制**，
> 校验场景通常使用 `TextFormField`。

---

如果你愿意，下一步我可以帮你：

* ✅ **按功能分类（登录 / 搜索 / 表单）封装 TextField**
* ✅ **对比 Material / Cupertino TextField**
* ✅ **TextField 常见面试题**
* ✅ **自己封装一个通用 Input 组件**

你选一个 👇
-----------------------------
下面按 **Flutter 官方 `TextField` 构造函数源码顺序** 给你整理 **TextField 参数大全**，**不改结构**，并且 **每个参数后直接写中文注释**，方便你 **对照源码 / IDE 跳转学习**。

> 说明
>
> * 基于 `flutter/material.dart` 中的 `TextField`
> * 顺序严格贴近官方构造函数
> * 注释偏向「源码语义 + 实战理解」，不是简单翻译

---

## TextField 构造函数（源码结构 + 中文注释）

```dart
const TextField({
  Key? key, // widget 唯一标识，用于 widget 树更新和 diff

  TextEditingController? controller, // 文本控制器，用于读取 / 设置输入内容
  FocusNode? focusNode, // 焦点控制节点，用于控制获取/失去焦点

  InputDecoration? decoration = const InputDecoration(), // 输入框装饰（边框、label、hint、错误提示等）

  TextInputType? keyboardType, // 键盘类型（文本、数字、邮箱、电话等）
  TextInputAction? textInputAction, // 键盘右下角动作按钮类型（done / next / search 等）
  TextCapitalization textCapitalization = TextCapitalization.none, // 文本自动大写规则

  TextStyle? style, // 输入文字样式
  StrutStyle? strutStyle, // 行高结构样式（高级排版控制）

  TextAlign textAlign = TextAlign.start, // 文本对齐方式
  TextAlignVertical? textAlignVertical, // 垂直方向对齐方式（center 常用于高度固定输入框）

  TextDirection? textDirection, // 文本方向（LTR / RTL）

  bool readOnly = false, // 是否只读（不可编辑，但可选中、可获取焦点）
  bool? showCursor, // 是否显示光标
  bool autofocus = false, // 是否自动获取焦点
  bool obscureText = false, // 是否隐藏文本（密码输入）
  bool autocorrect = true, // 是否启用自动纠错
  SmartDashesType? smartDashesType, // 智能破折号处理（iOS 风格）
  SmartQuotesType? smartQuotesType, // 智能引号处理（iOS 风格）
  bool enableSuggestions = true, // 是否启用输入建议

  int? maxLines = 1, // 最大行数（1 = 单行，null = 无限行）
  int? minLines, // 最小行数
  bool expands = false, // 是否填满父容器高度（与 maxLines/minLines 互斥）

  int? maxLength, // 最大输入长度
  MaxLengthEnforcement? maxLengthEnforcement, // 最大长度限制策略

  ValueChanged<String>? onChanged, // 文本变化回调（每次输入都会触发）
  VoidCallback? onEditingComplete, // 编辑完成回调（点完成/失去焦点）
  ValueChanged<String>? onSubmitted, // 提交回调（点击键盘 action）

  List<TextInputFormatter>? inputFormatters, // 输入格式化器（限制字符、过滤、格式化）

  bool? enabled, // 是否启用输入框（false 会禁用交互）
  double cursorWidth = 2.0, // 光标宽度
  double? cursorHeight, // 光标高度
  Radius? cursorRadius, // 光标圆角
  Color? cursorColor, // 光标颜色
  Brightness? keyboardAppearance, // 键盘明暗主题（iOS）

  EdgeInsets scrollPadding = const EdgeInsets.all(20.0), // 自动滚动时的内边距（避免被键盘遮挡）
  bool enableInteractiveSelection = true, // 是否允许复制/粘贴/选择

  TextSelectionControls? selectionControls, // 文本选择控制器（自定义复制粘贴菜单）

  ScrollPhysics? scrollPhysics, // 滚动物理效果（多行时生效）
  Iterable<String>? autofillHints, // 自动填充提示（账号、邮箱、手机号等）

  Clip clipBehavior = Clip.hardEdge, // 裁剪行为（影响溢出内容）

  String? restorationId, // 状态恢复 ID（页面恢复时使用）

  bool scribbleEnabled = true, // iPad 手写输入支持

  bool enableIMEPersonalizedLearning = true, // 是否允许输入法学习用户输入（隐私相关）
})
```

---

## 参数重点分组理解（源码级）

### 一、控制类（最核心）

* `controller`
* `focusNode`
* `onChanged`
* `onSubmitted`

👉 **决定你如何“拿到数据 & 控制输入框”**

---

### 二、外观 & 装饰（Material 风格）

* `decoration`
* `style`
* `textAlign`
* `cursorColor`
* `cursorWidth`

👉 **90% UI 定制都在 `InputDecoration`**

---

### 三、输入行为 & 键盘

* `keyboardType`
* `textInputAction`
* `obscureText`
* `autocorrect`
* `enableSuggestions`

👉 **移动端体验的核心**

---

### 四、多行 & 布局

* `maxLines`
* `minLines`
* `expands`
* `scrollPhysics`

👉 **评论框 / 聊天输入框必用**

---

### 五、长度 & 格式

* `maxLength`
* `maxLengthEnforcement`
* `inputFormatters`

👉 **手机号 / 验证码 / 金额输入**

---

## 源码级常见组合（理解用）

### 密码输入框

```dart
TextField(
  obscureText: true,
  enableSuggestions: false,
  autocorrect: false,
)
```

### 多行文本域

```dart
TextField(
  maxLines: null,
  minLines: 3,
  keyboardType: TextInputType.multiline,
)
```

### 受控输入

```dart
TextField(
  controller: _controller,
  onChanged: (value) {
    // 实时同步状态
  },
)
```

---

## 一句话总结（架构级）

> **TextField 是“最低层输入组件”**
>
> * 不负责校验
> * 不负责保存
> * 只负责“输入 + 交互”
>
> **Form / TextFormField 才是完整表单体系**

---

如果你接下来想继续深入，我可以直接给你整理：

* `TextFormField` 参数大全（对照 TextField 差异）
* `InputDecoration` 参数大全（真正的 UI 核心）
* Flutter 输入框 **企业级封装方案**

你直接说下一个要哪一个即可。
--------------------------------
下面按 **Flutter 官方 `TextFormField` 构造函数源码顺序** 整理 **TextFormField 参数大全**，**不改结构**，并且 **每个参数后直接写中文注释**，方便你 **对照源码 / IDE 跳转学习**。

> 说明
>
> * 基于 `flutter/material.dart`
> * 顺序严格贴近官方构造函数
> * 本质：`TextFormField = FormField<String> + TextField`
> * 多出来的参数主要是 **表单相关（校验 / 保存 / 初始值）**

---

## TextFormField 构造函数（源码结构 + 中文注释）

```dart
TextFormField({
  Key? key, // widget 唯一标识，用于 widget 树 diff 和重建

  TextEditingController? controller, // 文本控制器（存在时 initialValue 必须为 null）
  String? initialValue, // 初始文本值（仅在 controller 为 null 时使用）

  FocusNode? focusNode, // 焦点控制节点
  InputDecoration? decoration = const InputDecoration(), // 输入框装饰（边框、label、hint、错误提示等）

  TextInputType? keyboardType, // 键盘类型（文本、数字、邮箱等）
  TextInputAction? textInputAction, // 键盘 action（done / next / search）
  TextCapitalization textCapitalization = TextCapitalization.none, // 文本大小写规则

  TextStyle? style, // 输入文本样式
  StrutStyle? strutStyle, // 行高结构样式（高级排版控制）

  TextAlign textAlign = TextAlign.start, // 文本水平对齐
  TextAlignVertical? textAlignVertical, // 文本垂直对齐

  TextDirection? textDirection, // 文本方向（LTR / RTL）

  bool autofocus = false, // 是否自动获取焦点
  bool readOnly = false, // 是否只读（不可编辑但可选中）
  bool? showCursor, // 是否显示光标
  bool obscureText = false, // 是否隐藏文本（密码）
  bool autocorrect = true, // 是否启用自动纠错
  SmartDashesType? smartDashesType, // 智能破折号（iOS）
  SmartQuotesType? smartQuotesType, // 智能引号（iOS）
  bool enableSuggestions = true, // 是否启用输入建议

  int? maxLines = 1, // 最大行数（1 单行，null 无限）
  int? minLines, // 最小行数
  bool expands = false, // 是否填满父容器高度（与 maxLines/minLines 互斥）

  int? maxLength, // 最大输入长度
  MaxLengthEnforcement? maxLengthEnforcement, // 最大长度限制策略

  ValueChanged<String>? onChanged, // 文本变化回调（同时会触发 Form.onChanged）
  GestureTapCallback? onTap, // 点击输入框回调
  VoidCallback? onEditingComplete, // 编辑完成回调
  ValueChanged<String>? onFieldSubmitted, // 提交回调（键盘 action 触发）
  FormFieldSetter<String>? onSaved, // 表单保存时调用（FormState.save）

  FormFieldValidator<String>? validator, // 表单字段校验函数（返回错误字符串）

  List<TextInputFormatter>? inputFormatters, // 输入格式化器（限制/过滤/格式化）

  bool? enabled, // 是否启用输入框
  double cursorWidth = 2.0, // 光标宽度
  double? cursorHeight, // 光标高度
  Radius? cursorRadius, // 光标圆角
  Color? cursorColor, // 光标颜色
  Brightness? keyboardAppearance, // 键盘明暗主题（iOS）

  EdgeInsets scrollPadding = const EdgeInsets.all(20.0), // 自动滚动时预留边距
  bool enableInteractiveSelection = true, // 是否允许复制/粘贴/选择

  TextSelectionControls? selectionControls, // 自定义文本选择菜单

  ScrollPhysics? scrollPhysics, // 多行文本滚动物理效果
  Iterable<String>? autofillHints, // 自动填充提示（邮箱、手机号等）

  AutovalidateMode? autovalidateMode, // 自动校验模式（禁用 / 总是 / 用户交互后）

  ScrollController? scrollController, // 内部滚动控制器（多行时）

  String? restorationId, // 状态恢复 ID

  bool enableIMEPersonalizedLearning = true, // 是否允许输入法学习用户输入（隐私相关）

  bool? enableInteractiveSelection, // 是否允许文本交互选择（部分版本存在）
})
```

> ⚠️ 注
> 不同 Flutter 版本中，**少量参数位置或是否存在会略有差异**（如 `enableInteractiveSelection` 重复问题），但整体结构与语义一致，**适合对照源码学习**。

---

## TextFormField 比 TextField 多出来的「表单核心参数」

```dart
initialValue   // 表单字段初始值（controller 为空时）
validator      // 校验逻辑（返回错误文本）
onSaved        // 表单保存时回调
autovalidateMode // 自动校验模式
```

👉 这些参数 **来自 FormField<String>**

---

## 核心源码逻辑一句话理解

> **TextFormField = FormField<String> 包了一层 TextField**

* TextField：负责输入、键盘、交互
* FormField：负责校验、保存、重置、状态管理

---

## 典型 Form 场景（理解用）

```dart
Form(
  key: _formKey,
  child: TextFormField(
    decoration: const InputDecoration(labelText: '邮箱'),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '不能为空';
      }
      return null;
    },
    onSaved: (value) {
      email = value!;
    },
  ),
);
```

---

## 一句话总结（面试 / 架构级）

> * **TextField**：自由输入
> * **TextFormField**：表单字段（校验 + 保存 + 状态）
> * **Form**：字段协调器

---

如果你下一步想继续「源码级」系统化学习，我可以继续给你整理：

* `FormField<T>` 参数大全（真正的表单抽象）
* `InputDecoration` 参数大全（UI 定制核心）
* Flutter 表单 **企业级封装设计**

你直接说下一个即可。
