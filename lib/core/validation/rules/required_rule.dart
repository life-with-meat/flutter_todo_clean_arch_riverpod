import 'package:flutter_todo_clean_arch_riverpod/core/validation/rules/validation_rule.dart';

class RequiredRule implements ValidationRule {
  @override
  String? validate(String value) {
    return value.trim().isEmpty ? errorMessage : null;
  }

  @override
  String get errorMessage => '入力してください';
}
