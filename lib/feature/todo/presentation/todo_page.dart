import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/controller/todo_controller.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/widget/todo_dialog.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoPageState = ref.watch(todoControllerProvider);
    final todoPageController = ref.read(todoControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo リスト'),
      ),
      body: todoPageState.when(
        data:
            (todos) => ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return CheckboxListTile(
                  title: Text(
                    todo.title,
                    style: TextStyle(
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  value: todo.isDone,
                  activeColor: todo.isDone ? Colors.grey : null,
                  tileColor: todo.isDone ? Colors.grey.shade300 : null,
                  onChanged: (value) {
                    todoPageController.toggle(todo.id);
                  },
                  secondary: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (String value) {
                      if (value == 'edit') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return TodoDialog(
                              initialTitle: todo.title,
                              dialogTitle: 'タスクを編集',
                              errorProvider: editErrorProvider,
                              onSave: (newTitle) {
                                todoPageController.update(
                                  todo.copyWith(title: newTitle),
                                );
                              },
                            );
                          },
                        );
                      } else if (value == 'delete') {
                        todoPageController.remove(todo.id);
                      }
                    },
                    itemBuilder:
                        (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'edit',
                            child: Text('編集'),
                          ),
                          const PopupMenuItem<String>(
                            value: 'delete',
                            child: Text('削除'),
                          ),
                        ],
                  ),
                );
              },
            ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('エラーが発生しました: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TodoDialog(
                initialTitle: '',
                dialogTitle: '新しいタスク',
                errorProvider: editErrorProvider,
                onSave: (newTitle) {
                  todoPageController.add(newTitle);
                },
              );
            },
          );
        },
        tooltip: 'タスクを追加',
        child: const Icon(Icons.add),
      ),
    );
  }
}
