下面给你一份 **Flutter `CheckboxListTile` 的「知识点 + 使用大全」**，这是**最常用、最推荐**的 Checkbox 组合组件之一，真实项目里出现频率非常高。
我会按 **是什么 → 怎么用 → 属性 → 实战 → 常见坑 → 面试总结** 来讲，偏实战、可直接当笔记用 👍

---

## 一、CheckboxListTile 是什么？

`CheckboxListTile` = **Checkbox + ListTile**

👉 官方封装好的「**带文本的复选框行组件**」

**解决了什么问题？**

* 不用自己 `Row + Checkbox + Text`
* 点击整行即可切换选中
* 自带无障碍、间距、点击反馈

📌 **一句话**

> 只要是“复选框 + 文本”，优先用 `CheckboxListTile`

---

## 二、最基础用法（必须会）

```dart
bool _checked = false;

CheckboxListTile(
  value: _checked,
  onChanged: (value) {
    setState(() {
      _checked = value!;
    });
  },
  title: Text('我已阅读并同意用户协议'),
);
```

### 核心点

* `value`：当前选中状态
* `onChanged`：状态变化
* `title`：主文本
* **点击整行都会触发 onChanged**

---

## 三、CheckboxListTile 的核心属性 ⭐⭐⭐⭐⭐

```dart
CheckboxListTile(
  value: true,
  onChanged: (value) {},
  title: Text('标题'),
  subtitle: Text('副标题'),
  secondary: Icon(Icons.info),
  controlAffinity: ListTileControlAffinity.leading,
  activeColor: Colors.blue,
  checkColor: Colors.white,
  tristate: false,
  dense: false,
)
```

---

## 四、属性详解（非常重要）

### 1️⃣ title / subtitle

```dart
title: Text('开启通知'),
subtitle: Text('接收系统消息推送'),
```

📌 使用场景：

* 设置页
* 配置说明

---

### 2️⃣ secondary（左/右侧图标）

```dart
secondary: Icon(Icons.notifications),
```

📌 位置由 `controlAffinity` 决定

---

### 3️⃣ controlAffinity（复选框位置）⭐⭐⭐

```dart
controlAffinity: ListTileControlAffinity.leading,
```

| 值        | 说明              |
| -------- | --------------- |
| leading  | Checkbox 在左     |
| trailing | Checkbox 在右（默认） |
| platform | 跟随平台规范          |

📌 **国内 App 常用 leading**

---

### 4️⃣ activeColor / checkColor（样式）

```dart
activeColor: Colors.green,
checkColor: Colors.white,
```

---

### 5️⃣ tristate（三态复选框）

```dart
bool? value;

CheckboxListTile(
  value: value,
  tristate: true,
  onChanged: (v) {
    setState(() {
      value = v;
    });
  },
)
```

| 状态    | 含义       |
| ----- | -------- |
| true  | 选中       |
| false | 未选中      |
| null  | 半选 / 未确定 |

📌 常见于 **全选 / 半选**

---

### 6️⃣ dense（紧凑模式）

```dart
dense: true,
```

📌 列表多时非常有用（设置页）

---

## 五、CheckboxListTile vs Checkbox（面试必问）

| 对比     | Checkbox | CheckboxListTile |
| ------ | -------- | ---------------- |
| 是否带文本  | ❌        | ✅                |
| 是否可点整行 | ❌        | ✅                |
| 是否封装布局 | ❌        | ✅                |
| 实际项目推荐 | ❌        | ✅                |

👉 **面试答案**

> CheckboxListTile 是 Checkbox 的高阶封装，更适合业务开发

---

## 六、多选列表（高频实战）

### 示例：兴趣多选

```dart
List<String> options = ['篮球', '足球', '游戏'];
Set<String> selected = {};

Column(
  children: options.map((item) {
    return CheckboxListTile(
      title: Text(item),
      value: selected.contains(item),
      onChanged: (checked) {
        setState(() {
          checked!
              ? selected.add(item)
              : selected.remove(item);
        });
      },
    );
  }).toList(),
)
```

📌 核心思想：

* CheckboxListTile **不存状态**
* 状态由数据结构（Set / List）管理

---

## 七、全选 / 半选（高级用法）

### 1️⃣ 全选 Checkbox

```dart
bool allChecked = false;

CheckboxListTile(
  title: Text('全选'),
  value: allChecked,
  onChanged: (value) {
    setState(() {
      allChecked = value!;
      selected = value ? options.toSet() : {};
    });
  },
)
```

---

### 2️⃣ 三态全选（专业）

```dart
bool? allState;

CheckboxListTile(
  title: Text('全选'),
  value: allState,
  tristate: true,
  onChanged: (value) {
    setState(() {
      allState = value;
    });
  },
)
```

📌 根据子项数量动态计算 `true / false / null`

---

## 八、禁用状态

```dart
CheckboxListTile(
  value: true,
  onChanged: null, // 置空即禁用
  title: Text('不可修改'),
)
```

---

## 九、CheckboxListTile 在 ListView 中使用

```dart
ListView.builder(
  itemCount: options.length,
  itemBuilder: (context, index) {
    final item = options[index];
    return CheckboxListTile(
      key: ValueKey(item),
      title: Text(item),
      value: selected.contains(item),
      onChanged: (value) {
        setState(() {
          value!
              ? selected.add(item)
              : selected.remove(item);
        });
      },
    );
  },
)
```

📌 **一定要加 key，避免状态错乱**

---

## 十、与状态管理配合（推荐）

CheckboxListTile 非常适合：

* Provider
* Riverpod
* Bloc / Cubit
* GetX

👉 UI 只关心 `value`，逻辑在状态层

---

## 十一、常见坑（重点）⚠️

❌ 忘记 setState
❌ `value` 为 null 却没开 `tristate`
❌ ListView 中没加 key
❌ 用 Checkbox + Row 重复造轮子

---

## 十二、典型使用场景总结

* 登录页「同意用户协议」
* 设置页多选项
* 表单确认项
* 批量选择列表
* 权限 / 配置页面

---

## 十三、面试一句话总结（背下来）

> CheckboxListTile 是 Flutter 中用于“带文本的复选框”的高阶组件，
> 内部封装了 Checkbox 和 ListTile，
> 支持整行点击、更好的可访问性，更适合真实业务开发。

---

## 十四、你下一步可以继续学的 👇

如果你愿意，我可以继续帮你系统整理：

* ✅ **RadioListTile 全解（单选）**
* ✅ **SwitchListTile 全解（开关）**
* ✅ **CheckboxListTile + Form 表单**
* ✅ **Material 3 中 Checkbox / ListTile 的变化**
* ✅ **封装一套企业级「选择组件」**

你直接选一个，我继续给你深挖 🚀
