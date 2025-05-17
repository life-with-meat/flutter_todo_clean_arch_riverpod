import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/todo_repository.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/value/todo_title.dart';

class TodoUsecases {
  final TodoRepository repository;

  TodoUsecases(this.repository);

  Future<List<TodoModel>> fetch() => repository.fetchTodos();

  Future<void> add(String rawTitle) async {
    try {
      final title = TodoTitle(rawTitle);

      final todo = TodoModel(
        id: DateTime.now().toIso8601String(),
        title: title,
        isDone: false,
      );
      await repository.createTodo(todo);
    } catch (e) {
      throw Exception('保存できません: ${e is ArgumentError ? e.message : e}');
    }
  }

  Future<void> update(TodoModel todo) async {
    try {
      final title = TodoTitle(todo.title.value);

      final updatedTodo = todo.copyWith(title: title);
      await repository.updateTodo(updatedTodo);
    } catch (e) {
      throw Exception('保存できません: ${e is ArgumentError ? e.message : e}');
    }
  }

  Future<void> delete(String id) => repository.deleteTodo(id);
}
