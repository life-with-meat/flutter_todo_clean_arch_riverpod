import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo_clean_arch_riverpod/core/error/common_error.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/error/todo_error.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/todo_repository.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/infrastructure/data_source/firebase_todo_data_source.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseTodoDataSource dataSource;

  TodoRepositoryImpl(this.dataSource);

  // エラー処理を共通化した関数
  Future<T> _handleError<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } on FirebaseException catch (_) {
      throw TodoError.common(CommonError.networkError());
    } catch (_) {
      throw TodoError.common(CommonError.unexpectedError());
    }
  }

  @override
  Future<void> createTodo(TodoModel todo) async {
    await _handleError(() => dataSource.create(todo));
  }

  @override
  Future<List<TodoModel>> fetchTodos() async {
    return await _handleError(() => dataSource.fetchAll());
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await _handleError(() => dataSource.update(todo));
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _handleError(() => dataSource.delete(id));
  }
}
