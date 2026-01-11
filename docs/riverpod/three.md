下面是一份**完整可运行**的 Riverpod Todo List（**增 / 删 / 改 + 勾选完成**）案例：

* ✅ Riverpod：`StateNotifierProvider + StateNotifier`
* ✅ 模型：`Todo + copyWith`（不可变更新）
* ✅ 组件拆分：`TodoListItem` 独立组件，通过**回调**修改父组件 list（符合你之前的要求）
* ✅ UI：新增、编辑（弹窗输入）、勾选完成、删除、清空已完成

> 直接把代码复制到 `lib/main.dart`，`flutter run` 即可。

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// ===============
/// 1) 数据模型
/// ===============
@immutable
class Todo {
  final String id;
  final String title;
  final bool done;
  final DateTime createdAt;

  const Todo({
    required this.id,
    required this.title,
    required this.done,
    required this.createdAt,
  });

  Todo copyWith({
    String? title,
    bool? done,
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      done: done ?? this.done,
      createdAt: createdAt,
    );
  }
}

/// ===============
/// 2) 业务状态管理：StateNotifier
/// ===============
class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super(const []);

  void add(String title) {
    final text = title.trim();
    if (text.isEmpty) return;

    final todo = Todo(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: text,
      done: false,
      createdAt: DateTime.now(),
    );
    state = [...state, todo];
  }

  void toggle(String id) {
    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(done: !t.done) else t
    ];
  }

  void updateTitle(String id, String newTitle) {
    final text = newTitle.trim();
    if (text.isEmpty) return;

    state = [
      for (final t in state)
        if (t.id == id) t.copyWith(title: text) else t
    ];
  }

  void remove(String id) {
    state = state.where((t) => t.id != id).toList();
  }

  void clearCompleted() {
    state = state.where((t) => !t.done).toList();
  }

  void toggleAll(bool done) {
    state = [for (final t in state) t.copyWith(done: done)];
  }
}

final todoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>(
  (ref) => TodoNotifier(),
);

/// ===============
/// 3) App & Page
/// ===============
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Riverpod Todo',
      theme: ThemeData(useMaterial3: true),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _showEditDialog({
    required String initialText,
    required ValueChanged<String> onSubmit,
    required String title,
  }) async {
    final editController = TextEditingController(text: initialText);

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '输入内容',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (v) => Navigator.of(ctx).pop(v),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(null),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(editController.text),
            child: const Text('确定'),
          ),
        ],
      ),
    );

    editController.dispose();

    if (result == null) return;
    onSubmit(result);
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final notifier = ref.read(todoProvider.notifier);

    final doneCount = todos.where((t) => t.done).length;
    final allDone = todos.isNotEmpty && doneCount == todos.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List (Riverpod)'),
        actions: [
          IconButton(
            tooltip: allDone ? '全部设为未完成' : '全部设为已完成',
            onPressed: todos.isEmpty ? null : () => notifier.toggleAll(!allDone),
            icon: Icon(allDone ? Icons.check_box : Icons.check_box_outline_blank),
          ),
          PopupMenuButton<String>(
            onSelected: (v) {
              if (v == 'clear_done') notifier.clearCompleted();
            },
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 'clear_done',
                enabled: doneCount > 0,
                child: Text('清空已完成（$doneCount）'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // 顶部输入区：新增
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: '新增 Todo',
                      hintText: '比如：学习 Riverpod 30 分钟',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (v) {
                      notifier.add(v);
                      _controller.clear();
                    },
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton.icon(
                  onPressed: () {
                    notifier.add(_controller.text);
                    _controller.clear();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('添加'),
                ),
              ],
            ),
          ),

          // 统计信息
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Text('总数：${todos.length}'),
                const SizedBox(width: 12),
                Text('已完成：$doneCount'),
              ],
            ),
          ),

          const Divider(height: 1),

          // 列表
          Expanded(
            child: todos.isEmpty
                ? const Center(
                    child: Text('还没有 Todo，先加一个吧～'),
                  )
                : ListView.separated(
                    itemCount: todos.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final t = todos[index];

                      return TodoListItem(
                        todo: t,

                        // ✅ 通过回调修改父组件 list（由父组件调用 notifier）
                        onToggle: () => notifier.toggle(t.id),
                        onDelete: () => notifier.remove(t.id),
                        onEdit: () => _showEditDialog(
                          title: '编辑 Todo',
                          initialText: t.title,
                          onSubmit: (newText) => notifier.updateTitle(t.id, newText),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// ===============
/// 4) ListItem 独立组件（只负责展示 + 回调）
/// ===============
class TodoListItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TodoListItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: todo.done,
        onChanged: (_) => onToggle(),
      ),
      title: Text(
        todo.title,
        style: TextStyle(
          decoration: todo.done ? TextDecoration.lineThrough : null,
          color: todo.done ? Colors.grey : null,
        ),
      ),
      subtitle: Text(
        '创建：${todo.createdAt.toLocal().toString().split('.').first}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onEdit,
      trailing: IconButton(
        tooltip: '删除',
        icon: const Icon(Icons.delete_outline),
        onPressed: onDelete,
      ),
    );
  }
}
```

### 你练完这个案例，应该能明确掌握的点

* `StateNotifierProvider` 负责把**状态 + 方法**封装起来
* UI 用 `ref.watch(todoProvider)` 订阅状态
* 事件用 `ref.read(todoProvider.notifier)` 调方法
* `ListItem` 组件独立拆分，通过回调让父组件去更新状态（组件职责清晰）

如果你下一步想更接近真实项目，我可以把这个 Todo 升级成：

* ✅ `AsyncNotifier`（模拟网络加载 + 重试）
* ✅ 本地持久化（shared_preferences / hive）
* ✅ 过滤（全部/已完成/未完成）+ 搜索
  你想先加哪一个？
