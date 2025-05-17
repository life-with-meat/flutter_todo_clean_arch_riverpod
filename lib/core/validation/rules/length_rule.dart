import 'package:flutter_todo_clean_arch_riverpod/core/validation/rules/validation_rule.dart';

class LengthRule implements ValidationRule {
  final int? maxLength;
  final int? minLength;

  const LengthRule({this.maxLength, this.minLength});

  @override
  String? validate(String value) {
    final trimmed = value.trim();
    if (maxLength != null && trimmed.length > maxLength!) {
      return '$maxLength文字以内で入力してください';
    }
    if (minLength != null && trimmed.length < minLength!) {
      return '$minLength文字以上で入力してください';
    }
    return null;
  }

  @override
  String get errorMessage => '文字数制限を超えています';
}
