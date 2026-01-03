下面给你一份 **Flutter `Radio` 的「知识点 + 使用大全」**，这是 **单选场景的核心组件**，和 `Checkbox`（多选）正好形成一组。
我会按 **概念 → 基础 → 属性 → 实战 → 对比 → 常见坑 → 面试总结** 来讲，偏真实项目、可直接当笔记用 👍

---

## 一、Radio 是什么？

`Radio` 是 **单选组件**，用于：

* 多个选项中 **只能选一个**
* 性别选择（男 / 女）
* 支付方式（微信 / 支付宝）
* 配置项互斥选择

📌 **核心语义**

> Radio 关注的是：**“我属于哪一组？当前选的是谁？”**

---

## 二、Radio 的工作原理（非常重要 ⭐⭐⭐）

Radio **不是靠自身状态判断选中**，而是靠 **value 与 groupValue 是否相等**

```dart
Radio<T>(
  value: T,
  groupValue: T,
)
```

* `value`：当前这个 Radio 的值
* `groupValue`：当前组选中的值
* **value == groupValue → 选中**

📌 这是 Radio 最容易搞错的地方（面试必问）

---

## 三、最基础用法（必须会）

### 示例：性别选择

```dart
String _gender = 'male';

Column(
  children: [
    Radio<String>(
      value: 'male',
      groupValue: _gender,
      onChanged: (value) {
        setState(() {
          _gender = value!;
        });
      },
    ),
    Radio<String>(
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

* 所有 Radio **共享同一个 groupValue**
* 改的是 groupValue，不是 Radio 本身

---

## 四、Radio 的核心属性 ⭐⭐⭐⭐⭐

```dart
Radio<String>(
  value: 'a',
  groupValue: 'a',
  onChanged: (value) {},
  activeColor: Colors.blue,
  toggleable: false,
)
```

| 属性          | 作用      |
| ----------- | ------- |
| value       | 当前选项的值  |
| groupValue  | 当前组选中的值 |
| onChanged   | 切换回调    |
| activeColor | 选中颜色    |
| toggleable  | 是否可取消选中 |

---

## 五、toggleable（可取消选择）

```dart
String? selected;

Radio<String>(
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

📌 作用：

* 再点一次可取消选中
* 默认是 `false`

---

## 六、Radio + 文本（❌ 不推荐）

```dart
Row(
  children: [
    Radio(...),
    Text('选项 A'),
  ],
)
```

❌ 问题：

* 点击区域小
* 无障碍差
* 间距要自己处理

✅ **正确做法：用 RadioListTile**

（下面会讲）

---

## 七、RadioListTile（真实项目首选 ⭐⭐⭐⭐⭐）

```dart
String _pay = 'wechat';

RadioListTile<String>(
  title: Text('微信支付'),
  value: 'wechat',
  groupValue: _pay,
  onChanged: (value) {
    setState(() {
      _pay = value!;
    });
  },
)
```

📌 优点：

* 点击整行即可切换
* 自带布局 / 动画 / 无障碍
* 项目中 **90% 用它**

---

## 八、RadioListTile 常用属性

```dart
RadioListTile<String>(
  title: Text('支付宝'),
  subtitle: Text('推荐'),
  secondary: Icon(Icons.payment),
  controlAffinity: ListTileControlAffinity.leading,
  activeColor: Colors.green,
)
```

| 属性              | 说明         |
| --------------- | ---------- |
| title           | 主文本        |
| subtitle        | 副文本        |
| secondary       | 图标         |
| controlAffinity | Radio 在左/右 |
| dense           | 紧凑布局       |

---

## 九、动态 Radio 列表（高频）

```dart
List<String> options = ['A', 'B', 'C'];
String selected = 'A';

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

📌 和 Checkbox 的最大区别：

* Checkbox → 多个 true
* Radio → **只有一个 groupValue**

---

## 十、Radio 在 ListView 中使用（注意 key）

```dart
ListView.builder(
  itemCount: options.length,
  itemBuilder: (context, index) {
    final item = options[index];
    return RadioListTile(
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

⚠️ 不加 key 可能导致选中错乱

---

## 十一、Radio vs Checkbox vs Switch（面试必考）

| 组件       | 选择类型 | 使用场景      |
| -------- | ---- | --------- |
| Radio    | 单选   | 性别 / 支付方式 |
| Checkbox | 多选   | 兴趣 / 协议   |
| Switch   | 开关   | 设置        |

👉 **面试一句话**

> Radio 是互斥选择，Checkbox 是多选，Switch 表示功能开关

---

## 十二、Radio 常见坑（重点）⚠️

❌ 忘记所有 Radio 共享同一个 groupValue
❌ 用 bool 做 Radio（Radio 适合枚举/字符串）
❌ Radio + Row 手动布局
❌ ListView 中没加 key
❌ 在 Radio 内部存状态（不可能）

---

## 十三、Radio 的最佳实践（项目经验）

✅ 使用 `enum` 作为 value

```dart
enum Gender { male, female }

Gender _gender = Gender.male;

Radio<Gender>(
  value: Gender.male,
  groupValue: _gender,
  onChanged: (value) {
    setState(() {
      _gender = value!;
    });
  },
)
```

📌 **强烈推荐，类型安全 + 易维护**

---

## 十四、面试总结（背下来）

> Radio 是 Flutter 中的单选组件，
> 通过 value 与 groupValue 是否相等决定选中状态，
> 实际项目中通常使用 RadioListTile 并结合 enum 管理状态。

---

## 十五、你下一步可以继续学的 👇

如果你愿意，我可以继续帮你系统整理：

* ✅ **RadioListTile vs CheckboxListTile 深度对比**
* ✅ **Switch / SwitchListTile 全解**
* ✅ **Form 表单中的 Radio（FormField 封装）**
* ✅ **Material 3 中 Radio 的样式变化**
* ✅ **统一封装「选择类组件」库**

你直接选一个，我继续给你深挖 🚀
