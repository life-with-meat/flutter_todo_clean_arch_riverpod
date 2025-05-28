import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_todo_clean_arch_riverpod/core/error/common_error.dart';

part 'todo_error.freezed.dart';

@freezed
abstract class TodoError with _$TodoError {
  const TodoError._();

  const factory TodoError.common(CommonError error) = TodoCommonError;
  const factory TodoError.notFound() = TodoNotFoundError;
  const factory TodoError.duplicateTitle() = TodoDuplicateTitleError;
  const factory TodoError.invalidTitle() = TodoInvalidTitleError;
  const factory TodoError.invalidState() = TodoInvalidStateError;

  String get message {
    return switch (this) {
      TodoCommonError(error: final error) => error.message,
      TodoNotFoundError() => 'Todoが見つかりません',
      TodoDuplicateTitleError() => '同じタイトルのTodoが既に存在します',
      TodoInvalidTitleError() => '無効なタイトルです',
      TodoInvalidStateError() => '無効な状態です',
      _ => throw UnimplementedError(),
    };
  }
}
