import 'package:flutter_todo_clean_arch_riverpod/core/validation/rules/validation_rule.dart';

class Validator<T> {
  final List<ValidationRule> rules;

  const Validator(this.rules);

  String? validate(T value) {
    for (final rule in rules) {
      final error = rule.validate(value.toString());
      if (error != null) return error;
    }
    return null;
  }

  /// 指定された型のルールを取得
  R? getRule<R extends ValidationRule>() {
    for (final rule in rules) {
      if (rule is R) {
        return rule;
      }
    }
    return null;
  }
}
