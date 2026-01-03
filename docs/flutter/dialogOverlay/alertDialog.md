下面给你一份**📘 Flutter 的 AlertDialog 知识点与使用大全（实战版）**。我按**基础 → API → 常见场景 → 进阶定制 → 坑与最佳实践**系统整理，基本覆盖你在真实项目里 95% 的用法。

> 适用于 **Flutter** 中的提示、确认、输入、选择等弹窗场景。

---

## 一、AlertDialog 是什么（核心概念）

**AlertDialog 是一个模态对话框**，用于：

* 提示信息
* 确认 / 取消
* 简单表单输入
* 风险操作二次确认

特点：

* 阻断当前页面操作
* 需要用户明确交互（按钮）
* 通过 `showDialog` 弹出

---

## 二、AlertDialog 的基本使用（必会）

### 1️⃣ 最简单示例

```dart
showDialog(
  context: context,
  builder: (context) {
    return AlertDialog(
      title: Text('提示'),
      content: Text('操作成功'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('确定'),
        ),
      ],
    );
  },
);
```

👉 **记住一句话**：

> AlertDialog ≠ Widget 直接用，**必须通过 showDialog**

---

## 三、showDialog 的核心参数（重点）

```dart
showDialog(
  context: context,
  barrierDismissible: false, // 点击遮罩是否关闭
  builder: (context) => AlertDialog(...),
);
```

| 参数                   | 说明               |
| -------------------- | ---------------- |
| `context`            | 必须是当前页面的 context |
| `barrierDismissible` | 是否允许点空白关闭        |
| `builder`            | 返回 Dialog Widget |

---

## 四、AlertDialog 常用属性大全（必背）

```dart
AlertDialog(
  title: Text('标题'),
  content: Text('内容'),
  actions: [],
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12),
  ),
  elevation: 8,
  insetPadding: EdgeInsets.all(24),
)
```

| 属性             | 作用    |
| -------------- | ----- |
| `title`        | 标题    |
| `content`      | 主体内容  |
| `actions`      | 底部按钮  |
| `shape`        | 圆角    |
| `elevation`    | 阴影    |
| `insetPadding` | 与屏幕边距 |

---

## 五、常见使用场景（🔥 高频）

## 1️⃣ 确认 / 取消 对话框（最常见）

```dart
showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: Text('确认删除'),
    content: Text('删除后无法恢复，是否继续？'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text('取消'),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text('确认'),
      ),
    ],
  ),
);
```

### 获取返回值（🔥）

```dart
final result = await showDialog<bool>(...);
if (result == true) {
  deleteItem();
}
```

---

## 2️⃣ 提示信息（Toast 替代）

```dart
AlertDialog(
  content: Text('请先登录'),
  actions: [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('知道了'),
    ),
  ],
);
```

---

## 3️⃣ 带输入框的 AlertDialog（非常常见）

```dart
final controller = TextEditingController();

showDialog(
  context: context,
  builder: (_) => AlertDialog(
    title: Text('输入名称'),
    content: TextField(
      controller: controller,
      decoration: InputDecoration(hintText: '请输入'),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('取消'),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context, controller.text);
        },
        child: Text('确定'),
      ),
    ],
  ),
);
```

---

## 4️⃣ 加载中 Dialog（⚠️ 注意）

```dart
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (_) => AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 16),
        Text('加载中...'),
      ],
    ),
  ),
);
```

关闭：

```dart
Navigator.pop(context);
```

---

## 六、AlertDialog vs SimpleDialog vs Dialog（面试点）

| 类型           | 适用场景         |
| ------------ | ------------ |
| AlertDialog  | 提示 / 确认 / 输入 |
| SimpleDialog | 多选项          |
| Dialog       | 高度自定义        |

---

## 七、AlertDialog 的样式定制（进阶）

### 1️⃣ 圆角 + 自定义宽度

```dart
AlertDialog(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  content: SizedBox(
    width: 300,
    child: Text('内容'),
  ),
);
```

---

### 2️⃣ 自定义按钮布局

```dart
actionsAlignment: MainAxisAlignment.center,
```

---

### 3️⃣ 自定义内容（任意 Widget）

```dart
content: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.warning, color: Colors.red),
    SizedBox(height: 12),
    Text('危险操作'),
  ],
);
```

---

## 八、AlertDialog + async / await（🔥 正确姿势）

```dart
Future<void> showConfirm() async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(...),
  );

  if (ok == true) {
    await submit();
  }
}
```

---

## 九、常见坑 & 解决方案（⚠️ 面试必考）

### ❌ 1. 用错 context

```dart
showDialog(
  context: context, // 必须是页面 context
);
```

❗不要用已经 dispose 的 context

---

### ❌ 2. Dialog 太高报错

```dart
Column(
  mainAxisSize: MainAxisSize.min, // 必须
)
```

---

### ❌ 3. 多次 pop 导致页面退出

```dart
Navigator.pop(context); // 只 pop 一次
```

---

### ❌ 4. build 中直接 showDialog

👉 会无限弹窗
✅ 放在事件 / initState 后的回调

---

## 十、最佳实践总结（直接记）

> ✅ 所有 Dialog 都用 async/await 拿结果
> ✅ 确认框用 bool 返回
> ✅ 输入框用 String 返回
> ❌ build() 里弹 Dialog
> ❌ 业务逻辑写在 Dialog 内

---

## 十一、一个通用 AlertDialog 工具函数（推荐）

```dart
Future<bool?> showConfirmDialog(
  BuildContext context,
  String title,
  String content,
) {
  return showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('取消'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('确定'),
        ),
      ],
    ),
  );
}
```

---

## 十二、下一步我可以继续帮你👇

* ✅ **showModalBottomSheet 使用大全**
* ✅ **Dialog / BottomSheet / Snackbar 全面对比**
* ✅ **表单 + Dialog 实战**
* ✅ **自定义弹窗组件封装**

你直接说想学哪个，我接着给你整理 👍
