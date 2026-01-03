下面给你一份 **Flutter `TextFormField`「知识点 + 使用大全」**，这是 **登录 / 注册 / 表单场景的核心组件**。
风格依然偏 **实战 + 可直接复用 + 面试友好**，你可以当长期笔记来用 👍

---

## 一、TextFormField 是什么？

`TextFormField` = **`TextField` + 表单能力**

👉 本质上是 **`FormField<String>` 的一个实现**

**核心能力：**

* 表单校验（`validator`）
* 统一保存 / 重置（`FormState`）
* 表单级管理（`Form`）

📌 **一句话**

> 有“校验 / 提交 / 表单”的地方，一定用 `TextFormField`

---

## 二、基本结构（必须记住）

```dart
Form(
  key: _formKey,
  child: TextFormField(),
)
```

### 完整最小示例

```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: TextFormField(
    decoration: InputDecoration(
      labelText: '用户名',
    ),
  ),
)
```

---

## 三、最核心的 4 个属性 ⭐⭐⭐⭐⭐

### 1️⃣ validator —— 表单校验（灵魂）

```dart
TextFormField(
  validator: (value) {
    if (value == null || value.isEmpty) {
      return '不能为空';
    }
    return null; // 校验通过
  },
)
```

📌 规则：

* 返回 `String` → 显示错误
* 返回 `null` → 校验通过

---

### 2️⃣ FormState.validate()

```dart
if (_formKey.currentState!.validate()) {
  print("校验通过");
}
```

👉 会 **触发所有 TextFormField 的 validator**

---

### 3️⃣ onSaved —— 保存表单值

```dart
String? username;

TextFormField(
  onSaved: (value) {
    username = value;
  },
)
```

调用保存：

```dart
_formKey.currentState!.save();
```

📌 常用于 **一次性提交**

---

### 4️⃣ controller —— 获取 / 设置值

```dart
TextEditingController _controller = TextEditingController();

TextFormField(
  controller: _controller,
)
```

📌 实战建议：

* **简单表单** → `onSaved`
* **需要实时值** → `controller`

---

## 四、完整登录表单（高频模板）⭐⭐⭐⭐⭐

```dart
final _formKey = GlobalKey<FormState>();
final _userCtrl = TextEditingController();
final _pwdCtrl = TextEditingController();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _userCtrl,
        decoration: InputDecoration(
          labelText: '用户名',
          prefixIcon: Icon(Icons.person),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '请输入用户名';
          }
          return null;
        },
      ),

      SizedBox(height: 16),

      TextFormField(
        controller: _pwdCtrl,
        obscureText: true,
        decoration: InputDecoration(
          labelText: '密码',
          prefixIcon: Icon(Icons.lock),
        ),
        validator: (value) {
          if (value == null || value.length < 6) {
            return '密码至少 6 位';
          }
          return null;
        },
      ),

      ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            print(_userCtrl.text);
            print(_pwdCtrl.text);
          }
        },
        child: Text('登录'),
      ),
    ],
  ),
);
```

---

## 五、InputDecoration（和 TextField 完全一样）

`TextFormField` **100% 支持** `InputDecoration`

```dart
decoration: InputDecoration(
  labelText: '邮箱',
  hintText: '请输入邮箱',
  errorStyle: TextStyle(color: Colors.red),
  border: OutlineInputBorder(),
)
```

---

## 六、常见校验写法合集（直接用）

### 1️⃣ 非空校验

```dart
(value) => value!.isEmpty ? '不能为空' : null
```

---

### 2️⃣ 长度校验

```dart
(value) {
  if (value == null || value.length < 6) {
    return '至少 6 位';
  }
  return null;
}
```

---

### 3️⃣ 邮箱校验（正则）

```dart
(value) {
  final emailReg = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailReg.hasMatch(value!)) {
    return '邮箱格式不正确';
  }
  return null;
}
```

---

### 4️⃣ 手机号校验（中国）

```dart
(value) {
  if (!RegExp(r'^1[3-9]\d{9}$').hasMatch(value!)) {
    return '手机号格式错误';
  }
  return null;
}
```

---

## 七、自动校验模式（Autovalidate）

```dart
autovalidateMode: AutovalidateMode.onUserInteraction,
```

模式说明：

| 模式                | 说明           |
| ----------------- | ------------ |
| disabled          | 不自动校验        |
| always            | 一直校验         |
| onUserInteraction | 用户输入后校验（最常用） |

---

## 八、密码输入（带显示/隐藏）

```dart
bool _obscure = true;

TextFormField(
  obscureText: _obscure,
  decoration: InputDecoration(
    labelText: '密码',
    suffixIcon: IconButton(
      icon: Icon(
        _obscure ? Icons.visibility_off : Icons.visibility,
      ),
      onPressed: () {
        setState(() {
          _obscure = !_obscure;
        });
      },
    ),
  ),
)
```

---

## 九、输入限制（Formatter）

```dart
inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
],
maxLength: 11,
```

---

## 十、FocusNode（表单跳转焦点）

```dart
FocusNode _userFocus = FocusNode();
FocusNode _pwdFocus = FocusNode();

TextFormField(
  focusNode: _userFocus,
  onFieldSubmitted: (_) {
    FocusScope.of(context).requestFocus(_pwdFocus);
  },
)
```

📌 **登录页体验必备**

---

## 十一、Form 的常用方法

```dart
_formKey.currentState!.validate(); // 校验
_formKey.currentState!.save();     // 保存
_formKey.currentState!.reset();    // 重置
```

---

## 十二、TextFormField vs TextField ⭐⭐⭐

| 对比        | TextFormField | TextField |
| --------- | ------------- | --------- |
| 表单校验      | ✅             | ❌         |
| Form 管理   | ✅             | ❌         |
| validator | ✅             | ❌         |
| onSaved   | ✅             | ❌         |
| 使用场景      | 表单            | 即时输入      |

👉 **面试答案**

> 有校验一定用 `TextFormField`

---

## 十三、常见坑（重点）

❌ 忘了用 `Form` 包裹
❌ validator 返回 `false`（必须返回 String/null）
❌ controller + onSaved 混用逻辑混乱
❌ 在 build 里 new controller

---

## 十四、封装建议（真实项目）

> 项目中 **几乎都会二次封装**

```dart
class AppTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;

  const AppTextFormField({
    required this.label,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
```

---

## 十五、一句话总结（面试 + 总结）

> TextFormField 是 Flutter 表单体系的核心组件，
> 依赖 Form 统一管理，
> 通过 validator + FormState 实现输入校验与提交。

---

如果你愿意，我可以继续帮你：

* ✅ **封装一个「企业级表单组件」**
* ✅ **TextFormField 面试题大全**
* ✅ **Form + Provider / Bloc 表单管理**
* ✅ **Material vs Cupertino 表单差异**

你选一个，我继续给你深挖 👇
