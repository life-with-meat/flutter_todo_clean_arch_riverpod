import 'package:flutter_todo_clean_arch_riverpod/core/usecase/either_handler.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/error/todo_error.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/todo_repository.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/value/todo_title.dart';
import 'package:fpdart/fpdart.dart';

class TodoUsecases {
  final TodoRepository repository;

  TodoUsecases(this.repository);

  Future<Either<TodoError, List<TodoModel>>> fetch() async {
    return await toEither<TodoError, List<TodoModel>>(
      action: () => repository.fetchTodos(),
    );
  }

  Future<Either<TodoError, void>> add(String rawTitle) {
    return toEither<TodoError, void>(
      action: () async {
        final title = TodoTitle(rawTitle);

        final todo = TodoModel(
          id: DateTime.now().toIso8601String(),
          title: title,
          isDone: false,
        );
        await repository.createTodo(todo);
      },
    );
  }

  Future<Either<TodoError, void>> update(
    TodoModel todo,
    String rawTitle,
  ) async {
    return await toEither<TodoError, void>(
      action: () async {
        final title = TodoTitle(rawTitle);
        final updatedTodo = todo.copyWith(title: title);
        await repository.updateTodo(updatedTodo);
      },
    );
  }

  Future<Either<TodoError, void>> toggle(TodoModel todo) async {
    return await toEither<TodoError, void>(
      action: () async {
        final updatedTodo = todo.copyWith(isDone: !todo.isDone);
        await repository.updateTodo(updatedTodo);
      },
    );
  }

  Future<Either<TodoError, void>> delete(String id) async {
    return await toEither<TodoError, void>(
      action: () => repository.deleteTodo(id),
    );
  }
}
