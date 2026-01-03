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
