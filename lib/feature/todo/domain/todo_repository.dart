import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';

abstract class TodoRepository {
  Future<void> createTodo(TodoModel todo);
  Future<List<TodoModel>> fetchTodos();
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}
