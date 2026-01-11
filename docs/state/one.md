

## Step 0：先把“状态是什么”搞牢（1 天内）

**你要会：**

* 状态 = 会变化的数据（int/bool/string/list…）
* 状态变化 → UI 重新 build

**练习：**

* 计数器：`+ / - / reset`
* bool 开关：显示/隐藏一段文字

**别学：**

* Provider/Riverpod/Bloc（先别碰）



## Step 1：StatefulWidget + setState（核心入门，2–3 天）

**你要会：**

* `StatefulWidget` 的结构
* `setState(() { ... })` 触发刷新
* 把“逻辑”抽成函数：`increment() / decrement()`

**练习（必须做）：**

1. 计数器（加减、不能小于 0）
2. 简单表单：输入框改变文字预览
3. Tab 切换：不同状态显示不同内容

**你要形成的习惯：**

* 状态写在 `State` 里
* UI 只读状态，不直接写逻辑



## Step 2：局部状态拆分（从“嵌套地狱”出来，3–5 天）

**你要会：**

* 把大页面拆成小组件
* 状态放哪里：**离它最近的地方**
* 父传子：构造函数传值
* 子通知父：回调函数（`VoidCallback` / `ValueChanged<T>`）

**练习：**

* TodoList（本地列表）：

  * 添加 todo
  * 勾选完成
  * 删除
* 要求：ListItem 组件独立拆出来，点击 item 通过回调修改父组件的 list

**别学：**

* 复杂架构、全局状态（先把“组件通信”打通）



## Step 3：理解 Flutter 的“状态生命周期”（2–3 天）

**你要会：**

* `initState`：初始化/发请求
* `dispose`：释放资源（Controller/Stream）
* `setState` 不能乱用：异步后判断 `mounted`

**练习：**

* 用 `TextEditingController` 做一个输入框
* 页面退出时释放 controller
* 模拟异步加载（Future.delayed）显示 loading → 数据



## Step 4：从“状态”走向“模型”（1 周）

**你要会：**

* 状态不仅是 int，还可以是**对象/列表/枚举**
* 用 enum 表示页面状态：`loading/success/error`

**练习：**

* 模拟请求列表：

  * loading 圈圈
  * 成功显示列表
  * 失败显示错误 + 重试按钮

**这里你已经具备“项目级状态思维”了。**



## Step 5：选择一种主流状态管理（只选一种！2–7 天）

到这里再上框架，否则你会只会“API”，不会“为什么”。

我建议学习顺序（从轻到重）：

1. **Provider（入门友好）**
2. **Riverpod（更现代，写起来更舒服）**
3. Bloc（偏架构、偏工程化，后面再学）

> 你现在如果是学生毕业设计/个人项目：**Provider 或 Riverpod 二选一就够了。**



## Step 6：Provider/Riverpod 的最小闭环（1 周）

**你要会：**

* 把状态从页面挪到“状态类”里（ViewModel/Notifier）
* UI 只订阅、只渲染
* 逻辑都在状态类里（增删改查）

**练习：TodoList 2.0（必须做）**

* 状态类管理 todos
* UI 里不直接改 list，只调用方法：

  * `addTodo() / toggleTodo() / removeTodo()`



## Step 7：全局状态与持久化（1–2 周）

**你要会：**

* App 级状态：登录信息、主题、语言
* 本地持久化：`shared_preferences` / `hive`（选一个）

**练习：**

* 登录状态：

  * 未登录显示登录页
  * 登录后进入主页
  * 重启 App 还能保持登录状态



## Step 8：异步状态管理（中高级，1–2 周）

**你要会：**

* 网络请求（dio/http）
* 分页、下拉刷新
* 错误处理、缓存策略
* 防抖/节流（搜索框）

**练习：**

* 列表分页 + 下拉刷新 + 失败重试
* 搜索 + 防抖（输入停止 300ms 才请求）



## Step 9：架构化（高级，按需）

**你要会：**

* 分层：UI / State / Service / Repository
* 可测试：把逻辑从 UI 抽走
* 依赖注入（get_it 等，按需）



# 你现在应该怎么开始（最关键）

你目前“加减数字都不会”，所以你的起点是：

✅ **Step 0 → Step 1 → Step 2**
这三步走完，你就能真正理解状态管理。



## 给你一个很直接的执行计划（7 天游）

* Day1：计数器 + reset（Step0）
* Day2：输入框实时预览（Step1）
* Day3：show/hide + switch（Step1）
* Day4：父传子 + 回调（Step2）
* Day5：TodoList（本地）完成（Step2）
* Day6：initState/dispose + 异步加载（Step3）
* Day7：loading/success/error 三态（Step4）



如果你愿意，我可以按这个路线**给你每天一题**，你写完贴代码我帮你改。
你先回答我一句（不用长）：你更想从哪个练习开始？
1）计数器加强版（加减+重置+不小于0）
2）TodoList（增删改）
