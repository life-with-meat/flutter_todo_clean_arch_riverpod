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

  /// 指定された型のルールが存在するかチェック
  bool hasRule<R extends ValidationRule>() {
    return getRule<R>() != null;
  }

  /// すべてのルールを取得
  List<ValidationRule> get allRules => List.unmodifiable(rules);

  /// バリデーションルールを追加した新しいValidatorを作成
  Validator<T> addRule(ValidationRule rule) {
    return Validator([...rules, rule]);
  }

  /// 複数のバリデーションルールを追加した新しいValidatorを作成
  Validator<T> addRules(List<ValidationRule> newRules) {
    return Validator([...rules, ...newRules]);
  }

  /// 指定された型のルールを削除した新しいValidatorを作成
  Validator<T> removeRule<R extends ValidationRule>() {
    return Validator(rules.where((rule) => rule is! R).toList());
  }
}
