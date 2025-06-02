import 'package:flutter_todo_clean_arch_riverpod/core/validation/text_field_validator.dart';
import 'package:flutter_todo_clean_arch_riverpod/feature/todo/domain/error/todo_error.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_title.g.dart';

/// Todoのタイトルを表す値オブジェクト
///
/// タイトルは1文字以上50文字以下である必要があります。
/// 空文字列は許可されません。
@JsonSerializable(explicitToJson: true)
class TodoTitle {
  /// タイトルの最大文字数
  static const int maxLength = 50;

  /// タイトルの最小文字数
  static const int minLength = 1;

  /// タイトルの値
  @JsonKey(name: 'value')
  final String value;

  /// バリデーションルール
  static final TextFieldValidator validator = TextFieldValidator(
    maxLength: maxLength,
    minLength: minLength,
  );

  const TodoTitle._(this.value);

  /// 新しいTodoTitleを作成します。
  ///
  /// [value]が空の場合は[TodoError.invalidTitle]をスローします。
  /// [value]が[maxLength]を超える場合は[TodoError.invalidTitle]をスローします。
  /// [value]が[minLength]未満の場合は[TodoError.invalidTitle]をスローします。
  ///
  /// 例：
  /// ```dart
  /// final title = TodoTitle("新しいタスク"); // OK
  /// final emptyTitle = TodoTitle(""); // TodoError.invalidTitle
  /// final tooLongTitle = TodoTitle("a" * 51); // TodoError.invalidTitle
  /// ```
  factory TodoTitle(String value) {
    final error = validator.validate(value);
    if (error != null) throw TodoError.invalidTitle();
    return TodoTitle._(value.trim());
  }

  /// JSONからTodoTitleを作成します。
  ///
  /// [json]は'value'キーを持つMapである必要があります。
  /// 値は文字列である必要があります。
  factory TodoTitle.fromJson(Map<String, dynamic> json) {
    final value = json['value'] as String? ?? '';
    try {
      return TodoTitle(value);
    } catch (_) {
      throw TodoError.invalidTitle(); // より具体的に
    }
  }

  /// TodoTitleをJSONに変換します。
  ///
  /// 戻り値は'value'キーを持つMapです。
  Map<String, dynamic> toJson() => {'value': value};

  @override
  String toString() => value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TodoTitle && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
