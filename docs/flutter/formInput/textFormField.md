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
------------------------------------------------
这个组件**必须吃透**。
`TextFormField` 几乎承包了 Flutter 里 **90% 的表单输入场景**，你后面做登录、注册、搜索、资料编辑，全靠它。

下面我给你一份 **「实战级 · 全属性分类大全」**，不是简单罗列，而是告诉你：

* 🧠 这个属性**解决什么问题**
* 📌 **什么时候该用**
* ⚠️ **常见坑**

---

# 一、最核心（必背 ⭐⭐⭐⭐⭐）

## 1️⃣ `controller`

```dart
final controller = TextEditingController();

TextFormField(
  controller: controller,
);
```

作用：

* 获取 / 设置输入内容
* 与业务逻辑强绑定

📌 什么时候用？

* 登录表单
* 编辑已有数据

⚠️ 记得 `dispose()`

---

## 2️⃣ `initialValue`

```dart
TextFormField(
  initialValue: '默认值',
);
```

📌 注意 **和 controller 不能共存**

| 用途    | 选哪个          |
| ----- | ------------ |
| 静态初始值 | initialValue |
| 动态控制  | controller   |

---

## 3️⃣ `onChanged`

```dart
onChanged: (value) {
  print(value);
},
```

用途：

* 实时监听输入
* 搜索 / 表单联动

---

## 4️⃣ `validator`（表单灵魂）

```dart
validator: (value) {
  if (value == null || value.isEmpty) {
    return '不能为空';
  }
  return null;
},
```

* 返回 `String` → 错误
* 返回 `null` → 通过

---

## 5️⃣ `onSaved`

```dart
onSaved: (value) {
  formData['username'] = value;
},
```

📌 只在：

```dart
_formKey.currentState!.save();
```

时触发

---

# 二、输入行为控制（非常常用 ⭐⭐⭐⭐）

## 6️⃣ `keyboardType`

```dart
keyboardType: TextInputType.emailAddress,
```

常见值：

| 类型           | 场景 |
| ------------ | -- |
| text         | 默认 |
| number       | 数字 |
| phone        | 手机 |
| emailAddress | 邮箱 |
| url          | 链接 |

---

## 7️⃣ `textInputAction`

```dart
textInputAction: TextInputAction.next,
```

📌 控制键盘右下角按钮

| 值      | 效果  |
| ------ | --- |
| next   | 下一项 |
| done   | 完成  |
| search | 搜索  |

---

## 8️⃣ `obscureText`（密码）

```dart
obscureText: true,
```

📌 常配：

```dart
enableSuggestions: false,
autocorrect: false,
```

---

## 9️⃣ `maxLines / minLines`

```dart
maxLines: 5,
minLines: 3,
```

📌 多行输入（textarea）

---

## 🔟 `maxLength`

```dart
maxLength: 20,
```

⚠️ 默认会显示计数器
关闭计数器：

```dart
counterText: '',
```

---

# 三、样式 & 装饰（最复杂也最常用 ⭐⭐⭐⭐⭐）

## 1️⃣1️⃣ `decoration: InputDecoration`

这是 **80% 样式的入口**

```dart
decoration: InputDecoration(
  labelText: '用户名',
  hintText: '请输入用户名',
  prefixIcon: Icon(Icons.person),
  border: OutlineInputBorder(),
),
```

### 常用子属性速查

| 属性         | 作用   |
| ---------- | ---- |
| labelText  | 浮动标签 |
| hintText   | 占位提示 |
| helperText | 辅助说明 |
| errorText  | 手动错误 |
| prefixIcon | 前置图标 |
| suffixIcon | 后置图标 |
| border     | 边框   |
| filled     | 填充背景 |
| fillColor  | 背景色  |

---

### 常见边框类型

```dart
border: OutlineInputBorder(),
enabledBorder: OutlineInputBorder(),
focusedBorder: OutlineInputBorder(),
errorBorder: OutlineInputBorder(),
```

📌 **真实项目一定会配 `focusedBorder`**

---

## 1️⃣2️⃣ `style`

```dart
style: TextStyle(
  fontSize: 16,
  color: Colors.black,
),
```

控制 **输入文字样式**

---

# 四、交互 & 焦点控制（中高级 ⭐⭐⭐）

## 1️⃣3️⃣ `focusNode`

```dart
final focusNode = FocusNode();

TextFormField(
  focusNode: focusNode,
);
```

用途：

* 手动聚焦
* 表单自动跳转

---

## 1️⃣4️⃣ `readOnly`

```dart
readOnly: true,
```

📌 常用于：

* 时间选择
* 地址选择（点开弹窗）

---

## 1️⃣5️⃣ `enabled`

```dart
enabled: false,
```

* 禁用输入
* 样式会变灰

---

# 五、输入限制（高级但很重要 ⭐⭐⭐⭐）

## 1️⃣6️⃣ `inputFormatters`

```dart
inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(6),
],
```

📌 常见场景：

* 验证码
* 金额
* 手机号

---

## 1️⃣7️⃣ `autovalidateMode`

```dart
autovalidateMode: AutovalidateMode.onUserInteraction,
```

| 模式                | 行为    |
| ----------------- | ----- |
| disabled          | 默认    |
| always            | 一直校验  |
| onUserInteraction | 输入后校验 |

---

# 六、光标 & 选择（少见但有用）

## 1️⃣8️⃣ `cursorColor`

```dart
cursorColor: Colors.red,
```

---

## 1️⃣9️⃣ `textAlign`

```dart
textAlign: TextAlign.center,
```

---

## 2️⃣0️⃣ `textCapitalization`

```dart
textCapitalization: TextCapitalization.sentences,
```

---

# 七、完整高质量实战配置（你可以直接用）

```dart
TextFormField(
  controller: usernameController,
  keyboardType: TextInputType.emailAddress,
  textInputAction: TextInputAction.next,
  autovalidateMode: AutovalidateMode.onUserInteraction,
  decoration: InputDecoration(
    labelText: '邮箱',
    hintText: 'example@email.com',
    prefixIcon: Icon(Icons.email),
    border: OutlineInputBorder(),
  ),
  validator: (v) {
    if (v == null || v.isEmpty) return '不能为空';
    if (!v.contains('@')) return '邮箱格式不正确';
    return null;
  },
);
```

---

# 八、你现在该怎么记（给你直白建议）

❌ 不要死记全部属性
✅ **按使用频率记**

### 第一梯队（必须熟）

* controller
* validator
* decoration
* keyboardType
* obscureText
* onChanged

### 第二梯队（项目必用）

* inputFormatters
* autovalidateMode
* focusNode
* maxLines

---

如果你愿意，下一步我可以帮你：

* 🔥 手写一个 **“和 Web 表单体验一致” 的 Flutter Form 封装**
* 🔥 **TextFormField + 状态管理（Bloc / Riverpod）最佳实践**
* 🔥 常见 **表单反模式 & 踩坑合集**

你说下一步学哪一个，我直接带你上强度。
