import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/application/todo_usecases.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/model/todo_model.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/value/todo_title.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/todo_providers.dart';

/// Todoの編集時のエラー状態を管理するプロバイダー
final editErrorProvider = StateProvider<String?>((ref) => null);

/// Todoの状態を管理するコントローラーのプロバイダー
final todoControllerProvider =
    StateNotifierProvider<TodoController, AsyncValue<List<TodoModel>>>((ref) {
      return TodoController(ref.watch(todoUsecaseProvider));
    });

/// Todoの状態を管理するコントローラー
class TodoController extends StateNotifier<AsyncValue<List<TodoModel>>> {
  final TodoUsecases _usecases;

  TodoController(this._usecases) : super(const AsyncValue.loading());

  /// Todoリストを読み込む
  Future<void> load() async {
    state = const AsyncValue.loading();
    try {
      final todos = await _usecases.fetch();
      state = AsyncValue.data(todos);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 新しいTodoを追加する
  Future<void> add(String rawTitle) async {
    try {
      // バリデーションを実行
      TodoTitle(rawTitle);
      await _usecases.add(rawTitle);
      await load();
    } catch (e, st) {
      if (e is ArgumentError) {
        rethrow;
      }
      state = AsyncValue.error(e, st);
    }
  }

  /// Todoを更新する
  Future<void> update(String id, String rawTitle) async {
    final list = state.valueOrNull;
    if (list == null) return;

    try {
      // バリデーションを実行
      final title = TodoTitle(rawTitle);
      final todo = list.firstWhere((e) => e.id == id);
      final updatedTodo = todo.copyWith(title: title);
      await _usecases.update(updatedTodo);
      await load();
    } catch (e, st) {
      if (e is ArgumentError) {
        rethrow;
      }
      state = AsyncValue.error(e, st);
    }
  }

  /// Todoの完了状態を切り替える
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

  /// Todoを削除する
  Future<void> remove(String id) async {
    try {
      await _usecases.delete(id);
      await load();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
