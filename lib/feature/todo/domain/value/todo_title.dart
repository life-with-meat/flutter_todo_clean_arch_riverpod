import 'package:flutter_todo_clean_arch_riverpod/core/validation/text_field_validator.dart';
import 'package:json_annotation/json_annotation.dart';

/// Todoのタイトルを表す値オブジェクト
///
/// タイトルは1文字以上50文字以下である必要があります。
/// 空文字列は許可されません。
@JsonSerializable()
class TodoTitle {
  /// タイトルの最大文字数
  static const int maxLength = 50;

  /// タイトルの最小文字数
  static const int minLength = 1;

  /// タイトルの値
  final String value;

  /// バリデーションルール
  static final TextFieldValidator validator = TextFieldValidator(
    maxLength: maxLength,
    minLength: minLength,
  );

  const TodoTitle._(this.value);

  /// 新しいTodoTitleを作成します。
  ///
  /// [input]が空の場合は[ArgumentError]をスローします。
  /// [input]が[maxLength]を超える場合は[ArgumentError]をスローします。
  /// [input]が[minLength]未満の場合は[ArgumentError]をスローします。
  ///
  /// 例：
  /// ```dart
  /// final title = TodoTitle("新しいタスク"); // OK
  /// final emptyTitle = TodoTitle(""); // ArgumentError: 入力してください
  /// final tooLongTitle = TodoTitle("a" * 51); // ArgumentError: 50文字以内で入力してください
  /// ```
  factory TodoTitle(String input) {
    final error = validator.validate(input);
    if (error != null) throw ArgumentError(error);
    return TodoTitle._(input.trim());
  }

  /// JSONからTodoTitleを作成します。
  ///
  /// [json]は'value'キーを持つMapである必要があります。
  /// 値は文字列である必要があります。
  factory TodoTitle.fromJson(Map<String, dynamic> json) =>
      TodoTitle(json['value'] as String);

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
