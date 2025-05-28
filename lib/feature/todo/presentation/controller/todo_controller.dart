import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/error/todo_error.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/todo_providers.dart';

/// Todoの状態を管理するコントローラーのプロバイダー
final todoControllerProvider =
    AsyncNotifierProvider<TodoController, List<TodoModel>>(TodoController.new);

/// Todoの状態を管理するコントローラー
class TodoController extends AsyncNotifier<List<TodoModel>> {
  @override
  Future<List<TodoModel>> build() async {
    final usecases = ref.watch(todoUsecaseProvider);
    final result = await usecases.fetch();

    return result.fold((error) => throw error, (todos) => todos);
  }

  Future<TodoError?> add(String rawTitle) async {
    final usecases = ref.read(todoUsecaseProvider);

    final result = await usecases.add(rawTitle);
    return result.fold((error) => error, (_) async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async => await build());
      return null;
    });
  }

  Future<TodoError?> updateTodo(String id, String rawTitle) async {
    final list = state.valueOrNull;
    if (list == null) return null;

    final todo = list.firstWhere((e) => e.id == id);

    final usecases = ref.read(todoUsecaseProvider);

    final result = await usecases.update(todo, rawTitle);

    return result.fold((error) => error, (_) async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async => await build());
      return null;
    });
  }

  Future<TodoError?> toggle(String id) async {
    final list = state.valueOrNull;
    if (list == null) return null;

    final todo = list.firstWhere((e) => e.id == id);

    final usecases = ref.read(todoUsecaseProvider);

    final result = await usecases.toggle(todo);
    return result.fold((error) => error, (_) async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async => await build());
      return null;
    });
  }

  Future<TodoError?> remove(String id) async {
    final usecases = ref.read(todoUsecaseProvider);

    final result = await usecases.delete(id);
    return result.fold((error) => error, (_) async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async => await build());
      return null;
    });
  }
}
