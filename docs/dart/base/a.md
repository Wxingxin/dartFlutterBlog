

# 八、Map 的转换方法（🔥）

## 1️⃣3️⃣ `map`（key/value 转换）

```dart
var newMap = map.map((k, v) {
  return MapEntry(k, v * 10);
});
```

 知识点

* 返回 **新的 Map**
* 可以同时变 key / value



## 1️⃣4️⃣ `cast`

```dart
Map<String, int> typed =
    dynamicMap.cast<String, int>();
```

* 类型转换
* JSON / dynamic 场景常用



# 九、Map 方法的经典实战模式（🔥）

## 1️⃣ 计数（最经典）

```dart
for (var e in list) {
  countMap.update(e, (v) => v + 1, ifAbsent: () => 1);
}
```



## 2️⃣ 分组（必会）

```dart
for (var item in items) {
  groups.putIfAbsent(item.type, () => []).add(item);
}
```



## 3️⃣ 安全读取

```dart
var value = map['a'] ?? 0;
```



## 4️⃣ Flutter UI 构建

```dart
Column(
  children: map.entries.map((e) {
    return Text('${e.key}: ${e.value}');
  }).toList(),
);
```





# 十一、Map 方法 vs List 方法（认知对比）

| 对比点 | List     | Map               |
|  | -------- | ----------------- |
| 增   | add      | putIfAbsent / []= |
| 删   | removeAt | remove            |
| 改   | setAll   | update            |
| 查   | contains | containsKey       |
| 遍历  | for-in   | entries           |

---

# 十二、一句话总结（必须记住）

> **Map 的灵魂方法只有 3 个：**
>
> * `putIfAbsent`（建结构）
> * `update`（改数据）
> * `entries`（遍历）

其余方法，都是围绕这三个展开。

---

如果你愿意，我可以继续给你进阶内容：

* `Map 遍历方式 & 性能对比`
* `Map 在 JSON 解析中的最佳实践`
* `Map vs List vs Set 的选型总结`
* `Flutter 中 Map 驱动 UI 的模式`

你直接说下一步学哪个，我继续给你 **进阶版**。
