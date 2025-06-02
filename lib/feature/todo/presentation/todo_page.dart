import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/error/todo_error.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/value/todo_title.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/controller/todo_controller.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/presentation/widget/input_dialog.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoPageState = ref.watch(todoControllerProvider);
    final todoPageController = ref.read(todoControllerProvider.notifier);

    void showErrorSnackBar(TodoError? error) {
      if (error == null) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    }

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
                    todo.title.value,
                    style: TextStyle(
                      decoration:
                          todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  value: todo.isDone,
                  activeColor: todo.isDone ? Colors.grey : null,
                  tileColor: todo.isDone ? Colors.grey.shade300 : null,
                  onChanged: (value) async {
                    final error = await todoPageController.toggle(todo.id);
                    showErrorSnackBar(error);
                  },
                  secondary: PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (String value) async {
                      if (value == 'edit') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return InputDialog(
                              initialValue: todo.title.value,
                              dialogTitle: 'タスクを編集',
                              onSubmit: (newTitle) async {
                                final error = await todoPageController
                                    .updateTodo(todo.id, newTitle);
                                showErrorSnackBar(error);
                              },
                              validator: (v) => TodoTitle.validator.validate(v),
                            );
                          },
                        );
                      } else if (value == 'delete') {
                        final error = await todoPageController.remove(todo.id);
                        showErrorSnackBar(error);
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
        error:
            (error, stackTrace) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error is TodoError ? error.message : '予期せぬエラーが発生しました',
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => todoPageController.build(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('再取得'),
                  ),
                ],
              ),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return InputDialog(
                initialValue: '',
                dialogTitle: '新しいタスク',
                validator: (v) => TodoTitle.validator.validate(v),
                onSubmit: (newTitle) async {
                  final error = await todoPageController.add(newTitle);
                  showErrorSnackBar(error);
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
