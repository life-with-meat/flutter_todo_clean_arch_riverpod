import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/todo_repository.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/infrastructure/data_source/firebase_todo_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseTodoDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  @override
  Future<void> createTodo(TodoModel todo) => dataSource.create(todo);

  @override
  Future<List<TodoModel>> fetchTodos() => dataSource.fetchAll();

  @override
  Future<void> updateTodo(TodoModel todo) => dataSource.update(todo);

  @override
  Future<void> deleteTodo(String id) => dataSource.delete(id);
}
