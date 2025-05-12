import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/todo_repository.dart';

class TodoUsecases {
  final TodoRepository repository;

  TodoUsecases(this.repository);

  Future<List<TodoModel>> fetch() => repository.fetchTodos();

  Future<void> add(String title) async {
    if (title.trim().isEmpty) throw Exception("タイトルは必須です");
    final todo = TodoModel(
      id: DateTime.now().toIso8601String(),
      title: title.trim(),
      isDone: false,
    );
    await repository.createTodo(todo);
  }

  Future<void> update(TodoModel todo) async {
    if (todo.title.trim().isEmpty) throw Exception("タイトルは必須です");
    await repository.updateTodo(todo);
  }

  Future<void> delete(String id) => repository.deleteTodo(id);
}
