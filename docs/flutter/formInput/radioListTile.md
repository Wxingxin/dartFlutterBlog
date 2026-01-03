下面给你一份 **Flutter `RadioListTile` 的「知识点 + 使用大全」**，这是**单选场景里最常用、最推荐的组件**之一，真实项目里几乎不会手写 `Radio + Row`。
我会按 **概念 → 原理 → 属性 → 实战 → 对比 → 常见坑 → 面试总结** 来讲，偏实战、可直接当长期笔记用 👍

---

## 一、RadioListTile 是什么？

`RadioListTile` = **Radio + ListTile**

👉 官方提供的 **“带文字的单选项组件”**

**解决了什么问题？**

* 不用手写 `Row + Radio + Text`
* 点击整行即可选中
* 自带间距、动画、无障碍支持

📌 **一句话**

> 只要是“单选 + 文本列表”，优先用 `RadioListTile`

---

## 二、RadioListTile 的核心原理（面试必问 ⭐⭐⭐）

`RadioListTile` 的选中逻辑 **完全继承自 Radio**

```dart
value == groupValue → 选中
```

### 两个关键参数

* `value`：当前这一项代表的值
* `groupValue`：当前组选中的值

📌 **重点**

> RadioListTile 本身不存状态，
> 状态一定在外部（变量 / 状态管理）

---

## 三、最基础用法（必须会）

### 示例：性别选择

```dart
String _gender = 'male';

Column(
  children: [
    RadioListTile<String>(
      title: Text('男'),
      value: 'male',
      groupValue: _gender,
      onChanged: (value) {
        setState(() {
          _gender = value!;
        });
      },
    ),
    RadioListTile<String>(
      title: Text('女'),
      value: 'female',
      groupValue: _gender,
      onChanged: (value) {
        setState(() {
          _gender = value!;
        });
      },
    ),
  ],
)
```

📌 **关键点**

* 所有 RadioListTile **共享同一个 groupValue**
* 修改的是 `_gender`，不是某一个 RadioListTile

---

## 四、RadioListTile 的核心属性 ⭐⭐⭐⭐⭐

```dart
RadioListTile<String>(
  value: 'a',
  groupValue: 'a',
  onChanged: (value) {},
  title: Text('标题'),
  subtitle: Text('副标题'),
  secondary: Icon(Icons.info),
  controlAffinity: ListTileControlAffinity.leading,
  activeColor: Colors.blue,
  toggleable: false,
  dense: false,
)
```

---

## 五、属性详解（非常重要）

### 1️⃣ title / subtitle（文本）

```dart
title: Text('微信支付'),
subtitle: Text('推荐使用'),
```

📌 常用于设置页、支付页、配置页

---

### 2️⃣ secondary（图标）

```dart
secondary: Icon(Icons.payment),
```

📌 位置与 `controlAffinity` 相关

---

### 3️⃣ controlAffinity（Radio 位置）⭐⭐⭐

```dart
controlAffinity: ListTileControlAffinity.leading,
```

| 值        | 说明           |
| -------- | ------------ |
| leading  | Radio 在左     |
| trailing | Radio 在右（默认） |
| platform | 跟随平台规范       |

📌 **国内 App 多用 leading**

---

### 4️⃣ activeColor（选中颜色）

```dart
activeColor: Colors.green,
```

---

### 5️⃣ toggleable（是否可取消选中）

```dart
toggleable: true,
```

```dart
String? selected;

RadioListTile<String>(
  value: 'A',
  groupValue: selected,
  toggleable: true,
  onChanged: (value) {
    setState(() {
      selected = value;
    });
  },
)
```

📌 再点一次 → 取消选中
默认是 `false`

---

### 6️⃣ dense（紧凑布局）

```dart
dense: true,
```

📌 设置项很多时非常有用

---

## 六、RadioListTile vs Radio（面试高频）

| 对比     | Radio | RadioListTile |
| ------ | ----- | ------------- |
| 是否带文本  | ❌     | ✅             |
| 是否整行可点 | ❌     | ✅             |
| 是否封装布局 | ❌     | ✅             |
| 项目推荐   | ❌     | ✅             |

👉 **面试答案**

> RadioListTile 是 Radio 的业务级封装，更适合真实项目使用

---

## 七、动态单选列表（高频实战）

```dart
List<String> options = ['微信', '支付宝', '银行卡'];
String selected = '微信';

Column(
  children: options.map((item) {
    return RadioListTile<String>(
      title: Text(item),
      value: item,
      groupValue: selected,
      onChanged: (value) {
        setState(() {
          selected = value!;
        });
      },
    );
  }).toList(),
)
```

📌 **单选的本质**

* 任何时刻，只允许一个值等于 groupValue

---

## 八、RadioListTile + enum（强烈推荐 ⭐⭐⭐⭐⭐）

### 定义枚举

```dart
enum PayType { wechat, alipay, bank }
```

### 使用

```dart
PayType _pay = PayType.wechat;

RadioListTile<PayType>(
  title: Text('微信'),
  value: PayType.wechat,
  groupValue: _pay,
  onChanged: (value) {
    setState(() {
      _pay = value!;
    });
  },
)
```

📌 **优势**

* 类型安全
* 可维护性高
* 面试加分

---

## 九、在 ListView 中使用（注意 key）

```dart
ListView.builder(
  itemCount: options.length,
  itemBuilder: (context, index) {
    final item = options[index];
    return RadioListTile<String>(
      key: ValueKey(item),
      title: Text(item),
      value: item,
      groupValue: selected,
      onChanged: (value) {
        setState(() {
          selected = value!;
        });
      },
    );
  },
)
```

⚠️ 不加 `key` → 滑动时选中错乱

---

## 十、禁用 RadioListTile

```dart
RadioListTile(
  value: 'A',
  groupValue: selected,
  onChanged: null, // 置空即禁用
  title: Text('不可选'),
)
```

---

## 十一、RadioListTile 与状态管理

RadioListTile **非常适合做“状态驱动 UI”**

推荐搭配：

* Provider / Riverpod
* Bloc / Cubit
* GetX

👉 UI 只关心 `value / groupValue`

---

## 十二、常见坑（重点）⚠️

❌ groupValue 写死，导致点不动
❌ 每个 RadioListTile 用不同 groupValue
❌ 用 bool 做 Radio（Radio 更适合 enum / String）
❌ ListView 中没加 key
❌ 用 Radio + Row 重复造轮子

---

## 十三、典型使用场景总结

* 性别选择
* 支付方式
* 配送方式
* 设置页互斥选项
* 配置策略选择

---

## 十四、面试一句话总结（背下来）

> RadioListTile 是 Flutter 中用于“单选列表”的高阶组件，
> 通过 value 与 groupValue 的相等关系控制选中状态，
> 支持整行点击，更适合业务开发。

---

## 十五、你可以继续深入的方向 👇

如果你愿意，我可以继续给你系统整理：

* ✅ **Radio / Checkbox / Switch 三者深度对比**
* ✅ **RadioListTile + Form 表单校验**
* ✅ **Material 3 中 RadioListTile 样式变化**
* ✅ **封装一套企业级「选择组件库」**
* ✅ **选择组件常见面试题合集**

你直接选一个，我继续给你往下拆 🚀
