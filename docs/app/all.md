下面我按 **Flutter 官方体系 + 实际工程常用维度**，把 **Flutter 组件（Widget）做一份「完整、可长期查阅的分类大全」**。
不是简单罗列，而是**按职责分类**，方便你在开发时“知道该去找哪一类组件”。

---

# 一、基础（Foundation / App 级）组件

> **用于构建应用整体结构与入口**

## 1. App 根组件

* `MaterialApp`
* `CupertinoApp`
* `WidgetsApp`

## 2. 页面级

* `Scaffold`
* `AppBar`
* `BottomNavigationBar`
* `TabBar`
* `TabBarView`
* `Drawer`
* `NavigationRail`

---

# 二、布局类组件（Layout Widgets）

> **负责子组件的排列、约束与分布**

## 1. 线性布局

* `Row`
* `Column`
* `Flex`

## 2. 弹性布局

* `Expanded`
* `Flexible`
* `Spacer`

## 3. 层叠布局

* `Stack`
* `Positioned`
* `IndexedStack`

## 4. 流式 / 自动换行

* `Wrap`
* `Flow`

## 5. 表格 / 网格

* `Table`
* `TableRow`
* `GridView`
* `SliverGrid`

## 6. 列表 / 滚动布局

* `ListView`
* `ListView.builder`
* `ListView.separated`

---

# 三、容器类组件（Container / Box）

> **负责尺寸、对齐、装饰、约束（通常单子组件）**

## 1. 通用容器

* `Container`
* `SizedBox`
* `ConstrainedBox`
* `UnconstrainedBox`
* `LimitedBox`

## 2. 对齐 / 定位

* `Align`
* `Center`
* `FractionallySizedBox`

## 3. 内外边距

* `Padding`

## 4. 装饰

* `DecoratedBox`
* `ColoredBox`

## 5. 裁剪

* `ClipRect`
* `ClipRRect`
* `ClipOval`
* `ClipPath`

## 6. 变换

* `Transform`
* `Opacity`

---

# 四、滚动与 Sliver 组件

> **用于复杂滚动、性能优化**

## 1. Sliver 容器

* `CustomScrollView`
* `NestedScrollView`

## 2. Sliver 内容

* `SliverList`
* `SliverGrid`
* `SliverFillRemaining`
* `SliverToBoxAdapter`

## 3. Sliver 交互

* `SliverAppBar`
* `SliverPersistentHeader`

---

# 五、基础显示组件（Display Widgets）

> **纯展示，不直接处理用户输入**

## 1. 文本

* `Text`
* `RichText`
* `SelectableText`

## 2. 图片 / 图标

* `Image`
* `Icon`
* `FlutterLogo`

## 3. 装饰 / 分割

* `Divider`
* `VerticalDivider`
* `Placeholder`
* `Tooltip`

---

# 六、输入与交互组件（Input & Interaction）

> **接收用户操作**

## 1. 按钮

* `ElevatedButton`
* `TextButton`
* `OutlinedButton`
* `IconButton`
* `FloatingActionButton`

## 2. 表单

* `Form`
* `FormField`
* `TextField`
* `TextFormField`

## 3. 选择类

* `Checkbox`
* `Radio`
* `Switch`
* `Slider`
* `DropdownButton`

## 4. 手势

* `GestureDetector`
* `InkWell`
* `InkResponse`
* `Listener`

---

# 七、反馈与状态提示组件

> **向用户反馈当前状态**

* `SnackBar`
* `Dialog`
* `AlertDialog`
* `BottomSheet`
* `ModalBottomSheet`
* `CircularProgressIndicator`
* `LinearProgressIndicator`
* `RefreshIndicator`

---

# 八、动画与过渡组件

> **UI 动效与页面切换**

## 1. 基础动画

* `AnimatedContainer`
* `AnimatedOpacity`
* `AnimatedAlign`
* `AnimatedPadding`

## 2. 切换动画

* `AnimatedSwitcher`
* `Hero`

## 3. 过渡组件

* `FadeTransition`
* `ScaleTransition`
* `SlideTransition`

---

# 九、导航与路由组件

> **页面切换与栈管理**

* `Navigator`
* `Route`
* `MaterialPageRoute`
* `PageRouteBuilder`
* `WillPopScope`

---

# 十、主题与样式组件

> **全局风格控制**

* `Theme`
* `ThemeData`
* `InheritedTheme`
* `MediaQuery`
* `DefaultTextStyle`

---

# 十一、平台风格组件

## 1. Material（Android 风格）

* `Scaffold`
* `Card`
* `ListTile`
* `Chip`
* `Stepper`

## 2. Cupertino（iOS 风格）

* `CupertinoButton`
* `CupertinoNavigationBar`
* `CupertinoTabScaffold`
* `CupertinoPicker`

---

# 十二、功能型 / 工具型组件（Utility）

> **不直接显示 UI，但影响子树**

* `Builder`
* `LayoutBuilder`
* `SafeArea`
* `Offstage`
* `Visibility`
* `AbsorbPointer`
* `IgnorePointer`
* `Focus`
* `FocusScope`

---

# 十三、状态相关组件

> **管理 Widget 生命周期与状态**

* `StatelessWidget`
* `StatefulWidget`
* `State`
* `InheritedWidget`

---

# 十四、渲染层（进阶了解）

> **一般不直接使用，但理解很重要**

* `RenderObjectWidget`
* `LeafRenderObjectWidget`
* `SingleChildRenderObjectWidget`
* `MultiChildRenderObjectWidget`

---

# 十五、一句话总览（记忆版）

> **Flutter 中：**
>
> * 布局靠 `Row / Column / Stack`
> * 外观靠 `Container / Box`
> * 滚动靠 `ListView / Sliver`
> * 交互靠 `Button / Gesture`
> * 动画靠 `Animated*`
> * 架构靠 `State / Inherited`

---

如果你愿意，下一步我可以帮你做：

1. **Flutter 组件速查表（面试 / 实战）**
2. **一个页面中组件组合的标准套路**
3. **Flutter 常见组件的“替代关系”**
4. **Flutter 与 React Native 组件体系对照表**

你可以直接指定一个方向。
