import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/application/todo_usecases.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/todo_providers.dart';

final editErrorProvider = StateProvider<String?>((ref) => null);

final todoControllerProvider =
    StateNotifierProvider<TodoController, AsyncValue<List<TodoModel>>>((ref) {
      return TodoController(ref.watch(todoUsecaseProvider));
    });

class TodoController extends StateNotifier<AsyncValue<List<TodoModel>>> {
  final TodoUsecases _usecases;

  TodoController(this._usecases) : super(const AsyncValue.loading());

  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final todos = await _usecases.fetch();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> add(String title) async {
    try {
      await _usecases.add(title);
      await load();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggle(String id) async {
    final list = state.valueOrNull;
    if (list == null) return;

    try {
      final todo = list.firstWhere((e) => e.id == id);
      await _usecases.update(todo.copyWith(isDone: !todo.isDone));
      await load();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> remove(String id) async {
    try {
      await _usecases.delete(id);
      await load();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> update(TodoModel todo) async {
    try {
      await _usecases.update(todo);
      await load();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
